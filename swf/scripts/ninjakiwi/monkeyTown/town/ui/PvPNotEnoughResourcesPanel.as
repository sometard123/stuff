package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.PvPNotEnoughResourcesPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPNotEnoughResourcesPanel extends HideRevealView
   {
       
      
      private var _clip:PvPNotEnoughResourcesPanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _requiredBloonstones:int = 0;
      
      private var _videoAdPanelController:VideoAdPanelController;
      
      public function PvPNotEnoughResourcesPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new PvPNotEnoughResourcesPanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         super(param1,param2);
         this.isModal = true;
         this._clip.x = -10;
         this._clip.y = 100;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this._buyButton.setClickFunction(this.onBuyButtonClicked);
         setAutoPlayStopClipsArray([this._clip.gems]);
         this._videoAdPanelController = new VideoAdPanelController(this._clip.watchVideoPanel,this);
      }
      
      private function onCancelButtonClicked() : void
      {
         hide();
      }
      
      private function onBuyButtonClicked() : void
      {
         Premium.getInstance().showStoreForBloonstones();
         hide();
      }
      
      public function setRequiredBloonstones(param1:int, param2:String) : void
      {
         this._requiredBloonstones = param1;
         this._clip.messageField.htmlText = param2;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         this._videoAdPanelController.doVideoAvailableCheck();
      }
   }
}
