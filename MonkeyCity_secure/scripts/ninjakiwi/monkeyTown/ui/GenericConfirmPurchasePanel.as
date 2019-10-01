package ninjakiwi.monkeyTown.ui
{
   import assets.ui.ConfirmPurchasePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class GenericConfirmPurchasePanel extends HideRevealViewPopup
   {
       
      
      private var _clip:ConfirmPurchasePanelClip;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _onConfirmCallback:Function = null;
      
      public function GenericConfirmPurchasePanel(param1:DisplayObjectContainer)
      {
         this._clip = new ConfirmPurchasePanelClip();
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         super(param1);
         this._buyButton.setClickFunction(this.onBuyButtonClicked);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this.isModal = true;
         this.addChild(this._clip);
      }
      
      public function configure(param1:String, param2:Number, param3:Function) : void
      {
         this._onConfirmCallback = param3;
         this._clip.costField.text = param2.toString();
         this._clip.messageTxt.text = LocalisationConstants.PREMIUM_PURCHASE.split("<name>").join(param1);
      }
      
      private function onBuyButtonClicked() : void
      {
         if(this._onConfirmCallback !== null)
         {
            this._onConfirmCallback(true);
            this._onConfirmCallback = null;
         }
         hide();
      }
      
      private function onCancelButtonClicked() : void
      {
         if(this._onConfirmCallback !== null)
         {
            this._onConfirmCallback(false);
            this._onConfirmCallback = null;
         }
         hide();
      }
      
      override public function reveal(param1:Number = 1) : void
      {
         super.reveal(param1);
         if(Kong.isOnKong())
         {
            this._clip.currencyIcon0.gotoAndStop(2);
            this._clip.currencyIcon1.gotoAndStop(2);
         }
         else
         {
            this._clip.currencyIcon0.gotoAndStop(1);
            this._clip.currencyIcon1.gotoAndStop(1);
         }
      }
   }
}
