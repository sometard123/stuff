package ninjakiwi.monkeyTown.ui
{
   import assets.ui.PurchaseNKCoinsPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class PurchaseNKCoinsPanel extends HideRevealViewPopup
   {
       
      
      private var _clip:PurchaseNKCoinsPanelClip;
      
      private var _buyMoreCoinsButton:ButtonControllerBase;
      
      private var _cancelButton:ButtonControllerBase;
      
      private const NK_STORE_URL_REQUEST:URLRequest = new URLRequest(Constants.NK_STORE_URL);
      
      public function PurchaseNKCoinsPanel(param1:DisplayObjectContainer)
      {
         this._clip = new PurchaseNKCoinsPanelClip();
         this._buyMoreCoinsButton = new ButtonControllerBase(this._clip.buyCoinsButton);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         super(param1);
         this._buyMoreCoinsButton.setClickFunction(this.onBuyButtonClicked);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this.isModal = true;
         this.addChild(this._clip);
      }
      
      private function onBuyButtonClicked() : void
      {
         navigateToURL(this.NK_STORE_URL_REQUEST,"_blank");
      }
      
      private function onCancelButtonClicked() : void
      {
         hide();
      }
      
      override public function reveal(param1:Number = 1) : void
      {
         this.configureKong();
         super.reveal(param1);
      }
      
      private function configureKong() : void
      {
         if(Kong.isOnKong())
         {
            this._clip.coins1.gotoAndStop(2);
            this._clip.coins2.gotoAndStop(2);
            this._clip.titleField.text = "You are Out of Kreds!";
            this._clip.messageField.text = "Purchase more Kreds to continue!";
         }
         else
         {
            this._clip.coins1.gotoAndStop(1);
            this._clip.coins2.gotoAndStop(1);
            this._clip.titleField.text = "You are Out of Coins!";
            this._clip.messageField.text = "Purchase more Coins to continue!";
         }
      }
   }
}
