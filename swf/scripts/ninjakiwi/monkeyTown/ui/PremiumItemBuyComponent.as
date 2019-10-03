package ninjakiwi.monkeyTown.ui
{
   import assets.town.PremiumBuildBuyItemClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class PremiumItemBuyComponent
   {
       
      
      private var _clip:PremiumBuildBuyItemClip;
      
      private var _container:DisplayObjectContainer;
      
      private var _associatedBuildingDefinition:MonkeyTownBuildingDefinition;
      
      public var _costField:TextField;
      
      public var _buyButton:ButtonControllerBase;
      
      public function PremiumItemBuyComponent(param1:Sprite, param2:BuildPanelItemPremium, param3:MonkeyTownBuildingDefinition)
      {
         super();
         this._container = param1;
         this._associatedBuildingDefinition = param3;
         this.init();
      }
      
      private function init() : void
      {
         this._clip = new PremiumBuildBuyItemClip();
         this._container.addChild(this._clip);
         this._costField = this._clip.costField;
         this._costField.text = this._associatedBuildingDefinition.nkCoinCost.toString();
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         this._buyButton.setClickFunction(this.onBuyButtonClicked);
         this._clip.mouseChildren = true;
         this._buyButton.setOverFunction(function():void
         {
            _buyButton.gotoAndStop(2);
         });
         this._buyButton.setOutFunction(function():void
         {
            _buyButton.gotoAndStop(1);
         });
         this.syncCoinIconToCurrency();
      }
      
      public function syncCoinIconToCurrency() : void
      {
         if(Kong.isOnKong())
         {
            this._clip.currencyIcon.gotoAndStop(2);
         }
         else
         {
            this._clip.currencyIcon.gotoAndStop(1);
         }
      }
      
      private function onBuyButtonClicked() : void
      {
         TownUI.getInstance().confirmPurchasePanel.updateInfoForBuilding(this._associatedBuildingDefinition);
         TownUI.getInstance().confirmPurchasePanel.reveal();
      }
      
      public function get clip() : PremiumBuildBuyItemClip
      {
         return this._clip;
      }
   }
}
