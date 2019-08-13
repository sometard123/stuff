package ninjakiwi.monkeyTown.town.bmcEvents
{
   import assets.town.BouncyArrow;
   import assets.town.MyCitiesPanelClip;
   import assets.town.TownAvatarContainer;
   import assets.ui.WatchVideoPanelClip;
   import com.adobe.crypto.MD5;
   import com.codecatalyst.promise.Promise;
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.achievements.tests.AttackWonTest;
   import ninjakiwi.monkeyTown.achievements.tests.BTDGameCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BloonResearchLabUpgradeCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BuildCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.CashPillagedTest;
   import ninjakiwi.monkeyTown.achievements.tests.CityLevelChangedTest;
   import ninjakiwi.monkeyTown.achievements.tests.ContestedTest;
   import ninjakiwi.monkeyTown.achievements.tests.DefendAttackTest;
   import ninjakiwi.monkeyTown.achievements.tests.HonorTest;
   import ninjakiwi.monkeyTown.achievements.tests.MoneyCapacityIncreasedTest;
   import ninjakiwi.monkeyTown.achievements.tests.RevengeAttackLaunchedTest;
   import ninjakiwi.monkeyTown.achievements.tests.TileCapturedTest;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.dust.Particle;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePersistence;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.BuildingFactory;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.FirstTimeTriggerData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.tile.TileHighlighter;
   import ninjakiwi.monkeyTown.town.tile.TilePulsator;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.BuildPanel;
   import ninjakiwi.monkeyTown.town.ui.FirstTimeTriggerPanel;
   import ninjakiwi.monkeyTown.town.ui.MapBottomUI;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BossIsHidingCustomButtons;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.DefaultEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.KnowledgePackSaleEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.manageCitiesPanel.CityInformation;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge._flipButton;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.onClickedShake;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.playFlipSound;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.preFlipShudder;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.that;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.FlagRegistry;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import ninjakiwi.net.JSONRequest;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   import ninjakiwi.sharedFrameAnalyser.FrameCacher;
   import org.osflash.signals.Signal;
   
   public class FirstTimeTriggerManager
   {
      
      private static var instance:FirstTimeTriggerManager;
      
      public static var firstTimeTutorialFinished:Signal = new Signal();
      
      public static var tutorialStateChanged:Signal = new Signal();
       
      
      private var _map:TownMap;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _resourceStore:ResourceStore;
      
      private var _monkeyCityMain:MonkeyCityMain;
      
      private var _triggeredFlags:FlagRegistry;
      
      private var _uiPanel:FirstTimeTriggerPanel;
      
      private var _data:FirstTimeTriggerData;
      
      private var _bananaFarmArrow:BouncyArrow;
      
      private var _firstLandArrow:BouncyArrow;
      
      private var _mapBottomUI:MapBottomUI;
      
      private var _upgradeData:UpgradeData;
      
      private var _buildingData:BuildingData;
      
      private var _townUI:TownUI;
      
      private var _buildPanel:BuildPanel;
      
      private var _firstBuilding:Building;
      
      private var _firstTile:Tile;
      
      private var _buildingFactory:BuildingFactory;
      
      private var _mousePositionInTileSpace:IntPoint2D;
      
      private var _worldView:WorldView;
      
      private const _tileHighlighter:TileHighlighter = new TileHighlighter();
      
      private var _stateFlagIDs:Array;
      
      private var _tutorialCameraOffset:IntPoint2D;
      
      private var _continueFunction:Function;
      
      private var _continueParameter:TileAttackDefinition;
      
      private var _bloonTypeString:String;
      
      private const MIN_POWER_OF_BUILDING:int = 5;
      
      public function FirstTimeTriggerManager(param1:WorldView, param2:FirstTimeTriggerPanel)
      {
         this._resourceStore = ResourceStore.getInstance();
         this._monkeyCityMain = MonkeyCityMain.getInstance();
         this._triggeredFlags = new FlagRegistry();
         this._data = FirstTimeTriggerData.getInstance();
         this._mapBottomUI = MapBottomUI.getInstance();
         this._upgradeData = UpgradeData.getInstance();
         this._buildingData = BuildingData.getInstance();
         this._buildingFactory = BuildingFactory.getInstance();
         this._stateFlagIDs = [this._data.TUTORIAL_WELCOME.id,this._data.TUTORIAL_BUILDING.id,this._data.TUTORIAL_WAITING.id,this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,this._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id];
         this._tutorialCameraOffset = new IntPoint2D();
         super();
         if(instance != null)
         {
            throw new Error("FirstTimeTriggerManager already instantiated. use FirstTimeTriggerManager.getInstance() instead");
         }
         instance = this;
         this._worldView = param1;
         this._map = param1.map;
         this._uiPanel = param2;
         this.init();
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      public static function getInstance() : FirstTimeTriggerManager
      {
         return instance;
      }
      
      public static function get tutorialIsActive() : Boolean
      {
         if(MonkeySystem.getInstance().city.cityIndex > 0)
         {
            return false;
         }
         return !instance._triggeredFlags.getState(instance._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id);
      }
      
      private function onReset() : void
      {
         this._triggeredFlags = new FlagRegistry();
         this._uiPanel.sequenceCompleteSignal.removeAll();
         this._uiPanel.nextInSequenceSignal.removeAll();
         this._uiPanel.okSignal.removeAll();
         this._resourceStore.banksAreFullSignal.remove(this.onBanksAreFullSignal);
         PvPSignals.defendTileRevealed.remove(this.onPvpDefense);
         PvPSignals.defendAttackComplete.remove(this.onPvpDefenseComplete);
         GameSignals.POWER_USED_CHANGED_DIFF.remove(this.onPowerChanged);
         GameSignals.BLOONTONIUM_GENERATOR_CLICKED.remove(this.startNeedBloontoniumStorageTutorial);
         this._townUI.pvpAttackPanel.onRevealSignal.remove(this.onAttackPanelRevealed);
         this._townUI.requestAttackUISignal.remove(this.onRequestAttackUI);
         this._townUI.requestAttackUISignal.remove(this.onRequestFirstAttackUI);
         this._monkeyCityMain.signals.cancelledAttackSignal.remove(this.welcomeCancelledAttack);
         this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.remove(this.welcomeSequenceVictoryDialogClosed);
         this._monkeyCityMain.signals.btdGameRequestSet.remove(this.onBTDGameRequestSet);
         this._mapBottomUI.buildButtonClickedSignal.remove(this.buildTutorialBuildButtonClicked);
         Building.buildingWasPlacedSignal.remove(this.buildTutorialBuildingPlaced);
         this._buildPanel.buildPanelWasClosedSignal.remove(this.buildTutorialBuildPanelCancled);
         this._buildPanel.buildingWasSelectedSignal.remove(this.buildTutorialBuildingSelected);
         this._monkeyCityMain.signals.cancelPlacingBuildingSignal.remove(this.buildTutorialBuildingCanceled);
         this._monkeyCityMain.signals.buildPanelOpenedSignal.remove(this.toturoalFirstBuildingBuildOpened);
         this._monkeyCityMain.signals.buildPanelClosedSignal.remove(this.toturoalFirstBuildingBuildClosed);
         if(this._firstBuilding != null)
         {
            this._firstBuilding.buildCompleteSignal.remove(this.waitingTutorialBuildingCompleted);
         }
         this._mapBottomUI.myTowersButtonClickedSignal.remove(this.toturoalFirstBuildingMyTowerOpened);
         this._monkeyCityMain.signals.myTowersPanelClosedSignal.remove(this.toturoalFirstBuildingMyTowerClosed);
         this._townUI.requestAttackUISignal.remove(this.firstBuildingRequestFirstAttackUI);
         this._monkeyCityMain.signals.cancelledAttackSignal.remove(this.firstBuildingCancelledAttack);
         this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.remove(this.buildAcadamyStart);
         Building.buildingWasPlacedSignal.remove(this.buildAcademyTutorialBuildingPlaced);
         this._mapBottomUI.buildButtonClickedSignal.remove(this.buildAcademyTutorialBuildButtonClicked);
         this._buildPanel.buildPanelWasClosedSignal.remove(this.buildAcademyTutorialBuildPanelCancled);
         this._buildPanel.buildingWasSelectedSignal.remove(this.buildAcademyTutorialBuildingSelected);
         this._monkeyCityMain.signals.cancelPlacingBuildingSignal.remove(this.buildAcademyTutorialBuildingCanceled);
         this._resourceStore.monkeyMoneyChangedDiffSignal.remove(this.monkeyChanged);
         if(this._firstLandArrow != null)
         {
            WorldView.removeOverlayItem(this._firstLandArrow);
         }
         if(this._bananaFarmArrow != null)
         {
            WorldView.removeOverlayItem(this._bananaFarmArrow);
         }
         this._townUI.setMyTowersArrowActive(false);
         this._townUI.setBuildArrowActive(false);
      }
      
      private function init() : void
      {
         var _loc1_:String = String(Capabilities.playerType);
         if(_loc1_ == "StandAlone")
         {
         }
         this._townUI = TownUI.getInstance();
         this._buildPanel = this._townUI.buildPanel;
         GameSignals.BTD_GAME_WON_SIGNAL.add(this.onBTDGameComplete);
      }
      
      private function onBTDGameComplete(... rest) : void
      {
         this.checkForSpecialTownPositionTweakConditions();
      }
      
      private function checkForSpecialTownPositionTweakConditions() : void
      {
         if(this._triggeredFlags.getState(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id) && !this._triggeredFlags.getState(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id))
         {
            this._tutorialCameraOffset.y = -50;
            this.onResize(0,0);
            GameSignals.BTD_GAME_WON_SIGNAL.remove(this.onBTDGameComplete);
         }
      }
      
      public function getSaveData() : Object
      {
         return this._triggeredFlags.flags;
      }
      
      public function setSaveData(param1:Object) : void
      {
         this._triggeredFlags.flags = param1 || {};
         if(tutorialIsActive)
         {
            this.onResize(0,0);
         }
         this.checkForSpecialTownPositionTweakConditions();
      }
      
      private function sequenceComplete(param1:FirstTimeTriggerDefinition = null) : void
      {
         this.reactivateMonkeyCityMain();
      }
      
      private function reactivateMonkeyCityMain() : void
      {
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.enableDrag();
         this._monkeyCityMain.mouseManager.lock();
      }
      
      private function initialiseTrigger(param1:FirstTimeTriggerDefinition, param2:Function = null, param3:Function = null, param4:Boolean = false) : void
      {
         this._uiPanel.nextInSequenceSignal.removeAll();
         this._uiPanel.sequenceCompleteSignal.removeAll();
         if(param2 != null)
         {
            this._uiPanel.nextInSequenceSignal.add(param2);
         }
         if(param3 != null)
         {
            this._uiPanel.sequenceCompleteSignal.add(param3);
         }
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(false);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._uiPanel.beginTrigger(param1,param4);
      }
      
      private function setStateByIndex(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._stateFlagIDs.length)
         {
            _loc2_ = this._stateFlagIDs[_loc3_];
            if(_loc3_ <= param1)
            {
               this._triggeredFlags.setState(_loc2_,true);
            }
            else
            {
               this._triggeredFlags.setState(_loc2_,false);
            }
            _loc3_++;
         }
      }
      
      private function setStateByID(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:int = this._stateFlagIDs.indexOf(param1);
         if(!param2)
         {
            _loc3_--;
         }
         this.setStateByIndex(_loc3_);
      }
      
      public function checkTutorial() : Boolean
      {
         if(this._system.city.cityIndex > 0)
         {
            this.configureTutorialCompleted();
            return false;
         }
         Building.demolishEnabled = false;
         WorldView.mouseEnableAfterInit = false;
         AddStartCashModule.enableTickBox = false;
         Building.infoEnabled = false;
         this._firstTile = this._map.tileAt(MonkeySystem.getInstance().FIRST_BUILDING.x,MonkeySystem.getInstance().FIRST_BUILDING.y);
         this._firstBuilding = this._firstTile.building;
         var _loc1_:Boolean = this._firstTile.isCaptured;
         var _loc2_:* = this._map.totalCapturedCount() >= 2;
         var _loc3_:Object = this._system.city.buildingManager.getCompletedBuildingCount(this._buildingData.MONKEY_ACADEMY.id);
         var _loc4_:* = _loc3_.complete > 0;
         var _loc5_:Boolean = _loc4_ || _loc3_.incomplete > 0;
         var _loc6_:Boolean = this._firstTile.building !== null || _loc5_;
         var _loc7_:Boolean = _loc6_ && (this._firstTile.building !== null && this._firstTile.building.buildComplete || _loc5_);
         if(!_loc1_)
         {
            this.setStateByIndex(-1);
         }
         if(_loc1_ && !_loc6_)
         {
            this.setStateByID(this._data.TUTORIAL_BUILDING.id,false);
         }
         if(_loc1_ && _loc6_ && !_loc7_)
         {
            this.setStateByID(this._data.TUTORIAL_WAITING.id,false);
         }
         if(_loc1_ && _loc7_ && !_loc2_)
         {
            this.setStateByID(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,false);
         }
         if(_loc1_ && _loc7_ && _loc2_)
         {
            this.setStateByID(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,true);
         }
         if(_loc1_ && _loc7_ && _loc5_ && !_loc4_)
         {
         }
         if(_loc7_ && _loc5_)
         {
            this.setStateByID(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id,true);
         }
         var _loc8_:Boolean = true;
         if(!this._triggeredFlags.getState(this._data.TUTORIAL_WELCOME.id))
         {
            this.initialiseTrigger(this._data.TUTORIAL_WELCOME,this.welcomeSequenceNextStep,this.welcomeSequenceComplete);
         }
         else if(!this._triggeredFlags.getState(this._data.TUTORIAL_BUILDING.id))
         {
            this.initialiseTrigger(this._data.TUTORIAL_BUILDING,this.buildingSequenceNextStep,this.buildingSequenceComplete);
         }
         else if(!this._triggeredFlags.getState(this._data.TUTORIAL_WAITING.id))
         {
            this.initialiseTrigger(this._data.TUTORIAL_WAITING,this.waitingSequenceNextStep,this.waitingSequenceComplete);
         }
         else if(!this._triggeredFlags.getState(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id))
         {
            this.initialiseTrigger(this._data.TUTORIAL_SECOND_TILE_CAPTURED,this.tutorialFirstBuildingNextStep,this.tutorialFirstBuildingComplete);
         }
         else if(!this._triggeredFlags.getState(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id))
         {
            this.initialiseTrigger(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY,this.buildAcadamyNextStep,this.buildAcadamyComplete);
         }
         else
         {
            _loc8_ = false;
            this.configureTutorialCompleted();
         }
         if(_loc8_ == true)
         {
            this._system.resizeSignal.add(this.onResize);
            this.onResize(0,0);
            this._monkeyCityMain.ui.notificationUI.setVisible(false);
         }
         return _loc8_;
      }
      
      private function configureTutorialCompleted() : void
      {
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         Building.demolishEnabled = true;
         WorldView.mouseEnableAfterInit = true;
         AddStartCashModule.enableTickBox = true;
         Building.infoEnabled = true;
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.enableDrag();
         this.startExtraTutorial();
         firstTimeTutorialFinished.dispatch();
         this._monkeyCityMain.ui.notificationUI.setVisible(true);
      }
      
      private function onResize(param1:int, param2:int) : void
      {
         if(this._worldView != null)
         {
            this._worldView.setCameraForTutorial(false,this._tutorialCameraOffset.x,this._tutorialCameraOffset.y);
         }
      }
      
      private function startExtraTutorial() : void
      {
         var _loc1_:Boolean = true;
         if(!this._triggeredFlags.getState(this._data.BANKS_ARE_FULL.id))
         {
            this._resourceStore.banksAreFullSignal.addOnce(this.onBanksAreFullSignal);
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_CAMO_BLOONS.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_LEAD_BLOONS.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_MOABS.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_HARD.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_CAMO_ASSAULT.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_REGROW_ASSAULT.id))
         {
            _loc1_ = false;
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_PVP_DEFENSE.id))
         {
            PvPSignals.defendTileRevealed.addOnce(this.onPvpDefense);
         }
         if(!this._triggeredFlags.getState(this._data.FIRST_PVP_DEFENSE_COMPLETE.id))
         {
            PvPSignals.defendAttackComplete.addOnce(this.onPvpDefenseComplete);
         }
         if(!this._triggeredFlags.getState(this._data.POWER_FULL.id))
         {
            GameSignals.POWER_USED_CHANGED_DIFF.add(this.onPowerChanged);
         }
         if(!this._triggeredFlags.getState(this._data.NEED_BLOONTONIUM_STORAGE.id))
         {
            GameSignals.BLOONTONIUM_GENERATOR_CLICKED.add(this.startNeedBloontoniumStorageTutorial);
         }
         if(!this._triggeredFlags.getState(this._data.FILL_BLOONTONIUM.id))
         {
            this._townUI.pvpAttackPanel.onRevealSignal.add(this.onAttackPanelRevealed);
         }
         if(!_loc1_)
         {
            this._townUI.requestAttackUISignal.add(this.onRequestAttackUI);
         }
      }
      
      private function welcomeSequenceNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "WelcomeStep1":
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               this._uiPanel.setWelcome();
               break;
            case "WelcomeStep2":
               this._uiPanel.setSymbol(1);
               break;
            case "WelcomeStep3":
               this._uiPanel.setSymbol(2,70);
               break;
            case "WelcomeStep4":
               this._uiPanel.setSymbol(3,5);
               WorldView.enableOneTile = MonkeySystem.getInstance().FIRST_BUILDING;
               this.showFirstLandArrow();
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(true);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               this._townUI.requestAttackUISignal.add(this.onRequestFirstAttackUI);
               this._monkeyCityMain.signals.cancelledAttackSignal.add(this.welcomeCancelledAttack);
               this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.add(this.welcomeSequenceVictoryDialogClosed);
         }
      }
      
      private function showFirstLandArrow() : void
      {
         this._firstLandArrow = new BouncyArrow();
         WorldView.addOverlayItem(this._firstLandArrow);
         TilePulsator.setPulsateState(this._firstTile,true);
         var _loc1_:Tile = this._map.tileAtPoint(MonkeySystem.getInstance().FIRST_BUILDING);
         this._firstLandArrow.x = _loc1_.x + this._system.TOWN_GRID_UNIT_SIZE * 0.5;
         this._firstLandArrow.y = _loc1_.y + this._system.TOWN_GRID_UNIT_SIZE * 0.5;
      }
      
      private function hideFirstLandArrow() : void
      {
         if(this._firstLandArrow != null)
         {
            WorldView.removeOverlayItem(this._firstLandArrow);
            this._firstLandArrow.stop();
            this._firstLandArrow = null;
         }
      }
      
      private function welcomeSequenceComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this._triggeredFlags.setState(this._data.TUTORIAL_WELCOME.id,true);
         tutorialStateChanged.dispatch();
         TilePulsator.setPulsateState(this._firstTile,false);
         this._townUI.requestAttackUISignal.remove(this.onRequestFirstAttackUI);
         this._monkeyCityMain.signals.cancelledAttackSignal.remove(this.welcomeCancelledAttack);
         this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.remove(this.welcomeSequenceVictoryDialogClosed);
         this.initialiseTrigger(this._data.TUTORIAL_BUILDING,this.buildingSequenceNextStep,this.buildingSequenceComplete);
      }
      
      private function welcomeCancelledAttack() : void
      {
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._uiPanel.goToStep(3);
      }
      
      private function onRequestFirstAttackUI(param1:Function, param2:Function, param3:TileAttackDefinition) : void
      {
         this._continueFunction = param2;
         this._continueParameter = param3;
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(false);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._map.invalidateHoveredTile();
         this.hideFirstLandArrow();
         param1();
         this._uiPanel.okSignal.addOnce(this.clickOKWelcomTutorial5);
         this._uiPanel.goToStep(4);
         this._uiPanel.setSymbol(4);
      }
      
      private function clickOKWelcomTutorial5() : void
      {
         this._uiPanel.hide();
         this._monkeyCityMain.signals.btdGameRequestSet.addOnce(this.onBTDGameRequestSet);
         if(this._continueFunction != null)
         {
            this._continueFunction(this._continueParameter);
         }
         this._continueFunction = null;
         this._continueParameter = null;
      }
      
      private function onBTDGameRequestSet(param1:BTDGameRequest) : void
      {
         param1.tileUniqueData.trackID = 0;
         param1.IsTutorial(true);
      }
      
      private function welcomeSequenceVictoryDialogClosed(param1:Boolean) : void
      {
         if(!param1)
         {
            this.welcomeCancelledAttack();
            return;
         }
         this._monkeyCityMain.signals.cancelledAttackSignal.remove(this.welcomeCancelledAttack);
         this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.remove(this.welcomeSequenceVictoryDialogClosed);
         this._townUI.requestAttackUISignal.remove(this.onRequestFirstAttackUI);
         WorldView.enableOneTile = null;
         this._uiPanel.progressToNextStep();
      }
      
      private function buildingSequenceNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "TutorialBuilding":
               this._uiPanel.setSymbol(5,20);
               Building.buildingWasPlacedSignal.addOnce(this.buildTutorialBuildingPlaced);
               this._mapBottomUI.buildButtonClickedSignal.add(this.buildTutorialBuildButtonClicked);
               this._buildPanel.buildPanelWasClosedSignal.add(this.buildTutorialBuildPanelCancled);
               this._buildPanel.buildingWasSelectedSignal.add(this.buildTutorialBuildingSelected);
               this._monkeyCityMain.signals.cancelPlacingBuildingSignal.add(this.buildTutorialBuildingCanceled);
               this.showTutorialBuilding();
         }
      }
      
      private function showTutorialBuilding(param1:Boolean = false) : void
      {
         this._uiPanel.onRevealSignal.addOnce(this.onBuildingTutorialRevealed);
         if(param1)
         {
            PanelManager.getInstance().showPanel(this._uiPanel);
         }
      }
      
      private function onBuildingTutorialRevealed(param1:HideRevealView) : void
      {
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.BUILD_BUTTON);
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(false);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._townUI.setBuildArrowActive(true);
         this._monkeyCityMain.signals.buildPanelOpenedSignal.addOnce(this.toturoalFirstBuildingBuildOpened);
         this._monkeyCityMain.signals.buildPanelClosedSignal.addOnce(this.toturoalFirstBuildingBuildClosed);
      }
      
      private function toturoalFirstBuildingBuildOpened() : void
      {
      }
      
      private function toturoalFirstBuildingBuildClosed() : void
      {
      }
      
      private function buildingSequenceComplete(param1:FirstTimeTriggerDefinition) : void
      {
         Building.buildingWasPlacedSignal.remove(this.buildTutorialBuildingPlaced);
         this._mapBottomUI.buildButtonClickedSignal.remove(this.buildTutorialBuildButtonClicked);
         this._buildPanel.buildPanelWasClosedSignal.remove(this.buildTutorialBuildPanelCancled);
         this._buildPanel.buildingWasSelectedSignal.remove(this.buildTutorialBuildingSelected);
         this._monkeyCityMain.signals.cancelPlacingBuildingSignal.remove(this.buildTutorialBuildingCanceled);
         this._triggeredFlags.setState(this._data.TUTORIAL_BUILDING.id,true);
         tutorialStateChanged.dispatch();
         this.initialiseTrigger(this._data.TUTORIAL_WAITING,this.waitingSequenceNextStep,this.waitingSequenceComplete);
      }
      
      private function buildTutorialBuildingSelected(param1:MonkeyTownBuildingDefinition) : void
      {
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
      }
      
      private function buildTutorialBuildingCanceled() : void
      {
         this.showTutorialBuilding(true);
      }
      
      private function buildTutorialBuildButtonClicked() : void
      {
         this._buildPanel.onNextOpen({
            "openPanel":TownUI.BASE_BUILDINGS,
            "panelLocked":true,
            "enableBuildings":[this._buildingData.MONKEY_DART_HALL]
         });
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.BUILD_BUTTON);
         this._townUI.setBuildArrowActive(false);
         this._uiPanel.hide();
      }
      
      private function buildTutorialBuildPanelCancled() : void
      {
         this.showTutorialBuilding(true);
      }
      
      private function buildTutorialBuildingPlaced(param1:Building) : void
      {
         this._firstBuilding = param1;
         this._uiPanel.progressToNextStep();
      }
      
      private function waitingSequenceNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         var _loc3_:Tile = null;
         switch(param1.sequence[param2])
         {
            case "TutorialWaiting":
               this._uiPanel.setSymbol(6);
               this._townUI.setBuildArrowActive(false);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               _loc3_ = this._map.tileAt(MonkeySystem.getInstance().FIRST_BUILDING.x,MonkeySystem.getInstance().FIRST_BUILDING.y);
               if(_loc3_ != null)
               {
                  this._firstBuilding = _loc3_.building;
               }
               if(this._firstBuilding != null && this._firstBuilding.buildComplete == true)
               {
                  this.waitingSequenceComplete(param1);
               }
               else
               {
                  if(this._firstBuilding != null)
                  {
                     this._firstBuilding.buildCompleteSignal.addOnce(this.waitingTutorialBuildingCompleted);
                  }
                  this._uiPanel.okSignal.addOnce(this.waitingTutorialClickOk);
               }
         }
      }
      
      private function waitingSequenceComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this._uiPanel.okSignal.remove(this.waitingTutorialClickOk);
         if(this._firstBuilding != null)
         {
            this._firstBuilding.buildCompleteSignal.remove(this.waitingTutorialBuildingCompleted);
         }
         this._triggeredFlags.setState(this._data.TUTORIAL_WAITING.id,true);
         tutorialStateChanged.dispatch();
         this.initialiseTrigger(this._data.TUTORIAL_SECOND_TILE_CAPTURED,this.tutorialFirstBuildingNextStep,this.tutorialFirstBuildingComplete);
      }
      
      private function waitingTutorialBuildingCompleted(param1:Building) : void
      {
         this._uiPanel.progressToNextStep();
      }
      
      private function waitingTutorialClickOk() : void
      {
         if(this._firstBuilding == null)
         {
            return;
         }
         this._firstBuilding.completeBuilding();
      }
      
      private function tutorialFirstBuildingNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "TutorialFirstBuildingCompleteStep1":
               this._uiPanel.setSymbol(1,30);
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(false);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.MY_TOWERS_BUTTON);
               this._townUI.myTowersPanel.disableTab();
               this._townUI.setMyTowersArrowActive(true);
               this._mapBottomUI.myTowersButtonClickedSignal.addOnce(this.toturoalFirstBuildingMyTowerOpened);
               this._monkeyCityMain.signals.myTowersPanelClosedSignal.addOnce(this.toturoalFirstBuildingMyTowerClosed);
               break;
            case "TutorialFirstBuildingCompleteStep3":
               this._uiPanel.setSymbol(7,20);
               this._mapBottomUI.myTowersButtonClickedSignal.remove(this.toturoalFirstBuildingMyTowerOpened);
               this._monkeyCityMain.signals.myTowersPanelClosedSignal.remove(this.toturoalFirstBuildingMyTowerClosed);
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(true);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               this._townUI.requestAttackUISignal.add(this.firstBuildingRequestFirstAttackUI);
               this._monkeyCityMain.signals.cancelledAttackSignal.add(this.firstBuildingCancelledAttack);
               this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.add(this.buildAcadamyStart);
               break;
            case "TutorialFirstBuildingCompleteStep4":
               this._uiPanel.setSymbol(8,45);
         }
      }
      
      private function tutorialFirstBuildingComplete(param1:FirstTimeTriggerDefinition) : void
      {
         tutorialStateChanged.dispatch();
         this._townUI.requestAttackUISignal.remove(this.firstBuildingRequestFirstAttackUI);
         this._monkeyCityMain.signals.cancelledAttackSignal.remove(this.firstBuildingCancelledAttack);
         this.reactivateMonkeyCityMain();
         this._triggeredFlags.setState(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,true);
      }
      
      private function toturoalFirstBuildingMyTowerOpened() : void
      {
         this._uiPanel.hide();
         this._map.invalidateHoveredTile();
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.MY_TOWERS_BUTTON);
         this._townUI.setMyTowersArrowActive(false);
      }
      
      private function toturoalFirstBuildingMyTowerClosed() : void
      {
         this._townUI.myTowersPanel.enableTab();
         this._uiPanel.goToStep(1);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._tileHighlighter.setPulsateStateSecondSet(true);
         this._triggeredFlags.setState(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,true);
      }
      
      private function firstBuildingRequestFirstAttackUI(param1:Function, param2:Function, param3:TileAttackDefinition) : void
      {
         this._uiPanel.hide();
         this._map.invalidateHoveredTile();
         this._continueFunction = param2;
         this._continueParameter = param3;
         this._tileHighlighter.setPulsateStateSecondSet(false);
         var _loc4_:Tile = this._map.tileAtPoint(param3.attackAtLocation);
         if(_loc4_.terrainDefinition.groundType === TileDefinitions.getInstance().WATER_GROUND || _loc4_.terrainDefinition.id === TileDefinitions.getInstance().RIVER)
         {
            param1();
            this._tileHighlighter.setPulsateStateSecondSet(true);
            this._uiPanel.goToStep(2);
         }
      }
      
      private function firstBuildingCancelledAttack() : void
      {
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._tileHighlighter.setPulsateStateSecondSet(true);
         PanelManager.getInstance().showPanel(this._uiPanel);
      }
      
      private function buildAcadamyStart(param1:Boolean) : void
      {
         if(!param1)
         {
            this.firstBuildingCancelledAttack();
            return;
         }
         this._uiPanel.endSequence();
         this._monkeyCityMain.signals.btdVictoryDialogClosedSignal.remove(this.buildAcadamyStart);
         this._triggeredFlags.setState(this._data.TUTORIAL_SECOND_TILE_CAPTURED.id,true);
         this.initialiseTrigger(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY,this.buildAcadamyNextStep,this.buildAcadamyComplete);
      }
      
      private function buildAcadamyNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "TutorialBuildMonkeyAcademyStep1":
               this._uiPanel.setSymbol(9);
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(false);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.buildAcademyToturoalClickOk);
               Building.buildingWasPlacedSignal.addOnce(this.buildAcademyTutorialBuildingPlaced);
               this._mapBottomUI.buildButtonClickedSignal.add(this.buildAcademyTutorialBuildButtonClicked);
               this._buildPanel.buildPanelWasClosedSignal.add(this.buildAcademyTutorialBuildPanelCancled);
               this._buildPanel.buildingWasSelectedSignal.add(this.buildAcademyTutorialBuildingSelected);
               this._monkeyCityMain.signals.cancelPlacingBuildingSignal.add(this.buildAcademyTutorialBuildingCanceled);
               break;
            case "TutorialBuildMonkeyAcademyStep2":
               this._uiPanel.setSymbol(10);
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(true);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               WorldView.onlySimulateClickEnabled = true;
               this._bananaFarmArrow = new BouncyArrow();
               WorldView.addOverlayItem(this._bananaFarmArrow);
               this._bananaFarmArrow.x = this._system.TOWN_MAP_PIXEL_WIDTH * 0.5 + 100;
               this._bananaFarmArrow.y = this._system.TOWN_MAP_PIXEL_HEIGHT * 0.5 + 20;
               this._resourceStore.monkeyMoneyChangedDiffSignal.addOnce(this.monkeyChanged);
               break;
            case "TutorialBuildMonkeyAcademyStep3":
               this.showTutorialBuildAcademy();
               WorldView.onlySimulateClickEnabled = false;
               this._uiPanel.hide();
               break;
            case "TutorialBuildMonkeyAcademyStep4":
               this._uiPanel.setSymbol(1);
               this._monkeyCityMain.mouseManager.unlock();
               this._monkeyCityMain.mouseManager.setMouseActive(false);
               this._monkeyCityMain.mouseManager.disableDrag();
               this._monkeyCityMain.mouseManager.lock();
               this._uiPanel.okSignal.addOnce(this.buildAcademyToturoalClickOkAfterBuildingPlaced);
         }
      }
      
      private function monkeyChanged(param1:int, param2:Boolean = true) : void
      {
         var diff:int = param1;
         var updateUI:Boolean = param2;
         TweenLite.to(this._bananaFarmArrow,0.6,{
            "alpha":0,
            "onComplete":function():void
            {
               WorldView.removeOverlayItem(_bananaFarmArrow);
               _bananaFarmArrow.stop();
               _bananaFarmArrow = null;
               _uiPanel.progressToNextStep();
            }
         });
      }
      
      private function buildAcadamyComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this._triggeredFlags.setState(this._data.TUTORIAL_BUILD_MONKEY_ACADEMY.id,true);
         Building.buildingWasPlacedSignal.remove(this.buildAcademyTutorialBuildingPlaced);
         this._mapBottomUI.buildButtonClickedSignal.remove(this.buildAcademyTutorialBuildButtonClicked);
         this._buildPanel.buildPanelWasClosedSignal.remove(this.buildAcademyTutorialBuildPanelCancled);
         this._buildPanel.buildingWasSelectedSignal.remove(this.buildAcademyTutorialBuildingSelected);
         this._monkeyCityMain.signals.cancelPlacingBuildingSignal.remove(this.buildAcademyTutorialBuildingCanceled);
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.enableDrag();
         this._monkeyCityMain.mouseManager.lock();
         WorldView.onlySimulateClickEnabled = false;
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         Building.demolishEnabled = true;
         Building.infoEnabled = true;
         this.startExtraTutorial();
         AddStartCashModule.enableTickBox = true;
         this._system.resizeSignal.remove(this.onResize);
         this.reactivateMonkeyCityMain();
         tutorialStateChanged.dispatch();
         firstTimeTutorialFinished.dispatch();
      }
      
      private function showTutorialBuildAcademy() : void
      {
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.BUILD_BUTTON);
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(false);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
         this._townUI.setBuildArrowActive(true);
         this._uiPanel.hide();
      }
      
      private function buildAcademyToturoalClickOk() : void
      {
         if(this._resourceStore.spendableMonkeyMoney < this._buildingData.MONKEY_ACADEMY.monkeyMoneyCost)
         {
            this._uiPanel.goToStep(1);
         }
         else
         {
            this.showTutorialBuildAcademy();
         }
      }
      
      private function buildAcademyToturoalClickOkAfterBuildingPlaced() : void
      {
         this._uiPanel.progressToNextStep();
      }
      
      private function buildAcademyTutorialBuildingPlaced(param1:Building) : void
      {
         if(param1.definition.id == this._buildingData.MONKEY_ACADEMY.id)
         {
            this._townUI.setBuildArrowActive(false);
            GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
            this._uiPanel.goToStep(3);
         }
      }
      
      private function buildAcademyTutorialBuildingSelected(param1:MonkeyTownBuildingDefinition) : void
      {
         this._monkeyCityMain.mouseManager.unlock();
         this._monkeyCityMain.mouseManager.setMouseActive(true);
         this._monkeyCityMain.mouseManager.disableDrag();
         this._monkeyCityMain.mouseManager.lock();
      }
      
      private function buildAcademyTutorialBuildingCanceled() : void
      {
         this.showTutorialBuildAcademy();
      }
      
      private function buildAcademyTutorialBuildButtonClicked() : void
      {
         this._buildPanel.onNextOpen({
            "openPanel":TownUI.UPGRADE_BUILDINGS,
            "panelLocked":true,
            "enableBuildings":[this._buildingData.MONKEY_ACADEMY]
         });
         this._townUI.setBuildArrowActive(false);
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.dispatch(MapBottomUI.BUILD_BUTTON);
         this._uiPanel.hide();
      }
      
      private function buildAcademyTutorialBuildPanelCancled() : void
      {
         this.showTutorialBuildAcademy();
      }
      
      private function onRequestAttackUI(param1:Function, param2:Function, param3:TileAttackDefinition) : void
      {
         this._continueFunction = param2;
         this._continueParameter = param3;
         this._bloonTypeString = this._map.lastViewedWeights.strongestBloonType;
         var _loc4_:Tile = this._map.tileAtPoint(param3.attackAtLocation);
         if(this._triggeredFlags.getState(this._data.FIRST_CAMO_BLOONS.id) == false)
         {
            if(this._map.getDifficultyAtLocationPoint(param3.attackAtLocation) >= Constants.DIFFICULTY_REQUIRED_BEFORE_CAMO || _loc4_.isCamoTile === true || SpecialMissionsManager.getInstance().isSpecialMissionHasCamo(_loc4_))
            {
               param1();
               this.initialiseTrigger(this._data.FIRST_CAMO_BLOONS,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
               this._triggeredFlags.setState(this._data.FIRST_CAMO_BLOONS.id,true);
            }
         }
         else if(this._triggeredFlags.getState(this._data.FIRST_LEAD_BLOONS.id) == false && this._bloonTypeString == Constants.LEAD_BLOON)
         {
            param1();
            this.initialiseTrigger(this._data.FIRST_LEAD_BLOONS,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
            this._triggeredFlags.setState(this._data.FIRST_LEAD_BLOONS.id,true);
         }
         else if(this._triggeredFlags.getState(this._data.FIRST_MOABS.id) == false && (this._bloonTypeString == Constants.MOAB_BLOON || this._bloonTypeString == Constants.BFB_BLOON || this._bloonTypeString == Constants.BOSS_BLOON))
         {
            param1();
            this.initialiseTrigger(this._data.FIRST_MOABS,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
            this._triggeredFlags.setState(this._data.FIRST_MOABS.id,true);
         }
         else if(this._triggeredFlags.getState(this._data.FIRST_HARD.id) == false)
         {
            if(this._map.getRank(_loc4_) >= TownMap.HARD_INDEX)
            {
               param1();
               this.initialiseTrigger(this._data.FIRST_HARD,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
               this._triggeredFlags.setState(this._data.FIRST_HARD.id,true);
            }
         }
         else if(this._triggeredFlags.getState(this._data.FIRST_CAMO_ASSAULT.id) == false && _loc4_.isCamoTile == true)
         {
            param1();
            this.initialiseTrigger(this._data.FIRST_CAMO_ASSAULT,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
            this._triggeredFlags.setState(this._data.FIRST_CAMO_ASSAULT.id,true);
         }
         else if(this._triggeredFlags.getState(this._data.FIRST_REGROW_ASSAULT.id) == false && _loc4_.isRegenTile == true)
         {
            param1();
            this.initialiseTrigger(this._data.FIRST_REGROW_ASSAULT,this.firstAttackTutorialNextStep,this.attackTutorialComplete);
            this._triggeredFlags.setState(this._data.FIRST_REGROW_ASSAULT.id,true);
         }
      }
      
      private function firstAttackTutorialNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "FirstCamoBloons":
               this._uiPanel.setSymbol(11);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
               break;
            case "FirstLeadBloons":
               this._uiPanel.setSymbol(12);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
               break;
            case "FirstMOABs":
               this._uiPanel.setSymbol(13);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
               break;
            case "FirstHard":
               this._uiPanel.setSymbol(3);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
               break;
            case "FirstCamoAssault":
               this._uiPanel.setSymbol(19);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
               break;
            case "FirstRegrowAssault":
               this._uiPanel.setSymbol(20);
               GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
               this._uiPanel.okSignal.addOnce(this.tutorialAttackOkayClicked);
         }
      }
      
      private function attackTutorialComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         tutorialStateChanged.dispatch();
         if(this._continueFunction != null)
         {
            this._continueFunction(this._continueParameter);
         }
         this._continueFunction = null;
         this._continueParameter = null;
      }
      
      private function tutorialAttackOkayClicked() : void
      {
         this._uiPanel.progressToNextStep();
      }
      
      private function onBanksAreFullSignal() : void
      {
         this._triggeredFlags.setState(this._data.BANKS_ARE_FULL.id,true);
         this._uiPanel.okSignal.addOnce(this.banksAreFullOkClick);
         this.initialiseTrigger(this._data.BANKS_ARE_FULL,null,this.banksAreFullComplete);
         this._uiPanel.setSymbol(14);
      }
      
      private function banksAreFullComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         tutorialStateChanged.dispatch();
      }
      
      private function banksAreFullOkClick() : void
      {
         this._uiPanel.progressToNextStep();
      }
      
      private function onPvpDefense(param1:IncomingRaid = null, param2:Boolean = false) : void
      {
         this._uiPanel.isModal = true;
         this.initialiseTrigger(this._data.FIRST_PVP_DEFENSE,this.pvpDefenseTutorialNextStep,this.pvpDefenseTutorialComplete,true);
      }
      
      private function onPvpDefenseComplete(... rest) : void
      {
         this._uiPanel.isModal = true;
         this.initialiseTrigger(this._data.FIRST_PVP_DEFENSE_COMPLETE,this.pvpDefenseTutorialNextStep,this.pvpDefenseTutorialComplete,true);
      }
      
      private function pvpDefenseTutorialNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         switch(param1.sequence[param2])
         {
            case "FirstPVPDefense":
               this._triggeredFlags.setState(this._data.FIRST_PVP_DEFENSE.id,true);
               break;
            case "FirstPVPDefenseComplete":
               this._triggeredFlags.setState(this._data.FIRST_PVP_DEFENSE_COMPLETE.id,true);
         }
         this._uiPanel.setSymbol(16);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._uiPanel.okSignal.addOnce(this.pvpOkayClicked);
      }
      
      private function pvpDefenseTutorialComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         this._uiPanel.isModal = false;
         tutorialStateChanged.dispatch();
      }
      
      private function pvpOkayClicked() : void
      {
         this._uiPanel.progressToNextStep();
      }
      
      private function onPowerChanged(param1:int) : void
      {
         if(this._resourceStore.totalPower - this._resourceStore.totalPowerUsed < this.MIN_POWER_OF_BUILDING)
         {
            GameSignals.POWER_USED_CHANGED_DIFF.remove(this.onPowerChanged);
            this.startPowerFullTutorial();
         }
      }
      
      private function startPowerFullTutorial() : void
      {
         this.initialiseTrigger(this._data.POWER_FULL,this.powerFullNextStep,this.powerFullComplete);
      }
      
      private function powerFullNextStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         this._triggeredFlags.setState(this._data.POWER_FULL.id,true);
         this._uiPanel.setSymbol(17);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._uiPanel.okSignal.addOnce(this._uiPanel.progressToNextStep);
      }
      
      private function powerFullComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         tutorialStateChanged.dispatch();
      }
      
      private function startNeedBloontoniumStorageTutorial() : void
      {
         if(this._system.city.buildingManager.getCompletedBuildingCount(this._buildingData.BLOONTONIUM_STORAGE_TANK.id).complete <= 0)
         {
            GameSignals.BLOONTONIUM_GENERATOR_CLICKED.remove(this.startNeedBloontoniumStorageTutorial);
            this.initialiseTrigger(this._data.NEED_BLOONTONIUM_STORAGE,this.needBloontoniumStorageStep,this.needBloontoniumStorageComplete);
         }
      }
      
      private function needBloontoniumStorageStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         this._triggeredFlags.setState(this._data.NEED_BLOONTONIUM_STORAGE.id,true);
         this._uiPanel.setSymbol(18);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._uiPanel.okSignal.addOnce(this._uiPanel.progressToNextStep);
      }
      
      private function needBloontoniumStorageComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         tutorialStateChanged.dispatch();
      }
      
      private function onAttackPanelRevealed(param1:HideRevealView) : void
      {
         if(this._resourceStore.bloontoniumCapacity > 0 && !this._resourceStore.isBloontoniumMax())
         {
            this._townUI.pvpAttackPanel.onRevealSignal.remove(this.onAttackPanelRevealed);
            this.startFillBloontoniumTutorial();
         }
      }
      
      private function startFillBloontoniumTutorial() : void
      {
         this._uiPanel.isModal = true;
         this._uiPanel.additionalY = 150;
         this.initialiseTrigger(this._data.FILL_BLOONTONIUM,this.fillBloontoniumStep,this.fillBloontoniumComplete,true);
         this._uiPanel.resize();
      }
      
      private function fillBloontoniumStep(param1:FirstTimeTriggerDefinition, param2:int) : void
      {
         this._triggeredFlags.setState(this._data.FILL_BLOONTONIUM.id,true);
         this._uiPanel.setSymbol(18,0);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.dispatch();
         this._uiPanel.okSignal.addOnce(this._uiPanel.progressToNextStep);
      }
      
      private function fillBloontoniumComplete(param1:FirstTimeTriggerDefinition) : void
      {
         this._uiPanel.additionalY = 0;
         this._uiPanel.isModal = false;
         this.reactivateMonkeyCityMain();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.dispatch();
         tutorialStateChanged.dispatch();
      }
   }
}
