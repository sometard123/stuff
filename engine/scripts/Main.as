package
{
   import display.Frame;
   import display.FrameFactory;
   import display.ui.Tooltip;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.getTimer;
   import menuassets.IntroHold;
   import ninjakiwi.monkeyTown.btdModule.game.BloonSendSet;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.ContestedTerritoryBriefingPanel;
   import ninjakiwi.monkeyTown.btdModule.ingame.ContestedTerritoryRoundReachedPanel;
   import ninjakiwi.monkeyTown.btdModule.ingame.ModalBlocker;
   import ninjakiwi.monkeyTown.btdModule.ingame.NotEnoughBloonstonesSidePanel;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnTestModule;
   import ninjakiwi.monkeyTown.btdModule.premium.PremiumSaleFactory;
   import ninjakiwi.monkeyTown.btdModule.profile.Profile;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.test.ModuleCheats;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerMenuSet;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.tutorial.TutorialManager;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.IBloonsTowerDefenseModule;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.common.events.GameEvent;
   import ninjakiwi.monkeyTown.data.RemoteDataManager;
   import ninjakiwi.monkeyTown.debugView.DebugView;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class Main extends MovieClip implements IBloonsTowerDefenseModule
   {
      
      public static var instance:Main;
      
      private static const BUILD_DATE:String = "171109b";
      
      public static var playArea:Rectangle = new Rectangle(0,0,700,520);
      
      public static var mapArea:Rectangle = new Rectangle(0,0,700,520);
      
      public static const SITE_DETECTED:String = "SITE_DETECTED";
      
      public static const SITE_NK:uint = 0;
      
      public static const SITE_KONG:uint = 1;
      
      public static var onSite:uint = SITE_NK;
      
      public static var DEBUG_SINGLE_PLAYER:Boolean = false;
      
      public static var gooch:GoochProfiler = new GoochProfiler();
      
      public static var standalone:Boolean = false;
       
      
      public var frameFactory:FrameFactory;
      
      public var remoteDataManager:RemoteDataManager;
      
      public var towerFactory:TowerFactory = null;
      
      public var towerFactoryUnmodified:TowerFactory = null;
      
      public var towerMenuSet:TowerMenuSet = null;
      
      public var towerMenuSetUnmodified:TowerMenuSet = null;
      
      public var premuimSaleFactory:PremiumSaleFactory;
      
      public var bloonSendSet:BloonSendSet;
      
      public var bufferWidth:int = 800;
      
      public var bufferHeight:int = 600;
      
      public var scale:Number = 1;
      
      public var scaleX_:Number = 1;
      
      public var scaleY_:Number = 1;
      
      public var container:MovieClip = null;
      
      public var displayBuffer:BitmapData = null;
      
      private var displayBufferContainer:Bitmap = null;
      
      public var inGameUIParent:MovieClip = null;
      
      public var arrowLayer:Sprite = null;
      
      public var tutorialLayer:Sprite = null;
      
      public var effectLayer:Sprite = null;
      
      public var game:Game;
      
      public var profile:Profile;
      
      public var tooltip:display.ui.Tooltip = null;
      
      public var introHold:IntroHold;
      
      private var _stage:Stage;
      
      private var debugView:DebugView;
      
      public var appDomain:ApplicationDomain;
      
      public var lastTickTime:int;
      
      public var doTest:Boolean = false;
      
      public var tutorialManager:TutorialManager;
      
      private const _usedCrateSignal:Signal = new Signal();
      
      private const _analyticsSignal:Signal = new Signal();
      
      private const _contestedTerritoryRoundCompletedSignal:PrioritySignal = new PrioritySignal(int,Number);
      
      private var _requestOptionsPanelSignal:Signal;
      
      private var _eventBridgeDispatcher:EventDispatcher;
      
      private var _displayPremaintenanceSignal:Signal;
      
      public var notEnoughBloonstonesSidePanel:NotEnoughBloonstonesSidePanel;
      
      private var cheats:ModuleCheats;
      
      public var pause:Boolean = false;
      
      private var _deltaFrame:Number = 0.03333333333333333;
      
      public var lastGameRequest:BTDGameRequest = null;
      
      private var _startGameTime:Number = 0;
      
      private var _keyValues:Object;
      
      public function Main()
      {
         var _loc1_:* = null;
         this.frameFactory = new FrameFactory();
         this.remoteDataManager = new RemoteDataManager();
         this.premuimSaleFactory = new PremiumSaleFactory();
         this.bloonSendSet = new BloonSendSet();
         this.profile = new Profile();
         this.debugView = DebugView.instance;
         this.appDomain = new ApplicationDomain();
         this._requestOptionsPanelSignal = new Signal();
         this._eventBridgeDispatcher = new EventDispatcher();
         this._displayPremaintenanceSignal = new Signal();
         this._keyValues = {};
         super();
         if(BUILD_DATE !== Constants.BUILD_DATE)
         {
            _loc1_ = "Build Date Version Mismatch: Module = ";
            _loc1_ = _loc1_ + BUILD_DATE;
            _loc1_ = _loc1_ + ", MonkeyCity = ";
            _loc1_ = _loc1_ + Constants.BUILD_DATE;
            throw new Error(_loc1_);
         }
         instance = this;
         this.remoteDataManager.loadBakedData();
         addEventListener(Event.ADDED_TO_STAGE,this.initialise);
      }
      
      public function setIsStandalone(param1:Boolean) : void
      {
         Main.standalone = param1;
      }
      
      public function getVersion() : String
      {
         return BUILD_DATE;
      }
      
      public function contestedTerritoryLeadingScoreBeat(param1:Boolean, param2:String = "", param3:int = -1) : void
      {
         var _loc4_:int = 0;
         if(param1)
         {
            this.game.gameRequest.contestedTerritoryForCapture = true;
            this.game.gameRequest.contestedTerritoryRoundToBeat = param3;
            this.game.inGameMenu.contestedTerritoryBriefingPanel.popUp(ContestedTerritoryBriefingPanel.DESC_BEAT_NEW_SCORE,param3,param2);
         }
         else
         {
            _loc4_ = !!this.game.gameRequest.contestedTerritoryForCapture?int(ContestedTerritoryRoundReachedPanel.DESC_BEAT_OTHERS):int(ContestedTerritoryRoundReachedPanel.DESC_BEAT_MINE);
            this.game.inGameMenu.contestedTerritoryRoundReachedPanel.popUp(_loc4_);
         }
      }
      
      private function initialise(param1:Event) : void
      {
         var gameRequest:BTDGameRequest = null;
         var event:Event = param1;
         Frame.stage = super.stage;
         this.cheats = new ModuleCheats(super.stage);
         BloonSpawnTestModule.setStage(super.stage);
         this.debugView.container = this;
         this.debugView.hide(0);
         removeEventListener(Event.ADDED_TO_STAGE,this.initialise);
         this._stage = super.stage;
         this._stage.addEventListener(Event.RESIZE,this.resize);
         this.resize();
         tabChildren = false;
         try
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         catch(e:Error)
         {
         }
         this.displayBuffer = new BitmapData(this.bufferWidth * this.scale,this.bufferHeight * this.scale);
         this.displayBufferContainer = new Bitmap(this.displayBuffer);
         this.container = new MovieClip();
         addChild(this.container);
         this.container.addChild(this.displayBufferContainer);
         this.inGameUIParent = new MovieClip();
         this.game = new Game();
         this.game.init();
         this.initGameListeners();
         var tooltip_mc:assets.gui.Tooltip = new assets.gui.Tooltip();
         addChild(tooltip_mc);
         this.tooltip = new display.ui.Tooltip(tooltip_mc);
         this.arrowLayer = new Sprite();
         this.tutorialLayer = new Sprite();
         this.effectLayer = new Sprite();
         addChild(this.tutorialLayer);
         addChild(this.arrowLayer);
         addChild(this.inGameUIParent);
         addChild(this.effectLayer);
         this.notEnoughBloonstonesSidePanel = new NotEnoughBloonstonesSidePanel(this.tutorialLayer);
         this.lastTickTime = -1;
         var mask:Sprite = new Sprite();
         mask.graphics.beginFill(16777215);
         mask.graphics.drawRect(0,0,this.bufferWidth,this.bufferHeight);
         mask.graphics.endFill();
         this.mask = mask;
         this.addChild(mask);
         ModalBlocker.getInstance().setStage(this.stage);
         this.pause = false;
         Main.DEBUG_SINGLE_PLAYER = true;
         if(this.doTest)
         {
            gameRequest = new BTDGameRequest().Difficulty(20).IsCamoTile(false).IsRegenTile(true).Seed(1337).CityIndex(1).ExtraMonkeyBoosts(0).ExtraRedHotSpikes(0).TrackSelectionBias(0.8).StartingLives(900000).StartingMoney(9000000).IsBloonBeacon(false).BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.BOSS_ID).StrongestBloonType(Constants.BOSS_BLOON)).MoreCamo(Constants.NORMAL).MoreRegen(Constants.LOTS).MoreMoabs(Constants.NORMAL).MoreLead(Constants.LOTS).TileUniqueData(new TileUniqueDataDefinition().TrackID(0)).IsTutorial(false).DifficultyRankRelativeToMTL(0).DifficultyDescription("Trivial").IsContestedTerritory(false).ContestedTerritoryRoundToBeat(5).ContestedTerritoryForCapture(true).ExtensionRounds(0).TimeLeftInWeek(Number.MAX_VALUE).SpecialAbilities({
               "AntiCamoDust":{"active":true},
               "CuddlyBear":{"active":true},
               "SuperMonkey":{"dark":true}
            }).PvpAttackDefinition(new PvPAttackDefinition().Difficulty(60)).Crates([true,true,true]).AllowRetry(false);
            this.configureModTX(gameRequest);
            this.startGame(gameRequest);
         }
         gooch.x = 750;
         gooch.y = 50;
      }
      
      private function resize(param1:Event = null) : void
      {
         this.x = int(this._stage.stageWidth * 0.5) - 400;
         this.y = int(this._stage.stageHeight * 0.5) - 310;
         if(this.x < 0)
         {
            this.x = 0;
         }
         if(this.y < 0)
         {
            this.y = 0;
         }
      }
      
      private function frame(param1:Event) : void
      {
         if(this.pause == true)
         {
            return;
         }
         this._deltaFrame = 1 / this.stage.frameRate;
         if(this.game.active)
         {
            this.displayBuffer.fillRect(this.displayBuffer.rect,0);
            this.game.process(this._deltaFrame);
            this.game.draw(this.displayBuffer);
         }
         gooch.update();
         instance.profile.process(this._deltaFrame);
      }
      
      public function clearDisplayBuffer() : void
      {
         if(this.displayBuffer)
         {
            this.displayBuffer.fillRect(this.displayBuffer.rect,0);
         }
      }
      
      public function startGame(param1:BTDGameRequest) : String
      {
         this.towerFactory = new TowerFactory();
         this.towerFactoryUnmodified = new TowerFactory();
         this.towerMenuSet = new TowerMenuSet();
         this.towerMenuSetUnmodified = new TowerMenuSet();
         this.lastGameRequest = param1;
         this.clearDisplayBuffer();
         if(param1.isTutorial)
         {
            this.tutorialManager = new TutorialManager(this.container,this.tutorialLayer,this.game,this.game.inGameMenu);
         }
         this._startGameTime = getTimer();
         this.game.loadGame(param1);
         this.addEventListener(Event.ENTER_FRAME,this.frame);
         param1.tileUniqueData.numberOfTimesAttacked++;
         this.pause = false;
         return "btd";
      }
      
      public function endGame() : void
      {
         if(this.tutorialManager !== null)
         {
            this.tutorialManager.endTutorial();
         }
         if(this.game)
         {
            this.unPauseGame();
            this.game.exitGame();
         }
         this.clearDisplayBuffer();
         this.removeEventListener(Event.ENTER_FRAME,this.frame);
         this.towerFactory = new TowerFactory();
         this.towerFactoryUnmodified = new TowerFactory();
         this.towerMenuSet = new TowerMenuSet();
         this.towerMenuSetUnmodified = new TowerMenuSet();
      }
      
      public function pauseGame() : void
      {
         Main.instance.pause = true;
         TowerPlace.blockTowerPlacing = true;
      }
      
      public function unPauseGame() : void
      {
         Main.instance.pause = false;
         TowerPlace.blockTowerPlacing = false;
      }
      
      override public function get stage() : Stage
      {
         return this._stage;
      }
      
      public function get usedCrateSignal() : Signal
      {
         return this._usedCrateSignal;
      }
      
      public function get analyticsSignal() : Signal
      {
         return this._analyticsSignal;
      }
      
      public function get contestedTerritoryRoundCompletedSignal() : PrioritySignal
      {
         return this._contestedTerritoryRoundCompletedSignal;
      }
      
      private function initGameListeners() : void
      {
         Game.GAME_COMPLETE_SIGNAL.add(this.onGameOverSignal);
         Game.GAME_REQUEST_BLOONSTONES_SIGNAL.add(this.onRequestBloonstonesSignal);
      }
      
      private function onRequestBloonstonesSignal(param1:int, param2:Function, param3:Boolean) : void
      {
         this.dispatchEvent(new GameEvent(Constants.GAME_REQUEST_BLOONSTONES,{
            "bloonstones":param1,
            "callback":param2,
            "spend":param3
         }));
      }
      
      private function onGameOverSignal(param1:GameResultDefinition) : void
      {
         var that:Main = null;
         var gameResult:GameResultDefinition = param1;
         Game.GAME_EXIT_SIGNAL.dispatch();
         that = this;
         gameResult.durationOfGame = getTimer() - this._startGameTime;
         var success:Boolean = !!gameResult.wasContestedTerritory?gameResult.roundsCompleted >= this.game.gameRequest.contestedTerritoryRoundToBeat:Boolean(gameResult.success);
         this.doWithTransition(function transitionCallback():void
         {
            endGame();
            that.dispatchEvent(new GameEvent(Constants.GAME_OVER,{"result":gameResult}));
            if(gameResult.success)
            {
               that.dispatchEvent(new GameEvent(Constants.GAME_WIN,{"result":gameResult}));
            }
            else
            {
               that.dispatchEvent(new GameEvent(Constants.GAME_LOSE,{"result":gameResult}));
            }
         },success,gameResult.wasContestedTerritory);
      }
      
      public function cancelGame(param1:Boolean = false, param2:Boolean = true) : void
      {
         var that:Main = null;
         var durationOfGame:Number = NaN;
         var wasContestedTerritory:Boolean = false;
         var success:Boolean = param1;
         var cancelledGameFlag:Boolean = param2;
         Game.GAME_EXIT_SIGNAL.dispatch();
         that = this;
         durationOfGame = getTimer() - this._startGameTime;
         wasContestedTerritory = this.lastGameRequest == null?false:Boolean(this.lastGameRequest.isContestedTerritory);
         if(wasContestedTerritory)
         {
            success = this.didBeatGoalRound();
         }
         this.doWithTransition(function():void
         {
            var _loc1_:GameResultDefinition = new GameResultDefinition().Success(success).CancelledGame(cancelledGameFlag).RoundReached(game.level.roundIndex + 1).RoundsNeededToWin(game.level.totalRounds).FractionOfTotalBloonsPopped(0).StartingLives(lastGameRequest == null?0:int(lastGameRequest.startingLives)).LivesLost(lastGameRequest == null?0:int(lastGameRequest.startingLives)).DidPlayerLoseALife(game.didPlayerLostALife).BloonsPopped(game.bloonPopTracker.report).DurationOfGame(durationOfGame).TrackPlayed(game.currentLevelDef.id).DifficultyRankRelativeToMTL(lastGameRequest.difficultyRankRelativeToMTL).TutorialSave(game.inGameMenu.tacticsSave).WasHardcore(lastGameRequest == null?false:Boolean(lastGameRequest.isHardcore)).WasContestedTerritory(wasContestedTerritory).RoundsCompleted(game.roundsCompleted).NumOfRetries(game.numOfRetries).ContestedTerritoryExpired(false).AdvancedTracking(game.gameInfoTracking.getDataAsObject()).BossBattleResult(SpecialTrackManager.getInstance().getBossBattleResult());
            endGame();
            that.dispatchEvent(new GameEvent(Constants.GAME_CANCELLED,{"result":_loc1_}));
         },success,wasContestedTerritory);
      }
      
      public function didBeatGoalRound() : Boolean
      {
         var _loc1_:Boolean = this.lastGameRequest == null?false:Boolean(this.lastGameRequest.isContestedTerritory);
         var _loc2_:Boolean = !!_loc1_?this.game.roundsCompleted >= this.lastGameRequest.contestedTerritoryRoundToBeat:false;
         return _loc2_;
      }
      
      public function instawin() : void
      {
         Game.GAME_EXIT_SIGNAL.dispatch();
      }
      
      public function addContestRoundCheat() : void
      {
      }
      
      private function doWithTransition(param1:Function, param2:Boolean, param3:Boolean = false) : void
      {
         TransitionSignals.closeCurtainCompleteSignal.removeAll();
         TransitionSignals.closeCurtainCompleteSignal.addOnce(param1);
         TransitionSignals.beginTransitionFromBTDToCity.dispatch(param2,param3);
      }
      
      private function configureModTX(param1:BTDGameRequest) : void
      {
      }
      
      public function setData(param1:String, param2:*) : void
      {
         this._keyValues[param2] = param2;
      }
      
      public function getData(param1:String) : *
      {
         if(this._keyValues.hasOwnProperty(param1))
         {
            return this._keyValues[param1];
         }
         return null;
      }
      
      public function set blockTowerPlacing(param1:Boolean) : void
      {
         TowerPlace.blockTowerPlacing = param1;
      }
      
      public function get requestOptionsPanelSignal() : Signal
      {
         return this._requestOptionsPanelSignal;
      }
      
      public function get displayPremaintenanceSignal() : Signal
      {
         return this._displayPremaintenanceSignal;
      }
      
      public function set audioIsAudible(param1:Boolean) : void
      {
         MaxSound.isAudable = param1;
      }
      
      public function get eventBridge() : EventDispatcher
      {
         return this._eventBridgeDispatcher;
      }
   }
}
