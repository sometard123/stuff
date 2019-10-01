package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.SkipTrivialAttackPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class SkipTrivialAttackPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:SkipTrivialAttackPanelClip = new SkipTrivialAttackPanelClip();
      
      private var _okButton:ButtonControllerBase;
      
      private var _cancelButton:ButtonControllerBase;
      
      public const okSignal:Signal = new Signal();
      
      public const cancelSignal:Signal = new Signal();
      
      public const responseSignal:Signal = new Signal(Boolean);
      
      public function SkipTrivialAttackPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(this.onOkButtonClicked);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
      }
      
      private function onCancelButtonClicked() : void
      {
         this.cancelSignal.dispatch();
         this.responseSignal.dispatch(false);
         hide();
      }
      
      private function onOkButtonClicked() : void
      {
         this.okSignal.dispatch();
         this.responseSignal.dispatch(true);
         hide();
      }
      
      override protected function onESC() : void
      {
         this.cancelSignal.dispatch();
         this.responseSignal.dispatch(false);
         super.onESC();
      }
   }
}
