package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import com.lgrey.utils.LGMathUtil;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.analytics.StatsDataManager;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.interfaces.View;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeRewards;
   import ninjakiwi.monkeyTown.mouseManager.MouseManager;
   import ninjakiwi.monkeyTown.net.CachedPreMaintenanceChecker;
   import ninjakiwi.monkeyTown.net.CachedPvPEnabledChecker;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.persistence.AutoSaver;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.pvp.PvPTimerObject;
   import ninjakiwi.monkeyTown.sound.MCMusic;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BananaFarmBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloontoniumGenerator;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossBattleVictoryPanel;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.QuestManager;
   import ninjakiwi.monkeyTown.town.requirements.Requirements;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.MapTest;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.Compass;
   import ninjakiwi.monkeyTown.town.ui.MapBottomUI;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.clock.UpgradeBuildingWarmupClockManager;
   import ninjakiwi.monkeyTown.town.ui.cursor.MonkeyCityCursorManager;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   import ninjakiwi.monkeyTown.transition.Transition;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.ModalBlocker;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.Calculator;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class MonkeyCityMain extends MovieClip implements View
   {
      
      private static var _instance:MonkeyCityMain = null;
      
      public static const globalHideSignal:Signal = new Signal();
      
      public static const globalResetSignal:PrioritySignal = new PrioritySignal();
      
      public static var isInGame:Boolean = false;
      
      public static var attackEndSoonCheat:Boolean = false;
       
      
      public var signals:MonkeyCityMainSignals;
      
      private var _btdView:BTDView;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _transition:Transition;
      
      public var cursorContainer:Sprite;
      
      public var mouseManager:MouseManager;
      
      public var ui:TownUI;
      
      public var openingNewCityPanelSignal:Signal;
      
      public var closingNewCityPanelSignal:Signal;
      
      var _cursorManager:MonkeyCityCursorManager;
      
      private var _modalBlocker:ModalBlocker;
      
      private var _resourceStore:ResourceStore;
      
      private var _specialItemData:SpecialItemData;
      
      private var _specialItemStore:SpecialItemStore;
      
      private var _worldView:WorldView;
      
      private var _configData:ConfigData;
      
      private var _buildingData:BuildingData;
      
      private var _firstTimeTriggerManager:FirstTimeTriggerManager;
      
      private var _pendingTileAttackDefinition:TileAttackDefinition = null;
      
      private var _pendingIncomingRaid:IncomingRaid = null;
      
      private var _cityCommonDataManager:CityCommonDataManager;
      
      private var _stage:Stage;
      
      private const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      private var _autoSaver:AutoSaver;
      
      private var _pvpMain:PvPMain;
      
      private var _activeBTDGameRequest:BTDGameRequest = null;
      
      public var bloonBeaconSystem:BloonBeaconSystem = null;
      
      public function MonkeyCityMain(param1:DisplayObject, param2:BTDView)
      {
         this.signals = new MonkeyCityMainSignals();
         this._transition = Transition.getInstance();
         this.cursorContainer = new Sprite();
         this.openingNewCityPanelSignal = new Signal();
         this.closingNewCityPanelSignal = new Signal();
         this._modalBlocker = ModalBlocker.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         this._specialItemData = SpecialItemData.getInstance();
         this._specialItemStore = SpecialItemStore.getInstance();
         this._configData = ConfigData.getInstance();
         this._buildingData = BuildingData.getInstance();
         this._cityCommonDataManager = CityCommonDataManager.getInstance();
         super();
         if(_instance)
         {
            throw new Error("Error: MonkeyCityMain already instantiated. use MonkeyCityMain.getInstance() instead");
         }
         _instance = this;
         this._btdView = param2;
         if(stage)
         {
            this.addedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         }
         this.init(param1);
         Requirements.init();
         MCSound.getInstance();
      }
      
      public static function getInstance() : MonkeyCityMain
      {
         if(!_instance)
         {
            throw new Error("Error: MonkeyCityMain not instantiated yet!");
         }
         return _instance;
      }
      
      private function addedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this._stage = stage;
         this._modalBlocker.setStage(stage);
      }
      
      private function init(param1:DisplayObject) : void
      {
         this.initMouseManager(param1);
         this._cursorManager = new MonkeyCityCursorManager(this.cursorContainer,this.mouseManager);
         this._worldView = new WorldView(this.mouseManager,this._cursorManager);
         addChild(this._worldView);
         this._pvpMain = new PvPMain(this._worldView.map);
         this.bloonBeaconSystem = BloonBeaconSystem.getInstance();
         this.initUI();
         this.initSignals();
         this.initListeners();
         this._worldView.initSignals(this.signals);
         this._modalBlocker.stateChangedSignal.add(this.onModalBlockerStateChanged);
         PvPSignals.defendAttack.add(this.defendPvPAttack);
         this._firstTimeTriggerManager = new FirstTimeTriggerManager(this._worldView,this.ui.firstTimeTriggerPanel);
         this._autoSaver = AutoSaver.getInstance();
         this._autoSaver.init(this.signals);
         QuestManager.getInstance().init(this._worldView.map);
      }
      
      private function initSignals() : void
      {
         this.signals.beginPlacingBuildingSignal.setTargetSignal(this.ui.beginPlacingBuildingSignal);
         this.signals.cancelPlacingBuildingSignal.setTargetSignal(this.ui.cancelPlacingBuildingSignal);
         this.signals.cancelMovingBuildingSignal.setTargetSignal(this.ui.cancelMovingBuildingSignal);
         this.signals.buildWorldStartSignal.setTargetSignal(WorldViewSignals.buildWorldStartSignal);
         this.signals.buildingWasSelectedSignal.setTargetSignal(this.ui.buildPanel.buildingWasSelectedSignal);
         this.signals.buildingWasSelectedForTileSignal.setTargetSignal(this.ui.buildPanel.buildingWasSelectedForTileSignal);
         this.signals.myTowersPanelOpenedSignal.setTargetSignal(this.ui.myTowersPanel.openedSignal);
         this.signals.myTowersPanelClosedSignal.setTargetSignal(this.ui.myTowersPanel.closedSignal);
         this.signals.buildPanelOpenedSignal.setTargetSignal(this.ui.buildPanel.openedSignal);
         this.signals.buildPanelClosedSignal.setTargetSignal(this.ui.buildPanel.closedSignal);
      }
      
      private function initListeners() : void
      {
         WorldViewSignals.buildWorldStartSignal.add(this.sleep);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
         WorldViewSignals.userClickedTileSignal.add(this.onUserClickedTile);
         WorldViewSignals.createWorldEndSignal.add(this.onCreateWorldEnd);
         this.ui.confirmedAttackSignal.add(this.onConfirmedAttackSignal);
         this.ui.cancelledAttackSignal.add(this.onCancelledAttackSignal);
         BananaFarmBuilding.requestUpgradeSignal.add(this.showUpgradePanelForBuilding);
         BloontoniumGenerator.requestUpgradeSignal.add(this.showUpgradePanelForBuilding);
         WorldViewSignals.buildProgressBarEndSignal.add(this.onBuildProgressBarEndSignal);
         PvPSignals.damageCity.add(this.onDamageCitySignal);
      }
      
      private function onBuildProgressBarEndSignal() : void
      {
         if(this._worldView.ready)
         {
            MonkeyCityMain.getInstance().signals.loadCityAllCompleteSignal.dispatch();
            this.checkTutorial();
         }
      }
      
      public function reset() : void
      {
         this.clear();
         this._worldView.reset();
         isInGame = false;
      }
      
      private function onDataInvalidated() : void
      {
         Main.instance.returnToHomeScreen();
      }
      
      private function onBuildWorldEnd() : void
      {
         this.ui.notificationUI.startNotification();
         MCMusic.playMapMusic(this._system.city.cityIndex);
         this.checkTutorial();
      }
      
      private function onCreateWorldEnd() : void
      {
         this.checkTutorial();
      }
      
      private function checkTutorial() : Boolean
      {
         var _loc1_:Boolean = this._firstTimeTriggerManager.checkTutorial();
         if(!_loc1_)
         {
            this.wake();
         }
         return _loc1_;
      }
      
      private function showUpgradePanelForBuilding(param1:UpgradeableBuilding) : void
      {
         this.ui.upgradeBuildingPanel.setInfo(param1);
         PanelManager.getInstance().showPanelOverlay(this.ui.upgradeBuildingPanel);
      }
      
      private function onUserClickedTile(param1:Tile) : void
      {
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = false;
         if(param1 == null)
         {
            return;
         }
         if(!this.mouseManager.state)
         {
            return;
         }
         if(param1.building != null)
         {
            if(false == Building.infoEnabled)
            {
               return;
            }
            if(false == param1.building.buildComplete)
            {
               return;
            }
            _loc2_ = param1.building is UpgradeableBuilding;
            _loc3_ = param1.building.definition === this._buildingData.MONKEY_TOWN_HALL;
            _loc4_ = param1.building.definition.buildingCategory === this._buildingData.BASE_BUILDING;
            _loc5_ = param1.building.definition.buildingCategory === this._buildingData.PVP_BUILDING;
            _loc6_ = param1.building.definition.buildingCategory === this._buildingData.SPECIAL_BUILDING;
            _loc7_ = param1.building.definition.buildingCategory === this._buildingData.PREMIUM_BUILDING;
            if(param1.building.definition.id === "BloonResearchLab")
            {
               TownUI.getInstance().bloonResearchLabPanel.updateDemolish(false,param1);
               PanelManager.getInstance().showPanelOverlay(TownUI.getInstance().bloonResearchLabPanel);
            }
            else if(_loc4_ && false == _loc3_ && false == _loc2_)
            {
               this.ui.baseBuildingInfoPanel.baseBuildingInfo(param1.building);
            }
            else if((_loc5_ || _loc6_) && false == _loc3_ && false == _loc2_)
            {
               this.ui.buildingInfoPanel.baseBuildingInfo(param1.building);
            }
            else if(_loc2_)
            {
               if(UpgradeableBuilding(param1.building).isUpgrading && UpgradeableBuilding(param1.building).upgradeClock !== null)
               {
                  UpgradeBuildingWarmupClockManager(MonkeySystem.getInstance().city.upgradeBuildingWarmupClockManager).userClickedUpgradeClockSignal.dispatch(UpgradeableBuilding(param1.building).upgradeClock);
                  return;
               }
               if(param1.building is BananaFarmBuilding || param1.building is BloontoniumGenerator || UpgradeableBuilding(param1.building).isUpgrading)
               {
                  return;
               }
               this.ui.upgradeBuildingPanel.setInfo(UpgradeableBuilding(param1.building));
               PanelManager.getInstance().showPanelOverlay(this.ui.upgradeBuildingPanel);
            }
            else if(_loc7_)
            {
               this.ui.premiumBuildingInfoPanel.baseBuildingInfo(param1.building);
            }
            else
            {
               this.ui.upgradesPanel.revealForBuilding(param1.building);
            }
         }
         else if(param1.isCaptured)
         {
            this.ui.capturedTerrainInfoPanel.syncTerrainInformation(param1.getInformation(this._worldView.map),param1);
            PanelManager.getInstance().showPanelOverlay(this.ui.capturedTerrainInfoPanel);
         }
         else
         {
            this.ui.terrainInfoPanel.setDetails(this._worldView.map,param1);
            PanelManager.getInstance().showPanelOverlay(this.ui.terrainInfoPanel);
         }
      }
      
      private function initMouseManager(param1:DisplayObject) : void
      {
         this.mouseManager = new MouseManager(param1);
      }
      
      private function onModalBlockerStateChanged(param1:Boolean) : void
      {
         this.mouseManager.setMouseActive(!param1);
      }
      
      public function sleep() : void
      {
         this.mouseManager.setMouseActive(false);
         this.mouseManager.disableDrag();
         this.mouseManager.lock();
      }
      
      public function wake() : void
      {
         if(this._worldView.ready)
         {
            this.enableMouse();
            TownUI.getInstance().revealHud();
         }
      }
      
      private function enableMouse() : void
      {
         this.mouseManager.unlock();
         this.mouseManager.setMouseActive(true);
         this.mouseManager.enableDrag();
      }
      
      private function initUI() : void
      {
         this._modalBlocker.stateChangedSignal.add(this.onModalBlockerStateChanged);
         addChild(this.cursorContainer);
         this.ui = new TownUI(this._worldView);
         addChild(this.ui);
         this.ui.newCityPanel.makeNewCitySignal.add(this.onNewCityPanelMakeNewCitySignal);
         this.ui.hideHUD(0);
         this.ui.newCityPanel.onHideSignal.add(function(... rest):void
         {
            closingNewCityPanelSignal.dispatch();
         });
         Compass.COMPASS_CLICKED.add(function():void
         {
            _worldView.centerCameraOnVillage();
         });
      }
      
      private function onNewCityPanelMakeNewCitySignal(param1:String) : void
      {
         this._worldView.invokeCreateNewCity(param1);
      }
      
      private function defendPvPAttack(param1:IncomingRaid, param2:Number, param3:Boolean, param4:Array, param5:Boolean) : void
      {
         var incomingRaid:IncomingRaid = param1;
         var possibleBonusStartingCash:Number = param2;
         var isHardcore:Boolean = param3;
         var crates:Array = param4;
         var isBonusCashMode:Boolean = param5;
         this.ui.genericModalSpinner.reveal(1);
         CachedPvPEnabledChecker.checkEnabled(function(param1:Boolean):void
         {
            var isEnabled:Boolean = param1;
            if(!isEnabled)
            {
               ui.maintenanceScheduledMessage.showMvMDisabledMessage();
               ui.genericModalSpinner.hide(1);
            }
            else
            {
               isInGame = true;
               TransitionSignals.closeCurtainCompleteSignal.addOnce(function():void
               {
                  var tile:Tile = null;
                  var btdGameRequest:BTDGameRequest = null;
                  ui.genericModalSpinner.hide(0);
                  var pvpAttack:PvPAttackDefinition = incomingRaid.attack;
                  _pendingIncomingRaid = incomingRaid;
                  _cursorManager.hideCurrentCursor();
                  _transition.transitionTo(_btdView);
                  var map:TownMap = _worldView.map;
                  tile = map.tileAt(incomingRaid.linkedTile.x,incomingRaid.linkedTile.y);
                  if(tile === null)
                  {
                     tile = map.tileAt(int(Math.random() * map.width),0);
                  }
                  tile.isUnderPvPAttack = false;
                  if(tile.pvpAttackSquare !== null)
                  {
                     tile.pvpAttackSquare.killAttackSquare();
                     PvPAttackSquare.recycleSquare(tile.pvpAttackSquare);
                  }
                  tile.pvpAttackSquare = null;
                  var difficulty:int = incomingRaid.attack.difficulty;
                  var tileDifficulty:int = map.getDifficultyAtLocationPoint(tile.positionTilespace);
                  if(difficulty < tileDifficulty - 1)
                  {
                     difficulty = tileDifficulty - 1;
                  }
                  var rank:int = _system.map.getPVPRank(difficulty,_resourceStore.townLevel,incomingRaid.linkedTile.tile != null?incomingRaid.linkedTile.tile.type:"",tile);
                  var terrainType:String = tile.getBaseTerrainType();
                  _pendingTileAttackDefinition = new TileAttackDefinition().TerrainType(terrainType).MonkeyTownLevel(_resourceStore.townLevel).DifficultyLevel(difficulty).DifficultyRankRelativeToMTL(rank).AttackAtLocation(tile.positionTilespace).CostToAttack(0).IsHardcore(isHardcore);
                  btdGameRequest = new BTDGameRequest().ExtraRedHotSpikes(_resourceStore.redHotSpikes).ExtraMonkeyBoosts(_resourceStore.monkeyBoosts).CityIndex(_system.city.cityIndex).MoreCamo(Constants.NORMAL).MoreRegen(Constants.NORMAL).MoreLead(incomingRaid.attack.moreLeads).MoreMoabs(incomingRaid.attack.moreMoabs).Seed(tile.seed).AvailableUpgrades(_system.city.upgradeTree.getDescriptionForBTDModule()).AvailableTowers(_system.city.buildingManager.getAvailableTowersDescription(tile.type)).Difficulty(incomingRaid.attack.difficulty).StartingMoney(_resourceStore.btdStartingMoney + _resourceStore.btdBonusStartingMoney).StartingLives(_resourceStore.btdStartingLives).TerrainType(terrainType).BloonWeights(BloonPredictor.getWeightsDefinitionByUserDefinedStrongestBloonType(incomingRaid.attack.strongestBloonType)).TileUniqueData(tile.uniqueDataDefinition).PvpAttackDefinition(pvpAttack).TrackSelectionBias(0.5).DifficultyRankRelativeToMTL(rank).DifficultyDescription(_system.map.getDifficultyDescriptionByRank(rank)).IsCamoTile(incomingRaid.attack.moreCamos == Constants.LOTS?true:false).IsRegenTile(incomingRaid.attack.moreRegens == Constants.LOTS?true:false).IsBonusCashMode(isBonusCashMode).BonusCashAmount(possibleBonusStartingCash).TutorialSave(QuestCounter.getInstance().getCustomValue("tutorialSave") || {}).IsHardcore(isHardcore).Crates(crates);
                  var timeRemaining:PvPTimerObject = PvPTimerManager.getInstance().getTimer(incomingRaid.attackID);
                  if(timeRemaining != null)
                  {
                     if(timeRemaining.timeLeft > 0)
                     {
                        if(attackEndSoonCheat)
                        {
                           btdGameRequest.TimeLimit(20000);
                        }
                        else
                        {
                           btdGameRequest.TimeLimit(timeRemaining.timeLeft);
                        }
                     }
                  }
                  _activeBTDGameRequest = btdGameRequest;
                  signals.btdGameRequestSet.dispatch(btdGameRequest);
                  _btdView.gameCompleteSignal.addOnce(onBTDGameComplete);
                  _btdView.playGame(btdGameRequest,function():void
                  {
                     var _loc1_:Array = null;
                     if(btdGameRequest.tileUniqueData.numberOfTimesAttacked === 1)
                     {
                        _loc1_ = [tile];
                        CityDataPersistence.getInstance().saveValue(CityDataPersistence.TILES_KEY,_loc1_);
                     }
                  });
                  WorldView.stopOverlayItems();
                  WorldView.stopOverlayFlashItems();
               });
               TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
               {
                  PvPClient.startDefending(incomingRaid.attackID);
               });
               TransitionSignals.beganLoadingBTDGame.dispatch();
            }
         });
      }
      
      private function onDamageCitySignal(param1:int) : void
      {
         this._worldView.map.damageCity(param1);
      }
      
      private function onConfirmedAttackSignal(param1:TileAttackDefinition) : void
      {
         var tileAttackDefinition:TileAttackDefinition = param1;
         this.mouseManager.setMouseActive(false);
         this.mouseManager.lock();
         this._cursorManager.hideCurrentCursor();
         var tile:Tile = this._worldView.map.tileAtPoint(tileAttackDefinition.attackAtLocation);
         var isTrivial:Boolean = tileAttackDefinition.difficultyDescription === TownMap.DIFFICULTY_DESCRIPTIONS[0];
         var canAffordToSkip:Boolean = this._resourceStore.spendableMonkeyMoney >= tileAttackDefinition.costToAttack * 2;
         if(isTrivial && canAffordToSkip && SpecialMissionsManager.getInstance().findSpecialMission(tile) === null && tile.isCamoTile == false && tile.isRegenTile == false && BloonBeaconSystem.getInstance().isTileBeaconSquare(tile) == false && tileAttackDefinition.isBloonBeacon == false)
         {
            this.ui.skipTrivialAttackPanel.responseSignal.addOnce(function(param1:Boolean):void
            {
               if(param1)
               {
                  _pendingTileAttackDefinition = tileAttackDefinition;
                  onBTDGameComplete(new GameResultDefinition().Success(true).SkippedTrivial(true).DifficultyRankRelativeToMTL(_pendingTileAttackDefinition.difficultyRankRelativeToMTL));
               }
               else
               {
                  launchBTDGameWithEnabledCheck(tileAttackDefinition);
               }
            });
            PanelManager.getInstance().showPanel(this.ui.skipTrivialAttackPanel);
         }
         else
         {
            this.launchBTDGameWithEnabledCheck(tileAttackDefinition);
         }
         if(tileAttackDefinition.isBonusCashMode && tileAttackDefinition.bonusStartingCash > 0)
         {
            GameSignals.PLAYER_USED_BONUS_STARTING_CASH.dispatch(tileAttackDefinition.bonusStartingCash);
         }
      }
      
      private function onCancelledAttackSignal(param1:TileAttackDefinition) : void
      {
         this.mouseManager.setMouseActive(true);
         this.signals.cancelledAttackSignal.dispatch();
      }
      
      private function launchBTDGameWithEnabledCheck(param1:TileAttackDefinition) : void
      {
         var tileAttackDefinition:TileAttackDefinition = param1;
         this.ui.genericModalSpinner.reveal(1);
         CachedPreMaintenanceChecker.checkPreMaintenance(function(param1:Boolean):void
         {
            var isPreMaintenance:Boolean = param1;
            ui.genericModalSpinner.hide();
            if(isPreMaintenance)
            {
               ui.maintenanceScheduledMessage.showMvEWarningMessage(function(param1:Boolean):void
               {
                  if(param1)
                  {
                     launchBTDGame(tileAttackDefinition);
                  }
                  else
                  {
                     enableMouse();
                  }
               });
            }
            else
            {
               launchBTDGame(tileAttackDefinition);
            }
         });
      }
      
      private function launchBTDGame(param1:TileAttackDefinition) : void
      {
         var tileAttackDefinition:TileAttackDefinition = param1;
         isInGame = true;
         TransitionSignals.closeCurtainCompleteSignal.addOnce(function():void
         {
            onCurtainsClosed(tileAttackDefinition);
         });
         TransitionSignals.beganLoadingBTDGame.dispatch();
      }
      
      public function onCurtainsClosed(param1:TileAttackDefinition) : void
      {
         var tile:Tile = null;
         var btdGameRequest:BTDGameRequest = null;
         var tileAttackDefinition:TileAttackDefinition = param1;
         this._cursorManager.hideCurrentCursor();
         this._transition.transitionTo(this._btdView);
         this._pendingTileAttackDefinition = tileAttackDefinition;
         tile = this._worldView.map.tileAtPoint(tileAttackDefinition.attackAtLocation);
         var monkeyTeamTowers:Array = GameEventManager.getInstance().monkeyTeam.getCurrentActiveMonkeyTeam();
         btdGameRequest = new BTDGameRequest().ExtraRedHotSpikes(this._resourceStore.redHotSpikes).ExtraMonkeyBoosts(this._resourceStore.monkeyBoosts).Difficulty(tileAttackDefinition.difficultyLevel).AvailableUpgrades(this._system.city.upgradeTree.getDescriptionForBTDModule()).AvailableTowers(this._system.city.buildingManager.getAvailableTowersDescription(tile.type)).StartingMoney(this._resourceStore.btdStartingMoney + this._resourceStore.btdBonusStartingMoney).StartingLives(this._resourceStore.btdStartingLives).CityIndex(this._system.city.cityIndex).TerrainType(tileAttackDefinition.terrainType).BloonWeights(BloonPredictor.getWeightsDefinition(tileAttackDefinition.difficultyLevel,true,tile.variantHint)).TileUniqueData(tile.uniqueDataDefinition).TrackSelectionBias(tile.trackSelectionBias).DifficultyRankRelativeToMTL(tileAttackDefinition.difficultyRankRelativeToMTL).DifficultyDescription(tileAttackDefinition.difficultyDescription).IsCamoTile(tile.isCamoTile).IsRegenTile(tile.isRegenTile).Seed(tile.seed).TutorialSave(QuestCounter.getInstance().getCustomValue("tutorialSave") || {}).IsHardcore(tileAttackDefinition.isHardcore).Crates(tileAttackDefinition.crates).BonusCashAmount(tileAttackDefinition.bonusStartingCash).IsBonusCashMode(tileAttackDefinition.isBonusCashMode).IsBloonBeacon(tileAttackDefinition.isBloonBeacon).MonkeyTeamTowers(monkeyTeamTowers);
         this._activeBTDGameRequest = btdGameRequest;
         if(tile.terrainSpecialProperty != null && tile.terrainSpecialProperty.id == Constants.CAVES)
         {
            if(tile.uniqueDataDefinition.trackID != 0)
            {
               tile.uniqueDataDefinition.trackID = 0;
            }
         }
         SpecialMissionsManager.getInstance().applySpecialMission(btdGameRequest,tile);
         this.signals.btdGameRequestSet.dispatch(btdGameRequest);
         this._btdView.gameCompleteSignal.addOnce(this.onBTDGameComplete);
         this._btdView.playGame(btdGameRequest,function playGameCallback():void
         {
            var _loc1_:Array = null;
            if(btdGameRequest.tileUniqueData.numberOfTimesAttacked === 1)
            {
               _loc1_ = [tile];
               CityDataPersistence.getInstance().saveValue(CityDataPersistence.TILES_KEY,_loc1_);
            }
         });
         GameSignals.BTD_GAME_LAUNCHED_SIGNAL.dispatch({
            "track":tile.uniqueDataDefinition.trackClassName,
            "difficulty":tileAttackDefinition.difficultyLevel,
            "cityLevel":this._resourceStore.townLevel.toString(),
            "bonusStartingCash":tileAttackDefinition.bonusStartingCash.toString()
         });
         WorldView.stopOverlayItems();
         WorldView.stopOverlayFlashItems();
      }
      
      public function launchReplay(param1:BTDGameRequest) : void
      {
         var btdGameRequest:BTDGameRequest = param1;
         PanelManager.getInstance().showPanelOverlay(TownUI.getInstance().loading);
         isInGame = true;
         TransitionSignals.closeCurtainCompleteSignal.addOnce(function():void
         {
            _cursorManager.hideCurrentCursor();
            _transition.transitionTo(_btdView);
            _pendingTileAttackDefinition = null;
            _activeBTDGameRequest = btdGameRequest;
            signals.btdGameRequestSet.dispatch(btdGameRequest);
            _btdView.gameCompleteSignal.addOnce(onBTDReplayComplete);
            _btdView.playGame(btdGameRequest);
            WorldView.stopOverlayItems();
            WorldView.stopOverlayFlashItems();
            TownUI.getInstance().loading.hide();
         });
         TransitionSignals.beganLoadingBTDGame.dispatch();
      }
      
      public function launchContestedTerritory(param1:BTDGameRequest) : void
      {
         var btdGameRequest:BTDGameRequest = param1;
         PanelManager.getInstance().showPanelOverlay(TownUI.getInstance().loading);
         isInGame = true;
         TransitionSignals.closeCurtainCompleteSignal.addOnce(function():void
         {
            _cursorManager.hideCurrentCursor();
            _transition.transitionTo(_btdView);
            _pendingTileAttackDefinition = null;
            _activeBTDGameRequest = btdGameRequest;
            signals.btdGameRequestSet.dispatch(btdGameRequest);
            _btdView.gameCompleteSignal.addOnce(onBTDGameContestedTerritoryComplete);
            _btdView.playGame(btdGameRequest);
            WorldView.stopOverlayItems();
            WorldView.stopOverlayFlashItems();
            TownUI.getInstance().loading.hide();
         });
         TransitionSignals.beganLoadingContestedGame.dispatch();
         TransitionSignals.beganLoadingBTDGame.dispatch();
      }
      
      public function launchContestedTerritoryWithEnabledCheck(param1:BTDGameRequest) : void
      {
         var btdGameRequest:BTDGameRequest = param1;
         this.ui.genericModalSpinner.reveal(1);
         CachedPreMaintenanceChecker.checkPreMaintenance(function(param1:Boolean):void
         {
            var isPreMaintenance:Boolean = param1;
            ui.genericModalSpinner.hide();
            if(isPreMaintenance)
            {
               ui.maintenanceScheduledMessage.showCTStartPremaintenanceMessage(function(param1:Boolean):void
               {
                  if(param1)
                  {
                     launchContestedTerritory(btdGameRequest);
                  }
                  else
                  {
                     enableMouse();
                     TownUI.getInstance().contestedTerritoryPanel.premaintenanceCancel();
                  }
               });
            }
            else
            {
               launchContestedTerritory(btdGameRequest);
            }
         });
      }
      
      public function launchBTDBossBattle(param1:BTDGameRequest) : void
      {
         var btdGameRequest:BTDGameRequest = param1;
         PanelManager.getInstance().showPanelOverlay(TownUI.getInstance().loading);
         isInGame = true;
         TransitionSignals.closeCurtainCompleteSignal.addOnce(function():void
         {
            _cursorManager.hideCurrentCursor();
            _transition.transitionTo(_btdView);
            _pendingTileAttackDefinition = null;
            _activeBTDGameRequest = btdGameRequest;
            signals.btdGameRequestSet.dispatch(btdGameRequest);
            _btdView.gameCompleteSignal.addOnce(onBossBattleComplete);
            _btdView.playGame(btdGameRequest);
            WorldView.stopOverlayItems();
            WorldView.stopOverlayFlashItems();
            TownUI.getInstance().loading.hide();
         });
         TransitionSignals.beganLoadingBTDGame.dispatch();
      }
      
      private function prepareToReturnToCity(param1:GameResultDefinition, param2:Boolean) : void
      {
         PanelManager.getInstance().reset();
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.dispatch(param1,this._pendingTileAttackDefinition,this._activeBTDGameRequest);
         MCMusic.playMapMusic(this._system.city.cityIndex);
         setTimeout(TransitionSignals.endTransitionFromBTDToCity.dispatch,1500);
         this._transition.transitionTo(_instance);
         this.mouseManager.setMouseActive(false);
         WorldView.resumeOverlayItems();
         WorldView.resumeOverlayFlashItmes();
         StatsDataManager.getInstance().trackBloonsPopped(param1);
      }
      
      private function onBTDReplayComplete(param1:GameResultDefinition, param2:Boolean = false) : void
      {
         var gameResult:GameResultDefinition = param1;
         var gameWasSkipped:Boolean = param2;
         this.prepareToReturnToCity(gameResult,gameWasSkipped);
         TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
         {
            var remainingLives:int = 0;
            var cashEarned:int = 0;
            var newGameResult:Object = null;
            var rewardBloonstones:int = 0;
            var rewardCash:int = 0;
            if(gameResult.success)
            {
               remainingLives = gameResult.startingLives - gameResult.livesLost;
               cashEarned = Calculator.getCashFromAttack(_activeBTDGameRequest.difficulty,remainingLives);
               newGameResult = {
                  "roundReached":gameResult.roundReached,
                  "roundsNeededToWin":gameResult.roundsNeededToWin,
                  "xpEarned":0,
                  "cashEarned":cashEarned,
                  "bloonstonesEarned":0,
                  "treasureRecovered":0,
                  "terrainSpecialProperty":null,
                  "tile":null,
                  "livesLost":gameResult.livesLost,
                  "terrainType":_activeBTDGameRequest.terrainType,
                  "terrainName":_activeBTDGameRequest.terrainName,
                  "canHaveMonkeyTeamReward":gameResult.canHaveMonkeyTeamReward
               };
               ui.winInfoPanel.onHideSignal.addOnce(function():void
               {
                  signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
               });
               ui.winInfoPanel.gamePlayComplete(newGameResult);
               PanelManager.getInstance().showPanel(ui.winInfoPanel,null,0);
               TownUI.getInstance().informationBar.lockDisplay();
               rewardBloonstones = GameMods.awardBloonstones(newGameResult.bloonstonesEarned);
               rewardCash = GameMods.awardCash(cashEarned);
               TownUI.getInstance().informationBar.addRewardDisplay(ui.winInfoPanel.hideStartSignal,0,0,rewardCash,0,0,rewardBloonstones);
               TownUI.getInstance().informationBar.unlockDisplay();
               MCSound.getInstance().playDelayedSound(MCSound.VICTORY,1,0.3);
            }
            else
            {
               ui.loseInfoPanel.onHideSignal.addOnce(function():void
               {
                  signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
               });
               ui.loseInfoPanel.syncToGameResult(gameResult);
               PanelManager.getInstance().showPanel(ui.loseInfoPanel,null,0);
            }
            enableMouse();
            isInGame = false;
         });
      }
      
      private function onBTDGameContestedTerritoryComplete(param1:GameResultDefinition, param2:Boolean = false) : void
      {
         var gameResult:GameResultDefinition = param1;
         var gameWasSkipped:Boolean = param2;
         this.prepareToReturnToCity(gameResult,gameWasSkipped);
         TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
         {
            if(gameResult.success == false && gameResult.contestedTerritoryExpired == false)
            {
               ui.loseInfoPanel.syncToGameResult(gameResult);
               PanelManager.getInstance().showPanel(ui.loseInfoPanel,null,0);
            }
            enableMouse();
            isInGame = false;
            TownUI.getInstance().contestedTerritoryPanel.btdGameEnded(gameResult);
         });
      }
      
      private function onBossBattleComplete(param1:GameResultDefinition, param2:Boolean = false) : void
      {
         var gameResult:GameResultDefinition = param1;
         var gameWasSkipped:Boolean = param2;
         this.prepareToReturnToCity(gameResult,gameWasSkipped);
         QuestCounter.getInstance().setCustomValue("tutorialSave",gameResult.tutorialSave);
         TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
         {
            var _loc1_:BossBattleVictoryPanel = null;
            if(gameResult.success)
            {
               _loc1_ = TownUI.getInstance().bossBattleVictoryPanel;
               PanelManager.getInstance().showPanel(_loc1_);
            }
            enableMouse();
            isInGame = false;
         });
      }
      
      private function onBTDGameComplete(param1:GameResultDefinition) : void
      {
         var incomingRaid:IncomingRaid = null;
         var wasDefendingPvP:Boolean = false;
         var attackDefinition:TileAttackDefinition = null;
         var gameWasSkipped:Boolean = false;
         var attackLocation:IntPoint2D = null;
         var tile:Tile = null;
         var wasBloonBeacon:Boolean = false;
         var gameResult:GameResultDefinition = param1;
         incomingRaid = this._pendingIncomingRaid;
         this._pendingIncomingRaid = null;
         wasDefendingPvP = incomingRaid !== null;
         PanelManager.getInstance().reset();
         PanelManager.getInstance().lock = true;
         if(false == gameResult.skippedTrivial)
         {
            TownUI.getInstance().hideHUD(0);
         }
         if(wasDefendingPvP)
         {
            MapBottomUI.getInstance().disableAllButtons();
         }
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.dispatch(gameResult,this._pendingTileAttackDefinition,this._activeBTDGameRequest);
         MCMusic.playMapMusic(this._system.city.cityIndex);
         attackDefinition = this._pendingTileAttackDefinition;
         this._pendingTileAttackDefinition = null;
         gameWasSkipped = gameResult.skippedTrivial;
         this.prepareToReturnToCity(gameResult,gameWasSkipped);
         if(!gameResult.cancelledGame)
         {
         }
         attackLocation = attackDefinition.attackAtLocation;
         tile = this._worldView.map.tileAtPoint(attackDefinition.attackAtLocation);
         var wasBossBattle:Boolean = this._activeBTDGameRequest !== null && this._activeBTDGameRequest.bossAttack !== null;
         wasBloonBeacon = attackDefinition.isBloonBeacon;
         if(!gameWasSkipped)
         {
            setTimeout(TransitionSignals.endTransitionFromBTDToCity.dispatch,1500);
            QuestCounter.getInstance().setCustomValue("tutorialSave",gameResult.tutorialSave);
         }
         else
         {
            TransitionSignals.endTransitionFromBTDToCity.dispatch();
         }
         this._transition.transitionTo(_instance);
         this.mouseManager.setMouseActive(false);
         this.signals.completedGameDialogClosedSignal.addOnce(function():void
         {
            var _loc1_:Boolean = false;
            _worldView.addGameResultAnimation(gameResult.success,attackLocation.x * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE * 0.5,attackLocation.y * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE * 0.5,0.3);
            signals.btdVictoryDialogClosedSignal.dispatch(Boolean(gameResult.success));
            if(gameResult.success && wasBloonBeacon)
            {
               _loc1_ = GameEventManager.getInstance().bossEventManager.bossIsActive;
               if(_loc1_)
               {
                  PanelManager.getInstance().showFreePanel(BloonBeaconSystem.getInstance().ui.bloonBeaconVictoryPanelBoss);
               }
               else
               {
                  PanelManager.getInstance().showFreePanel(BloonBeaconSystem.getInstance().ui.bloonBeaconVictoryPanel);
               }
            }
         });
         WorldView.resumeOverlayItems();
         WorldView.resumeOverlayFlashItmes();
         var wasAlreadyCaptured:Boolean = false;
         TransitionSignals.raiseCurtainCompleteSignal.addOnce(function():void
         {
            var trackName:String = null;
            var xpEarned:int = 0;
            var treasureRecovered:String = null;
            var wasSpecialMission:Boolean = false;
            var wasHardcore:Boolean = false;
            var cashEarned:int = 0;
            var bloonstonesEarned:int = 0;
            var newGameResult:Object = null;
            var remainingLives:int = 0;
            var monkeyKnowledgeRewards:Object = null;
            var currentWinPanel:HideRevealView = null;
            var rewardXP:int = 0;
            var rewardCash:int = 0;
            var rewardBS:int = 0;
            if(gameResult.success)
            {
               if(tile.isCaptured)
               {
                  wasAlreadyCaptured = true;
               }
               tile.isCaptured = true;
               tile.addCitizens();
               _worldView.map.fenceBuilder.updateFenceAroundLocation(attackLocation.x,attackLocation.y);
               xpEarned = Calculator.getXPFromAttack(_worldView.map,attackDefinition.difficultyLevel,attackDefinition.difficultyRankRelativeToMTL);
               treasureRecovered = "You have found a treasure!";
               wasSpecialMission = _activeBTDGameRequest !== null && _activeBTDGameRequest.specialMissionID !== null;
               wasHardcore = gameResult.wasHardcore;
               cashEarned = 0;
               bloonstonesEarned = 0;
               newGameResult = null;
               remainingLives = gameResult.startingLives - gameResult.livesLost;
               if(!gameWasSkipped)
               {
                  if(tile.uniqueDataDefinition != null && tile.uniqueDataDefinition.trackClassName != null)
                  {
                     TrackManager.getInstance().unlockTrack(tile.uniqueDataDefinition.trackClassName);
                  }
                  cashEarned = Calculator.getCashFromAttack(_activeBTDGameRequest.difficulty,remainingLives);
                  bloonstonesEarned = gameResult.didPlayerLoseALife == false?int(_system.NO_LIVES_LOST_BLOONSTONES_BONUS):0;
                  if(wasHardcore)
                  {
                     cashEarned = cashEarned * Constants.HARDCORE_MODE_MODIFIER;
                     bloonstonesEarned = bloonstonesEarned * Constants.HARDCORE_MODE_MODIFIER;
                  }
                  monkeyKnowledgeRewards = MonkeyKnowledgeRewards.getInstance().giveTileCaptureRewards();
                  newGameResult = {
                     "roundReached":gameResult.roundReached,
                     "roundsNeededToWin":gameResult.roundsNeededToWin,
                     "xpEarned":xpEarned,
                     "cashEarned":cashEarned,
                     "bloonstonesEarned":bloonstonesEarned,
                     "treasureRecovered":treasureRecovered,
                     "terrainSpecialProperty":tile.terrainSpecialProperty,
                     "tile":tile,
                     "livesLost":gameResult.livesLost,
                     "didPlayerLoseALife":gameResult.didPlayerLoseALife,
                     "monkeyKnowledgeRewards":monkeyKnowledgeRewards,
                     "canHaveMonkeyTeamReward":gameResult.canHaveMonkeyTeamReward
                  };
                  SpecialMissionsManager.getInstance().setBaseReward(newGameResult);
                  if(wasDefendingPvP)
                  {
                     ui.pvpWinInfoPanel.gamePlayComplete(incomingRaid,newGameResult);
                  }
                  else
                  {
                     ui.winInfoPanel.onHideSignal.addOnce(function():void
                     {
                        signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
                     });
                     ui.winInfoPanel.gamePlayComplete(newGameResult);
                     PanelManager.getInstance().showPanel(ui.winInfoPanel);
                  }
                  if(newGameResult != null)
                  {
                     if(wasDefendingPvP)
                     {
                        currentWinPanel = ui.pvpWinInfoPanel;
                     }
                     else
                     {
                        currentWinPanel = ui.winInfoPanel;
                     }
                     TownUI.getInstance().informationBar.lockDisplay();
                     rewardXP = 0;
                     rewardCash = 0;
                     rewardBS = 0;
                     if(newGameResult.xpEarned != null)
                     {
                        rewardXP = rewardXP + GameMods.awardXP(newGameResult.xpEarned);
                     }
                     if(newGameResult.cashEarned != null)
                     {
                        rewardCash = rewardCash + GameMods.awardCash(newGameResult.cashEarned);
                     }
                     if(newGameResult.bloonstonesEarned != null)
                     {
                        rewardBS = rewardBS + GameMods.awardBloonstones(newGameResult.bloonstonesEarned);
                     }
                     if(newGameResult.terrainBonusMoney != null)
                     {
                        rewardCash = rewardCash + GameMods.awardCash(newGameResult.terrainBonusMoney);
                     }
                     if(newGameResult.terrainBonusBloonstones != null)
                     {
                        rewardBS = rewardBS + GameMods.awardBloonstones(newGameResult.terrainBonusBloonstones);
                     }
                     TownUI.getInstance().informationBar.addRewardDisplay(currentWinPanel.hideStartSignal,rewardXP,0,rewardCash,0,0,rewardBS);
                     TownUI.getInstance().informationBar.unlockDisplay();
                  }
               }
               else
               {
                  xpEarned = 0;
               }
               signals.btdGameWonSignal.dispatch();
               GameSignals.BTD_GAME_WON_SIGNAL.dispatch(gameResult);
               if(!gameWasSkipped)
               {
                  MCSound.getInstance().playDelayedSound(MCSound.VICTORY,1,0.3);
               }
               else
               {
                  signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
               }
               Tile.tileChangedSignal.dispatch(tile);
               if(tile.hasTreasureChest)
               {
                  GameSignals.TREASURE_CHEST_CAPTURED.dispatch();
                  _specialItemStore.extractTreasureFromTile(tile,_worldView.map);
               }
               if(!gameWasSkipped)
               {
                  if(TileDefinitions.getInstance().isVolcano(tile))
                  {
                     _specialItemStore.acquiredBloonstones(Calculator.getBloonstoneFromVolcano(attackDefinition.difficultyLevel));
                  }
                  else if(TileDefinitions.getInstance().isCave(tile))
                  {
                     _specialItemStore.acquiredCash(Calculator.getCashFromCave(attackDefinition.difficultyLevel));
                     _specialItemStore.acquiredBloonstones(Calculator.getBloonstoneFromCave(attackDefinition.difficultyLevel));
                  }
                  SpecialMissionsManager.getInstance().rewardSpecialMission();
               }
               _worldView.updateFogOfWar();
               if(wasDefendingPvP)
               {
                  GameSignals.PVP_WON_SIGNAL.dispatch({
                     "attackID":incomingRaid.attackID,
                     "xpEarned":(newGameResult.xpEarned != null?newGameResult.xpEarned:0),
                     "investedBloontonium":incomingRaid.attack.investedBloontonium.toString(),
                     "defenderCityLevel":incomingRaid.attack.defenderCityLevel.toString()
                  });
               }
               GameSignals.TILE_CAPTURED_SIGNAL.dispatch(tile,_worldView.map,attackDefinition,gameWasSkipped);
            }
            else
            {
               GameSignals.BTD_GAME_LOST_SIGNAL.dispatch(gameResult);
               if(wasDefendingPvP)
               {
                  GameSignals.PVP_LOST_SIGNAL.dispatch({
                     "attackID":incomingRaid.attackID,
                     "investedBloontonium":incomingRaid.attack.investedBloontonium.toString(),
                     "defenderCityLevel":incomingRaid.attack.defenderCityLevel.toString()
                  });
               }
               else
               {
                  ui.loseInfoPanel.onHideSignal.addOnce(function():void
                  {
                     signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
                  });
                  ui.loseInfoPanel.syncToGameResult(gameResult);
                  PanelManager.getInstance().showPanel(ui.loseInfoPanel);
                  setTimeout(function():void
                  {
                     signals.completedGameDialogClosedSignal.dispatch(Boolean(gameResult.success));
                  },10);
               }
            }
            SpecialMissionsManager.getInstance().resetMission();
            if(wasDefendingPvP)
            {
               PvPSignals.defendAttackComplete.dispatch(gameResult,incomingRaid);
            }
            if(_activeBTDGameRequest && _activeBTDGameRequest.tileUniqueData && _activeBTDGameRequest.tileUniqueData.trackClassName)
            {
               trackName = _activeBTDGameRequest.tileUniqueData.trackClassName;
            }
            else
            {
               trackName = "skipped";
            }
            _activeBTDGameRequest = null;
            if(gameWasSkipped)
            {
               enableMouse();
            }
            isInGame = false;
            ui.interstitialController.btdGameComplete();
            if(!wasDefendingPvP)
            {
               PanelManager.getInstance().lock = false;
               TownUI.getInstance().revealHud();
               PanelManager.getInstance().showNextPanel();
            }
         });
      }
      
      public function reveal() : void
      {
         if(this._cityCommonDataManager.numberOfCities === 0)
         {
            this.ui.hideHUD();
            this.ui.newCityPanel.showFirstCityView();
            this.openingNewCityPanelSignal.dispatch();
         }
      }
      
      public function revealMyCities() : void
      {
         this.ui.myCitiesPanel.populateInfo(true,this._system.city.cityIndex);
         PanelManager.getInstance().showPanelOverlay(this.ui.myCitiesPanel);
      }
      
      public function prepareToReveal() : void
      {
      }
      
      public function prepareToExit() : void
      {
         this.sleep();
      }
      
      public function arriveAfterTransition() : void
      {
         this.wake();
      }
      
      public function sleepAfterExit() : void
      {
         this.sleep();
      }
      
      public function process(param1:Number) : void
      {
         if(!this._worldView.map.worldIsReady)
         {
            return;
         }
         this.mouseManager.tick();
         this._worldView.tick();
         BloonResearchLabState.tick();
         this.ui.tick();
         this._pvpMain.update();
      }
      
      public function draw(param1:BitmapData) : void
      {
         this._worldView.render(param1);
      }
      
      public function clear() : void
      {
         this._autoSaver.off();
         this._worldView.clear();
         this._autoSaver.on();
      }
      
      public function getTownMapSaveDefinition() : TownMapSaveDefinition
      {
         return this._worldView.getTownMapSaveDefinition();
      }
      
      public function populateFromSaveDefinition(param1:TownMapSaveDefinition) : void
      {
         this._worldView.populateFromSaveDefinition(param1);
      }
      
      public function toggleFog() : void
      {
         this._worldView.toggleFog();
      }
      
      public function saveMapImage() : void
      {
         this._worldView.map.saveMapImage();
      }
      
      public function saveMapDescription() : void
      {
         this._worldView.map.exportMapDescription();
      }
      
      public function multiMapTest() : void
      {
         new MapTest(this._worldView.map);
      }
      
      public function testMoveConsecrated() : void
      {
         this.worldView.testMoveConsecrated();
      }
      
      public function get isContestedTerritory() : Boolean
      {
         if(this._activeBTDGameRequest == null)
         {
            return false;
         }
         return this._activeBTDGameRequest.isContestedTerritory;
      }
      
      public function get worldView() : WorldView
      {
         return this._worldView;
      }
      
      public function get activeBTDGameRequest() : BTDGameRequest
      {
         return this._activeBTDGameRequest;
      }
      
      public function get btdView() : BTDView
      {
         return this._btdView;
      }
   }
}
