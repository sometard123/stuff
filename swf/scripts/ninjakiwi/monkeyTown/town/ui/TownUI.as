package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.MonkeyCityMainUIClip;
   import assets.ui.MobilePromoButtonInGameClip;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.saleEvents.ui.KnowledgePackSaleIntroPanel;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.NotEnoughCashPanel;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossBattleVictoryPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GameEventsUIManager;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackPanelBase;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackPanelBloonBeacon;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackPanelContest;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackSpecialMissionPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.BossBattleAttackPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.TestMissionPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CrateRequestSentPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesReturnedPanel;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesSentMessagePanel;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.IncomingCratePanel;
   import ninjakiwi.monkeyTown.town.ui.construction.DemolishConfirmPanel;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryUnlockedPanel;
   import ninjakiwi.monkeyTown.town.ui.currencyExchange.BloonstonesToBloontoniumExchangeUI;
   import ninjakiwi.monkeyTown.town.ui.currencyExchange.BloonstonesToCashExchangeUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenu;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.RequestCratePanel;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.SendCratePanel;
   import ninjakiwi.monkeyTown.town.ui.loading.LoadingPopup;
   import ninjakiwi.monkeyTown.town.ui.myCitiesPanel.MyCitiesPanel;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackTutorial;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTracksPanel;
   import ninjakiwi.monkeyTown.town.ui.myTrack.TrackReplayPanel;
   import ninjakiwi.monkeyTown.town.ui.newsPanelScroller.NewsPanelScroller;
   import ninjakiwi.monkeyTown.town.ui.promo.MobilePromoButtonInGame;
   import ninjakiwi.monkeyTown.town.ui.pvp.BattleHistoryPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.MvMTutorialPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.PacifistModePanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPDefendTilePanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.UseBloonstonesConfirmPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackFailedPanel;
   import ninjakiwi.monkeyTown.town.ui.salePanels.MonkeyKnowledgePackSalePanel;
   import ninjakiwi.monkeyTown.town.ui.skipClockPanel.SkipBuildPanel;
   import ninjakiwi.monkeyTown.town.ui.skipClockPanel.SkipBuildingUpgradeWarmupPanel;
   import ninjakiwi.monkeyTown.town.ui.skipClockPanel.SkipUpgradeWarmupPanel;
   import ninjakiwi.monkeyTown.town.ui.terrain.CapturedTerrainInfoPanel;
   import ninjakiwi.monkeyTown.town.ui.warning.MissingSomethingPanel;
   import ninjakiwi.monkeyTown.ui.BuildingInfoPanelPremium;
   import ninjakiwi.monkeyTown.ui.BuyBloonstonesPanel;
   import ninjakiwi.monkeyTown.ui.ConfirmPanel;
   import ninjakiwi.monkeyTown.ui.ConfirmPurchasePanel;
   import ninjakiwi.monkeyTown.ui.ContestDailyPanel;
   import ninjakiwi.monkeyTown.ui.ContestDailyPanelWithScores;
   import ninjakiwi.monkeyTown.ui.ContestExpiredPanel;
   import ninjakiwi.monkeyTown.ui.ContestLoseWeekPanel;
   import ninjakiwi.monkeyTown.ui.ContestLostLead;
   import ninjakiwi.monkeyTown.ui.ContestWinWeekPanel;
   import ninjakiwi.monkeyTown.ui.ContestedTerritoryLeaderPanel;
   import ninjakiwi.monkeyTown.ui.GenericConfirmPurchasePanel;
   import ninjakiwi.monkeyTown.ui.GenericModalSpinner;
   import ninjakiwi.monkeyTown.ui.LoseInfoPanel;
   import ninjakiwi.monkeyTown.ui.MaintenanceScheduledMessage;
   import ninjakiwi.monkeyTown.ui.Notification;
   import ninjakiwi.monkeyTown.ui.OptionsPanel;
   import ninjakiwi.monkeyTown.ui.PurchaseNKCoinsPanel;
   import ninjakiwi.monkeyTown.ui.ShutDownOverlay;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.WatchVideosForBloonstonesPanel;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MoneyKnowledgeLevelUpPopup;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeInfoPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeIntroPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeOpenPacksScreen;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeWonPacksPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.ui.videoAds.InterstitialController;
   import ninjakiwi.monkeyTown.ui.videoAds.VideoPromptInterstitialGeneric;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.Flatten;
   import org.osflash.signals.Signal;
   
   public class TownUI extends MovieClip
   {
      
      private static var _instance:TownUI;
      
      private static const _clip:MonkeyCityMainUIClip = new MonkeyCityMainUIClip();
      
      private static const _arrowMyTowersClip:MovieClip = _clip.bottomUI.arrowMyTowers;
      
      private static const _arrowBuildClip:MovieClip = _clip.bottomUI.arrowBuild;
      
      public static const BASE_BUILDINGS:String = "baseBuildings";
      
      public static const UPGRADE_BUILDINGS:String = "upgradeBuildings";
      
      public static const RESOURCE_BUILDINGS:String = "resourceBuildings";
      
      public static const showToolTipSignal:Signal = new Signal(String);
      
      public static const hideToolTipSignal:Signal = new Signal();
      
      public static const globalMouseDownSignal:Signal = new Signal();
      
      public static const globalMouseOverSignal:Signal = new Signal();
       
      
      public var buildPanel:BuildPanel;
      
      public var upgradesPanel:UpgradesPanel;
      
      public var genericInfoPanel:GenericInfoPanel;
      
      public var firstTimeTriggerPanel:FirstTimeTriggerPanel;
      
      public var myTowersPanel:MyTowersPanel;
      
      public var myTracksPanel:MyTracksPanel;
      
      public var trackReplayPanel:TrackReplayPanel;
      
      public var specialItemsPanel:SpecialItemsPanel;
      
      public var myCitiesPanel:MyCitiesPanel;
      
      public var specialTracksPanel:SpecialTracksPanel;
      
      public var skipBuildPanel:SkipBuildPanel;
      
      public var skipBuildingUpgradeWarmupPanel:SkipBuildingUpgradeWarmupPanel;
      
      public var skipUpgradeWarmupPanel:SkipUpgradeWarmupPanel;
      
      public var informationBar:InformationBar;
      
      public var bottomUI:MapBottomUI;
      
      public var baseBuildingInfoPanel:BaseBuildingInfoPanel;
      
      public var buildingInfoPanel:BuildingInfoPanel;
      
      public var winInfoPanel:WinInfoPanel;
      
      public var pvpWinInfoPanel:PvPWinInfoPanel;
      
      public var pvpWinAttackInfoPanel:PvPWinAttackInfoPanel;
      
      public var pvpLoseInfoPanel:PvPLoseInfoPanel;
      
      public var loseInfoPanel:LoseInfoPanel;
      
      public var bossBattleVictoryPanel:BossBattleVictoryPanel;
      
      public var generatingWorldMessage:GeneratingWorldMessage;
      
      public var bloonstonesToCashExchangeUI:BloonstonesToCashExchangeUI;
      
      public var bloonstonesToBloontoniumExchangeUI:BloonstonesToBloontoniumExchangeUI;
      
      public var notificationPanel:Notification;
      
      public var confirmPanel:ConfirmPanel;
      
      public var questsUI:QuestsUI;
      
      public var notificationUI:NotificationUI;
      
      public var pvpPanel:PvPPanel;
      
      public var pvpAttackPanel:PvPAttackPanel;
      
      public var bossBattleAttackPanel:BossBattleAttackPanel;
      
      public var treasurePanel:TreasureChestPanel;
      
      public var levelUpPanel:LevelUpPanel;
      
      public var attackPanel:AttackPanel;
      
      public var attackSpecialMissionPanel:AttackSpecialMissionPanel;
      
      public var attackPanelContest:AttackPanelContest;
      
      public var terrainInfoPanel:TerrainInfoPanel;
      
      public var newCityPanel:NewCityPanel;
      
      public var battleHistoryPanel:BattleHistoryPanel;
      
      public var skipTrivialAttackPanel:SkipTrivialAttackPanel;
      
      public var bloonResearchLabPanel:BloonResearchLabPanel;
      
      public var upgradeBuildingPanel:UpgradeBuildingPanel;
      
      public var pvpAttackDeployedPanel:AttackDeployedPanel;
      
      public var missingSomethingPanel:MissingSomethingPanel;
      
      public var capturedTerrainInfoPanel:CapturedTerrainInfoPanel;
      
      public var compass:Compass;
      
      public var watchVideosForBloonstonesPanel:WatchVideosForBloonstonesPanel;
      
      public var pacifistModePanel:PacifistModePanel;
      
      public var testMissionPanel:TestMissionPanel;
      
      public var demolishConfirmPanel:DemolishConfirmPanel;
      
      public var loading:LoadingPopup;
      
      public var attackFailedPanel:PvPAttackFailedPanel;
      
      public var mvmTutorialPanel:MvMTutorialPanel;
      
      public var myTrackTutorial:MyTrackTutorial;
      
      public var contestedTerritoryUnlockedPanel:ContestedTerritoryUnlockedPanel;
      
      public var starterPackTutorial:StarterPackTutorialPanel;
      
      public var newCityUnlockedPanel:NewCityUnlockedPanel;
      
      public var useBloonstonesConfirmPanel:UseBloonstonesConfirmPanel;
      
      public var requestCratePanel:RequestCratePanel;
      
      public var sendCratePanel:SendCratePanel;
      
      public var crateRequestSentPanel:CrateRequestSentPanel;
      
      public var cratesSentMessagePanel:CratesSentMessagePanel;
      
      public var cratesReturnedPanel:CratesReturnedPanel;
      
      public var incomingCratePanel:IncomingCratePanel;
      
      public var contestLostLead:ContestLostLead;
      
      public var contestExpiredPanel:ContestExpiredPanel;
      
      public var contestDailyPanel:ContestDailyPanel;
      
      public var contestDailyPanelWithScores:ContestDailyPanelWithScores;
      
      public var contestWinWeekPanel:ContestWinWeekPanel;
      
      public var contestLoseWeekPanel:ContestLoseWeekPanel;
      
      public var contestWinGamePanel:ContestedTerritoryLeaderPanel;
      
      public var videoPromptGeneric:VideoPromptInterstitialGeneric;
      
      public var videoPromptMvM:VideoPromptInterstitialGeneric;
      
      public var contestedTerritoryPanel:ContestedTerritoryPanel;
      
      public var premiumBuildingInfoPanel:BuildingInfoPanelPremium;
      
      public var confirmPurchasePanel:ConfirmPurchasePanel;
      
      public var genericConfirmPurchasePanel:GenericConfirmPurchasePanel;
      
      public var purchaseNKCoinsPanel:PurchaseNKCoinsPanel;
      
      public var maintenanceScheduledMessage:MaintenanceScheduledMessage;
      
      public var towerUnlockedPanel:TowerUnlockedPanel;
      
      public var desertCityWelcomePanel:WelcomeDesertPanel;
      
      public var optionsPanel:OptionsPanel;
      
      public var gameEventsUIManager:GameEventsUIManager;
      
      private const connectivityStateUIManager:ConnectivityStateUIManager = new ConnectivityStateUIManager();
      
      public var genericModalSpinner:GenericModalSpinner;
      
      public const tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      public const buildingData:BuildingData = BuildingData.getInstance();
      
      public const system:MonkeySystem = MonkeySystem.getInstance();
      
      public var buyBloonstonesPanel:BuyBloonstonesPanel;
      
      private var _btdMockup:MovieClip;
      
      private var _tooltip:ToolTip;
      
      public var monkeyKnowledgeLevelUpPopup:MoneyKnowledgeLevelUpPopup;
      
      public var winMonkeyKnowledgePopup:MonkeyKnowledgeWonPacksPanel;
      
      public var monkeyKnowledgeIntroPanel:MonkeyKnowledgeIntroPanel;
      
      public var knowledgePackSaleIntroPanel:KnowledgePackSaleIntroPanel;
      
      public var genericEventPopupPanel:GenericEventPopupPanel;
      
      public var bloonBeaconAttackPanel:AttackPanelBloonBeacon;
      
      public var eventsMenu:EventsMenu;
      
      public var knowledgePackSalePanel:MonkeyKnowledgePackSalePanel;
      
      public var notEnoughCashPanel:NotEnoughCashPanel;
      
      public var shutDownOverlay:ShutDownOverlay;
      
      private var _tasksContainer:MovieClip;
      
      private var _worldView:WorldView;
      
      public var beginPlacingBuildingSignal:Signal;
      
      public var cancelPlacingBuildingSignal:Signal;
      
      public var cancelMovingBuildingSignal:Signal;
      
      public var confirmedAttackSignal:Signal;
      
      public var cancelledAttackSignal:Signal;
      
      public var requestAttackUISignal:Signal;
      
      public var requestBeaconAttackUISignal:Signal;
      
      public var containerBelowHUD:Sprite;
      
      private var _consoleField:TextField;
      
      private var _consoleFieldContainer:Sprite;
      
      public const panelLayer:Sprite = new Sprite();
      
      public const popupLayer:Sprite = new Sprite();
      
      public const tutorialLayer:Sprite = new Sprite();
      
      public const higherPopupLayer:Sprite = new Sprite();
      
      public var interstitialController:InterstitialController;
      
      public var mobilePromo:MobilePromoButtonInGame;
      
      public var monkeyKnowledgeOpenPacksScreen:MonkeyKnowledgeOpenPacksScreen;
      
      public var monkeyKnowledgeInfoPanel:MonkeyKnowledgeInfoPanel;
      
      public var newsPanelScroller:NewsPanelScroller;
      
      public function TownUI(param1:WorldView)
      {
         this._tooltip = new ToolTip();
         this._tasksContainer = _clip.tasksContainer;
         this.beginPlacingBuildingSignal = new Signal();
         this.cancelPlacingBuildingSignal = new Signal();
         this.cancelMovingBuildingSignal = new Signal();
         this.confirmedAttackSignal = new Signal(TileAttackDefinition);
         this.cancelledAttackSignal = new Signal(TileAttackDefinition);
         this.requestAttackUISignal = new Signal(Function,Function,TileAttackDefinition);
         this.requestBeaconAttackUISignal = new Signal(Function,Function,TileAttackDefinition);
         this._consoleFieldContainer = new Sprite();
         super();
         _instance = this;
         this._worldView = param1;
         addChild(_clip);
         this.addChild(this.panelLayer);
         this.addChild(this.popupLayer);
         this.addChild(this.tutorialLayer);
         this.addChild(this.higherPopupLayer);
         this.init();
      }
      
      public static function getInstance() : TownUI
      {
         return _instance;
      }
      
      public function tick() : void
      {
         this.compass.tick();
      }
      
      private function init() : void
      {
         this._consoleField = _clip.terrainInfoBox.consoleField;
         this._consoleField.mouseEnabled = false;
         this.compass = new Compass(_clip.compass,this._worldView.camera);
         this.informationBar = new InformationBar(_clip.informationBar);
         this.baseBuildingInfoPanel = new BaseBuildingInfoPanel(this.popupLayer);
         this.buildingInfoPanel = new BuildingInfoPanel(this.popupLayer);
         this.winInfoPanel = new WinInfoPanel(this.popupLayer);
         this.bossBattleVictoryPanel = new BossBattleVictoryPanel(this.popupLayer);
         this.pvpWinInfoPanel = new PvPWinInfoPanel(Main.instance.topLevelUIContainer);
         this.pvpLoseInfoPanel = new PvPLoseInfoPanel(Main.instance.topLevelUIContainer);
         this.loseInfoPanel = new LoseInfoPanel(Main.instance.topLevelUIContainer);
         this.pvpAttackDeployedPanel = new AttackDeployedPanel(this.popupLayer);
         this.containerBelowHUD = new Sprite();
         addChild(this.containerBelowHUD);
         this.generatingWorldMessage = new GeneratingWorldMessage(this.popupLayer);
         this.buildPanel = new BuildPanel(_clip.bottomUI.panelContainer);
         this.bloonResearchLabPanel = new BloonResearchLabPanel(this.popupLayer);
         this.contestedTerritoryPanel = new ContestedTerritoryPanel(_clip.bottomUI.panelContainer);
         this.upgradesPanel = new UpgradesPanel(_clip.bottomUI.panelContainer);
         this.myTowersPanel = new MyTowersPanel(_clip.bottomUI.panelContainer);
         this.myTracksPanel = new MyTracksPanel(_clip.bottomUI.panelContainer);
         var _loc1_:Sprite = new Sprite();
         _loc1_.y = 600;
         Main.instance.topLevelUIContainer.addChild(_loc1_);
         this.myCitiesPanel = new MyCitiesPanel(_loc1_,_clip.bottomUI.panelContainer);
         this.newCityPanel = new NewCityPanel(Main.instance.topLevelUIContainer);
         this.gameEventsUIManager = new GameEventsUIManager(Main.instance.topLevelUIContainer);
         this.specialItemsPanel = new SpecialItemsPanel(_clip.bottomUI.panelContainer);
         this.specialTracksPanel = new SpecialTracksPanel(_clip.bottomUI.panelContainer);
         this.trackReplayPanel = new TrackReplayPanel(this.popupLayer);
         this.skipBuildPanel = new SkipBuildPanel(this.popupLayer);
         this.skipBuildingUpgradeWarmupPanel = new SkipBuildingUpgradeWarmupPanel(this.popupLayer);
         this.skipUpgradeWarmupPanel = new SkipUpgradeWarmupPanel(this.popupLayer);
         this.notificationPanel = new Notification(this.popupLayer);
         this.genericInfoPanel = new GenericInfoPanel(this.popupLayer);
         this.confirmPanel = new ConfirmPanel(this.popupLayer);
         this.pvpAttackPanel = new PvPAttackPanel(this.popupLayer,this._worldView.map);
         this.pvpPanel = new PvPPanel(_clip.bottomUI.panelContainer);
         this.attackPanelContest = new AttackPanelContest(this.popupLayer);
         this.requestCratePanel = new RequestCratePanel(this.popupLayer);
         this.sendCratePanel = new SendCratePanel(this.popupLayer);
         this.crateRequestSentPanel = new CrateRequestSentPanel(this.popupLayer);
         this.cratesSentMessagePanel = new CratesSentMessagePanel(this.popupLayer);
         this.cratesReturnedPanel = new CratesReturnedPanel(this.popupLayer);
         this.incomingCratePanel = new IncomingCratePanel(this.popupLayer);
         this.contestLostLead = new ContestLostLead(this.popupLayer);
         this.contestExpiredPanel = new ContestExpiredPanel(this.popupLayer);
         this.contestDailyPanel = new ContestDailyPanel(this.popupLayer);
         this.contestDailyPanelWithScores = new ContestDailyPanelWithScores(this.popupLayer);
         this.contestWinWeekPanel = new ContestWinWeekPanel(this.popupLayer);
         this.contestLoseWeekPanel = new ContestLoseWeekPanel(this.popupLayer);
         this.contestWinGamePanel = new ContestedTerritoryLeaderPanel(this.popupLayer);
         this.premiumBuildingInfoPanel = new BuildingInfoPanelPremium(this.popupLayer);
         this.confirmPurchasePanel = new ConfirmPurchasePanel(this.popupLayer);
         this.genericConfirmPurchasePanel = new GenericConfirmPurchasePanel(this.popupLayer);
         this.purchaseNKCoinsPanel = new PurchaseNKCoinsPanel(this.popupLayer);
         this.treasurePanel = new TreasureChestPanel(this.popupLayer);
         this.levelUpPanel = new LevelUpPanel(this.popupLayer);
         this.attackPanel = new AttackPanel(this.popupLayer);
         this.attackSpecialMissionPanel = new AttackSpecialMissionPanel(this.popupLayer);
         this.terrainInfoPanel = new TerrainInfoPanel(this.popupLayer,this._worldView);
         this.upgradeBuildingPanel = new UpgradeBuildingPanel(this.popupLayer);
         this.battleHistoryPanel = new BattleHistoryPanel(this.popupLayer);
         this.skipTrivialAttackPanel = new SkipTrivialAttackPanel(this.popupLayer);
         this.missingSomethingPanel = new MissingSomethingPanel(this.popupLayer);
         this.capturedTerrainInfoPanel = new CapturedTerrainInfoPanel(this.popupLayer);
         this.firstTimeTriggerPanel = new FirstTimeTriggerPanel(this.tutorialLayer);
         this.testMissionPanel = new TestMissionPanel(this.popupLayer);
         this.demolishConfirmPanel = new DemolishConfirmPanel(this.popupLayer);
         this.questsUI = new QuestsUI(this.popupLayer,_clip.questUI);
         this.eventsMenu = new EventsMenu(_clip.eventsMenuContainer);
         this.genericEventPopupPanel = new GenericEventPopupPanel(this.popupLayer);
         this.knowledgePackSalePanel = new MonkeyKnowledgePackSalePanel(this.popupLayer);
         this.knowledgePackSaleIntroPanel = new KnowledgePackSaleIntroPanel(this.popupLayer);
         this.notEnoughCashPanel = new NotEnoughCashPanel(this.popupLayer);
         this.notificationUI = new NotificationUI(_clip.bottomUI.questsInfoButton,_clip.bottomUI.newsInfoButton,_clip.bottomUI.questsListPanel);
         this.loading = new LoadingPopup(this.higherPopupLayer);
         this.attackFailedPanel = new PvPAttackFailedPanel(this.popupLayer);
         this.mvmTutorialPanel = new MvMTutorialPanel(this.tutorialLayer);
         this.myTrackTutorial = new MyTrackTutorial(this.tutorialLayer);
         this.starterPackTutorial = new StarterPackTutorialPanel(this.tutorialLayer);
         this.useBloonstonesConfirmPanel = new UseBloonstonesConfirmPanel(this.popupLayer);
         this.pacifistModePanel = new PacifistModePanel(this.popupLayer);
         this.newsPanelScroller = new NewsPanelScroller(this.popupLayer);
         this.contestedTerritoryUnlockedPanel = new ContestedTerritoryUnlockedPanel(this.tutorialLayer);
         this.newCityUnlockedPanel = new NewCityUnlockedPanel(this.tutorialLayer);
         this.buyBloonstonesPanel = new BuyBloonstonesPanel(Main.instance.topLevelUIContainer);
         this.maintenanceScheduledMessage = new MaintenanceScheduledMessage(this.popupLayer);
         this.towerUnlockedPanel = new TowerUnlockedPanel(this.popupLayer);
         this.desertCityWelcomePanel = new WelcomeDesertPanel(this.popupLayer);
         this.genericModalSpinner = new GenericModalSpinner(this.popupLayer);
         this.optionsPanel = new OptionsPanel(Main.instance.topLevelUIContainer);
         this.monkeyKnowledgeOpenPacksScreen = new MonkeyKnowledgeOpenPacksScreen(this.popupLayer);
         this.monkeyKnowledgeInfoPanel = new MonkeyKnowledgeInfoPanel(this.popupLayer);
         this.monkeyKnowledgeLevelUpPopup = new MoneyKnowledgeLevelUpPopup(this.popupLayer);
         this.winMonkeyKnowledgePopup = new MonkeyKnowledgeWonPacksPanel(this.popupLayer);
         this.monkeyKnowledgeIntroPanel = new MonkeyKnowledgeIntroPanel(this.popupLayer);
         this.mobilePromo = new MobilePromoButtonInGame(new MobilePromoButtonInGameClip());
         Main.instance.topLevelUIContainer.addChild(this.mobilePromo);
         this.contestedTerritoryPanel.init();
         this.contestedTerritoryPanel.uiMutexGroup = "mainUIPanel";
         this.contestedTerritoryPanel.autocloseMutexSiblings = true;
         this.myTowersPanel.uiMutexGroup = "mainUIPanel";
         this.myTowersPanel.autocloseMutexSiblings = true;
         this.myTracksPanel.uiMutexGroup = "mainUIPanel";
         this.myTracksPanel.autocloseMutexSiblings = true;
         this.buildPanel.uiMutexGroup = "mainUIPanel";
         this.buildPanel.autocloseMutexSiblings = true;
         this.specialTracksPanel.uiMutexGroup = "mainUIPanel";
         this.specialTracksPanel.autocloseMutexSiblings = true;
         this.upgradesPanel.uiMutexGroup = "mainUIPanel";
         this.upgradesPanel.autocloseMutexSiblings = true;
         this.specialItemsPanel.uiMutexGroup = "mainUIPanel";
         this.specialItemsPanel.autocloseMutexSiblings = true;
         this.myCitiesPanel.uiMutexGroup = "mainUIPanel";
         this.myCitiesPanel.autocloseMutexSiblings = true;
         this.pvpAttackPanel.uiMutexGroup = "mainUIPanel";
         this.pvpAttackPanel.autocloseMutexSiblings = true;
         this.pvpPanel.uiMutexGroup = "mainUIPanel";
         this.pvpPanel.autocloseMutexSiblings = true;
         this.bloonBeaconAttackPanel = new AttackPanelBloonBeacon(this.popupLayer);
         this.contestedTerritoryPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.buildPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.upgradesPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.myTowersPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.myTracksPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.specialItemsPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.myCitiesPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.pvpAttackPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.pvpPanel.modalBlockerContainer = _clip.bottomUIModalContainer;
         this.skipBuildPanel.uiMutexGroup = "mainUIPanel";
         this.skipBuildingUpgradeWarmupPanel.uiMutexGroup = "mainUIPanel";
         this.bloonstonesToCashExchangeUI = new BloonstonesToCashExchangeUI(this.higherPopupLayer);
         this.bloonstonesToBloontoniumExchangeUI = new BloonstonesToBloontoniumExchangeUI(this.higherPopupLayer);
         this.bossBattleAttackPanel = new BossBattleAttackPanel(this.popupLayer);
         this.bottomUI = new MapBottomUI(_clip.bottomUI);
         this.setMyTowersArrowActive(false);
         this.setBuildArrowActive(false);
         addChild(this._tooltip);
         this._tooltip.setStage(this.system.flashStage);
         this._tooltip.message = "";
         this._tooltip.activateMouseFollow();
         this._tooltip.scaleWidthByTextWidth = true;
         this._tooltip.positionOffset.x = 15;
         this._tooltip.positionOffset.y = -10;
         this.watchVideosForBloonstonesPanel = new WatchVideosForBloonstonesPanel(this.higherPopupLayer);
         this.videoPromptGeneric = new VideoPromptInterstitialGeneric(this.higherPopupLayer);
         this.videoPromptMvM = new VideoPromptInterstitialGeneric(this.higherPopupLayer);
         this.interstitialController = new InterstitialController();
         showToolTipSignal.add(this.showToolTip);
         hideToolTipSignal.add(this._tooltip.hide);
         if(!Constants.USE_DEV_MAGIC || true)
         {
            this._consoleField.htmlText = "";
            this._consoleField.height = 0;
         }
         Flatten.flatten(_clip.lowerLeftCornerEmbellishment);
         Flatten.flatten(_clip.lowerRightCornerEmbellishment);
         this.initListeners();
         _clip.backgroundBottom.visible = false;
      }
      
      private function showToolTip(param1:String) : void
      {
         this._tooltip.message = param1;
         this._tooltip.clip.visible = true;
         this._tooltip.reveal();
      }
      
      private function initListeners() : void
      {
         this.capturedTerrainInfoPanel.buildSignal.add(this.tileBuildButtonClicked);
         this.bottomUI.contestedTerritoryButtonClickedSignal.add(this.onContestedTerritoryButtonClicked);
         this.bottomUI.specialTracksButtonClickedSignal.add(this.onSpecialTracksButtonClicked);
         this.bottomUI.myTowersButtonClickedSignal.add(this.onMyTowersButtonClicked);
         this.bottomUI.buildButtonClickedSignal.add(this.onBuildButtonClicked);
         this.bottomUI.cancelBuildButtonClickedSignal.add(this.onCancelPlaceBuildingButtonClicked);
         this.bottomUI.cancelMoveButtonClickedSignal.add(this.onCancelMoveBuildingButtonClicked);
         this.bottomUI.upgradesButtonClickedSignal.add(this.onUpgradesButtonClicked);
         this.bottomUI.pvpButtonClickedSignal.add(this.onPVPButtonClicked);
         this.bottomUI.myCitiesButtonClickedSignal.add(this.onMyCitiesButtonClicked);
         this.system.resizeSignal.add(this.onResize);
         this.buildPanel.buildingWasSelectedSignal.add(this.onBuildingWasSelectedSignal);
         this.buildPanel.buildingWasSelectedForTileSignal.add(this.onBuildingWasSelectedForTileSignal);
         WorldViewSignals.requestBTDGameSignal.add(this.onRequestBTDGame);
         WorldViewSignals.requestBeaconGameSignal.add(this.onRequestBeaconGame);
         WorldViewSignals.reportOnMouseEnterNewTile.add(this.onReportOnMouseEnterNewTileSignal);
         WorldViewSignals.buildingWasPlacedWithoutShiftSignal.add(this.onBuildingWasPlacedWithoutShiftSignal);
         WorldViewSignals.buildWorldProgressSignal.add(this.onBuildWorldProgressSignal);
         this.pvpPanel.attackTargetSelectedSignal.add(this.onPvPAttackTargetSelectedSignal);
         this.pvpPanel.incomingRaidSelectedSignal.add(this.onIncomingRaidSelectedSignal);
         PvPSignals.defendTileSignal.add(this.pvpDefendTile);
         PvPSignals.requestRevengeAttack.add(this.onRequestRevengeAttackSignal);
         PvPSignals.requestReportMultipleNewPvPAttackVictories.add(this.onRequestReportMultipleNewPvPAttackVictories);
         PvPSignals.requestReportNewPvPAttackVictory.add(this.onRequestReportNewPvPAttackVictory);
         WorldViewSignals.requestGenericConfirmation.add(this.onRequestGenericConfirmation);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onAllUIMouseOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onAllUIMouseDown);
         this.bottomUI.giveCrateButtonClickedSignal.add(this.onGiveCrateButtonClicked);
         this.bottomUI.getCrateButtonClickedSignal.add(this.onGetCrateButtonClicked);
         WorldViewSignals.initialMVMDataReceived.add(this.revealHud);
         this.shutDownOverlay = new ShutDownOverlay();
      }
      
      private function onGetCrateButtonClicked() : void
      {
         PanelManager.getInstance().showPanelOverlay(this.requestCratePanel);
      }
      
      private function onGiveCrateButtonClicked() : void
      {
         this.showSendCratePanel();
      }
      
      public function showCrateRequestSentPanel() : void
      {
         PanelManager.getInstance().showPanelOverlay(this.crateRequestSentPanel);
      }
      
      public function showCratesSentPanel() : void
      {
         PanelManager.getInstance().showPanelOverlay(this.cratesSentMessagePanel);
      }
      
      public function showCratesReturnedPanel(param1:Vector.<String>) : void
      {
         var userIDs:Vector.<String> = param1;
         this.cratesReturnedPanel.populateInfo(userIDs,function():void
         {
            PanelManager.getInstance().showPanelOverlay(cratesReturnedPanel);
         });
      }
      
      public function showSendCratePanel() : void
      {
         PanelManager.getInstance().showPanelOverlay(this.sendCratePanel);
      }
      
      private function onAllUIMouseDown(param1:MouseEvent) : void
      {
         TownUI.globalMouseDownSignal.dispatch();
      }
      
      private function onAllUIMouseOver(param1:MouseEvent) : void
      {
         TownUI.globalMouseOverSignal.dispatch();
      }
      
      private function onRequestGenericConfirmation(param1:String, param2:String, param3:Function) : void
      {
         var title:String = param1;
         var message:String = param2;
         var callback:Function = param3;
         this.confirmPanel.setMessage(ConfirmPanel.YES | ConfirmPanel.NO,title,message);
         this.confirmPanel.reveal();
         this.confirmPanel.responseSignal.addOnce(function(param1:Boolean):void
         {
            callback(param1);
         });
      }
      
      private function onReportOnMouseEnterNewTileSignal(param1:String) : void
      {
         this._consoleField.htmlText = "";
         this._consoleField.height = 0;
      }
      
      private function onRequestReportMultipleNewPvPAttackVictories() : void
      {
         PanelManager.getInstance().showPanel(this.battleHistoryPanel);
      }
      
      private function onRequestReportNewPvPAttackVictory(param1:Object) : void
      {
         this.pvpWinAttackInfoPanel = new PvPWinAttackInfoPanel(this.popupLayer);
         this.pvpWinAttackInfoPanel.syncToData(param1);
         PanelManager.getInstance().showPanel(this.pvpWinAttackInfoPanel);
      }
      
      private function pvpDefendTile(param1:IncomingRaid, param2:Boolean = false) : void
      {
         var pvpDefendTilePanel:PvPDefendTilePanel = null;
         var attack:IncomingRaid = param1;
         var notification:Boolean = param2;
         if(!MonkeyCityMain.isInGame)
         {
            pvpDefendTilePanel = new PvPDefendTilePanel(this.popupLayer);
            pvpDefendTilePanel.syncToAttack(attack,notification);
            pvpDefendTilePanel.attackConfirmSignal.addOnce(function(param1:Boolean):void
            {
               if(param1 == true)
               {
                  PvPSignals.defendAttack.dispatch(attack,pvpDefendTilePanel.startCashOption.calculatePossibleBonusCash(),pvpDefendTilePanel.isHardcore,pvpDefendTilePanel.cratesTickedArray,pvpDefendTilePanel.startCashOption.bonusCashTickbox.ticked);
               }
            });
            PanelManager.getInstance().showPanel(pvpDefendTilePanel);
         }
      }
      
      private function onRequestRevengeAttackSignal(param1:Friend, param2:int) : void
      {
         param1 = new Friend({
            "userID":param1.userID,
            "name":param1.name,
            "clan":param1.clan,
            "cities":JSON.parse(JSON.stringify(param1.cities))
         });
         if(this.pvpAttackPanel.canSendAttack())
         {
            this.pvpAttackPanel.setUpRevengeAttack(param1,param2);
            PanelManager.getInstance().showPanel(this.pvpAttackPanel);
         }
         else
         {
            PvPSignals.revengeOpportunityNotTaken.dispatch();
         }
      }
      
      private function onPvPAttackTargetSelectedSignal(param1:Friend, param2:int) : void
      {
         if(this.pvpAttackPanel.canSendAttack())
         {
            if(this.pvpAttackPanel.checkMiniumBloonType(param1,param2) == true)
            {
               PvPSignals.selectBloontoniumScreenShown.dispatch();
               this.pvpPanel.hide();
               this.pvpAttackPanel.syncToOpponent(param1,param2);
               PanelManager.getInstance().showPanelOverlay(this.pvpAttackPanel);
            }
         }
      }
      
      private function onIncomingRaidSelectedSignal(param1:IncomingRaid) : void
      {
         this.pvpPanel.hide();
         PvPSignals.defendTileSignal.dispatch(param1);
      }
      
      private function onBuildingWasPlacedWithoutShiftSignal(param1:Building) : void
      {
         this.readyForNewSelection();
      }
      
      private function onBuildWorldProgressSignal(param1:Number) : void
      {
      }
      
      private function onRequestBTDGame(param1:TileAttackDefinition) : void
      {
         var tileAttackDefinition:TileAttackDefinition = param1;
         var openNow:Boolean = true;
         this.requestAttackUISignal.dispatch(function():void
         {
            openNow = false;
         },this.showAttackPanel,tileAttackDefinition);
         if(openNow)
         {
            this.showAttackPanel(tileAttackDefinition);
         }
      }
      
      private function onRequestBeaconGame(param1:TileAttackDefinition) : void
      {
         this.showBeaconAttackPanel(param1);
      }
      
      private function showBeaconAttackPanel(param1:TileAttackDefinition) : void
      {
         var tileAttackDefinition:TileAttackDefinition = param1;
         this.bloonBeaconAttackPanel.syncToAttack(tileAttackDefinition);
         PanelManager.getInstance().showFreePanel(this.bloonBeaconAttackPanel);
         MCSound.getInstance().playSound(MCSound.BEACON_OPEN);
         this.bloonBeaconAttackPanel.attackSelectionSignal.addOnce(function(param1:Boolean, ... rest):void
         {
            tileAttackDefinition.crates = bloonBeaconAttackPanel.cratesTickedArray;
            tileAttackDefinition.bonusStartingCash = bloonBeaconAttackPanel.startCashOption.possibleBonusCash;
            tileAttackDefinition.isBonusCashMode = bloonBeaconAttackPanel.startCashOption.bonusCashTickbox.ticked;
            switch(param1)
            {
               case true:
                  confirmedAttackSignal.dispatch(tileAttackDefinition);
                  break;
               default:
                  cancelledAttackSignal.dispatch(tileAttackDefinition);
            }
         });
      }
      
      private function showAttackPanel(param1:TileAttackDefinition) : void
      {
         var panel:AttackPanelBase = null;
         var tileAttackDefinition:TileAttackDefinition = param1;
         var mission:SpecialMissionDefinition = SpecialMissionsManager.getInstance().findSpecialMission(this._worldView.map.tileAtPoint(tileAttackDefinition.attackAtLocation));
         if(mission != null)
         {
            panel = this.attackSpecialMissionPanel;
         }
         else
         {
            panel = this.attackPanel;
         }
         panel.setMessage(this._worldView.map,tileAttackDefinition);
         panel.attackConfirmSignal.addOnce(function(param1:Boolean, ... rest):void
         {
            tileAttackDefinition.isHardcore = panel.isHardcore;
            tileAttackDefinition.crates = panel.cratesTickedArray;
            tileAttackDefinition.bonusStartingCash = panel.startCashOption.possibleBonusCash;
            tileAttackDefinition.isBonusCashMode = panel.startCashOption.bonusCashTickbox.ticked;
            switch(param1)
            {
               case true:
                  confirmedAttackSignal.dispatch(tileAttackDefinition);
                  break;
               default:
                  cancelledAttackSignal.dispatch(tileAttackDefinition);
            }
         });
         PanelManager.getInstance().showPanel(panel);
      }
      
      public function onBuildingWasSelectedSignal(param1:MonkeyTownBuildingDefinition) : void
      {
         this.bottomUI.cancelBuildButtonEnabled = true;
      }
      
      public function onBuildingWasSelectedForTileSignal(param1:MonkeyTownBuildingDefinition, param2:Tile) : void
      {
         this.bottomUI.cancelBuildButtonEnabled = true;
      }
      
      private function onContestedTerritoryButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.contestedTerritoryPanel);
      }
      
      private function onSpecialTracksButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.specialTracksPanel);
      }
      
      private function onUpgradesButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.upgradesPanel);
      }
      
      private function onMyTowersButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.myTowersPanel);
      }
      
      private function onSecialItemsButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.specialItemsPanel);
      }
      
      private function onPVPButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.pvpPanel);
      }
      
      private function onMyCitiesButtonClicked() : void
      {
         this.myCitiesPanel.populateInfo(true,MonkeySystem.getInstance().city.cityIndex);
         PanelManager.getInstance().showFreePanel(this.myCitiesPanel);
      }
      
      public function onBuildButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this.buildPanel);
      }
      
      public function tileBuildButtonClicked(param1:Tile) : void
      {
         PanelManager.getInstance().showFreePanel(this.buildPanel);
         this.buildPanel.buildBaseBuildingsIcons();
         this.buildPanel.setTargetBuildTile(param1);
      }
      
      private function onCancelPlaceBuildingButtonClicked() : void
      {
         this.bottomUI.cancelBuildButtonEnabled = false;
         this.cancelPlacingBuildingSignal.dispatch();
      }
      
      private function onCancelMoveBuildingButtonClicked() : void
      {
         this.bottomUI.cancelMoveButtonEnabled = false;
         this.cancelMovingBuildingSignal.dispatch();
      }
      
      private function onResize(param1:int, param2:int) : void
      {
         var _loc3_:int = param2 - 20;
         if(Kong.isOnKong())
         {
            _loc3_ = _loc3_ + 20;
         }
         var _loc4_:int = 400;
         _clip.backgroundBottom.y = _loc3_;
         _clip.backgroundBottom.width = param1;
         _clip.informationBar.x = int(param1 * 0.5 - _loc4_);
         if(_clip.informationBar.x < 0)
         {
            _clip.informationBar.x = 0;
         }
         _clip.bottomUI.y = _loc3_;
         _clip.bottomUI.x = int(param1 * 0.5 - _loc4_);
         if(_clip.bottomUI.x < 0)
         {
            _clip.bottomUI.x = 0;
         }
         this.bottomUI.resize(param1,param2);
         _clip.lowerLeftCornerEmbellishment.x = 0;
         _clip.lowerLeftCornerEmbellishment.y = _loc3_;
         _clip.lowerRightCornerEmbellishment.x = param1;
         _clip.lowerRightCornerEmbellishment.y = _loc3_;
         _clip.baseFrame.x = int(param1 * 0.5);
         _clip.baseFrame.y = int(_loc3_);
      }
      
      public function readyForNewSelection() : void
      {
         this.bottomUI.cancelBuildButtonEnabled = false;
      }
      
      public function revealHud(param1:Number = 0.5, param2:Boolean = false) : void
      {
         if(param2)
         {
            _clip.alpha = 0;
         }
         _clip.visible = true;
         _clip.mouseEnabled = true;
         _clip.mouseChildren = true;
         TweenLite.to(_clip,param1,{"alpha":1});
      }
      
      public function hideHUD(param1:Number = 0.5) : void
      {
         var time:Number = param1;
         _clip.mouseEnabled = false;
         _clip.mouseChildren = false;
         TweenLite.to(_clip,time,{
            "alpha":0,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
      }
      
      public function setMyTowersArrowActive(param1:Boolean) : void
      {
         switch(param1)
         {
            case true:
               _arrowMyTowersClip.play();
               _arrowMyTowersClip.visible = true;
               break;
            case false:
               _arrowMyTowersClip.stop();
               _arrowMyTowersClip.visible = false;
         }
      }
      
      public function setBuildArrowActive(param1:Boolean) : void
      {
         switch(param1)
         {
            case true:
               _arrowBuildClip.play();
               _arrowBuildClip.visible = true;
               break;
            case false:
               _arrowBuildClip.stop();
               _arrowBuildClip.visible = false;
         }
      }
      
      public function get worldView() : WorldView
      {
         return this._worldView;
      }
   }
}
