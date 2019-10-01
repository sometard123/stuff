package ninjakiwi.monkeyTown.ui
{
   import assets.ui.ConfirmPurchasePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class ConfirmPurchasePanel extends HideRevealViewPopup
   {
       
      
      private var _clip:ConfirmPurchasePanelClip;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _buildingDefinition:MonkeyTownBuildingDefinition;
      
      public function ConfirmPurchasePanel(param1:DisplayObjectContainer)
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
      
      public function updateInfoForBuilding(param1:MonkeyTownBuildingDefinition) : void
      {
         this._buildingDefinition = param1;
         this._clip.costField.text = this._buildingDefinition.nkCoinCost.toString();
         this._clip.messageTxt.text = LocalisationConstants.PREMIUM_PURCHASE.split("<name>").join(this._buildingDefinition.name);
      }
      
      private function onBuyButtonClicked() : void
      {
         PremiumBuildingManager.getInstance().buyPremiumBuilding(this._buildingDefinition.nkItemID,this._buildingDefinition.id);
         hide();
      }
      
      private function onCancelButtonClicked() : void
      {
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
