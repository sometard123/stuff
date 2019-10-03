package ninjakiwi.monkeyTown.ui
{
   import assets.ui.BloonstonesStorePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class BuyBloonstonesPanel extends HideRevealView
   {
       
      
      private var _clip:BloonstonesStorePanelClip;
      
      private var _buttonBS250:ButtonControllerBase;
      
      private var _buttonBS550:ButtonControllerBase;
      
      private var _buttonBS1200:ButtonControllerBase;
      
      private var _buttonBS3250:ButtonControllerBase;
      
      private var _buttonStarterPack:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _allButtons:Array;
      
      public function BuyBloonstonesPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         isModal = true;
         this.immediateInitialise();
      }
      
      private function immediateInitialise() : void
      {
         Premium.showInGameBloonstonesPanel.add(this.onShowPanelSignal);
      }
      
      override protected function lazyInitialise() : void
      {
         if(_hasBeenLazyInitialised)
         {
            return;
         }
         super.lazyInitialise();
         this._clip = new BloonstonesStorePanelClip();
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._buttonBS250 = new ButtonControllerBase(this._clip.premiumBuyContainer0.buyButton);
         this._buttonBS550 = new ButtonControllerBase(this._clip.premiumBuyContainer1.buyButton);
         this._buttonBS1200 = new ButtonControllerBase(this._clip.premiumBuyContainer2.buyButton);
         this._buttonBS3250 = new ButtonControllerBase(this._clip.premiumBuyContainer3.buyButton);
         this._buttonStarterPack = new ButtonControllerBase(this._clip.premiumBuyContainer4.buyButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._buttonBS250.setClickFunction(this.onButtonClicked,false,true);
         this._buttonBS550.setClickFunction(this.onButtonClicked,false,true);
         this._buttonBS1200.setClickFunction(this.onButtonClicked,false,true);
         this._buttonBS3250.setClickFunction(this.onButtonClicked,false,true);
         this._buttonStarterPack.setClickFunction(this.onButtonClicked,false,true);
         this._closeButton.setClickFunction(hide);
         this._clip.premiumBuyContainer0.costField.text = "50";
         this._clip.premiumBuyContainer1.costField.text = "100";
         this._clip.premiumBuyContainer2.costField.text = "200";
         this._clip.premiumBuyContainer3.costField.text = "500";
         this._clip.premiumBuyContainer4.costField.text = "50";
         this._allButtons = [this._buttonBS250,this._buttonBS550,this._buttonBS1200,this._buttonBS3250,this._buttonStarterPack];
      }
      
      private function onShowPanelSignal() : void
      {
         PanelManager.getInstance().showFreePanel(this);
      }
      
      private function onButtonClicked(param1:ButtonControllerBase) : void
      {
         switch(param1)
         {
            case this._buttonBS250:
               Premium.getInstance().showStore([Premium.PILE_OF_BLOONSTONES_ID]);
               break;
            case this._buttonBS550:
               Premium.getInstance().showStore([Premium.BASKET_OF_BLOONSTONES_ID]);
               break;
            case this._buttonBS1200:
               Premium.getInstance().showStore([Premium.CHEST_OF_BLOONSTONES_ID]);
               break;
            case this._buttonBS3250:
               Premium.getInstance().showStore([Premium.MOUNTAIN_OF_BLOONSTONES_ID]);
               break;
            case this._buttonStarterPack:
               Premium.getInstance().showStore([Premium.STARTER_PACK_ID]);
         }
         hide();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         this.lazyInitialise();
         this.configureCurrencyIcon();
         this.setStarterPackAlreadyPurchasedState();
         super.reveal(param1);
      }
      
      private function setStarterPackAlreadyPurchasedState() : void
      {
         var _loc1_:Boolean = Premium.getInstance().isStarterPackPurchased();
         if(_loc1_)
         {
            this._buttonStarterPack.disableMouseInteraction();
            this._buttonStarterPack.lock();
            this._clip.purchasedOverlay.visible = true;
         }
         else
         {
            this._buttonStarterPack.enableMouseInteraction();
            this._buttonStarterPack.unlock();
            this._clip.purchasedOverlay.visible = false;
         }
      }
      
      private function configureCurrencyIcon() : void
      {
         var _loc1_:int = !!Kong.isOnKong()?2:1;
         this._clip.premiumBuyContainer0.currencyIcon.gotoAndStop(_loc1_);
         this._clip.premiumBuyContainer1.currencyIcon.gotoAndStop(_loc1_);
         this._clip.premiumBuyContainer2.currencyIcon.gotoAndStop(_loc1_);
         this._clip.premiumBuyContainer3.currencyIcon.gotoAndStop(_loc1_);
         this._clip.premiumBuyContainer4.currencyIcon.gotoAndStop(_loc1_);
      }
   }
}
