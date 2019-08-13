package ninjakiwi.monkeyTown.town.gameEvents.boss
{
   import assets.town.BouncyArrow;
   import com.ninjakiwi.nkBar.assets.NKBar_Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.achievements.AchievementDefinition;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.pvp.actualCashLost;
   import ninjakiwi.monkeyTown.pvp.damageToCityValue;
   import ninjakiwi.monkeyTown.pvp.defenderRecoveredBloontonium;
   import ninjakiwi.monkeyTown.pvp.forceProcessLost;
   import ninjakiwi.monkeyTown.pvp.gameResult;
   import ninjakiwi.monkeyTown.pvp.hasServerResponse;
   import ninjakiwi.monkeyTown.pvp.incomingRaid;
   import ninjakiwi.monkeyTown.pvp.tile;
   import ninjakiwi.monkeyTown.pvp.timeoutID;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventMonitor;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossMilestonesRewardPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.QuestDefinition;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.quests.task.QuestBloonResearch;
   import ninjakiwi.monkeyTown.town.quests.task.QuestBuilding;
   import ninjakiwi.monkeyTown.town.quests.task.QuestCapture;
   import ninjakiwi.monkeyTown.town.quests.task.QuestGatherSupplies;
   import ninjakiwi.monkeyTown.town.quests.task.QuestMorePreparation;
   import ninjakiwi.monkeyTown.town.quests.task.QuestResourcePower;
   import ninjakiwi.monkeyTown.town.quests.task.QuestSpecialItem;
   import ninjakiwi.monkeyTown.town.quests.task.QuestTotalMonkeys;
   import ninjakiwi.monkeyTown.town.quests.task.QuestUpgrade;
   import ninjakiwi.monkeyTown.town.quests.task.QuestUpgradeBuilding;
   import ninjakiwi.monkeyTown.town.quests.task.building.QuestBuildingPower;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestCaptureDifficulty;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestCaptureSpecialTerrain;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestHunter;
   import ninjakiwi.monkeyTown.town.quests.task.pvp.QuestPVPPillage;
   import ninjakiwi.monkeyTown.town.quests.task.pvp.QuestPVPRevenge;
   import ninjakiwi.monkeyTown.town.quests.task.upgrade.QuestUpgradeTier;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.newsPanelScroller.NewsPanelScrollerItem;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MKPTester;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeTutorialPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.DeepMixin;
   import ninjakiwi.mynk.save.TrafficGate;
   import ninjakiwi.net.JSONRequest;
   import org.osflash.signals.Signal;
   
   public class BossEventManager extends GameEventSubManager
   {
      
      public static var alwaysShowAbilityTutorial:Boolean = false;
      
      private static const HP_PER_LEVEL:int = 2000;
      
      private static const BOSS_ACTIVE_TIME:Number = 60 * 60 * 1000;
      
      private static const STARTING_CASH_MULTIPLIER:Number = 2;
      
      public static const UNLOCK_LEVEL:int = 12;
      
      public static const BLOONSTONES_REWARD:int = 5;
      
      private static const DEFAULT_PER_CITY_DATA:Object = {
         "timeActivated":0,
         "bossLevel":1,
         "bossHitPoints":HP_PER_LEVEL,
         "timesDefeated":0,
         "attackAttemptsThisLevel":0
      };
       
      
      private var _eventDataForCurrentAttack:Object = null;
      
      private var _eventForCurrentAttack:GameplayEvent = null;
      
      private var _btdGameRequestForCurrentAttack:BTDGameRequest;
      
      public var activeStateChangedSignal:Signal;
      
      public var _countDownTimer:Timer;
      
      private var _resourceStore:ResourceStore;
      
      private var _achievements:BossAchievements;
      
      private var _persistentData:Object = null;
      
      public function BossEventManager()
      {
         this.activeStateChangedSignal = new Signal();
         this._countDownTimer = new Timer(0,1);
         this._resourceStore = ResourceStore.getInstance();
         this._achievements = new BossAchievements();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
         BloonBeaconSystem.getInstance().onBeaconCapturedSignal.add(this.onBeaconCaptured);
         GameSignals.CITY_IS_FINALLY_READY.add(this.syncStateToData);
         GameSignals.LOAD_CITY_BEGIN.add(this.cancelCountdownTimer);
         GameEventMonitor.gameEventStarted.add(this.onGameEventBecameActive);
         this._countDownTimer.addEventListener(TimerEvent.TIMER,this.onCountdownTimerEnd);
      }
      
      override public function getPersistentData() : Object
      {
         return this._persistentData;
      }
      
      override public function setPersistentData(param1:Object) : void
      {
         if(param1 == null)
         {
            param1 = {};
         }
         param1 = DeepMixin.mix(this.getDefaultData(),param1);
         this._persistentData = param1;
      }
      
      private function getDefaultData() : Object
      {
         var _loc1_:Object = {
            "eventID":null,
            "perCityData":[]
         };
         var _loc2_:int = 0;
         while(_loc2_ < Constants.NUMBER_OF_CITIES)
         {
            _loc1_.perCityData[_loc2_] = this.getDefaultPerCityData();
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getDefaultPerCityData() : Object
      {
         return JSON.parse(JSON.stringify(DEFAULT_PER_CITY_DATA));
      }
      
      private function getDataForCurrentCity() : Object
      {
         var _loc1_:int = MonkeySystem.getInstance().city.cityIndex;
         return this._persistentData.perCityData[_loc1_];
      }
      
      private function syncStateToData(... rest) : void
      {
         var _loc2_:GameplayEvent = findCurrentEvent();
         var _loc3_:Boolean = _loc2_ !== null && _loc2_.active;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:String = this._persistentData.eventID;
         if(_loc2_.uid !== _loc4_)
         {
            this.startNewBossEvent();
         }
         var _loc5_:Object = this.getDataForCurrentCity();
         var _loc6_:Number = _loc5_.timeActivated;
         var _loc7_:Number = MonkeySystem.getInstance().getSecureTime();
         if(_loc7_ - _loc6_ <= BOSS_ACTIVE_TIME)
         {
            if(_loc5_.bossLevel > 1)
            {
               this.startCountdownToDeactivation(_loc6_);
            }
         }
         else if(_loc5_.bossLevel > 1)
         {
            this.expireBoss();
         }
      }
      
      private function getEventDataByBoss(param1:String, param2:Function) : void
      {
         SkuSettingsLoader.getGameEventDataByID("bossBattle",param1,param2);
      }
      
      public function getBossActiveTimeRemaining() : Number
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc3_:Number = _loc1_.timeActivated;
         return Math.max(0,BOSS_ACTIVE_TIME - (_loc2_ - _loc3_));
      }
      
      private function expireBoss() : void
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         var _loc2_:int = BossData.getInstance().getHealthForLevel(_loc1_.bossLevel);
         _loc1_.bossHitPoints = _loc2_;
         _loc1_.attackAttemptsThisLevel = 0;
         _loc1_.timeActivated = 0;
         save();
      }
      
      private function deactivateBoss() : void
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         _loc1_.timeActivated = 0;
         save();
      }
      
      private function startCountdownToDeactivation(param1:Number) : void
      {
         var _loc2_:Object = this.getDataForCurrentCity();
         if(_loc2_.timesDefeated === 0)
         {
            return;
         }
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc4_:Number = param1 + BOSS_ACTIVE_TIME;
         var _loc5_:Number = _loc4_ - _loc3_;
         this._countDownTimer.reset();
         this._countDownTimer.delay = _loc5_;
         this._countDownTimer.start();
      }
      
      private function cancelCountdownTimer(... rest) : void
      {
         this._countDownTimer.stop();
         this._countDownTimer.reset();
      }
      
      private function onCountdownTimerEnd(param1:TimerEvent) : void
      {
         this.cancelCountdownTimer();
         this.expireBoss();
         this.activeStateChangedSignal.dispatch();
      }
      
      private function onBeaconCaptured(param1:Tile, param2:Number) : void
      {
         if(this.bossIsActive)
         {
            return;
         }
         var _loc3_:Object = this.getDataForCurrentCity();
         _loc3_.timeActivated = param2;
         save();
         if(_loc3_.timesDefeated > 0)
         {
            this.startCountdownToDeactivation(_loc3_.timeActivated);
         }
         this.activeStateChangedSignal.dispatch();
      }
      
      public function get bossIsActive() : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         if(ResourceStore.getInstance().townLevel < UNLOCK_LEVEL)
         {
            return false;
         }
         var _loc1_:GameplayEvent = findCurrentEvent();
         var _loc2_:Boolean = _loc1_ !== null && _loc1_.active;
         if(_loc2_)
         {
            _loc3_ = this.getDataForCurrentCity();
            _loc4_ = MonkeySystem.getInstance().getSecureTime();
            if(_loc3_.timesDefeated == 0 || _loc4_ - _loc3_.timeActivated < BOSS_ACTIVE_TIME)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function get typeID() : String
      {
         return "bossBattle";
      }
      
      private function onGameEventManagerReady(... rest) : void
      {
         var arguments:Array = rest;
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.add(this.onBTDGameComplete);
         this.getDataForCurrentEvent(function(param1:Object):void
         {
            if(param1 == null)
            {
               return;
            }
         });
      }
      
      private function onGameEventBecameActive(param1:GameplayEvent, param2:GameEventSubManager) : void
      {
         if(param2 === this)
         {
            this.startNewBossEvent();
         }
      }
      
      public function startNewBossEvent() : void
      {
         this.cancelCountdownTimer();
         this._persistentData = this.getDefaultData();
         var _loc1_:GameplayEvent = findCurrentEvent();
         if(_loc1_ !== null && _loc1_.active)
         {
            this._persistentData.eventID = _loc1_.uid;
         }
         save();
      }
      
      private function onBTDGameComplete(param1:GameResultDefinition, param2:TileAttackDefinition, param3:BTDGameRequest) : void
      {
         var trackingData:Object = null;
         var rewardLevel:int = 0;
         var gameResult:GameResultDefinition = param1;
         var tileAttack:TileAttackDefinition = param2;
         var gameRequest:BTDGameRequest = param3;
         if(gameResult.skippedTrivial)
         {
            return;
         }
         var data:Object = this.getDataForCurrentCity();
         var wasBossBattle:Boolean = gameRequest.bossAttack !== null;
         if(!wasBossBattle)
         {
            return;
         }
         var cratesUsed:int = 0;
         var i:int = 0;
         while(i < gameRequest.crates.length)
         {
            if(true === gameRequest.crates[i])
            {
               cratesUsed++;
            }
            i++;
         }
         var successText:String = !!gameResult.success?"win":"loss";
         if(gameResult.cancelledGame)
         {
            successText = "quit";
         }
         trackingData = {
            "success":successText,
            "level":gameRequest.bossAttack.bossLevel,
            "health":gameResult.bossBattleResult.remainingHP,
            "maxHealth":gameRequest.bossAttack.bossMaxHitPoints,
            "cityLevel":ResourceStore.getInstance().townLevel,
            "attempt":data.attackAttemptsThisLevel,
            "crates":cratesUsed,
            "bonusCashUsed":gameRequest.bonusCashAmount,
            "gameDuration":gameResult.durationOfGame / 1000
         };
         this.getDataForCurrentEvent(function(param1:Object):void
         {
            trackingData.bossName = param1.name;
            AnalyticsUtil.track("boss_end",JSON.stringify(trackingData));
            if(gameResult.success)
            {
               _achievements.killedBoss(param1.name,gameRequest.bossAttack.bossLevel);
            }
         });
         if(gameResult.success)
         {
            rewardLevel = data.bossLevel;
            TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
            {
               giveRewardsForLevel(rewardLevel);
            });
            data.bossLevel++;
            data.attackAttemptsThisLevel = 0;
            data.timesDefeated++;
            data.bossHitPoints = BossData.getInstance().getHealthForLevel(data.bossLevel);
            data.timeActivated = 0;
            this.activeStateChangedSignal.dispatch();
         }
         else
         {
            data.bossHitPoints = gameResult.bossBattleResult.remainingHP;
         }
         save();
      }
      
      private function giveRewardsForLevel(param1:int) : void
      {
         var level:int = param1;
         var data:Object = this.getDataForCurrentCity();
         this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney + this.getCashRewardForLevel(data.bossLevel);
         this._resourceStore.bloonstones = this._resourceStore.bloonstones + BLOONSTONES_REWARD;
         this.getDataForCurrentEvent(function(param1:Object):void
         {
            var milestonesPanel:BossMilestonesRewardPanel = null;
            var eventData:Object = param1;
            if(eventData == null)
            {
               return;
            }
            var milestoneAwarder:BossMilestoneAwarder = new BossMilestoneAwarder(eventData.rewards);
            var hitMilestone:Boolean = milestoneAwarder.awardForTier(level);
            if(hitMilestone)
            {
               milestonesPanel = TownUI.getInstance().gameEventsUIManager.bossMilestonesPanel;
               milestonesPanel.queueWinAnimationOnReveal(level);
               TownUI.getInstance().bossBattleVictoryPanel.onRevealSignal.addOnce(function(... rest):void
               {
                  var arguments:Array = rest;
                  setTimeout(function():void
                  {
                     PanelManager.getInstance().showFreePanel(milestonesPanel);
                  },1000);
               });
            }
         });
      }
      
      public function getAttackDefinition(param1:String, param2:String, param3:String) : BossBattleAttackDefinition
      {
         var _loc4_:Object = this.getDataForCurrentCity();
         var _loc5_:BossBattleAttackDefinition = new BossBattleAttackDefinition().BossID(param1).ShortName(param2).LongName(param3).TimeLastAttacked(_loc4_.timeLastAttacked).BossLevel(_loc4_.bossLevel).BossHitPoints(_loc4_.bossHitPoints).BossMaxHitPoints(BossData.getInstance().getHealthForLevel(_loc4_.bossLevel)).ExtraBossChills(ResourceStore.getInstance().bossChills).ExtraBossBanes(ResourceStore.getInstance().bossBanes).ExtraBossBlasts(ResourceStore.getInstance().bossBlasts).ExtraBossWeakens(ResourceStore.getInstance().bossWeakens);
         if(_loc5_.bossHitPoints > _loc5_.bossMaxHitPoints)
         {
            _loc5_.bossHitPoints = _loc5_.bossMaxHitPoints;
         }
         switch(param1)
         {
            default:
            case "bloonarius":
               _loc5_.BossType(Constants.BOSS_BLOONARIUS_ID).SpecialTrackID(Constants.BOSS_BLOONARIUS);
               break;
            case "vortex":
               _loc5_.BossType(Constants.BOSS_VORTEX_ID).SpecialTrackID(Constants.BOSS_VORTEX);
               break;
            case "blastapopoulos":
               _loc5_.BossType(Constants.BOSS_BLASTAPOPOULOS_ID).SpecialTrackID(Constants.BOSS_BLASTAPOPOULOS);
               break;
            case "dreadbloon":
               _loc5_.BossType(Constants.BOSS_DREADBLOON_ID).SpecialTrackID(Constants.BOSS_DREADBLOON);
         }
         return _loc5_;
      }
      
      public function getCostToAttack() : Number
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         return BossData.getInstance().getCostToAttack(_loc1_.bossLevel,_loc1_.attackAttemptsThisLevel + 1);
      }
      
      public function getStartingCash() : Number
      {
         var _loc1_:Number = (this._resourceStore.btdStartingMoney + this._resourceStore.btdBonusStartingMoney) * STARTING_CASH_MULTIPLIER;
         return _loc1_;
      }
      
      public function getDataForCurrentEvent(param1:Function) : void
      {
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(_loc2_ == null)
         {
            param1(null);
            return;
         }
         SkuSettingsLoader.getGameEventDataByID("bossBattle",_loc2_.dataID,param1);
      }
      
      public function get bossLevel() : int
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         return _loc1_.bossLevel;
      }
      
      public function cheatBossLevel(param1:int) : void
      {
      }
      
      public function launchBossBattle(param1:Array, param2:int) : void
      {
         var cratesArray:Array = param1;
         var bonusStartingCash:int = param2;
         this.getDataForCurrentEvent(function(param1:Object):void
         {
            if(param1 == null)
            {
               _eventDataForCurrentAttack = null;
               _eventForCurrentAttack = null;
               _btdGameRequestForCurrentAttack = null;
               return;
            }
            _eventDataForCurrentAttack = param1;
            _eventForCurrentAttack = findCurrentEvent();
            var _loc2_:Object = getDataForCurrentCity();
            var _loc3_:MonkeySystem = MonkeySystem.getInstance();
            var _loc4_:Number = getCostToAttack();
            _loc2_.attackAttemptsThisLevel++;
            save();
            var _loc5_:Object = QuestCounter.getInstance().getCustomValue("tutorialSave") || {};
            if(false === _loc5_.hasOwnProperty("firstChill") || false === _loc5_.firstChill)
            {
               ResourceStore.getInstance().bossChills++;
               _loc5_.firstChill = true;
               QuestCounter.getInstance().setCustomValue("tutorialSave",_loc5_);
            }
            if(BossEventManager.alwaysShowAbilityTutorial)
            {
               _loc5_.seenAntiBossAbilityTutorial = false;
            }
            var _loc6_:String = param1.name;
            var _loc7_:String = param1.longName;
            var _loc8_:Number = getStartingCash() + bonusStartingCash;
            var _loc9_:GameplayEvent = findCurrentEvent();
            var _loc10_:int = int(_loc9_.startTime) + _loc2_.bossLevel;
            if(_loc10_ == 0)
            {
               _loc10_ = 1337 + _loc2_.bossLevel;
            }
            var _loc11_:BTDGameRequest = new BTDGameRequest().ExtraRedHotSpikes(ResourceStore.getInstance().redHotSpikes).ExtraMonkeyBoosts(ResourceStore.getInstance().monkeyBoosts).AvailableUpgrades(_loc3_.city.upgradeTree.getDescriptionForBTDModule()).AvailableTowers(_loc3_.city.buildingManager.getAvailableTowersDescription(null)).StartingMoney(_loc8_).BonusCashAmount(bonusStartingCash).StartingLives(ResourceStore.getInstance().btdStartingLives).TrackSelectionBias(1).IsReplayMode(false).IsCamoTile(false).IsRegenTile(false).MoreLead(Constants.NORMAL).IsTutorial(false).TutorialSave(_loc5_).IsContestedTerritory(false).Difficulty(20 + _loc2_.bossLevel * 2).DifficultyRankRelativeToMTL(6).DifficultyDescription(_loc3_.map.getDifficultyDescriptionByRank(6)).TileUniqueData(new TileUniqueDataDefinition()).Seed(_loc10_).CityIndex(_loc3_.city.cityIndex).Crates(cratesArray).BloonWeights(BloonPredictor.getWeightsDefinitionByUserDefinedStrongestBloonType(Constants.DDT_BLOON)).BossAttack(GameEventManager.getInstance().bossEventManager.getAttackDefinition(_loc9_.dataID,_loc6_,_loc7_)).ExtensionRounds(200).AllowRetry(false);
            switch(_loc9_.dataID)
            {
               default:
               case "bloonarius":
                  _loc11_.TerrainType(Constants.TERRAIN_BOSS_BLOONARIUS);
                  _loc11_.TerrainName(Constants.TERRAIN_BOSS_BLOONARIUS);
                  break;
               case "vortex":
                  _loc11_.TerrainType(Constants.TERRAIN_BOSS_VORTEX);
                  _loc11_.TerrainName(Constants.TERRAIN_BOSS_VORTEX);
                  break;
               case "blastapopoulos":
                  _loc11_.TerrainType(Constants.TERRAIN_BOSS_BLASTAPOPOULOS);
                  _loc11_.TerrainName(Constants.TERRAIN_BOSS_BLASTAPOPOULOS);
                  break;
               case "dreadbloon":
                  _loc11_.TerrainType(Constants.TERRAIN_BOSS_DREADBLOON);
                  _loc11_.TerrainName(Constants.TERRAIN_BOSS_DREADBLOON);
            }
            _btdGameRequestForCurrentAttack = _loc11_;
            MonkeyCityMain.getInstance().launchBTDBossBattle(_loc11_);
            ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney - _loc4_;
         });
      }
      
      public function getCashRewardForLevel(param1:int) : int
      {
         return BossData.getInstance().getCostToAttack(param1,2) * 1.5;
      }
      
      public function getBossEventTimeRemaining() : Number
      {
         var _loc1_:GameplayEvent = findCurrentEvent();
         if(_loc1_ == null)
         {
            return 0;
         }
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         return Math.max(0,_loc1_.endTime - _loc2_);
      }
      
      public function get attackAttemptsThisLevel() : int
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         return _loc1_.attackAttemptsThisLevel;
      }
      
      public function get eventDataForCurrentAttack() : Object
      {
         return this._eventDataForCurrentAttack;
      }
      
      public function get eventForCurrentAttack() : GameplayEvent
      {
         return this._eventForCurrentAttack;
      }
      
      public function get btdGameRequestForCurrentAttack() : BTDGameRequest
      {
         return this._btdGameRequestForCurrentAttack;
      }
   }
}
