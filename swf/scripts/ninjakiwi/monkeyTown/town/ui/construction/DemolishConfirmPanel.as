package ninjakiwi.monkeyTown.town.ui.construction
{
   import assets.ui.DemolishConfirmPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class DemolishConfirmPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:DemolishConfirmPanelClip = new DemolishConfirmPanelClip();
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _confirmButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public const confirmSignal:Signal = new Signal();
      
      public function DemolishConfirmPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._cancelButton.setClickFunction(hide);
         this._confirmButton.setClickFunction(this.onConfirm);
         this.isModal = true;
         this.addChild(this._clip);
         setAutoPlayStopClipsArray([this._clip.dynamite]);
      }
      
      private function onConfirm() : void
      {
         this.confirmSignal.dispatch();
         hide();
      }
   }
}
