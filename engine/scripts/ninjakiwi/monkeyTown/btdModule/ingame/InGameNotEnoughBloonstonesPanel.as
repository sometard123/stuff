package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.PvPNotEnoughResourcesPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class InGameNotEnoughBloonstonesPanel extends HideRevealViewSimple
   {
       
      
      private var _clip:PvPNotEnoughResourcesPanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _requiredBloonstones:int = 0;
      
      private var _parentPanel:HideRevealViewSimple;
      
      public function InGameNotEnoughBloonstonesPanel(param1:DisplayObjectContainer, param2:HideRevealViewSimple, param3:* = null)
      {
         this._clip = new PvPNotEnoughResourcesPanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         this._parentPanel = param2;
         super(param1);
         this._clip.x = -50;
         this._clip.y = 66;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this._buyButton.setClickFunction(this.onBuyButtonClicked);
         setAutoPlayStopClipsArray([this._clip.gems]);
      }
      
      private function onCancelButtonClicked() : void
      {
         this.hide();
      }
      
      private function onBuyButtonClicked() : void
      {
         Main.instance.game.openShop.dispatch();
         this.hide();
      }
      
      public function setRequiredBloonstones(param1:int) : void
      {
         this._requiredBloonstones = param1;
         this._clip.messageField.htmlText = LocalisationConstants.BLOONSTONES_FOR_PVP_RETRY.split("<bloonstones>").join(String(this._requiredBloonstones));
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         if(this._parentPanel != null)
         {
            this._parentPanel.hide();
         }
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         if(this._parentPanel != null)
         {
            this._parentPanel.reveal();
         }
      }
      
      public function hideWithoutPoppingUpParent(param1:Number = 0.5) : void
      {
         super.hide(param1);
      }
      
      public function get requiredBloonstones() : int
      {
         return this._requiredBloonstones;
      }
      
      public function set parentPanel(param1:HideRevealViewSimple) : void
      {
         this._parentPanel = param1;
      }
   }
}
