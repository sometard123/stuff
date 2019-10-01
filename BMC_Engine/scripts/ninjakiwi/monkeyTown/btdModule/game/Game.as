package ninjakiwi.monkeyTown.btdModule.game
{
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.btdModule.abilities.OverclockWrench;
   import ninjakiwi.monkeyTown.btdModule.analytics.BenchmarkTracking;
   import ninjakiwi.monkeyTown.btdModule.analytics.BloonPopTracker;
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.Banana;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Scene;
   import ninjakiwi.monkeyTown.btdModule.gameEvents.GameEventsManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.GameGoButtonController;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.ingame.MonkeyTeam;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.BuffManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.Disposable;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.BigBloonSabotage;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.MonkeyTycoon;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.TowerBuffs;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.LevelDefFactory;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.LevelDef;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSendTestModule;
   import ninjakiwi.monkeyTown.btdModule.levels.util.LevelSwfLoader;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.btdModule.towers.SpecialAbilityManager;
   import ninjakiwi.monkeyTown.btdModule.towers.TerrainRestrictionManager;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerAvailabilityManager;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeAvailabilityManager;
   import ninjakiwi.monkeyTown.btdModule.ui.EnteranceFinder;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.GlobalTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.common.events.GameEvent;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import org.osflash.signals.Signal;
   
   public class Game extends Scene
   {
      
      public static const RETRY_BLOONSTONES:int = 20;
      
      public static const RETRY_BLOONSTONES_FOR_MVM:int = 50;
      
      public static const RETRY_BLOONSTONES_EXTRA_CASH:int = 10;
      
      public static const HARDCORE_COST_SCALAR:Number = 1.08;
      
      public static const FIRST_CITY_MOAB_HEALTH_MODIFIER:Number = 0.66;
      
      public static const SECOND_CITY_MOAB_HEALTH_MODIFIER:Number = 0.8;
      
      public static const BLOONSTONES_FOR_BONUS_CASH:int = 10;
      
      public static const FAST_FORWARD_STEPS:int = 4;
      
      public static var bloonsPoppedThisGame:int = 0;
      
      public static const GAME_COMPLETE_SIGNAL:Signal = new Signal(GameResultDefinition);
      
      public static const GAME_EXIT_SIGNAL:Signal = new Signal();
      
      public static const GAME_REQUEST_BLOONSTONES_SIGNAL:Signal = new Signal(int,Function,Boolean);
      
      public static const GAME_RESTART_RESET_SIGNAL:Signal = new Signal();
       
      
      public var inGameMenu:InGameMenu;
      
      public var active:Boolean = false;
      
      public var roundTime:Number = 0;
      
      public var waveIndex:int = -1;
      
      public var numOfRetries:int = 0;
      
      public var didPlayerLostALife:Boolean = false;
      
      private var frameNumber:uint = 0;
      
      private var gameTime:Number = 0;
      
      private var playTime:Number = 0;
      
      private var processMultiplier:Number = 1.0;
      
      private var inBetweenRounds:Boolean = true;
      
      private var contestedTerritoryExpired:Boolean = false;
      
      private var _cashPerPop:INumber;
      
      private var _level:Level;
      
      private var _fastForward:Boolean = false;
      
      private var _continuous:Boolean = false;
      
      private var _gameRequest:BTDGameRequest;
      
      private var _levelLoader:LevelSwfLoader;
      
      private var _playerLost:Boolean = false;
      
      private var _countingDownToGameOver:Boolean = false;
      
      private var _framesSinceGameEnded:int = 0;
      
      private var _currentLevelDef:LevelDef;
      
      private var _baseCash:INumber;
      
      private var _specialMissionCashBonus:INumber;
      
      private var _bonusStartingCash:INumber;
      
      private var _roundsCompleted:INumber;
      
      private var _gameEventsManager:GameEventsManager;
      
      public var bloonPopTracker:BloonPopTracker;
      
      private const FRAME_DELAY_BEFORE_GAME_OVER:int = 15;
      
      private var _isBonusCashMode:INumber;
      
      public var endOfRoundAwardScalar:Number = 1;
      
      public var endOfRoundAddInterestScalar:Number = 0;
      
      public const restartGamePVP:Signal = new Signal();
      
      public const restartGame:Signal = new Signal();
      
      public const openShop:Signal = new Signal();
      
      public var sigCashTickChanged:Signal;
      
      public var gameInfoTracking:GameInfoTracking;
      
      public var benchmarkTracking:BenchmarkTracking;
      
      public var overclockWrench:OverclockWrench;
      
      public var monkeyTeam:MonkeyTeam;
      
      private var _processEventData:Object;
      
      public function Game()
      {
         this._cashPerPop = DancingShadows.getOne();
         this._baseCash = DancingShadows.getOne();
         this._specialMissionCashBonus = DancingShadows.getOne();
         this._bonusStartingCash = DancingShadows.getOne();
         this._roundsCompleted = DancingShadows.getOne();
         this.bloonPopTracker = new BloonPopTracker();
         this._isBonusCashMode = DancingShadows.getOne();
         this.sigCashTickChanged = new Signal();
         this.monkeyTeam = new MonkeyTeam();
         this._processEventData = {"delta":0};
         super();
      }
      
      public function init() : void
      {
         this._cashPerPop.value = 1;
         this._roundsCompleted.value = 0;
         this.numOfRetries = 0;
         this.didPlayerLostALife = false;
         this.inGameMenu = new InGameMenu();
         this.inGameMenu.addEventListener("START_NEXT_ROUND",this.onStartNextRoundHandler);
         this._gameEventsManager = new GameEventsManager();
      }
      
      public function loadGame(param1:BTDGameRequest) : void
      {
         var towerKey:String = null;
         var levelDef:LevelDef = null;
         var gameRequest:BTDGameRequest = param1;
         this._gameRequest = gameRequest;
         this._countingDownToGameOver = false;
         bloonsPoppedThisGame = 0;
         this._roundsCompleted.value = 0;
         this.numOfRetries = 0;
         this.didPlayerLostALife = false;
         this._level = new Level();
         this.overclockWrench = new OverclockWrench();
         this.monkeyTeam.setRequest(gameRequest);
         BuffManager.instance.buildListOfBuffsToActivate();
         if(this.gameInfoTracking == null)
         {
            this.gameInfoTracking = new GameInfoTracking();
         }
         if(this.benchmarkTracking == null)
         {
            this.benchmarkTracking = new BenchmarkTracking();
         }
         this.endOfRoundAwardScalar = 1;
         this.endOfRoundAddInterestScalar = 0;
         this.gameInfoTracking.reset();
         this.benchmarkTracking.onNewGame();
         this.inGameMenu.setRoundTextVisible(true);
         this.inGameMenu.setHealthbarVisible(false);
         this.inGameMenu.setAntiBossAbilitiesVisible(false);
         this.inGameMenu.antiBossAbilityPane.setGameRequest(gameRequest);
         if(gameRequest.specialMissionID != null)
         {
            if(!SpecialTrackManager.getInstance().setSpecialTrack(gameRequest,gameRequest.specialMissionID))
            {
               gameRequest.SpecialMissionID(null);
            }
         }
         else if(gameRequest.bossAttack != null)
         {
            if(SpecialTrackManager.getInstance().setSpecialTrack(gameRequest,gameRequest.bossAttack.specialTrackID))
            {
            }
         }
         if(this._gameRequest.cityIndex > 0)
         {
            Bloon.setMOABHealthModifier(Game.SECOND_CITY_MOAB_HEALTH_MODIFIER);
         }
         else
         {
            Bloon.setMOABHealthModifier(Game.FIRST_CITY_MOAB_HEALTH_MODIFIER);
         }
         if(gameRequest.isHardcore)
         {
            Main.instance.towerFactory.applyHardcoreCosts(Game.HARDCORE_COST_SCALAR);
            Main.instance.towerMenuSet.applyHardcoreCosts(Game.HARDCORE_COST_SCALAR);
         }
         if(gameRequest.specialMissionID == null)
         {
            TerrainRestrictionManager.getInstance().applyCosts(gameRequest.availableTowers);
         }
         TowerBuffs.instance.activateBuffs();
         ActiveAbilityEmpower.instance.activateBuffs();
         BigBloonSabotage.instance.activateBuffs();
         MonkeyTycoon.instance.activateBuffs();
         BigBloonSabotage.instance.applyMOABHealthBuffs();
         TowerAvailabilityManager.instance.setup(gameRequest.availableTowers);
         UpgradeAvailabilityManager.instance.setup(gameRequest.availableUpgrades);
         for(towerKey in gameRequest.availableTowers)
         {
            BuffManager.instance.activateBuffsOfMethodInPath(Disposable,towerKey);
         }
         this.gameTime = 0;
         this.playTime = 0;
         this.waveIndex = -1;
         Rndm.seed = uint(1337);
         Banana.rand.seed = 1337;
         Bloon.eventDispatcher.addEventListener(BloonEvent.POP,this.onBloonPopped);
         levelDef = LevelDefFactory.instance.getLevelDef(gameRequest);
         this._currentLevelDef = levelDef;
         this._levelLoader = new LevelSwfLoader();
         this._levelLoader.completeSignal.addOnce(function levelLoadComplete(param1:MovieClip, param2:ApplicationDomain):void
         {
            onLevelLoadComplete(levelDef,param1,param2);
         });
         this._levelLoader.progressSignal.add(this.onSwfProgress);
         this._levelLoader.load(levelDef.swfName);
      }
      
      private function onLevelLoadComplete(param1:LevelDef, param2:MovieClip, param3:ApplicationDomain) : void
      {
         var levelDef:LevelDef = param1;
         var swf:MovieClip = param2;
         var applicationDomain:ApplicationDomain = param3;
         var that:Game = this;
         if(swf !== null)
         {
            LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(swf,false,true,true);
            LGDisplayListUtil.getInstance().removeAllChildren(swf);
         }
         this._levelLoader.completeSignal.remove(arguments.callee);
         this._levelLoader.progressSignal.remove(this.onSwfProgress);
         this._level.init(that,levelDef,this.gameRequest,applicationDomain);
         this._level.sigBloonRemoved.add(this.checkForRoundOver);
         this._level.setHealth(this.gameRequest.startingLives);
         this._level.helpFromFriends.newGame(this.gameRequest.crates);
         this._level.sigHealthChange.add(this.checkForGameOver);
         this._baseCash.value = this.gameRequest.startingMoney;
         var startingCash:Number = this.gameRequest.startingMoney + (!!this.gameRequest.isBonusCashMode?this.gameRequest.bonusCashAmount:0);
         this._bonusStartingCash.value = this.gameRequest.bonusCashAmount;
         this._level.sigLevelIsReady.add(this.checkForGameOver);
         this.waveIndex = -1;
         this.bloonPopTracker.reset();
         this._continuous = false;
         if(levelDef.music != null)
         {
         }
         Tower.nextFreeID = 0;
         Main.instance.inGameUIParent.addChild(this.inGameMenu);
         this._specialMissionCashBonus.value = 0;
         if(this.gameRequest.specialMissionID != null)
         {
            SpecialTrackManager.getInstance().activateSpecialTrack(this.gameRequest);
            if(this.gameRequest.specialMissionID == Constants.TRANQUIL_GLADE)
            {
               this._specialMissionCashBonus.value = 500;
            }
            startingCash = startingCash + this._specialMissionCashBonus.value;
            this.level.setCash(startingCash);
            this.gameInfoTracking.cashEarned(startingCash,GameInfoTracking.CASH_TYPE_START);
         }
         else
         {
            this.level.setCash(startingCash);
            this.gameInfoTracking.cashEarned(startingCash,GameInfoTracking.CASH_TYPE_START);
         }
         if(this.gameRequest.isTutorial)
         {
            if(Main.instance.tutorialManager != null)
            {
               Main.instance.tutorialManager.setRound(this.gameRequest);
            }
         }
         SpecialAbilityManager.getInstance().applyAbilities(this.gameRequest.specialAbilities);
         this.inGameMenu.startGame(this.gameRequest,this.gameRequest.availableTowers);
         TerrainRestrictionManager.getInstance().applyTowerAvailability(this.gameRequest.availableTowers);
         this.setProcessSpeedMultiplier(1);
         this._fastForward = false;
         this.active = true;
         if(!this.gameRequest.isTutorial)
         {
            EnteranceFinder.removeEnteranceArrows();
            EnteranceFinder.setEnteranceArrow(levelDef,this.inGameMenu);
            this.inGameMenu.addEventListener("START_NEXT_ROUND",this.goButtonClicked);
         }
         this.inGameMenu.prepareForNextRound();
         this.inGameMenu.goButton.setThrottleState(GameGoButtonController.THROTTLE_STATE_PAUSED);
         TransitionSignals.btdGameIsNowReady.dispatch();
         TransitionSignals.trackSwfLoadComplete.dispatch();
         this._levelLoader.clean();
         this._levelLoader = null;
         GlobalTimer.getInstance().reset();
         if(this._gameRequest.pvpAttackDefinition != null)
         {
            if(this._gameRequest.timeLimit >= 0)
            {
               GlobalTimer.getInstance().registerTimer("pvpTimer",Constants.PVP_DEFENSE_EXTRA_TIME_S + this._gameRequest.timeLimit,this.onPvPTimeLimit);
            }
            else
            {
               GlobalTimer.getInstance().registerTimer("pvpTimer",Constants.PVP_DEFENSE_EXTRA_TIME_S,this.onPvPTimeLimit);
            }
         }
         this.contestedTerritoryExpired = false;
         if(this.gameRequest.isContestedTerritory)
         {
            GlobalTimer.getInstance().registerTimer("contestTimer",this.gameRequest.timeLeftInWeek * 0.001,this.onCTTimeLimit);
         }
         this.restartGamePVP.add(this.onRestartGamePVP);
         this.restartGame.add(this.onRestartGameTile);
         this.openShop.add(this.onOpenShop);
         this.inGameMenu.outOfLivesNoRetryPanel.okSignal.add(function():void
         {
            if(_gameRequest.isContestedTerritory)
            {
               gameOver(_roundsCompleted.value < _gameRequest.contestedTerritoryRoundToBeat);
            }
            else
            {
               gameOver(true);
            }
         });
         this.inGameMenu.retryPanel.retrySignal.remove(this.onRetry);
         this.inGameMenu.retryPanel.retrySignal.add(this.onRetry);
         setTimeout(function():void
         {
            Main.instance.eventBridge.dispatchEvent(new Event("gameIsReady"));
            inGameMenu.mouseEnabled = true;
            inGameMenu.mouseChildren = true;
         },10);
      }
      
      private function onPvPTimeLimit() : void
      {
         GlobalTimer.getInstance().deleteTimer("pvpTimer");
         this._level.sigBloonRemoved.remove(this.checkForRoundOver);
         this._level.sigHealthChange.remove(this.checkForGameOver);
         this.inGameMenu.enableInGameMenu(false);
         this.endRound(false);
         EnteranceFinder.removeEnteranceArrows();
         this.inGameMenu.timeOutPanel.okSignal.addOnce(function():void
         {
            gameOver(true);
         });
         this.inGameMenu.confirmQuitPanel.hide(0);
         this.inGameMenu.confirmQuitPanelTile.hide(0);
         this.inGameMenu.retryPanel.hide(0);
         this.inGameMenu.mvmRetryPanel.hide(0);
         this.inGameMenu.timeOutPanel.reveal();
      }
      
      private function onCTTimeLimit() : void
      {
         var success:Boolean = false;
         this.contestedTerritoryExpired = true;
         success = Main.instance.didBeatGoalRound();
         GlobalTimer.getInstance().deleteTimer("contestTimer");
         this._level.sigBloonRemoved.remove(this.checkForRoundOver);
         this._level.sigHealthChange.remove(this.checkForGameOver);
         this.inGameMenu.enableInGameMenu(false);
         this.endRound(false);
         EnteranceFinder.removeEnteranceArrows();
         this.inGameMenu.contestedTerritoryClosedPanel.okSignal.addOnce(function():void
         {
            gameOver(success);
         });
         this.inGameMenu.confirmQuitPanel.hide(0);
         this.inGameMenu.confirmQuitPanelTile.hide(0);
         this.inGameMenu.retryPanel.hide(0);
         this.inGameMenu.mvmRetryPanel.hide(0);
         this.inGameMenu.contestedTerritoryClosedPanel.reveal();
      }
      
      private function goButtonClicked(param1:Event) : void
      {
         if(this.inGameMenu.hasEventListener("START_NEXT_ROUND"))
         {
            this.inGameMenu.removeEventListener("START_NEXT_ROUND",this.goButtonClicked);
         }
         EnteranceFinder.removeEnteranceArrows();
      }
      
      private function onSwfProgress(param1:Number) : void
      {
         TransitionSignals.gameSwfLoadProgressSignal.dispatch(param1);
      }
      
      private function onStartNextRoundHandler(param1:Event) : void
      {
         this.startRound();
      }
      
      private function stopMusic() : void
      {
      }
      
      public function exitGame() : void
      {
         this.inGameMenu.enableInGameMenu(false);
         this.inGameMenu.exitGame();
         if(this._level == null)
         {
            return;
         }
         GlobalTimer.getInstance().deleteTimer("pvpTimer");
         EnteranceFinder.removeEnteranceArrows();
         SpecialTrackManager.getInstance().clearSpecialTrack();
         this.active = false;
         this.stopMusic();
         GlobalTimer.getInstance().reset();
         this.level.helpFromFriends.destroy();
         if(this._levelLoader !== null)
         {
            this._levelLoader.completeSignal.removeAll();
            this._levelLoader.progressSignal.removeAll();
            this._levelLoader.ioErrorSignal.removeAll();
         }
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.level.helpFromFriends.newRound);
         BloonSendTestModule.instance.deactivateBloonSendTestModule();
         super.clear();
      }
      
      private function countDownToGameOver(param1:Boolean) : void
      {
         if(this._countingDownToGameOver)
         {
            return;
         }
         this._framesSinceGameEnded = 0;
         this._playerLost = param1;
         this._countingDownToGameOver = true;
      }
      
      public function endGame(param1:Boolean) : void
      {
         var _loc2_:* = !param1;
         this.inGameMenu.endGame();
         BananaEmitter.clear();
         BananaEmitter.rotAllBananas();
         this._level.sigBloonRemoved.remove(this.checkForRoundOver);
         this._level.sigHealthChange.remove(this.checkForGameOver);
         this.inGameMenu.enableInGameMenu(false);
         if(this._gameRequest.isContestedTerritory)
         {
            this.inGameMenu.outOfLivesNoRetryPanel.reveal();
         }
         if(param1)
         {
            this.endRound(param1);
            if(this._gameRequest !== null && this._gameRequest.pvpAttackDefinition !== null)
            {
               this.inGameMenu.mvmRetryPanel.reveal();
            }
            else if(this._gameRequest !== null && this._gameRequest.bossAttack !== null)
            {
               this.gameOver(param1);
            }
            else
            {
               this.inGameMenu.confirmQuitPanel.hide(0);
               this.inGameMenu.confirmQuitPanelTile.hide(0);
               this.inGameMenu.notEnoughBloonstonesPanel.hideWithoutPoppingUpParent(0);
               if(!this._gameRequest.isContestedTerritory)
               {
                  this.inGameMenu.retryPanel.updateBonusCashRetry(this.level.calculateMvBBonusCash());
                  this.inGameMenu.retryPanel.reveal();
               }
            }
         }
         else
         {
            this.gameOver(param1);
         }
      }
      
      private function continueGame() : void
      {
         this._level.sigBloonRemoved.remove(this.checkForRoundOver);
         this._level.sigHealthChange.remove(this.checkForGameOver);
         this._level.sigLevelIsReady.remove(this.checkForGameOver);
         this._level.removeAllBloons();
         this._level.setHealth(this.gameRequest.startingLives);
         this.inGameMenu.continueGame();
         this.inGameMenu.enableInGameMenu(true);
         this._countingDownToGameOver = false;
         this._framesSinceGameEnded = 0;
         bloonsPoppedThisGame = 0;
         this.gameTime = 0;
         this.playTime = 0;
         this._fastForward = false;
         this.waveIndex--;
         this.didPlayerLostALife = false;
         this._level.sigBloonRemoved.add(this.checkForRoundOver);
         this._level.sigHealthChange.add(this.checkForGameOver);
         this._level.sigLevelIsReady.add(this.checkForGameOver);
      }
      
      public function gameOver(param1:Boolean) : void
      {
         var skipVictoryScreen:Boolean = false;
         var playerLost:Boolean = param1;
         if(this._level)
         {
            this._level.sigBloonRemoved.remove(this.checkForRoundOver);
            this._level.sigHealthChange.remove(this.checkForGameOver);
            this._level.sigLevelIsReady.remove(this.checkForGameOver);
         }
         this.active = false;
         if(playerLost)
         {
            Main.instance.profile.battleScore = Main.instance.profile.battleScore + Balance.instance.BATTLESCORE_FOR_LOSS.v;
            Main.instance.profile.medallions = Main.instance.profile.medallions + Balance.instance.MEDS_FOR_LOSS.v;
            this.dispatchGameResult(!playerLost);
            this.exitGame();
            this.stopMusic();
         }
         else
         {
            Main.instance.profile.battleScore = Main.instance.profile.battleScore + Balance.instance.BATTLESCORE_FOR_WIN.v;
            Main.instance.profile.medallions = Main.instance.profile.medallions + Balance.instance.MEDS_FOR_WIN.v;
            skipVictoryScreen = this._gameRequest.isContestedTerritory;
            if(skipVictoryScreen)
            {
               this.dispatchGameResult(!playerLost);
               this.exitGame();
               this.stopMusic();
            }
            else if(this._gameRequest.bossAttack != null)
            {
               this.inGameMenu.victoryPanelBoss.revealForBoss(this._gameRequest.bossAttack.bossID,this._gameRequest.bossAttack.shortName);
               this.inGameMenu.victoryPanelBoss.okSignal.addOnce(function(... rest):void
               {
                  dispatchGameResult(!playerLost);
                  exitGame();
                  stopMusic();
               });
            }
            else
            {
               this.inGameMenu.victoryGenericPanel.reveal();
               this.inGameMenu.victoryGenericPanel.okSignal.addOnce(function(... rest):void
               {
                  dispatchGameResult(!playerLost);
                  exitGame();
                  stopMusic();
               });
            }
         }
         Main.instance.pauseGame();
      }
      
      private function dispatchGameResult(param1:Boolean) : void
      {
         if(this._level == null || this._level.roundGenerator == null)
         {
            return;
         }
         var _loc2_:Number = Game.bloonsPoppedThisGame / (this._level.roundGenerator.totalBloons == 0?1:this._level.roundGenerator.totalBloons);
         if(this._level === null)
         {
            throw new Error("dispatchGameResult: _level was null");
         }
         if(this._level.roundGenerator === null)
         {
            throw new Error("dispatchGameResult: level.roundGenerator was null");
         }
         if(this._gameRequest === null)
         {
            throw new Error("dispatchGameResult: _gameRequest was null");
         }
         if(this._level.roundGenerator.bloonTypeList === null)
         {
            throw new Error("dispatchGameResult: level.roundGenerator.bloonTypeList was null");
         }
         if(this.bloonPopTracker === null)
         {
            throw new Error("dispatchGameResult: bloonPopTracker was null");
         }
         if(this._currentLevelDef === null)
         {
            throw new Error("dispatchGameResult: bloonPopTracker was null");
         }
         var _loc3_:* = this._gameRequest.bossAttack !== null;
         var _loc4_:GameResultDefinition = new GameResultDefinition().Success(param1).BloonTypeList(this._level.roundGenerator.bloonTypeList).RoundReached(this._level.roundIndex + 1).RoundsNeededToWin(this._level.totalRounds).StartingLives(this._gameRequest == null?0:int(this._gameRequest.startingLives)).DidPlayerLoseALife(this.didPlayerLostALife).FractionOfTotalBloonsPopped(_loc2_).LivesLost(this._gameRequest == null?0:int(this._gameRequest.startingLives - this._level.health.value)).BloonsPopped(this.bloonPopTracker.report).TrackPlayed(this._currentLevelDef.id).DifficultyRankRelativeToMTL(this._gameRequest == null?0:int(this._gameRequest.difficultyRankRelativeToMTL)).BloonTypeList(this._level.roundGenerator.bloonTypeList).TutorialSave(this.inGameMenu.tacticsSave).WasHardcore(this._gameRequest == null?false:Boolean(this._gameRequest.isHardcore)).WasContestedTerritory(this._gameRequest == null?false:Boolean(this._gameRequest.isContestedTerritory)).RoundsCompleted(this._roundsCompleted.value).NumOfRetries(this.numOfRetries).ContestedTerritoryExpired(this.contestedTerritoryExpired).CanHaveMonkeyTeamReward(this.monkeyTeam.canHaveMonkeyTeamReward()).BossBattleResult(SpecialTrackManager.getInstance().getBossBattleResult());
         GAME_COMPLETE_SIGNAL.dispatch(_loc4_);
      }
      
      override public function process(param1:Number) : void
      {
         var _loc4_:SpecialTrackBoss = null;
         param1 = param1 * this.processMultiplier;
         this._processEventData.delta = param1;
         dispatchEvent(new GameEvent(GameEvent.PRE_PROCESS,this._processEventData));
         var _loc2_:int = !!this._fastForward?int(FAST_FORWARD_STEPS):1;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.gameTime = this.gameTime + param1;
            if(false == Main.instance.pause)
            {
               this.playTime = this.playTime + param1;
            }
            this.roundTime = this.roundTime + param1;
            this._level.process(param1);
            SpecialTrackManager.getInstance().update(param1);
            Main.gooch.start("scene_process");
            super.process(param1);
            Main.gooch.end();
            _loc3_++;
         }
         if(this._countingDownToGameOver)
         {
            if(++this._framesSinceGameEnded == this.FRAME_DELAY_BEFORE_GAME_OVER)
            {
               if(this._gameRequest.bossAttack !== null)
               {
                  _loc4_ = SpecialTrackManager.getInstance().specialTrack as SpecialTrackBoss;
                  Main.instance.pauseGame();
                  _loc4_.onBossWin();
               }
               else
               {
                  this.endGame(this._playerLost);
               }
            }
         }
         GlobalTimer.getInstance().update();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this._level === null)
         {
            return;
         }
         dispatchEvent(new GameEvent(GameEvent.PRE_DRAW));
         this._level.draw(param1);
         super.draw(param1);
      }
      
      public function startRound(param1:Event = null) : void
      {
         if(!this.inBetweenRounds && !this._continuous)
         {
         }
         if(param1)
         {
            GameSpeedTimer(param1.target).removeEventListener(GameSpeedTimer.COMPLETE,this.startRound);
         }
         this.inBetweenRounds = false;
         this.roundTime = 0;
         this.waveIndex++;
         this._level.startRound(this.waveIndex);
         this.recalculateCashPerPop();
         dispatchEvent(new LevelEvent(LevelEvent.ROUND_START));
      }
      
      private function endRound(param1:Boolean = true) : void
      {
         this.level.endRound();
         dispatchEvent(new LevelEvent(LevelEvent.ROUND_OVER));
         if(this._level.levelIsComplete() && this.level.health.value > 0)
         {
            this.inBetweenRounds = true;
            this._roundsCompleted.value = this._roundsCompleted.value + 1;
            if(this.gameRequest.isContestedTerritory)
            {
               Main.instance.contestedTerritoryRoundCompletedSignal.dispatch(this._roundsCompleted.value,new Date().getTime());
            }
            this.countDownToGameOver(false);
            return;
         }
         if(param1)
         {
            if(this.level.health.value > 0)
            {
               this.awardMoneyForEndOfRound();
               this._roundsCompleted.value = this._roundsCompleted.value + 1;
               if(this._gameRequest.isContestedTerritory)
               {
                  Main.instance.contestedTerritoryRoundCompletedSignal.dispatch(this._roundsCompleted.value,new Date().getTime());
               }
               this.inGameMenu.prepareForNextRound();
               if(this._continuous)
               {
                  this.startRound();
               }
               else
               {
                  this.inGameMenu.goButton.setThrottleState(GameGoButtonController.THROTTLE_STATE_PAUSED);
               }
            }
            else
            {
               if(this._gameRequest.isContestedTerritory)
               {
                  this.inGameMenu.outOfLivesNoRetryPanel.reveal();
               }
               this.inBetweenRounds = true;
               this.inGameMenu.goButton.setThrottleState(GameGoButtonController.THROTTLE_STATE_NORMAL);
            }
         }
      }
      
      private function onBloonPopped(param1:BloonEvent) : void
      {
         bloonsPoppedThisGame = bloonsPoppedThisGame + param1.layers;
         var _loc2_:Number = this._cashPerPop.value * param1.bloon.cashPerPopScale * param1.moneyEarned;
         this._level.addCash(_loc2_);
         this.gameInfoTracking.cashEarned(_loc2_,GameInfoTracking.CASH_TYPE_POP);
      }
      
      private function awardMoneyForEndOfRound() : void
      {
         var _loc1_:Number = 100 + this._level.roundIndex - 1;
         if(this.checkIsElligableForEndOfRoundBoost())
         {
            _loc1_ = _loc1_ * this.endOfRoundAwardScalar;
            _loc1_ = _loc1_ + this._level.cash.value * this.endOfRoundAddInterestScalar;
         }
         this._level.addCash(_loc1_);
         this.gameInfoTracking.cashEarned(_loc1_,GameInfoTracking.CASH_TYPE_END_OF_ROUND);
      }
      
      private function checkIsElligableForEndOfRoundBoost() : Boolean
      {
         var _loc1_:* = this.level.getTowerFromID("BananaInvestmentsAdvisory") != null;
         var _loc2_:* = this.level.getTowerFromID("MonkeyBank") != null;
         if(_loc1_ || _loc2_)
         {
            return true;
         }
         return false;
      }
      
      private function checkForRoundOver(param1:Bloon) : void
      {
         if(this._level.hasBloonToGo() == false && this.inBetweenRounds == false)
         {
            this.endRound();
         }
      }
      
      private function checkForGameOver(param1:int, param2:int) : void
      {
         if(this.level.health.value <= 0)
         {
            this.level.sigHealthChange.remove(this.checkForGameOver);
            this.countDownToGameOver(true);
         }
      }
      
      private function onRetry() : void
      {
         GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(RETRY_BLOONSTONES,function(param1:Boolean, param2:int):void
         {
            var _loc3_:Number = NaN;
            if(param1)
            {
               Main.instance.dispatchEvent(new GameEvent(Constants.GAME_RETRY_WITH_BLOONSTONES,{
                  "track":_currentLevelDef.id,
                  "roundReached":_level.roundGenerator.currentRound,
                  "bloonstonesSpent":Game.RETRY_BLOONSTONES
               }));
               Main.instance.game.numOfRetries++;
               continueGame();
               _loc3_ = level.calculateMvBBonusCash();
               level.addCash(_loc3_);
               gameInfoTracking.cashEarned(_loc3_,GameInfoTracking.CASH_TYPE_RETRY);
               inGameMenu.goButton.setThrottleState(GameGoButtonController.THROTTLE_STATE_PAUSED);
            }
            else
            {
               inGameMenu.retryPanel.notEnoughBloonstonesPanel.parentPanel = inGameMenu.retryPanel;
               inGameMenu.retryPanel.notEnoughBloonstonesPanel.setRequiredBloonstones(RETRY_BLOONSTONES - param2);
               inGameMenu.retryPanel.notEnoughBloonstonesPanel.reveal();
            }
            inGameMenu.bsTxt.text = String(param2);
         },true);
      }
      
      private function restartReset() : void
      {
         this.exitGame();
         this.inGameMenu.mouseEnabled = false;
         this.inGameMenu.mouseChildren = false;
         this.inGameMenu.resetPlaceState();
         Main.instance.startGame(this.gameRequest);
      }
      
      private function onRestartGameTile(param1:Number) : void
      {
         this.restartReset();
         this.inGameMenu.nonStopCheckbox.reset();
         var _loc2_:Number = this.baseCash + param1;
         this.gameInfoTracking.cashEarned(_loc2_,GameInfoTracking.CASH_TYPE_START);
         this.level.setCash(_loc2_);
      }
      
      private function onRestartGamePVP(param1:Number) : void
      {
         this.restartReset();
         if(this._gameRequest.pvpAttackDefinition == null)
         {
            return;
         }
         var _loc2_:Number = this.baseCash + param1;
         this.gameInfoTracking.cashEarned(_loc2_,GameInfoTracking.CASH_TYPE_START);
         this.level.setCash(_loc2_);
      }
      
      public function onOpenShop() : void
      {
         Main.instance.dispatchEvent(new GameEvent(Constants.GAME_OPEN_SHOP,{"bloonstonesRequired":this.inGameMenu.notEnoughBloonstonesPanel.requiredBloonstones}));
      }
      
      public function get level() : Level
      {
         return this._level;
      }
      
      public function get gameRequest() : BTDGameRequest
      {
         return this._gameRequest;
      }
      
      public function get currentLevelDef() : LevelDef
      {
         return this._currentLevelDef;
      }
      
      public function get baseCash() : Number
      {
         return this._baseCash.value;
      }
      
      public function get bonusStartingCash() : INumber
      {
         return this._bonusStartingCash;
      }
      
      public function get roundsCompleted() : int
      {
         return this._roundsCompleted.value;
      }
      
      public function set roundsCompleted(param1:int) : void
      {
         this._roundsCompleted.value = param1;
      }
      
      public function get cashPerPop() : Number
      {
         return this._cashPerPop.value;
      }
      
      public function get specialMissionCashBonus() : Number
      {
         return this._specialMissionCashBonus.value;
      }
      
      public function get fastForward() : Boolean
      {
         return this._fastForward;
      }
      
      public function getGameTime() : Number
      {
         return this.gameTime;
      }
      
      public function getMousePosForSlug(param1:Level) : Vector2
      {
         return new Vector2(Main.instance.mouseX,Main.instance.mouseY);
      }
      
      public function isPlayerLevel(param1:Level) : Boolean
      {
         return param1 == param1;
      }
      
      public function setProcessSpeedMultiplier(param1:Number) : void
      {
         this.processMultiplier = param1;
      }
      
      public function setFastForward(param1:Boolean) : void
      {
         this._fastForward = param1;
      }
      
      public function setContinuous(param1:Boolean) : void
      {
         this._continuous = param1;
      }
      
      public function recalculateCashPerPop() : void
      {
         this._cashPerPop.value = Bloon.calculateCashChance();
      }
   }
}
