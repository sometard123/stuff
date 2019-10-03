package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.LoadingClip;
   import assets.effects.Select;
   import assets.effects.SelectedEffect;
   import assets.gui.GoButtonClip;
   import assets.gui.InGameUI;
   import assets.gui.MinusBloonstones;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.btdModule.BSSpecialAbility.BSSpecialAbilityManager;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def.AntiBossAbilitySlideoutPane;
   import ninjakiwi.monkeyTown.btdModule.entities.TowerHilight;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.events.TowerChangedEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Balance;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.ingamestate.GameStateMessage;
   import ninjakiwi.monkeyTown.btdModule.ingame.ingamestate.NeutralState;
   import ninjakiwi.monkeyTown.btdModule.ingame.ingamestate.PlaceState;
   import ninjakiwi.monkeyTown.btdModule.ingame.ingamestate.TowerNotSelectedState;
   import ninjakiwi.monkeyTown.btdModule.ingame.ingamestate.TowerSelectedState;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorPvP;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.profile.Profile;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.state.Machine;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.ui.MvMTimeOutPanel;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   import ninjakiwi.monkeyTown.common.ConfigureDeployConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class InGameMenu extends MovieClip
   {
      
      public static var instance:InGameMenu = null;
      
      public static const prepareNextRoundSignal:Signal = new Signal();
      
      public static const startRoundSignal:Signal = new Signal();
      
      public static const enableGoButtonSignal:Signal = new Signal(Boolean);
      
      public static const towerPlacedSignal:Signal = new Signal(Tower);
       
      
      public var mc:InGameUI;
      
      public var game:Game;
      
      public var userProfile:Profile;
      
      public var range:RangeCombo = null;
      
      public var extendedRange:RangeCombo = null;
      
      public var placingReticle:Reticle = null;
      
      private var prevReticle:Reticle = null;
      
      private var _optionsButton:ButtonControllerBase;
      
      public var stateMachine:Machine;
      
      public var neutral:NeutralState = null;
      
      public var placingState:PlaceState = null;
      
      public var towerSelectedState:TowerSelectedState = null;
      
      public var towerNotSelectedState:TowerNotSelectedState = null;
      
      public var towerMenu:TowerGroup;
      
      public var towerHilight:TowerHilight;
      
      public var towerSelectHilight:TowerHilight;
      
      public var abilityBar:AbilityBar;
      
      private var subMenu:MovieClip = null;
      
      private var gameTimer:Timer;
      
      public var shiftDown:Boolean = false;
      
      public var inInvalidArea:Boolean = false;
      
      public var sellScale:Number = 0.8;
      
      private const bottomUIArea:Rectangle = new Rectangle(Main.mapArea.left,Main.mapArea.bottom,Settings.STAGE_WIDTH,Settings.STAGE_HEIGHT - Main.mapArea.height);
      
      private const rightUIArea:Rectangle = new Rectangle(Main.mapArea.right,Main.mapArea.top,Settings.STAGE_WIDTH - Main.mapArea.width,Settings.STAGE_HEIGHT);
      
      public const leftPlayArea:Rectangle = Main.mapArea;
      
      public var playerPlayArea:Rectangle;
      
      public var goButton:GameGoButtonController;
      
      public var nonStopCheckbox:NonstopCheckboxController;
      
      public var bossDefeatPanel:BossDefeatPanel;
      
      public var victoryGenericPanel:VictoryGenericPanel;
      
      public var victoryPanelBoss:VictoryPanelBoss;
      
      private var _retryPanel:RetryPanel;
      
      private var _mvmRetryPanel:MvMRetryPanel;
      
      private var _timeOutPanel:MvMTimeOutPanel;
      
      private var _confirmQuitPanel:ConfirmQuitPanel;
      
      private var _confirmQuitPanelTile:ConfirmQuitPanelTile;
      
      private var _contestedTerritoryBriefingPanel:ContestedTerritoryBriefingPanel;
      
      private var _contestedTerritoryRoundReachedPanel:ContestedTerritoryRoundReachedPanel;
      
      private var _contestedTerritoryOutOfLives:ContestOutOfLivesPanel;
      
      private var _contestedTerritoryClosedPanel:ContestedTerritoryClosedPanel;
      
      private var _premaintenancePanel:PremaintenancePanel;
      
      private const _moreBloonstonesButton:ButtonControllerBase = new ButtonControllerBase(this.mc.uiPanels.specialAgentPanel.moreBloonstonesButton);
      
      public const bsTxt:TextField = this.mc.uiPanels.specialAgentPanel.bloonStones_Amount;
      
      private var tacticsManager:BSSpecialAbilityManager;
      
      public var notEnoughBloonstonesPanel:InGameNotEnoughBloonstonesPanel;
      
      private var _antiBossAbilityPane:AntiBossAbilitySlideoutPane;
      
      private var _ctEventsInGameUI:CTEventsInGameUI;
      
      private var _loadingThrobber:LoadingClip;
      
      public var blockTowerPlacing:Boolean = false;
      
      private var specialAbilitiesAreBlocked:Boolean = false;
      
      public var bossHealthBar:BossHealthbar;
      
      private var _bs:INumber;
      
      private var _cashTextfieldNeedsUpdate:Boolean = false;
      
      private var _previousHealthProgress:Number = 1;
      
      public function InGameMenu()
      {
         var good:int = 0;
         this.mc = new InGameUI();
         this.game = Main.instance.game;
         this.userProfile = Main.instance.profile;
         this.stateMachine = new Machine();
         this.towerHilight = new TowerHilight(Select);
         this.towerSelectHilight = new TowerHilight(SelectedEffect);
         this.abilityBar = new AbilityBar();
         this.playerPlayArea = this.leftPlayArea;
         this._ctEventsInGameUI = new CTEventsInGameUI(this.mc.uiPanels.specialAgentPanel);
         this._loadingThrobber = new LoadingClip();
         this._bs = DancingShadows.getOne();
         super();
         instance = this;
         this.notEnoughBloonstonesPanel = new InGameNotEnoughBloonstonesPanel(this,null);
         this.tacticsManager = new BSSpecialAbilityManager(this.mc.uiPanels.buildPanel.towerBuild.specialAbilityBox);
         addChild(this.mc);
         this.subMenu = this.mc.uiPanels.subMenu;
         this.towerMenu = new TowerGroup();
         this.towerMenu.init(this.mc.uiPanels.buildPanel.towerBuild as MovieClip,this.mc.uiPanels.buildPanel.towerBuild.roadSpikesButton as MovieClip,this.mc.uiPanels.buildPanel.towerBuild.pineappleButton as MovieClip);
         this.abilityBar.init(this.mc.uiPanels.abilityContainer);
         this.bossHealthBar = new BossHealthbar(this.mc.healthBar);
         if(Constants.ENABLE_ANTI_BOSS_ABILITIES)
         {
            this.mc.antiBossAbilitiesPane.visible = true;
         }
         else
         {
            this.mc.antiBossAbilitiesPane.visible = false;
         }
         this._antiBossAbilityPane = new AntiBossAbilitySlideoutPane(this.mc.antiBossAbilitiesPane);
         this.goButton = new GameGoButtonController(GoButtonClip(this.mc.nextRoundButton));
         this.goButton.addEventListener(GameGoButtonController.ENTER_PLAY_STATE,this.clickedGoButtonHandler);
         this.goButton.addEventListener(GameGoButtonController.FAST_FORWARD_ON,this.clickedFastForwardOnButtonHandler);
         this.goButton.addEventListener(GameGoButtonController.FAST_FORWARD_OFF,this.clickedFastForwardOffButtonHandler);
         this.nonStopCheckbox = new NonstopCheckboxController(this.mc.nonstopCheckbox);
         this.nonStopCheckbox.addEventListener(NonstopCheckboxController.CONTINUOUS_ON,this.clickedContinuousOnButtonHandler);
         this.nonStopCheckbox.addEventListener(NonstopCheckboxController.CONTINUOUS_OFF,this.clickedContinuousOffButtonHandler);
         this.resetPlaceState();
         this.game.addEventListener(LevelEvent.ROUND_OVER,this.roundOver);
         this.game.addEventListener(LevelEvent.ROUND_START,this.roundStart);
         RoundGeneratorPvP.roundStartSignal.add(this.onPVPRoundStartSignal);
         this.mc.cancel_btn.visible = false;
         this.mc.cancel_btn.click = function(param1:MouseEvent):void
         {
            stateMachine.message(new GameStateMessage(GameStateMessage.CANCEL_MSG));
         };
         this._optionsButton = new ButtonControllerBase(this.mc.uiPanels.optionsButton);
         this._optionsButton.setClickFunction(this.onOptionsButtonClick);
         MaxSound.isAudable = !AudioState.sfxIsMuted;
         this.mc.uiPanels.home.click = function(param1:Event):void
         {
            var e:Event = param1;
            if(false == game.gameRequest.isContestedTerritory && game.gameRequest.pvpAttackDefinition == null && game.gameRequest.bossAttack == null && game.gameRequest.isTutorial == false)
            {
               _confirmQuitPanelTile.decisionSignal.addOnce(function(param1:Boolean):void
               {
                  if(param1)
                  {
                     Main.instance.cancelGame();
                  }
               });
               _confirmQuitPanelTile.reveal();
            }
            else
            {
               _confirmQuitPanel.decisionSignal.addOnce(function(param1:Boolean):void
               {
                  if(param1)
                  {
                     Main.instance.cancelGame();
                  }
               });
               _confirmQuitPanel.reveal();
            }
         };
         this.mc.uiPanels.instawinButton.alpha = 0;
         this.mc.uiPanels.addContestRoundButton.alpha = 0;
         if(Constants.ENABLE_CONTEST_CHEAT_BUTTON && Constants.DEPLOY_STATE != ConfigureDeployConstants.PRODUCTION)
         {
            good = 1337;
         }
         else
         {
            this.mc.uiPanels.removeChild(this.mc.uiPanels.addContestRoundButton);
         }
         this.bossDefeatPanel = new BossDefeatPanel(this);
         this.victoryGenericPanel = new VictoryGenericPanel(this);
         this.victoryPanelBoss = new VictoryPanelBoss(this);
         this._retryPanel = new RetryPanel(this,this.notEnoughBloonstonesPanel,this.onRequestTileRestart,this.onTileCancel);
         this._mvmRetryPanel = new MvMRetryPanel(this,this.notEnoughBloonstonesPanel,this.onRequestMvMRestart,this.onMvMRetryCancel);
         this._confirmQuitPanel = new ConfirmQuitPanel(Main.instance.inGameUIParent);
         this._confirmQuitPanelTile = new ConfirmQuitPanelTile(Main.instance.inGameUIParent,this.notEnoughBloonstonesPanel,this.onRequestTileRestart);
         this._timeOutPanel = new MvMTimeOutPanel(this);
         this._contestedTerritoryBriefingPanel = new ContestedTerritoryBriefingPanel(this);
         this._contestedTerritoryRoundReachedPanel = new ContestedTerritoryRoundReachedPanel(this);
         this._contestedTerritoryOutOfLives = new ContestOutOfLivesPanel(this);
         this._contestedTerritoryClosedPanel = new ContestedTerritoryClosedPanel(this);
         this._premaintenancePanel = new PremaintenancePanel(this);
         this._moreBloonstonesButton.setClickFunction(this.bloonstonesButtonClicked);
         Constants.BLOONSTONES_CHANGED_SIGNAL.add(this.onBloonstonesChangedSignal);
         this.tacticsManager.init();
         this.visible = false;
         this._loadingThrobber.visible = false;
         this._loadingThrobber.x = Main.mapArea.width * 0.5 - this._loadingThrobber.width * 0.5;
         this._loadingThrobber.y = Main.mapArea.height * 0.5 - this._loadingThrobber.height * 0.5;
         this._loadingThrobber.stop();
         addChild(this._loadingThrobber);
         Main.instance.displayPremaintenanceSignal.remove(this._premaintenancePanel.popUp);
         Main.instance.displayPremaintenanceSignal.add(this._premaintenancePanel.popUp);
         if(Constants.DISABLE_BOSS)
         {
            this.mc.healthBar.visible = false;
            this.mc.antiBossAbilityBox.visible = false;
         }
      }
      
      public function resetPlaceState() : void
      {
         if(this.placingState)
         {
            this.placingState.exit();
         }
         if(this.towerSelectedState)
         {
            this.towerSelectedState.exit();
         }
         if(this.towerNotSelectedState)
         {
            this.towerNotSelectedState.exit();
         }
         if(this.neutral)
         {
            this.neutral.exit();
         }
         this.placingState = new PlaceState(this);
         this.towerSelectedState = new TowerSelectedState(this);
         this.towerNotSelectedState = new TowerNotSelectedState(this);
         this.neutral = new NeutralState(this);
      }
      
      private function onOptionsButtonClick() : void
      {
         Main.instance.requestOptionsPanelSignal.dispatch();
      }
      
      private function onBloonstonesChangedSignal(param1:int) : void
      {
         this.mc.uiPanels.specialAgentPanel.bloonStones_Amount.text = String(param1);
         var _loc2_:int = param1 - this._bs.value;
         if(_loc2_ < 0)
         {
            this.subtractBloonstonesTextEffect(_loc2_);
         }
         this._bs.value = param1;
      }
      
      private function bloonstonesButtonClicked() : void
      {
         Constants.OPEN_STORE_SIGNAL.dispatch();
      }
      
      private function onMuteSFXButtonChanged(param1:Boolean) : void
      {
         AudioState.sfxIsMuted = param1;
      }
      
      private function onMuteMusicButtonChanged(param1:Boolean) : void
      {
         AudioState.musicIsMuted = param1;
      }
      
      private function clickedGoButtonHandler(param1:Event) : void
      {
         this.dispatchEvent(new Event("START_NEXT_ROUND"));
      }
      
      private function clickedFastForwardOnButtonHandler(param1:Event) : void
      {
         this.game.setFastForward(true);
      }
      
      private function clickedFastForwardOffButtonHandler(param1:Event) : void
      {
         this.game.setFastForward(false);
      }
      
      private function clickedContinuousOnButtonHandler(param1:Event) : void
      {
         this.game.setContinuous(true);
      }
      
      private function clickedContinuousOffButtonHandler(param1:Event) : void
      {
         this.game.setContinuous(false);
      }
      
      public function prepareForNextRound() : void
      {
         prepareNextRoundSignal.dispatch();
      }
      
      private function getTowerPickerDefs(param1:Object) : Vector.<TowerPickerDef>
      {
         var _loc3_:* = null;
         var _loc4_:TowerPickerDef = null;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc4_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc3_);
            if(_loc4_ !== null)
            {
               _loc4_.towersAvailable = param1[_loc3_].count;
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn("menuOrder",Array.NUMERIC);
         return Vector.<TowerPickerDef>(_loc2_);
      }
      
      public function startGame(param1:BTDGameRequest, param2:Object) : void
      {
         var panelDescriptionType:int = 0;
         var gameRequest:BTDGameRequest = param1;
         var availableTowers:Object = param2;
         this.visible = true;
         this.stateMachine.changeState(this.neutral,null);
         this.enableInGameMenu(true);
         this.game.level.addEventListener("TOWER_ADDED",this.towerAdded);
         this.game.level.addEventListener("TOWER_REMOVED",this.towerRemoved);
         this.mc.wave_txt.text = "";
         this.updateHealth(this.game.level.health.value);
         this.game.level.sigHealthChange.add(this.updateHealth);
         this.towerMenu.startGame(this.getTowerPickerDefs(availableTowers));
         this.range = new RangeCombo();
         this.extendedRange = new RangeCombo();
         this.range.visible = false;
         this.extendedRange.visible = false;
         this.game.level.addEntity(this.towerHilight);
         this.mc.uiPanels.cash.label_txt.text = String(this.game.level.cash.value);
         this.game.level.addEventListener(LevelEvent.CASH_CHANGE,this.updateCash);
         this.abilityBar.gameBegin(this.game.level.allTowers);
         this.playerPlayArea = this.leftPlayArea;
         var difficultyTextFormat:TextFormat = new TextFormat();
         this.nonStopCheckbox.reset();
         this._confirmQuitPanelTile.reset();
         this._retryPanel.reset();
         this._mvmRetryPanel.reset();
         this.bossDefeatPanel.hide(0);
         this.victoryGenericPanel.hide(0);
         this.mc.uiPanels.buildPanel.towerBuild.specialAbilityBox.visible = gameRequest.isTutorial == false;
         this.mc.uiPanels.buildPanel.towerBuild.specialAbilityBox.visible = gameRequest.isTutorial == false;
         if(gameRequest.isTutorial || gameRequest.pvpAttackDefinition !== null || gameRequest.bossAttack !== null)
         {
            this.nonStopCheckbox.lock(true);
         }
         else
         {
            this.nonStopCheckbox.lock(false);
         }
         if(gameRequest.isContestedTerritory)
         {
            this.mc.uiPanels.specialAgentPanel.indicator.visible = false;
            this.mc.uiPanels.specialAgentPanel.difficulty_header_txt.text = "Contested Territory";
            this.mc.uiPanels.specialAgentPanel.difficulty_txt.text = "";
            difficultyTextFormat.align = TextFormatAlign.CENTER;
         }
         else
         {
            this.mc.uiPanels.specialAgentPanel.indicator.visible = true;
            this.mc.uiPanels.specialAgentPanel.indicator.gotoAndStop(gameRequest.difficultyRankRelativeToMTL + 1);
            this.mc.uiPanels.specialAgentPanel.difficulty_header_txt.text = "Difficulty";
            this.mc.uiPanels.specialAgentPanel.difficulty_txt.text = gameRequest.difficultyDescription;
            difficultyTextFormat.align = TextFormatAlign.LEFT;
         }
         this.mc.uiPanels.specialAgentPanel.difficulty_header_txt.setTextFormat(difficultyTextFormat);
         this.mc.uiPanels.specialAgentPanel.bloonStones_Amount.text = "";
         Game.GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(0,function(param1:Boolean, param2:int):void
         {
            mc.uiPanels.specialAgentPanel.bloonStones_Amount.text = String(param2);
            _bs.value = param2;
         },false);
         this.gameTimer = new Timer(1000);
         this.gameTimer.addEventListener(TimerEvent.TIMER,this.updateGameTimer);
         this.gameTimer.start();
         if(gameRequest.isContestedTerritory)
         {
            panelDescriptionType = !!gameRequest.contestedTerritoryForCapture?int(ContestedTerritoryBriefingPanel.DESC_GAIN_CONTROL):int(ContestedTerritoryBriefingPanel.DESC_EXTEND_LEAD);
            this._contestedTerritoryBriefingPanel.popUp(panelDescriptionType,gameRequest.contestedTerritoryRoundToBeat);
         }
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.stageMouseMove);
         this.tacticsManager.startGame(gameRequest,Main.instance.tutorialLayer);
         this.towerMenu.reset();
         addEventListener(Event.ENTER_FRAME,this.process);
      }
      
      public function subtractBloonstonesTextEffect(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:MinusBloonstones = new MinusBloonstones();
         _loc2_.x = 155;
         _loc2_.y = 525;
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         _loc2_.label.text = String(int(param1));
         Main.instance.game.inGameMenu.addChild(_loc2_);
      }
      
      public function endGame() : void
      {
         this.towerMenu.endGame();
         this.cancel();
         this.stateMachine.changeState(null,null);
         this.tacticsManager.endGame();
      }
      
      public function continueGame() : void
      {
         this.towerMenu.continueGame();
         this.stateMachine.changeState(this.neutral,null);
      }
      
      public function exitGame() : void
      {
         FireAtReticle.ResetLocations();
         this.removeReticle();
         this.game = Main.instance.game;
         if(this.game == null || this.game.level == null)
         {
            return;
         }
         this.game.level.removeEventListener("TOWER_ADDED",this.towerAdded);
         this.game.level.removeEventListener("TOWER_REMOVED",this.towerRemoved);
         this.game.level.sigHealthChange.remove(this.updateHealth);
         this.game.level.removeEventListener(LevelEvent.CASH_CHANGE,this.updateCash);
         this.game.sigCashTickChanged.remove(this.updateCashTick);
         this.towerMenu.exitGame();
         this.abilityBar.reset();
         this._confirmQuitPanel.hide(0);
         this._confirmQuitPanelTile.hide(0);
         this._retryPanel.hide(0);
         this._mvmRetryPanel.hide(0);
         this._timeOutPanel.hide(0);
         this._contestedTerritoryBriefingPanel.hide(0);
         this._contestedTerritoryOutOfLives.hide(0);
         this._contestedTerritoryRoundReachedPanel.hide(0);
         this._contestedTerritoryClosedPanel.hide(0);
         this._premaintenancePanel.hide(0);
         this.bossDefeatPanel.hide(0);
         this.victoryGenericPanel.hide(0);
         if(this.stateMachine != null && this.stateMachine.currentState != null)
         {
            this.stateMachine.currentState.exit();
         }
         this.gameTimer.removeEventListener(TimerEvent.TIMER,this.updateGameTimer);
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.stageMouseMove);
         removeEventListener(Event.ENTER_FRAME,this.process);
      }
      
      public function process(param1:Event) : void
      {
         this.abilityBar.update();
         if(this._cashTextfieldNeedsUpdate)
         {
            this.mc.uiPanels.cash.label_txt.text = String(int(this.game.level.cash.value));
            this._cashTextfieldNeedsUpdate = false;
         }
         this.tacticsManager.update();
         this._antiBossAbilityPane.update();
      }
      
      public function updateGameTimer(param1:Event) : void
      {
         var _loc2_:Number = this.game.getGameTime() - Balance.instance.FIRST_ROUND_START_TIME;
         if(_loc2_ < 0)
         {
            _loc2_ = _loc2_ - 0.999999;
         }
      }
      
      private function toTimeString(param1:int) : String
      {
         var _loc2_:String = "";
         if(int(param1 / 3600) > 0)
         {
            _loc2_ = _loc2_ + (int(param1 / 3600) + ":");
         }
         var _loc3_:String = String(int(param1 / 60 % 60));
         if(_loc3_.length != 2)
         {
            _loc3_ = "0" + _loc3_;
         }
         _loc2_ = _loc2_ + (_loc3_ + ":");
         var _loc4_:String = String(int(param1 % 60));
         if(_loc4_.length != 2)
         {
            _loc4_ = "0" + _loc4_;
         }
         _loc2_ = _loc2_ + _loc4_;
         return _loc2_;
      }
      
      private function updateCash(param1:Event) : void
      {
         this._cashTextfieldNeedsUpdate = true;
      }
      
      private function updateCashTick(param1:Number) : void
      {
      }
      
      private function updateHealth(param1:int, param2:int = 0) : void
      {
         this.mc.uiPanels.health.label_txt.text = param1.toString();
      }
      
      private function towerAdded(param1:TowerChangedEvent) : void
      {
         this.abilityBar.addTower(param1.tower);
      }
      
      private function towerRemoved(param1:TowerChangedEvent) : void
      {
         this.abilityBar.removeTower(param1.tower);
      }
      
      public function enableInGameMenu(param1:Boolean) : void
      {
         this.mc.mouseEnabled = param1;
         this.mc.mouseChildren = param1;
         if(param1)
         {
            Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownEvent);
            Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpEvent);
         }
         else
         {
            Main.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownEvent);
            Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpEvent);
            if(this.stateMachine.currentState == this.towerSelectedState)
            {
               this.towerSelectedState.exit();
            }
         }
      }
      
      private function roundStart(param1:Event) : void
      {
         this.syncWaveText();
      }
      
      public function restartReset() : void
      {
         this.mc.wave_txt.text = 1 + " of " + this.game.level.totalRounds;
         this.tacticsManager.reset();
         this.towerMenu.syncTowerCounts();
         this.retryPanel.hide(0);
         this.mvmRetryPanel.hide(0);
         this.confirmQuitPanel.hide(0);
         this.confirmQuitPanelTile.hide(0);
         this.goButton.setThrottleState(GameGoButtonController.THROTTLE_STATE_PAUSED);
      }
      
      private function onRequestTileRestart(param1:Boolean) : void
      {
         var _loc2_:Number = 0;
         if(param1)
         {
            Main.instance.game.gameRequest.isBonusCashMode = this._retryPanel.bonusCashTickbox.ticked;
         }
         else
         {
            Main.instance.game.gameRequest.isBonusCashMode = this.confirmQuitPanelTile.bonusCashTickbox.ticked;
         }
         _loc2_ = !!Main.instance.game.gameRequest.isBonusCashMode?Number(this.game.bonusStartingCash.value):Number(0);
         _loc2_ = _loc2_ + this.game.specialMissionCashBonus;
         Main.instance.game.numOfRetries++;
         this.game.restartGame.dispatch(_loc2_);
      }
      
      private function onRequestMvMRestart() : void
      {
         this.restartReset();
         Main.instance.game.gameRequest.isBonusCashMode = this.mvmRetryPanel.bonusCashTickbox.ticked;
         var _loc1_:Number = !!Main.instance.game.gameRequest.isBonusCashMode?Number(this.game.bonusStartingCash.value):Number(0);
         Main.instance.game.numOfRetries++;
         this.game.restartGamePVP.dispatch(_loc1_);
      }
      
      private function syncWaveText() : void
      {
         if(this.game.gameRequest.isContestedTerritory)
         {
            this.mc.wave_txt.text = String(this.game.waveIndex + 1);
         }
         else
         {
            this.mc.wave_txt.text = this.game.waveIndex + 1 + " of " + this.game.level.totalRounds;
         }
      }
      
      private function onTileCancel() : void
      {
         this.game.gameOver(true);
      }
      
      private function onMvMRetryCancel() : void
      {
         this.game.gameOver(true);
      }
      
      private function onPVPRoundStartSignal(param1:int) : void
      {
         this.mc.wave_txt.text = param1 + 1 + " of " + this.game.level.totalRounds;
      }
      
      public function setRoundTextVisible(param1:Boolean) : void
      {
         this.mc.wave_txt.visible = param1;
      }
      
      public function setHealthbarVisible(param1:Boolean, param2:Boolean = false) : void
      {
         this.bossHealthBar.setHealthbarVisible(param1,param2);
      }
      
      public function setHealthbarShieldVisible(param1:Boolean) : void
      {
         this.bossHealthBar.setShieldVisible(param1);
      }
      
      public function setAntiBossAbilitiesVisible(param1:Boolean) : void
      {
         if(false === Constants.ENABLE_ANTI_BOSS_ABILITIES)
         {
            this.mc.state = false;
         }
         this.mc.antiBossAbilitiesPane.visible = param1;
         if(param1 == true)
         {
            this.mc.antiBossAbilitiesPane.alpha = 0;
            TweenLite.to(this.mc.antiBossAbilitiesPane,0.5,{"alpha":1});
         }
         else
         {
            this.mc.antiBossAbilitiesPane.alpha = 1;
         }
      }
      
      public function setHealthBarProgress(param1:Number) : void
      {
         this.bossHealthBar.setHealthBarProgress(param1);
      }
      
      public function setBossLevel(param1:int) : void
      {
         this.bossHealthBar.setBossLevel(param1);
      }
      
      private function roundOver(param1:Event) : void
      {
      }
      
      public function keyUpEvent(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            if(this.goButton.isCancelEnabled)
            {
               this.stateMachine.message(new GameStateMessage(GameStateMessage.CANCEL_MSG));
            }
         }
         else if(param1.keyCode == Keyboard.SHIFT)
         {
            this.shiftDown = false;
         }
      }
      
      public function keyDownEvent(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SHIFT)
         {
            this.shiftDown = true;
         }
         else if(param1.keyCode == Keyboard.SPACE)
         {
            if(this.goButton.isCancelEnabled)
            {
               this.goButton.onClick();
            }
         }
      }
      
      public function canSelect(param1:TowerDef) : Boolean
      {
         if(param1.id == "RoadSpikes" || param1.id == "ExplodingPineapple")
         {
            return false;
         }
         return true;
      }
      
      public function cancel() : void
      {
         this.stateMachine.message(new GameStateMessage(GameStateMessage.CANCEL_MSG));
         this.setSpecialAbilitiesBlocked(false);
      }
      
      public function beginPlacingTower(param1:TowerPickerDef) : void
      {
         this.cancel();
         this.mc.addEventListener(MouseEvent.CLICK,this.uiClicked,true);
         var _loc2_:GameStateMessage = new GameStateMessage(GameStateMessage.TOWERPLACING_MSG);
         _loc2_.towerPickerDef = param1;
         this.stateMachine.message(_loc2_);
         this.setSpecialAbilitiesBlocked(true);
      }
      
      public function placeUp(param1:Tower) : void
      {
         var tower_:Tower = param1;
         this.mc.removeEventListener(MouseEvent.CLICK,this.uiClicked,true);
         var gsm:GameStateMessage = new GameStateMessage(GameStateMessage.TOWERPLACED_MSG);
         gsm.tower = tower_;
         this.stateMachine.message(gsm);
         towerPlacedSignal.dispatch(tower_);
         setTimeout(function():void
         {
            setSpecialAbilitiesBlocked(false);
         },1);
      }
      
      public function cancelPlace() : void
      {
         this.mc.removeEventListener(MouseEvent.CLICK,this.uiClicked,true);
         this.setSpecialAbilitiesBlocked(false);
      }
      
      private function uiClicked(param1:MouseEvent) : void
      {
         var _loc2_:Number = Main.instance.mouseX;
         var _loc3_:Number = Main.instance.mouseY;
         if(this.bottomUIArea.containsPoint(new Point(_loc2_,_loc3_)))
         {
            if(this.goButton.isCancelEnabled)
            {
               this.cancel();
            }
         }
      }
      
      private function stageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = Main.instance.mouseX;
         var _loc3_:Number = Main.instance.mouseY;
         if(this.stateMachine.currentState == this.placingState)
         {
            this.inInvalidArea = true;
         }
         else
         {
            this.inInvalidArea = false;
         }
      }
      
      public function inPlayArea() : Boolean
      {
         return this.playerPlayArea.containsPoint(new Point(Main.instance.mouseX,Main.instance.mouseY));
      }
      
      public function inPlayAreaVector(param1:Vector2) : Boolean
      {
         return this.playerPlayArea.containsPoint(new Point(param1.x,param1.y));
      }
      
      public function inBottomUIArea() : Boolean
      {
         return this.bottomUIArea.containsPoint(new Point(Main.instance.mouseX,Main.instance.mouseY));
      }
      
      public function inRightUIArea() : Boolean
      {
         return this.rightUIArea.containsPoint(new Point(Main.instance.mouseX,Main.instance.mouseY));
      }
      
      public function setupReticle(param1:Tower) : void
      {
         var _loc2_:Vector2 = null;
         if(this.placingReticle)
         {
            this.placingReticle.destroy();
         }
         if(this.prevReticle)
         {
            this.prevReticle.destroy();
         }
         if(param1.targetingSystem == TowerDef.TARGETS_RETICLE)
         {
            _loc2_ = FireAtReticle.GetLocation(param1);
            this.placingReticle = new Reticle();
            this.placingReticle.initialise(param1,true);
            this.placingReticle.x = _loc2_.x;
            this.placingReticle.y = _loc2_.y;
            this.game.level.addEntity(this.placingReticle);
            this.prevReticle = new Reticle();
            this.prevReticle.initialise(param1,false);
            this.prevReticle.x = _loc2_.x;
            this.prevReticle.y = _loc2_.y;
            this.game.level.addEntity(this.prevReticle);
         }
      }
      
      public function placeReticle() : void
      {
         this.game.level.movedTargetingReticle(this.placingReticle.tower,this.placingReticle.x,this.placingReticle.y);
         this.prevReticle.x = this.placingReticle.x;
         this.prevReticle.y = this.placingReticle.y;
         this.placingReticle.destroy();
         this.placingReticle = null;
      }
      
      public function removeReticle() : void
      {
         if(this.placingReticle)
         {
            this.placingReticle.destroy();
            this.placingReticle = null;
         }
         if(this.prevReticle)
         {
            this.prevReticle.destroy();
            this.prevReticle = null;
         }
      }
      
      public function setSpecialAbilitiesBlocked(param1:Boolean) : void
      {
         this.specialAbilitiesAreBlocked = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.tacticsManager.abilities.length)
         {
            if(param1)
            {
               this.tacticsManager.abilities[_loc2_].button.disableMouseInteraction();
            }
            else
            {
               this.tacticsManager.abilities[_loc2_].button.enableMouseInteraction();
            }
            _loc2_++;
         }
      }
      
      public function isPointPlaceable(param1:Number, param2:Number) : Boolean
      {
         return true;
      }
      
      public function upgradeTowerPath(param1:Tower) : void
      {
         if(this.prevReticle)
         {
            this.prevReticle.refreshReticle(param1);
         }
      }
      
      public function get retryPanel() : RetryPanel
      {
         return this._retryPanel;
      }
      
      public function get mvmRetryPanel() : MvMRetryPanel
      {
         return this._mvmRetryPanel;
      }
      
      public function get timeOutPanel() : MvMTimeOutPanel
      {
         return this._timeOutPanel;
      }
      
      public function get confirmQuitPanel() : ConfirmQuitPanel
      {
         return this._confirmQuitPanel;
      }
      
      public function get confirmQuitPanelTile() : ConfirmQuitPanelTile
      {
         return this._confirmQuitPanelTile;
      }
      
      public function get tacticsSave() : Object
      {
         return this.tacticsManager.getSaveData();
      }
      
      public function get contestedTerritoryRoundReachedPanel() : ContestedTerritoryRoundReachedPanel
      {
         return this._contestedTerritoryRoundReachedPanel;
      }
      
      public function get outOfLivesNoRetryPanel() : ContestOutOfLivesPanel
      {
         return this._contestedTerritoryOutOfLives;
      }
      
      public function get contestedTerritoryClosedPanel() : ContestedTerritoryClosedPanel
      {
         return this._contestedTerritoryClosedPanel;
      }
      
      public function get contestedTerritoryBriefingPanel() : ContestedTerritoryBriefingPanel
      {
         return this._contestedTerritoryBriefingPanel;
      }
      
      public function get loadingThrobber() : LoadingClip
      {
         return this._loadingThrobber;
      }
      
      public function get bs() : INumber
      {
         return this._bs;
      }
      
      public function get premaintenancePanel() : PremaintenancePanel
      {
         return this._premaintenancePanel;
      }
      
      public function get antiBossAbilityPane() : AntiBossAbilitySlideoutPane
      {
         return this._antiBossAbilityPane;
      }
   }
}
