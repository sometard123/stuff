package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.RetryPanelClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class RetryPanel extends HideRevealViewSimple
   {
       
      
      private const USE_FANCY_FADE_IN:Boolean = false;
      
      private const _clip:RetryPanelClip = new RetryPanelClip();
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _continueButton:ButtonControllerBase = new ButtonControllerBase(this._clip.continueButton);
      
      private const _restartButton:ButtonControllerBase = new ButtonControllerBase(this._clip.restartButton);
      
      private const _bonusCashTickbox:TickBox = new TickBox(this._clip.bonusCashClip.bonusCashTickBox);
      
      private const _bonusCashClip:MovieClip = this._clip.bonusCashClip;
      
      private const _orText:MovieClip = this._clip.orText;
      
      private const standardText:String = "Oops! The Bloons got through and you ran out of lives - don\'t let them undo your hard work!";
      
      private var _notEnoughBloonstonesPanel:InGameNotEnoughBloonstonesPanel;
      
      public var retrySignal:Signal;
      
      private var _onRestartFunction:Function;
      
      private var _onCancelFunction:Function;
      
      private var _startWithBonusCash:INumber;
      
      public function RetryPanel(param1:DisplayObjectContainer, param2:InGameNotEnoughBloonstonesPanel, param3:Function, param4:Function)
      {
         this.retrySignal = new Signal();
         this._startWithBonusCash = DancingShadows.getOne();
         super(param1);
         this._notEnoughBloonstonesPanel = param2;
         this._onRestartFunction = param3;
         this._onCancelFunction = param4;
         this.addChild(this._clip);
         this._clip.continueButton.bloonStones_txt.text = String(Game.RETRY_BLOONSTONES);
         this._continueButton.unlock();
         this._continueButton.setClickFunction(this.onClickRetry);
         this._restartButton.setClickFunction(this.onClickedRestart);
         this._cancelButton.setClickFunction(this.onClickCancel);
         this._bonusCashTickbox.changedSignal.add(this.onBonusCashTicked);
         this.reset();
      }
      
      public function reset() : void
      {
         this._startWithBonusCash.value = 0;
         this._bonusCashTickbox.reset();
         this._bonusCashTickbox.ticked = false;
         this._bonusCashTickbox.enabled = true;
      }
      
      override public function resize() : void
      {
         super.resize();
         this._clip.x = Main.mapArea.width * 0.5;
         this._clip.y = Main.mapArea.height * 0.5;
      }
      
      private function onClickRetry() : void
      {
         this.retrySignal.dispatch();
         this.hide();
      }
      
      private function onClickedRestart() : void
      {
         if(this._startWithBonusCash.value)
         {
            Game.GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(Game.BLOONSTONES_FOR_BONUS_CASH,this.onBloonstonesCharged,true);
         }
         else
         {
            this.hide();
            this.callRestartFunction();
         }
      }
      
      private function onClickCancel() : void
      {
         this._onCancelFunction();
         this.hide();
      }
      
      public function updateBonusCashRetry(param1:Number) : void
      {
         this._clip.startingCash.text = new String("$" + param1);
      }
      
      private function updateBonusCashRestart(param1:INumber) : void
      {
         this._clip.bonusCashClip.description.text = LocalisationConstants.ADD_START_CASH_TILE_TEXT.split("<added>").join(String(param1.value));
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().reveal("Retry",_container);
         if(this.USE_FANCY_FADE_IN)
         {
            this._continueButton.disableMouseInteraction();
            this._continueButton.fadeOut(0);
            this._restartButton.disableMouseInteraction();
            this._restartButton.fadeOut(0);
            this._cancelButton.disableMouseInteraction();
            this._cancelButton.fadeOut(0);
            this._bonusCashClip.visible = false;
            this._orText.visible = false;
            this._continueButton.disableMouseInteraction();
         }
         else
         {
            this._cancelButton.enableMouseInteraction();
            this._cancelButton.fadeIn(0);
            this._continueButton.enableMouseInteraction();
            this._continueButton.fadeIn(0);
            this._orText.visible = true;
            this._orText.alpha = 1;
            this._bonusCashClip.visible = true;
            this._bonusCashClip.alpha = 1;
            this._restartButton.enableMouseInteraction();
            this._restartButton.fadeIn(0);
         }
         this.updateBonusCashRestart(Main.instance.game.bonusStartingCash);
         this._bonusCashTickbox.ticked = Main.instance.game.gameRequest.isBonusCashMode;
         revealCompleteSignal.remove(this.onCompleteFadeIn);
         revealCompleteSignal.add(this.onCompleteFadeIn);
         super.reveal(param1);
         this.setActive(true);
         this.setBonusCashAvailable(Main.instance.game.gameRequest.specialMissionID == null);
      }
      
      public function setActive(param1:Boolean) : void
      {
         if(param1)
         {
            this._cancelButton.unlock();
            this._continueButton.unlock();
            this._restartButton.unlock();
            this._bonusCashTickbox.enabled = true;
         }
         else
         {
            this._cancelButton.lock();
            this._continueButton.lock();
            this._restartButton.lock();
            this._bonusCashTickbox.enabled = false;
         }
      }
      
      public function setBonusCashAvailable(param1:Boolean) : void
      {
         this._clip.bonusCashClip.mouseChildren = param1;
         this._clip.bonusCashClip.mouseEnabled = param1;
         this._clip.bonusCashClip.bonusCashTickBox.enabled = param1;
         this._bonusCashTickbox.enabled = param1;
      }
      
      public function onCompleteFadeIn() : void
      {
         if(this.USE_FANCY_FADE_IN)
         {
            TweenLite.delayedCall(0.5,function():void
            {
               _cancelButton.enableMouseInteraction();
               _cancelButton.fadeIn(0.5);
               _continueButton.enableMouseInteraction();
               _continueButton.fadeIn(0.5);
            });
            TweenLite.delayedCall(1.5,function():void
            {
               _orText.visible = true;
               _orText.alpha = 0;
               TweenLite.to(_orText,0.5,{"alpha":1});
            });
            TweenLite.delayedCall(2.5,function():void
            {
               _bonusCashClip.visible = true;
               _bonusCashClip.alpha = 0;
               TweenLite.to(_bonusCashClip,0.5,{"alpha":1});
               _restartButton.enableMouseInteraction();
               _restartButton.fadeIn(0.5);
            });
         }
      }
      
      private function onBonusCashTicked(param1:Boolean) : void
      {
         if(param1)
         {
            this._startWithBonusCash.value = 1;
         }
         else
         {
            this._startWithBonusCash.value = 0;
         }
      }
      
      private function onBloonstonesCharged(param1:Boolean, param2:int) : void
      {
         this.hide();
         if(param1)
         {
            this.callRestartFunction();
         }
         else
         {
            this._notEnoughBloonstonesPanel.setRequiredBloonstones(Game.BLOONSTONES_FOR_BONUS_CASH - param2);
            this._notEnoughBloonstonesPanel.parentPanel = this;
            this._notEnoughBloonstonesPanel.reveal();
            ModalBlocker.getInstance().hide("Retry");
         }
      }
      
      private function callRestartFunction() : void
      {
         Main.instance.game.inGameMenu.loadingThrobber.visible = true;
         Main.instance.game.inGameMenu.loadingThrobber.alpha = 1;
         Main.instance.game.inGameMenu.loadingThrobber.play();
         TweenLite.delayedCall(0.5,function():void
         {
            TweenLite.to(Main.instance.game.inGameMenu.loadingThrobber,15,{
               "alpha":0,
               "useFrames":true,
               "onComplete":function():void
               {
                  Main.instance.game.inGameMenu.loadingThrobber.visible = false;
                  Main.instance.game.inGameMenu.loadingThrobber.stop();
               }
            });
            _onRestartFunction(true);
         });
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().hide("Retry");
         super.hide(param1);
      }
      
      public function get notEnoughBloonstonesPanel() : InGameNotEnoughBloonstonesPanel
      {
         return this._notEnoughBloonstonesPanel;
      }
      
      public function get bonusCashTickbox() : TickBox
      {
         return this._bonusCashTickbox;
      }
   }
}
