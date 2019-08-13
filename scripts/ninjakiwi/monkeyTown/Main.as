package ninjakiwi.monkeyTown
{
   import com.greensock.OverwriteManager;
   import com.greensock.plugins.ColorTransformPlugin;
   import com.greensock.plugins.TintPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.lgrey.game.cheat.CheatCodeListener;
   import com.lgrey.input.Key;
   import com.lgrey.utils.LGMathUtil;
   import com.ninjakiwi.gateway.nk.NKGateway;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   import flash.ui.ContextMenu;
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.link.LiNK;
   import ninjakiwi.monkeyTown.achievements.AchievementsManager;
   import ninjakiwi.monkeyTown.ads.VideoAds;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.analytics.Tracking;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.cheat.Cheats;
   import ninjakiwi.monkeyTown.common.ConfigureDeployConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.RemoteDataManager;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.data.TerrainTowerRestrictionsData;
   import ninjakiwi.monkeyTown.debug.DebugUI;
   import ninjakiwi.monkeyTown.display.bitClip.AnimationCustom;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.net.SqueezeClassMap;
   import ninjakiwi.monkeyTown.persistence.Persistence;
   import ninjakiwi.monkeyTown.persistence.PersistenceCheckLSO;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.sound.MCMusic;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.testing.APITests.LoadCoreTest;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.data.BananaFarmData;
   import ninjakiwi.monkeyTown.town.data.BankTierData;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.EventsData;
   import ninjakiwi.monkeyTown.town.data.FirstTimeTriggerData;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.MonkeyTownXPLevelData;
   import ninjakiwi.monkeyTown.town.data.MyTowersData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossData;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestManager;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.BuildProgressBar;
   import ninjakiwi.monkeyTown.town.ui.ConnectionLostPanel;
   import ninjakiwi.monkeyTown.town.ui.SavingNotifier;
   import ninjakiwi.monkeyTown.town.ui.ServerErrorRetryPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.manageCitiesPanel.CityInformation;
   import ninjakiwi.monkeyTown.town.ui.myCitiesPanel.MyCitiesPanel;
   import ninjakiwi.monkeyTown.town.ui.newsPanelScroller.NewsDataLoader;
   import ninjakiwi.monkeyTown.transition.Transition;
   import ninjakiwi.monkeyTown.ui.LoadingTransition;
   import ninjakiwi.monkeyTown.ui.MainMenuView;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.UserServicesHelper;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.monkeyTown.utils.ObjectHelper2;
   import ninjakiwi.net.JSONRequest;
   import ninjakiwi.net.RequestQueuer;
   import ninjakiwi.net.WebAction;
   import ninjakiwi.utils.StandardStuff;
   
   public final class Main extends MovieClip
   {
      
      public static var instance:Main;
       
      
      public var loadingTransition:LoadingTransition;
      
      private var _cheatCodeListener:CheatCodeListener;
      
      private var _mainBitmapData:BitmapData;
      
      private var _mainBitmap:Bitmap;
      
      private var _mainBitmapContainer:Sprite;
      
      private var _monkeyCityMain:MonkeyCityMain;
      
      private var _btdView:BTDView;
      
      private var _timeOfLastTick:Number;
      
      private var _transition:Transition;
      
      private var _stage:Stage;
      
      private var _mainMenu:MainMenuView;
      
      private var _nkGateway:NKGateway;
      
      private var _buildProgressBar:BuildProgressBar;
      
      public const topLevelUIContainer:Sprite = new Sprite();
      
      public const system:MonkeySystem = MonkeySystem.getInstance();
      
      public const tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      public const buildingData:BuildingData = BuildingData.getInstance();
      
      public const upgradeData:UpgradeData = UpgradeData.getInstance();
      
      public const xpLevelData:MonkeyTownXPLevelData = MonkeyTownXPLevelData.getInstance();
      
      public const configData:ConfigData = ConfigData.getInstance();
      
      public const remoteDataManager:RemoteDataManager = new RemoteDataManager();
      
      public const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      public const specialItemData:SpecialItemData = SpecialItemData.getInstance();
      
      public var connectionLostPanel:ConnectionLostPanel;
      
      public var serverErrorRetryPanel:ServerErrorRetryPanel;
      
      public const myMenu:ContextMenu = new ContextMenu();
      
      public var savingNotifier:SavingNotifier;
      
      private var _xpCheck:PersistenceCheckLSO;
      
      private var _videoAds:VideoAds;
      
      private var _cheats:Cheats;
      
      public var debugUI:DebugUI;
      
      public var loadCoreTest:LoadCoreTest;
      
      private var userLoggedIn:Boolean = false;
      
      private var _cuedReturnToHomeScreen:Boolean = false;
      
      private var _requireSWFRefresh:Boolean = false;
      
      private var _returnToHomeScreenLocked:Boolean = false;
      
      private var _timeOfLastGC:Number = 0;
      
      private var _timeOfLastResize:Number = -1;
      
      public function Main()
      {
         this._mainBitmapContainer = new Sprite();
         this._transition = Transition.getInstance();
         this._mainMenu = new MainMenuView();
         this._videoAds = new VideoAds();
         this.loadCoreTest = new LoadCoreTest();
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         OverwriteManager.init(OverwriteManager.AUTO);
         DancingShadows.alarm.addEventListener(DancingShadows.MODIFIED,this.dancingShadowsAlarmHandler);
         instance = this;
      }
      
      private function init(... rest) : void
      {
         var args:Array = rest;
         StandardStuff.showSplash(this,this.initGame,800);
         StandardStuff.setClick(new EventDispatcher(),function(param1:Event):void
         {
         });
      }
      
      private function initGame(param1:Event = null) : void
      {
         LiNK.APPID = 7;
         LiNK.SKUID = 20;
         AnimationCustom.stage = stage;
         ConfigureDeployConstants.configure(Constants.DEPLOY_STATE);
         SkuSettingsLoader.loadSettings();
         NewsDataLoader.loadData();
         KeyValueStore.getInstance().readySignal.add(this.onKeyValueStoreReady);
         var _loc2_:Object = this.root.loaderInfo.parameters;
         switch(_loc2_.userServices)
         {
            case "kong":
               this.y = 0;
               NKGateway.container.y = NKGateway.container.y - 1000;
               this.system.resizeSignal.dispatch(stage.stageWidth,stage.stageHeight);
               if(Constants.DEPLOY_STATE == ConfigureDeployConstants.PRODUCTION)
               {
                  Constants.DEPLOY_STATE = ConfigureDeployConstants.PRODUCTION_KONG;
                  ConfigureDeployConstants.configure(Constants.DEPLOY_STATE);
               }
               break;
            default:
               this.y = 20;
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         this._stage = stage;
         this.system.flashStage = stage;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.addEventListener(Event.RESIZE,this.stageResizeHandler);
         Key.initialize(stage);
         this.initialiseData();
         StandardStuff.setContextMenu(this);
         this._cheatCodeListener = new CheatCodeListener(this._stage);
         if(Constants.ENABLE_REQUEST_LOGGING)
         {
            JSONRequest.logRequests = !JSONRequest.logRequests;
            ErrorReporter.externalLog("Request logging is " + (!!JSONRequest.logRequests?"ON":"OFF"));
         }
         ObjectHelper2.typeIDMap = SqueezeClassMap.map;
         this.loadingTransition = new LoadingTransition(this);
         MCMusic.playTitleMusic();
         this.setUpLogOutLockZones();
         this.stageResizeHandler();
         Tracking.init(stage);
         this._buildProgressBar = new BuildProgressBar(this);
         this._monkeyCityMain.openingNewCityPanelSignal.add(this.onOpenNewCityPanel);
         this.connectionLostPanel = new ConnectionLostPanel(this);
         this.serverErrorRetryPanel = new ServerErrorRetryPanel(this);
         this.savingNotifier = new SavingNotifier();
         addChild(this.savingNotifier);
         this.debugUI = new DebugUI();
         addChild(this.topLevelUIContainer);
         this.topLevelUIContainer.addChild(this.debugUI);
         this._xpCheck = new PersistenceCheckLSO();
         this._cheats = new Cheats(stage);
         TweenPlugin.activate([ColorTransformPlugin,TintPlugin]);
      }
      
      private function onKeyValueStoreReady() : void
      {
         KeyValueStore.getInstance().get("gameEventsManager",function(param1:Object):void
         {
            GameEventManager.getInstance().setPersistentData(param1);
         });
      }
      
      private function onOpenNewCityPanel() : void
      {
         this._buildProgressBar.hideWithoutEffects();
         this._monkeyCityMain.closingNewCityPanelSignal.addOnce(this._buildProgressBar.reveal);
      }
      
      private function initialiseData() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc1_:String = "google";
         var _loc2_:String = "cache";
         var _loc3_:String = "baked";
         var _loc4_:String = _loc3_;
         if(this.system.USE_BAKED_DATA_FOR_DEV && Capabilities.playerType == "StandAlone" || this.system.USE_BAKED_DATA_IN_LIVE)
         {
            _loc4_ = "baked";
         }
         this.remoteDataManager.dataLoadedSignal.add(this.onDataLoaded);
         this.remoteDataManager.dataLoadFailedSignal.add(this.onDataLoadFailed);
         this.remoteDataManager.dataBeginLoadingItemSignal.add(this.onDataBeginLoadingItem);
         var _loc7_:Object = stage.loaderInfo.parameters;
         _loc5_ = _loc7_.dataSource != undefined?_loc7_.dataSource:_loc4_;
         switch(_loc5_)
         {
            case _loc1_:
               this.remoteDataManager.startLoadingRemoteData();
               break;
            case _loc2_:
               this.remoteDataManager.loadCachedData();
               break;
            default:
               this.remoteDataManager.loadBakedData();
         }
      }
      
      private function onDataBeginLoadingItem(param1:String) : void
      {
      }
      
      private function onDataLoadFailed() : void
      {
      }
      
      private function onDataLoaded() : void
      {
         this.processData();
      }
      
      private function processData() : void
      {
         this.upgradeData.initialiseFromDataObject(this.remoteDataManager.upgradeData);
         this.upgradeData.initialiseBuildingUpgrades(this.remoteDataManager.buildingUpgradeData);
         this.buildingData.initialiseFromDataObjects(this.remoteDataManager.buildingData,this.remoteDataManager.upgradeBuildingData,this.remoteDataManager.specialBuildingsData,this.remoteDataManager.pvpBuildingsData,this.remoteDataManager.premiumBuildingsData);
         this.xpLevelData.initFromDataObject(this.remoteDataManager.monkeytownXpLevelData);
         this.tileDefinitions.initialiseTerrainDataFromObject(this.remoteDataManager.terrainData);
         this.tileDefinitions.initialiseTerrainSpecialPropertiesDataFromObject(this.remoteDataManager.terrainSpecialProperties);
         this.configData.initialiseFromDataObject(this.remoteDataManager.configData);
         this.specialItemData.initItemDataFromObject(this.remoteDataManager.specialItems);
         FirstTimeTriggerData.getInstance().initDataFromObject(this.remoteDataManager.firstTimeTriggerData);
         TownMap.terrainDifficultyCurve = this.remoteDataManager.terrainDifficultyCurve.difficulty;
         QuestManager.getInstance().initialiseBaseData(this.remoteDataManager.questData);
         BloonResearchLabUpgrades.processData(this.remoteDataManager.bloonResearchLabUpgrades);
         TerrainTowerRestrictionsData.processData(this.remoteDataManager.terrainTowerRestrictionsData);
         BankTierData.processData(this.remoteDataManager.bankUpgradeTiers);
         BananaFarmData.processData(this.remoteDataManager.bananaFarmUpgradeTiers);
         SpecialMissionsManager.getInstance().populateFromData(this.remoteDataManager.specialMissions);
         RequestQueuer.unauthorisedSignal.add(this.onRemoteLogout);
         MyTowersData.setData(this.remoteDataManager.myMonkeys);
         AchievementsManager.getInstance().initialiseWithData(this.remoteDataManager.achievements);
         MonkeyKnowledgeBuffData.getInstance().initialiseWithData(this.remoteDataManager.monkeyKnowledge);
         EventsData.populate(this.remoteDataManager.eventsData);
         GameMods.init();
         BossData.getInstance().setData(this.remoteDataManager.bossAttackCostData);
         this.onDataInitialised();
      }
      
      public function onGlobalReset() : void
      {
         Persistence.getInstance().invalidateSession();
      }
      
      private function onDataInitialised() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         this.initialiseViews();
         this.system.resizeSignal.dispatch(stage.stageWidth,stage.stageHeight);
         Persistence.getInstance().init();
         this._mainMenu.playGameSignal.add(this.onPlayGameSignal);
         this._mainMenu.deleteSaveSignal.add(Persistence.getInstance().deleteSaveData);
         this._stage.addChild(NKGateway.container);
         if(Capabilities.playerType !== "Desktop")
         {
            _loc1_ = {};
            _loc2_ = {};
            _loc1_ = {
               "barUrl":Constants.NK_BAR_URL,
               "policyUrl":"https://assets.nkstatic.com/crossdomain.xml",
               "cacheBust":true
            };
            if(Kong.isOnKong())
            {
               _loc2_.notonnk = true;
            }
            NKGateway.load(Settings.GAME_NAME,_loc1_,_loc2_).then(this.nkGatewayLoaded);
         }
         this._mainMenu.revealHomeScreen();
      }
      
      private function nkGatewayLoaded(param1:NKGateway) : void
      {
         this.system.nkGateway = this._nkGateway = param1;
         param1.checkedForExistingUserSignal.addOnce(this.onCheckedForExistingUserSignal);
         param1.newUserFinishedLoadingSignal.add(this.onNewUserFinishedLoadingSignal);
         UserServicesHelper.configure(this);
         this.system.resizeSignal.dispatch(stage.stageWidth,stage.stageHeight);
      }
      
      private function onCheckedForExistingUserSignal(param1:Boolean) : void
      {
         if(Kong.isOnKong() && Kong.isGuest())
         {
            Kong.showSignInBox();
            return;
         }
         if(param1 === false || Kong.isOnKong() && Kong.isGuest())
         {
            LoginSignals.showLoginPrompt.dispatch();
         }
      }
      
      private function onNewUserFinishedLoadingSignal(param1:NKGatewayUser) : void
      {
         var newUser:NKGatewayUser = param1;
         t.obj(newUser.loginInfo.id);
         this.system.setNKGatewayUser(newUser);
         newUser.logOutSignal.add(this.userLoggedOut);
         Persistence.getInstance().shakeHandsWithServer(function(param1:Object):void
         {
            system.setServerTime(param1.serverTime);
            _timeOfLastTick = system.getSecureTime();
            _xpCheck.init();
            Premium.getInstance().initForUser(newUser);
            PremiumBuildingManager.getInstance().initForUser(newUser);
            AnalyticsUtil.setUser(newUser);
            LoginSignals.userHasLoggedIn.dispatch();
            Premium.getInstance().processInventory(newUser);
            PremiumBuildingManager.getInstance().processInventory(newUser);
            _videoAds.init();
            LoginSignals.showPlayPrompt.dispatch(false);
         });
      }
      
      private function userLoggedOut(param1:Boolean = true) : void
      {
         this.system.setNKGatewayUser(null);
         AnalyticsUtil.setUser(null);
         this._monkeyCityMain.clear();
         this._transition.hideAllViews();
         if(param1)
         {
            LoginSignals.showLoginPrompt.dispatch();
         }
         LoginSignals.userHasLoggedOut.dispatch();
         this.returnToHomeScreen();
      }
      
      private function onRemoteLogout() : void
      {
         this._monkeyCityMain.clear();
         this._transition.hideAllViews();
         this.returnToHomeScreen();
         LoginSignals.showPlayPrompt.dispatch(true);
      }
      
      private function setUpLogOutLockZones() : void
      {
         this._mainMenu.playGameSignal.add(this.lockReturnToHomeScreen);
         WorldViewSignals.buildWorldStartSignal.add(this.lockReturnToHomeScreen);
         this._monkeyCityMain.openingNewCityPanelSignal.add(this.unLockReturnToHomeScreen);
         WorldViewSignals.buildWorldEndSignal.add(this.unLockReturnToHomeScreen);
         MyCitiesPanel.preGameCityPanelRevealed.add(this.unLockReturnToHomeScreen);
         MyCitiesPanel.preGameCitySelected.add(this.lockReturnToHomeScreen);
      }
      
      private function lockReturnToHomeScreen() : void
      {
         this._returnToHomeScreenLocked = true;
      }
      
      public function unLockReturnToHomeScreen() : void
      {
         this._returnToHomeScreenLocked = false;
         if(this._cuedReturnToHomeScreen === true)
         {
            this.returnToHomeScreen();
            this._cuedReturnToHomeScreen = false;
         }
      }
      
      public function tearDown() : void
      {
         this.stopTicker();
         this.loadingTransition.hide(0);
         this._buildProgressBar.hide(0);
         ResourceStore.getInstance().reset();
         this._transition.hideAllViews();
         this._monkeyCityMain.reset();
         this._mainMenu.revealHomeScreen();
         this._monkeyCityMain.ui.hideHUD();
         this._btdView.tearDownGame();
      }
      
      public function returnToHomeScreenAndRequireRefresh() : void
      {
         this._requireSWFRefresh = true;
         this._returnToHomeScreenLocked = false;
         this.returnToHomeScreen();
      }
      
      public function returnToHomeScreen(param1:Boolean = false) : void
      {
         if(this._returnToHomeScreenLocked && !param1)
         {
            this._cuedReturnToHomeScreen = true;
            return;
         }
         this.tearDown();
         MCMusic.playTitleMusic();
         if(this._requireSWFRefresh)
         {
            this._mainMenu.titleScreen.showRequireSWFRefreshMessage();
         }
      }
      
      private function onPlayGameSignal() : void
      {
         this._mainMenu.hide();
         this._monkeyCityMain.ui.hideHUD();
         MCMusic.playMapMusic();
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Contacting server...");
         this._buildProgressBar.reveal();
         setTimeout(this.launchGame,2000);
      }
      
      private function launchGame() : void
      {
         MonkeyCityMain.getInstance().worldView.clear();
         var hasSession:Boolean = WebAction.hasSession;
         if(hasSession)
         {
            this.launchGamePostHandshake();
         }
         else
         {
            Persistence.getInstance().shakeHandsWithServer(function(param1:Object):void
            {
               launchGamePostHandshake();
            });
         }
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Loading core data...");
         this._timeOfLastTick = this.system.getSecureTime();
      }
      
      public function launchGamePostHandshake() : void
      {
         Persistence.getInstance().loadCoreData(function():void
         {
            Persistence.getInstance().loadCityList(function():void
            {
               var onCityReadyToReveal:Function = null;
               onCityReadyToReveal = function():void
               {
                  CityInformation.citySelectedSignal.remove(onCityReadyToReveal);
                  WorldViewSignals.buildWorldEndSignal.remove(onCityReadyToReveal);
                  _monkeyCityMain.reveal();
                  _transition.makeOneViewVisible(_monkeyCityMain);
                  startTicker();
               };
               if(CityCommonDataManager.getInstance().numberOfCities === 0)
               {
                  TownUI.getInstance().newCityPanel.showNewCity();
               }
               else
               {
                  _monkeyCityMain.ui.myCitiesPanel.populateInfo(false);
                  PanelManager.getInstance().showPanel(_monkeyCityMain.ui.myCitiesPanel);
               }
               _buildProgressBar.hide();
               CityInformation.citySelectedSignal.addOnce(onCityReadyToReveal);
               WorldViewSignals.worldIsNowVisibleSignal.addOnce(onCityReadyToReveal);
            });
         });
      }
      
      public function clearMainBitmapData() : void
      {
         this._mainBitmapData.fillRect(this._mainBitmapData.rect,0);
      }
      
      private function startTicker() : void
      {
         addEventListener(Event.ENTER_FRAME,this.tick);
      }
      
      private function stopTicker() : void
      {
         this._mainBitmapData.fillRect(this._mainBitmapData.rect,0);
         removeEventListener(Event.ENTER_FRAME,this.tick);
      }
      
      private function tick(param1:Event) : void
      {
         var _loc2_:Number = this.system.getSecureTime();
         var _loc3_:Number = (_loc2_ - this._timeOfLastTick) * 0.001;
         this._transition.currentView.process(_loc3_);
         this._transition.currentView.draw(this._mainBitmapData);
         this._timeOfLastTick = _loc2_;
      }
      
      private function initialiseViews() : void
      {
         this._mainBitmapData = new BitmapData(this.system.RENDER_SURFACE_WIDTH,this.system.RENDER_SURFACE_HEIGHT,true,0);
         this._mainBitmap = new Bitmap(this._mainBitmapData);
         this._mainBitmap.smoothing = false;
         var _loc1_:Sprite = new Sprite();
         this._mainBitmapContainer.addChild(this._mainBitmap);
         addChild(this._mainBitmapContainer);
         addChild(this._transition);
         this._btdView = new BTDView();
         this._transition.registerView(this._btdView);
         this._monkeyCityMain = new MonkeyCityMain(this._mainBitmapContainer,this._btdView);
         this._transition.registerView(this._monkeyCityMain);
         addChild(this._mainMenu);
      }
      
      private function dancingShadowsAlarmHandler(param1:Event) : void
      {
      }
      
      private function stageResizeHandler(param1:Event = null) : void
      {
         var e:Event = param1;
         var currentTime:Number = new Date().getTime();
         var newWidth:int = stage.stageWidth;
         var newHeight:int = stage.stageHeight;
         this.system.RENDER_SURFACE_WIDTH = newWidth;
         this.system.RENDER_SURFACE_HEIGHT = newHeight;
         if(this._mainBitmapData !== null)
         {
            this._mainBitmapData.dispose();
         }
         try
         {
            this._mainBitmapData = new BitmapData(newWidth,newHeight,true,0);
         }
         catch(err:Error)
         {
         }
         this._mainBitmap.bitmapData = this._mainBitmapData;
         this.system.resizeSignal.dispatch(stage.stageWidth,stage.stageHeight);
         this._timeOfLastResize = currentTime;
      }
      
      public function get btdView() : BTDView
      {
         return this._btdView;
      }
      
      public function get mainBitmap() : Bitmap
      {
         return this._mainBitmap;
      }
      
      public function get mainBitmapData() : BitmapData
      {
         return this._mainBitmapData;
      }
      
      public function get returnToHomeScreenLocked() : Boolean
      {
         return this._returnToHomeScreenLocked;
      }
   }
}
