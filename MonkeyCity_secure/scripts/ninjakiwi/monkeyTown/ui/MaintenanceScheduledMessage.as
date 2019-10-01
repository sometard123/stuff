package ninjakiwi.monkeyTown.ui
{
   import assets.ui.MaintenanceScheduledMessageClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MaintenanceScheduledMessage extends HideRevealView
   {
      
      private static const OK_BUTTON_ONLY:int = 0;
      
      private static const OK_AND_CANCEL_BUTTON:int = 1;
       
      
      private const _clip:MaintenanceScheduledMessageClip = new MaintenanceScheduledMessageClip();
      
      private var _okButton:ButtonControllerBase;
      
      private var _warningOKButton:ButtonControllerBase;
      
      private var _warningCancelButton:ButtonControllerBase;
      
      private var _confirmCallback:Function = null;
      
      public function MaintenanceScheduledMessage(param1:DisplayObjectContainer, param2:* = null)
      {
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._warningOKButton = new ButtonControllerBase(this._clip.cancelOKButtons.okButton);
         this._warningCancelButton = new ButtonControllerBase(this._clip.cancelOKButtons.cancelButton);
         super(param1,param2);
         this._clip.stop();
         enableDefaultOnResize(this._clip);
         isModal = true;
         addChild(this._clip);
         this._okButton.setClickFunction(hide);
         this._warningCancelButton.setClickFunction(this.onCancel);
         this._warningOKButton.setClickFunction(this.onConfirm);
      }
      
      private function onCancel() : void
      {
         if(this._confirmCallback !== null)
         {
            this._confirmCallback(false);
         }
         hide();
      }
      
      private function onConfirm() : void
      {
         if(this._confirmCallback !== null)
         {
            this._confirmCallback(true);
         }
         hide();
      }
      
      public function showMvMDisabledMessage() : void
      {
         this._clip.gotoAndStop(1);
         this.setupButtons(OK_BUTTON_ONLY);
         reveal();
      }
      
      public function showCTStartPremaintenanceMessage(param1:Function) : void
      {
         this._confirmCallback = param1;
         this._clip.gotoAndStop(3);
         this.setupButtons(OK_AND_CANCEL_BUTTON);
         reveal();
      }
      
      public function showBossStartPremaintenanceMessage(param1:Function) : void
      {
         this._confirmCallback = param1;
         this._clip.gotoAndStop(4);
         this.setupButtons(OK_AND_CANCEL_BUTTON);
         reveal();
      }
      
      public function showMvEWarningMessage(param1:Function) : void
      {
         this._confirmCallback = param1;
         this._clip.gotoAndStop(2);
         this.setupButtons(OK_AND_CANCEL_BUTTON);
         reveal();
      }
      
      private function setupButtons(param1:int) : void
      {
         switch(param1)
         {
            case OK_BUTTON_ONLY:
               this._clip.okButton.visible = true;
               this._clip.cancelOKButtons.visible = false;
               break;
            case OK_AND_CANCEL_BUTTON:
               this._clip.okButton.visible = false;
               this._clip.cancelOKButtons.visible = true;
         }
      }
   }
}
