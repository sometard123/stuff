package ninjakiwi.monkeyTown.pvp
{
   import com.lgrey.utils.LGDisplayListUtil;
   import com.ninjakiwi.nkBar.assets.NKBar_Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.analytics.IdleTracker;
   import ninjakiwi.monkeyTown.analytics.StatsDataManager;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.persistence.Persistence;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.townMap.TownMapInvasionUtil;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import ninjakiwi.monkeyTown.town.ui.MapBottomUI;
   import ninjakiwi.monkeyTown.town.ui.PvPLoseInfoPanel;
   import ninjakiwi.monkeyTown.town.ui.PvPWinInfoPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class PvPMain
   {
      
      public static const STATE_PACIFIST:String = "pacifist";
      
      public static const STATE_MAXATTACKS:String = "maxAttacks";
      
      public static const STATE_ALREADY:String = "already";
      
      public static const STATE_LOW_LEVEL:String = "lowLevel";
      
      public static const STATE_NOT_PLAYING:String = "notPlaying";
      
      public static const STATE_NOT_INITIALISED:String = "notInitialised";
      
      public static const STATE_LOADING:String = "loading";
      
      public static const ATTACK_STATUS_INVALID:int = 0;
      
      public static const ATTACK_STATUS_NEW_SENT:int = 1;
      
      public static const ATTACK_STATUS_DELIVERED:int = 2;
      
      public static const ATTACK_STATUS_LINKED:int = 3;
      
      public static const ATTACK_STATUS_STARTED:int = 4;
      
      public static const ATTACK_STATUS_RESOLVED:int = 5;
      
      public static const ATTACK_STATUS_CLOSED:int = 6;
      
      public static const ATTACK_RESOLUTION_WIN:String = "win";
      
      public static const ATTACK_RESOLUTION_LOSS:String = "loss";
      
      public static const ATTACK_RESOLUTION_EXPIRE:String = "expire";
      
      public static const ATTACK_RESOLUTION_PENDING:String = "NaN";
      
      public static const MAX_REVENGE_COUNT:int = 3;
      
      public static const MAX_PILLAGE_EMPTY_BANKS:int = 2000;
      
      public static var isInPacifistMode:Boolean = false;
      
      public static var instance:PvPMain = null;
       
      
      public const REFRESH_TIME_S:int = 900.0;
      
      public const REFRESH_FULL_TIME_S:int = 3600.0;
      
      public const TIMESTAMP_REFRESH_TIME_S:int = 1800.0;
      
      public const recentlyResolvedAttacks:Vector.<String> = new Vector.<String>();
      
      private var _matchedOpponents:Array = null;
      
      private var _incomingRaids:Array = null;
      
      private var _outgoingAttacks:Array = null;
      
      private var _completedAttacks:Array = null;
      
      private var _expiredAttacks:Array = null;
      
      private var _battleHistory:Array = null;
      
      private var _attacksToClaimRewardsFor:Array = null;
      
      private var _map:TownMap;
      
      private var _townMapInvasionUtil:TownMapInvasionUtil;
      
      private var _canReceiveUpdates:Boolean = false;
      
      private const _pvpNotifications:PvPNotifications = new PvPNotifications();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _pvPAttackResultHandler:PvPAttackResultHandler = new PvPAttackResultHandler();
      
      private const _pacifist:Pacifist = new Pacifist();
      
      private var _timeStamp:Number = 0;
      
      public function PvPMain(param1:TownMap)
      {
         super();
         instance = this;
         this._map = param1;
         this.init();
      }
      
      public static function getPossiblePillageCash(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = param3;
         var _loc5_:int = param2;
         var _loc6_:* = int(_loc5_);
         if(int(_loc5_) > _loc4_)
         {
            _loc6_ = int(_loc4_);
         }
         var _loc7_:int = param1 * 2000;
         if(_loc6_ > _loc7_)
         {
            _loc6_ = int(_loc7_);
         }
         return _loc6_;
      }
      
      public static function getMatchingCity(param1:Array, param2:int) : Object
      {
         var _loc4_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.cityIndex == param2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function init() : void
      {
         this._townMapInvasionUtil = new TownMapInvasionUtil(this._map);
         Persistence.pvpStartupDataLoadedSignal.add(this.onPvPStartupDataLoadedSignal);
         PvPSignals.requestRefeshPvPData.add(this.onRequestRefreshData);
         PvPSignals.defendAttackComplete.add(this.onDefendAttackComplete);
         PvPSignals.revengeOpportunityNotTaken.add(this.onRevengeOpportunityNotTaken);
         PvPSignals.updatePacifistModeUI.add(this.onPacifistModeChanged);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEndSignal);
         this._timeStamp = getTimer();
      }
      
      public function get numberOfIncomingAttacks() : int
      {
         if(this._incomingRaids === null)
         {
            return 0;
         }
         return this._incomingRaids.length;
      }
      
      public function get incomingRaids() : Array
      {
         return this._incomingRaids;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         this._timeStamp = param1;
      }
      
      public function get pacifist() : Pacifist
      {
         return this._pacifist;
      }
      
      public function get townMapInvasionUtil() : TownMapInvasionUtil
      {
         return this._townMapInvasionUtil;
      }
      
      public function getOutgoingAttacks() : Array
      {
         return this._outgoingAttacks;
      }
      
      private function onReset() : void
      {
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onLevelChanged);
         this._timeStamp = getTimer();
      }
      
      public function update() : void
      {
         PvPTimerManager.getInstance().update();
      }
      
      private function pingForUpdates(param1:TimerEvent = null) : void
      {
         var _loc2_:Number = NaN;
         if(!this._map.worldIsReady)
         {
            return;
         }
         if(!MonkeyCityMain.isInGame && !IdleTracker.isIdle && this._resourceStore.townLevel >= Constants.MINIMUM_PVP_LEVEL && !PvPMain.isInPacifistMode)
         {
            _loc2_ = getTimer();
            if(_loc2_ - this._timeStamp > this.REFRESH_FULL_TIME_S * 1000)
            {
               this._timeStamp = _loc2_;
               this.refreshCoreData();
            }
            else
            {
               PvPClient.getCoreUpdates(this.processDataAndDispatch);
            }
         }
         this.cueNextPingForUpdates();
      }
      
      private function updateServerTimestamp(param1:TimerEvent = null) : void
      {
      }
      
      private function cueNextPingForUpdates() : void
      {
         PvPTimerManager.getInstance().registerTimer("pingForUpdate",this.REFRESH_TIME_S,this.pingForUpdates);
      }
      
      private function cueNextTimestampUpdate() : void
      {
         PvPTimerManager.getInstance().registerTimer("timestampUpdate",this.TIMESTAMP_REFRESH_TIME_S,this.updateServerTimestamp);
      }
      
      private function onPvPStartupDataLoadedSignal(param1:Object) : void
      {
         WorldViewSignals.clearWorldCompleteSignal.addOnce(this.onClearWorldCompleteSignal);
      }
      
      private function onPacifistModeChanged(param1:Boolean) : void
      {
         PvPMain.isInPacifistMode = param1;
      }
      
      private function onDefendAttackComplete(param1:GameResultDefinition, param2:IncomingRaid, param3:Boolean = false) : void
      {
         var defenderRecoveredBloontonium:Number = NaN;
         var tile:Tile = null;
         var myMaxCashPillage:int = 0;
         var totalCashPenalty:int = 0;
         var damageToCityValue:int = 0;
         var actualCashLost:int = 0;
         var hasServerResponse:Boolean = false;
         var timeoutID:uint = 0;
         var gameResult:GameResultDefinition = param1;
         var incomingRaid:IncomingRaid = param2;
         var forceProcessLost:Boolean = param3;
         var wasHardcore:Boolean = gameResult.wasHardcore;
         var resultObject:Object = {
            "attackID":incomingRaid.attackID,
            "wasHardcore":wasHardcore
         };
         PvPTimerManager.getInstance().deleteTimer(incomingRaid.attackID);
         var system:MonkeySystem = MonkeySystem.getInstance();
         t.obj(gameResult);
         var bloontoniumRecoveryEfficiency:Number = 0.5;
         var investedBT:int = 0;
         if(incomingRaid != null && incomingRaid.attack != null)
         {
            investedBT = incomingRaid.attack.investedBloontonium;
         }
         defenderRecoveredBloontonium = gameResult.fractionOfTotalBloonsPopped * investedBT * bloontoniumRecoveryEfficiency;
         if(wasHardcore)
         {
            defenderRecoveredBloontonium = defenderRecoveredBloontonium * Constants.HARDCORE_MODE_MODIFIER;
         }
         switch(gameResult.success)
         {
            case true:
               resultObject.attackSucceeded = false;
               break;
            case false:
               resultObject.attackSucceeded = true;
         }
         resultObject.attackerCash = incomingRaid.cashPillage;
         resultObject.attackerBloontonium = 0;
         if(incomingRaid.linkedTile != null)
         {
            tile = this._map.tileAt(incomingRaid.linkedTile.x,incomingRaid.linkedTile.y);
            tile.isUnderPvPAttack = false;
         }
         if(tile !== null && tile.pvpAttackSquare !== null)
         {
            tile.pvpAttackSquare.killAttackSquare();
            PvPAttackSquare.recycleSquare(tile.pvpAttackSquare);
            tile.pvpAttackSquare = null;
         }
         myMaxCashPillage = MonkeySystem.getInstance().city.bankManager.getMaximumPillage();
         var lowestCashPillage:int = incomingRaid.cashPillage > myMaxCashPillage?int(myMaxCashPillage):int(incomingRaid.cashPillage);
         var totalCashInBank:int = this._resourceStore.monkeyMoney;
         totalCashPenalty = lowestCashPillage;
         damageToCityValue = 0;
         var maxPossibleCashPillageFromBuildings:int = totalCashPenalty * 0.25;
         actualCashLost = totalCashPenalty;
         if(totalCashPenalty > totalCashInBank)
         {
            damageToCityValue = totalCashPenalty - totalCashInBank;
            actualCashLost = totalCashInBank;
         }
         var rest:int = totalCashPenalty - actualCashLost;
         if(rest > maxPossibleCashPillageFromBuildings)
         {
            rest = maxPossibleCashPillageFromBuildings;
         }
         rest = Math.min(rest,MAX_PILLAGE_EMPTY_BANKS);
         var attackerCashReward:int = actualCashLost + rest;
         TownUI.getInstance().informationBar.lockDisplay();
         if(gameResult.success == false)
         {
            this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney - actualCashLost;
         }
         hasServerResponse = false;
         timeoutID = setTimeout(function():void
         {
            if(!hasServerResponse)
            {
               unlockPanelManager();
            }
         },5 * 1000);
         incomingRaid.target.resolutionSeen = MonkeySystem.getInstance().getSecureTime();
         var attackObject:* = PvPClient.sendAttackResult(resultObject,{
            "trackName":(tile != null?tile.uniqueDataDefinition.trackClassName:"null"),
            "rounds":gameResult.roundReached,
            "totalRounds":gameResult.roundsNeededToWin,
            "bloonStrength":(incomingRaid.attack != null?incomingRaid.attack.strongestBloonType:Constants.RED_BLOON),
            "attackerCashReward":attackerCashReward,
            "attackerBloontoniumReward":0,
            "salvagedBloontonium":defenderRecoveredBloontonium
         },function(param1:Object):void
         {
            onPvPAttackResult(param1,incomingRaid,forceProcessLost,timeoutID,defenderRecoveredBloontonium,gameResult,damageToCityValue,tile,actualCashLost);
            hasServerResponse = true;
         });
      }
      
      private function onPvPAttackResult(param1:Object, param2:IncomingRaid, param3:Object, param4:uint, param5:Number, param6:GameResultDefinition, param7:int, param8:Tile, param9:int) : void
      {
         var opponentCities:Array = null;
         var winInfoPanel:PvPWinInfoPanel = null;
         var loseInfoPanel:PvPLoseInfoPanel = null;
         var sendAttackResultResponse:Object = param1;
         var incomingRaid:IncomingRaid = param2;
         var forceProcessLost:Object = param3;
         var timeoutID:uint = param4;
         var defenderRecoveredBloontonium:Number = param5;
         var gameResult:GameResultDefinition = param6;
         var damageToCityValue:int = param7;
         var tile:Tile = param8;
         var actualCashLost:int = param9;
         TownUI.getInstance().loading.hide();
         clearTimeout(timeoutID);
         if(sendAttackResultResponse.success == false || sendAttackResultResponse.error != null)
         {
            if(!forceProcessLost)
            {
               AnalyticsUtil.track("error_send_attack_result");
               this.unlockPanelManager();
               return;
            }
         }
         var revengeAvailable:Boolean = true;
         this._resourceStore.addBloontoniumWithTempOverage(defenderRecoveredBloontonium);
         var honourChange:int = sendAttackResultResponse.target.honourChange;
         if(this._resourceStore.honour + honourChange < 0)
         {
            honourChange = -this._resourceStore.honour;
         }
         if(honourChange == 0 || honourChange == 0)
         {
            honourChange = 0;
         }
         this._resourceStore.setHonour(this._resourceStore.honour + honourChange,false,false);
         var honor:int = 0;
         if(sendAttackResultResponse.sender == null)
         {
            honor = sendAttackResultResponse.honour;
         }
         else
         {
            honor = sendAttackResultResponse.sender.honour;
         }
         opponentCities = [];
         opponentCities.push(sendAttackResultResponse.senderCity);
         opponentCities.sortOn("cityIndex",Array.NUMERIC);
         var opponent:Friend = new Friend({
            "userID":incomingRaid.userID,
            "name":incomingRaid.name,
            "cityLevel":incomingRaid.cityLevel,
            "clan":incomingRaid.clan,
            "cities":opponentCities,
            "honour":honor
         });
         switch(gameResult.success)
         {
            case true:
               winInfoPanel = TownUI.getInstance().pvpWinInfoPanel;
               winInfoPanel.onHideSignal.addOnce(function():void
               {
                  MonkeyCityMain.getInstance().signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
               });
               winInfoPanel.syncOpponent(opponent,incomingRaid);
               winInfoPanel.setSalvagedBloontonium(defenderRecoveredBloontonium,revengeAvailable);
               winInfoPanel.setHonor(honourChange);
               TownUI.getInstance().informationBar.addRewardDisplay(winInfoPanel.hideStartSignal,0,0,0,0,defenderRecoveredBloontonium,0,honourChange);
               PanelManager.getInstance().showPanel(winInfoPanel);
               break;
            case false:
               if(damageToCityValue > 0)
               {
                  PvPSignals.damageCity.dispatch(damageToCityValue);
               }
               loseInfoPanel = new PvPLoseInfoPanel(TownUI.getInstance().popupLayer);
               loseInfoPanel.onHideSignal.addOnce(function():void
               {
                  MonkeyCityMain.getInstance().signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
               });
               loseInfoPanel.resetResult();
               loseInfoPanel.setResult(opponent,actualCashLost,defenderRecoveredBloontonium,damageToCityValue > 0,incomingRaid,revengeAvailable);
               loseInfoPanel.setHonor(honourChange);
               TownUI.getInstance().informationBar.addRewardDisplay(loseInfoPanel.hideStartSignal,0,0,-actualCashLost,0,defenderRecoveredBloontonium,0,honourChange);
               PanelManager.getInstance().showPanel(loseInfoPanel);
               if(damageToCityValue > 0)
               {
                  PanelManager.getInstance().showPanel(TownUI.getInstance().myTowersPanel);
               }
         }
         TownUI.getInstance().informationBar.unlockDisplay();
         this.removeIncomingAttackByID(incomingRaid.attackID);
         PvPSignals.requestRefeshPvPData.dispatch();
         this.unlockPanelManager();
         if(tile != null)
         {
            tile.isUnderPvPAttack = false;
            if(tile.pvpAttackSquare !== null)
            {
               tile.pvpAttackSquare.killAttackSquare();
               PvPAttackSquare.recycleSquare(tile.pvpAttackSquare);
               tile.pvpAttackSquare = null;
            }
         }
      }
      
      private function unlockPanelManager() : void
      {
         if(PanelManager.getInstance().lock === false)
         {
            return;
         }
         PanelManager.getInstance().lock = false;
         TownUI.getInstance().revealHud();
         PanelManager.getInstance().showNextPanel();
         MapBottomUI.getInstance().enableAllButtons();
      }
      
      public function removeIncomingAttackByID(param1:String) : void
      {
         var _loc2_:IncomingRaid = null;
         if(this._incomingRaids == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._incomingRaids.length)
         {
            _loc2_ = this._incomingRaids[_loc3_];
            if(_loc2_.attackID === param1)
            {
               _loc2_.clear();
               this._incomingRaids.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         PvPSignals.attackRemoved.dispatch(this._incomingRaids.length);
      }
      
      private function onRevengeOpportunityNotTaken() : void
      {
         this._resourceStore.discardBloontoniumOverage();
      }
      
      private function refreshCoreData() : void
      {
         PvPClient.getCore(function(param1:Object, param2:Object = null):void
         {
            processDataAndDispatch(param1,param2);
         });
      }
      
      private function onBuildWorldEndSignal() : void
      {
         this.firstTimeGetCoreData();
         this.cueNextPingForUpdates();
         this.updateServerTimestamp();
         this.checkTutorial();
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onLevelChanged);
      }
      
      private function onLevelChanged(... rest) : void
      {
         if(this._resourceStore.townLevel === Constants.MINIMUM_PVP_LEVEL)
         {
            this.getCoreData();
         }
         this.checkTutorial();
      }
      
      private function checkTutorial() : void
      {
         if(this._resourceStore.townLevel >= Constants.MINIMUM_PVP_LEVEL && int(QuestCounter.getInstance().getCustomValue("mvmTutorial")) == 0)
         {
            PanelManager.getInstance().showPanel(TownUI.getInstance().mvmTutorialPanel);
            QuestCounter.getInstance().setCustomValue("mvmTutorial",1);
         }
      }
      
      private function onClearWorldCompleteSignal() : void
      {
         PvPTimerManager.getInstance().deleteTimer("pingForUpdate");
      }
      
      private function onRequestRefreshData() : void
      {
         this.getCoreData();
      }
      
      private function findUnawardedHonour(param1:Array) : Number
      {
         var _loc2_:Object = null;
         var _loc5_:Number = NaN;
         if(param1 == null)
         {
            param1 = [];
         }
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_];
            if(_loc2_.hasOwnProperty("notify") && _loc2_.notify === true && _loc2_.hasOwnProperty("outcome") && _loc2_.hasOwnProperty("timeResolved"))
            {
               _loc5_ = 0;
               if(_loc2_.sender.userID === Kloud.userID)
               {
                  _loc5_ = _loc2_.sender.honourChange;
               }
               else
               {
                  _loc5_ = _loc2_.target.honourChange;
               }
               _loc3_ = _loc3_ + _loc5_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function firstTimeGetCoreData() : void
      {
         var enoughLevel:Boolean = this._resourceStore.townLevel >= Constants.MINIMUM_PVP_LEVEL;
         if(!enoughLevel)
         {
            this._resourceStore.setHonour(0,false,false);
            WorldViewSignals.initialMVMDataReceived.dispatch();
         }
         else
         {
            GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Securing the perimeter...");
            PvPClient.getCore(function(param1:Object, param2:Object = null):void
            {
               processDataAndDispatch(param1,param2);
               WorldViewSignals.initialMVMDataReceived.dispatch();
            });
         }
      }
      
      private function getCoreData() : void
      {
         PvPClient.getCore(function(param1:Object, param2:Object = null):void
         {
            processDataAndDispatch(param1,param2);
         });
      }
      
      private function updateCoreData() : void
      {
         PvPClient.getCoreUpdates(this.processDataAndDispatch);
      }
      
      private function processDataAndDispatch(param1:Object, param2:Object) : void
      {
         if(!param1.success || !param1.hasOwnProperty("attacks"))
         {
            return;
         }
         this.processAllData(param1);
         var _loc3_:Object = {
            "timeUntilPacifist":param1.timeUntilPacifist,
            "incomingRaids":this._incomingRaids,
            "completedAttacks":this._completedAttacks,
            "expiredAttacks":this._expiredAttacks,
            "battleHistory":this._battleHistory
         };
         PvPSignals.pvpDataUpdatedSignal.dispatch(_loc3_,param2,param1);
         this._completedAttacks.length = 0;
         this._expiredAttacks.length = 0;
      }
      
      private function processIncomingAttacksData(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc8_:Tile = null;
         var _loc9_:IncomingRaid = null;
         var _loc10_:Object = null;
         if(param1 === null || param2 === null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            PvPSignals.recievedNewPvPAttack.dispatch(param1[_loc3_]);
            _loc3_++;
         }
         if(this._incomingRaids != null)
         {
            _loc4_ = 0;
            while(_loc4_ < this._incomingRaids.length)
            {
               if(this._incomingRaids[_loc4_].linkedTile != null)
               {
                  _loc8_ = this._incomingRaids[_loc4_].linkedTile.tile;
                  if(_loc8_ != null)
                  {
                     _loc8_.isUnderPvPAttack = false;
                     if(_loc8_.pvpAttackSquare !== null)
                     {
                        _loc8_.pvpAttackSquare.killAttackSquare();
                        PvPAttackSquare.recycleSquare(_loc8_.pvpAttackSquare);
                     }
                     _loc8_.pvpAttackSquare = null;
                  }
               }
               _loc4_++;
            }
         }
         this._incomingRaids = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            StatsDataManager.getInstance().attackReceived();
            _loc5_++;
         }
         this._townMapInvasionUtil.notifiedAttacks.length = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            this._townMapInvasionUtil.notifiedAttacks.push(param2[_loc6_].attackID);
            _loc6_++;
         }
         var _loc7_:Array = param1.concat(param2);
         _loc4_ = 0;
         while(_loc4_ < _loc7_.length)
         {
            _loc9_ = new IncomingRaid();
            if(_loc9_.syncData(_loc7_[_loc4_]))
            {
               _loc10_ = FriendsManager.getInstance().findOpponentByID(_loc9_.sender.userID);
               if(_loc10_ == null)
               {
                  _loc9_.sender.honour = _loc9_.sender.honour;
               }
               else if(_loc9_.sender.honour == null)
               {
                  _loc9_.sender.honour = _loc10_.honour;
               }
               this._incomingRaids.push(_loc9_);
            }
            _loc4_++;
         }
      }
      
      private function processBattleHistoryData(param1:Array, param2:Array) : void
      {
         if(param1 === null || param2 === null)
         {
            return;
         }
         this._completedAttacks = param1;
         this._expiredAttacks = param2;
         this._battleHistory = this._completedAttacks.concat(this._expiredAttacks);
         var _loc3_:int = 0;
         while(_loc3_ < this._battleHistory.length)
         {
            this._battleHistory[_loc3_].info = Squeeze.derialiseAndDecompress(this._battleHistory[_loc3_].info);
            if(-1 != this.recentlyResolvedAttacks.indexOf(this._battleHistory[_loc3_].attackID))
            {
               this._battleHistory[_loc3_].isNew = true;
            }
            _loc3_++;
         }
         if(this._completedAttacks.length > 0)
         {
         }
         this._battleHistory.sort(this.sortByTimeResolved);
      }
      
      private function sortByTimeResolved(param1:Object, param2:Object) : int
      {
         if(false == param1.sender.hasOwnProperty("resolutionSeen") && false == param2.sender.hasOwnProperty("resolutionSeen"))
         {
            return 0;
         }
         if(false == param1.sender.hasOwnProperty("resolutionSeen"))
         {
            return -1;
         }
         if(false == param2.sender.hasOwnProperty("resolutionSeen"))
         {
            return 1;
         }
         if(param1.resolutionSeen > param2.resolutionSeen)
         {
            return -1;
         }
         if(param1.resolutionSeen < param2.resolutionSeen)
         {
            return 1;
         }
         return 0;
      }
      
      private function processOutgoingAttacksData(param1:Array) : void
      {
         var _loc3_:OutgoingAttack = null;
         this._outgoingAttacks = [];
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new OutgoingAttack();
            if(_loc3_.syncToData(param1[_loc2_]))
            {
               this._outgoingAttacks.push(_loc3_);
            }
            _loc2_++;
         }
         UserDataLoader.getInstance().populateAttackedUsers(this._outgoingAttacks);
      }
      
      private function processAttacksToClaimRewardsFor(param1:Array) : void
      {
         if(null == param1)
         {
            return;
         }
         this._attacksToClaimRewardsFor = param1;
      }
      
      private function processAllData(param1:Object) : void
      {
         var i:int = 0;
         var attack:Object = null;
         var attackStatus:int = 0;
         var isSenderSameAsPlayer:Boolean = false;
         var data:Object = param1;
         if(data == null || data.attacks == null)
         {
            return;
         }
         var newIncomingAttacks:Array = [];
         var incomingAttacks:Array = [];
         var completedAttacks:Array = [];
         var outgoingAttacks:Array = [];
         var expiredAttacks:Array = [];
         var secureTime:Number = MonkeySystem.getInstance().getSecureTime();
         try
         {
            i = 0;
            while(i < data.attacks.length)
            {
               attack = data.attacks[i];
               attackStatus = attack.status;
               isSenderSameAsPlayer = attack.sender.userID == Kloud.userID;
               if(ATTACK_STATUS_NEW_SENT == attackStatus)
               {
                  if(isSenderSameAsPlayer)
                  {
                     outgoingAttacks.push(attack);
                  }
                  else if(attack.expireAt <= secureTime)
                  {
                     expiredAttacks.push(attack);
                  }
                  else
                  {
                     newIncomingAttacks.push(attack);
                  }
               }
               else if(ATTACK_STATUS_DELIVERED == attackStatus || ATTACK_STATUS_LINKED == attackStatus || ATTACK_STATUS_STARTED == attackStatus)
               {
                  if(attack.expireAt <= secureTime)
                  {
                     if(isSenderSameAsPlayer)
                     {
                        outgoingAttacks.push(attack);
                     }
                     else
                     {
                        expiredAttacks.push(attack);
                     }
                  }
                  else if(isSenderSameAsPlayer)
                  {
                     outgoingAttacks.push(attack);
                  }
                  else if(ATTACK_STATUS_DELIVERED == attackStatus)
                  {
                     newIncomingAttacks.push(attack);
                  }
                  else
                  {
                     incomingAttacks.push(attack);
                  }
               }
               else if(ATTACK_STATUS_RESOLVED == attackStatus || ATTACK_STATUS_CLOSED >= attackStatus)
               {
                  completedAttacks.push(attack);
               }
               i++;
            }
         }
         catch(e:Error)
         {
            return;
         }
         this.processOutgoingAttacksData(outgoingAttacks);
         this.processIncomingAttacksData(newIncomingAttacks,incomingAttacks);
         this.processBattleHistoryData(completedAttacks,expiredAttacks);
         TimeUntilPacifistTracker.setTimeUntilPacifist(data.timeUntilPacifist);
      }
      
      public function checkOutgoingCount(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._outgoingAttacks.length)
         {
            if((this._outgoingAttacks[_loc3_] as OutgoingAttack).attack.defenderID == param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
