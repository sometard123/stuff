package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.ConfirmCancelGamePanelTileClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class ConfirmQuitPanelTile extends HideRevealViewSimple
   {
       
      
      private var _clip:ConfirmCancelGamePanelTileClip;
      
      private const _yesButton:ButtonControllerBase = new ButtonControllerBase(this._clip.yesButton);
      
      private const _noButton:ButtonControllerBase = new ButtonControllerBase(this._clip.noButton);
      
      private const _restartButton:ButtonControllerBase = new ButtonControllerBase(this._clip.RetryButton);
      
      private var _notEnoughBloonstonesPanel:InGameNotEnoughBloonstonesPanel;
      
      private var _onRestartFunction:Function;
      
      private const _bonusCashTickbox:TickBox = new TickBox(this._clip.bonusCashClip.bonusCashTickBox);
      
      private var _startWithBonusCash:INumber;
      
      private var _bloonstonesCharged:INumber;
      
      public const decisionSignal:Signal = new Signal(Boolean);
      
      public function ConfirmQuitPanelTile(param1:DisplayObjectContainer, param2:InGameNotEnoughBloonstonesPanel, param3:Function)
      {
         this._clip = new ConfirmCancelGamePanelTileClip();
         this._startWithBonusCash = DancingShadows.getOne();
         this._bloonstonesCharged = DancingShadows.getOne();
         super(param1);
         this._notEnoughBloonstonesPanel = param2;
         this._onRestartFunction = param3;
         this.addChild(this._clip);
         this._yesButton.setClickFunction(this.onClickYesButton);
         this._noButton.setClickFunction(this.onClickNoButton);
         this._restartButton.setClickFunction(this.onClickRestartButton);
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
      
      public function updateBonusCashRetry(param1:Number) : void
      {
         this._clip.bonusCashClip.description.text = LocalisationConstants.ADD_START_CASH_TILE_TEXT.split("<added>").join(String(param1));
      }
      
      public function setBonusCashAvailable(param1:Boolean) : void
      {
         this._clip.bonusCashClip.mouseChildren = param1;
         this._clip.bonusCashClip.mouseEnabled = param1;
         this._clip.bonusCashClip.bonusCashTickBox.enabled = param1;
         this._bonusCashTickbox.enabled = param1;
      }
      
      private function onClickYesButton() : void
      {
         this.hide();
         this.decisionSignal.dispatch(true);
      }
      
      private function onClickRestartButton() : void
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
            _onRestartFunction(false);
         });
      }
      
      private function onClickNoButton() : void
      {
         this.hide();
         this.decisionSignal.dispatch(false);
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this.updateBonusCashRetry(Main.instance.game.bonusStartingCash.value);
         this.onBonusCashTicked(Main.instance.game.gameRequest.isBonusCashMode);
         this._bonusCashTickbox.ticked = Main.instance.game.gameRequest.isBonusCashMode;
         ModalBlocker.getInstance().reveal("InGame",_container);
         super.reveal(param1);
         this.setBonusCashAvailable(Main.instance.game.gameRequest.specialMissionID == null);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().hide("InGame");
         super.hide(param1);
      }
      
      public function get bloonstonesCharged() : INumber
      {
         return this._bloonstonesCharged;
      }
      
      public function get bonusCashTickbox() : TickBox
      {
         return this._bonusCashTickbox;
      }
   }
}
