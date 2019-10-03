package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.ConfirmCancelGamePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ConfirmQuitPanel extends HideRevealViewSimple
   {
       
      
      private var _clip:ConfirmCancelGamePanelClip;
      
      private const _yesButton:ButtonControllerBase = new ButtonControllerBase(this._clip.yesButton);
      
      private const _noButton:ButtonControllerBase = new ButtonControllerBase(this._clip.noButton);
      
      public const decisionSignal:Signal = new Signal(Boolean);
      
      public function ConfirmQuitPanel(param1:DisplayObjectContainer)
      {
         this._clip = new ConfirmCancelGamePanelClip();
         super(param1);
         this.addChild(this._clip);
         this._yesButton.setClickFunction(this.onClickYesButton);
         this._noButton.setClickFunction(this.onClickNoButton);
      }
      
      override public function resize() : void
      {
         super.resize();
         this._clip.x = Main.mapArea.width * 0.5;
         this._clip.y = Main.mapArea.height * 0.5;
      }
      
      private function onClickYesButton() : void
      {
         this.hide();
         this.decisionSignal.dispatch(true);
      }
      
      private function onClickNoButton() : void
      {
         this.hide();
         this.decisionSignal.dispatch(false);
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().reveal("InGame",_container);
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         ModalBlocker.getInstance().hide("InGame");
      }
   }
}
