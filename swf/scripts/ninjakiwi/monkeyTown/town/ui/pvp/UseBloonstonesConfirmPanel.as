package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.UseBloonstonesConfirmPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class UseBloonstonesConfirmPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:UseBloonstonesConfirmPanelClip = new UseBloonstonesConfirmPanelClip();
      
      private const _cancel:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private var _videoAdPanelController:VideoAdPanelController;
      
      public const okSignal:Signal = new Signal();
      
      public function UseBloonstonesConfirmPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this._cancel.setClickFunction(hide);
         this._ok.setClickFunction(this.onOk);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         setAutoPlayStopClipsArray([this._clip.gems]);
         this._videoAdPanelController = new VideoAdPanelController(this._clip.watchVideoPanel,this);
      }
      
      private function onOk() : void
      {
         hide();
         this.okSignal.dispatch();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         this._videoAdPanelController.doVideoAvailableCheck();
      }
   }
}
