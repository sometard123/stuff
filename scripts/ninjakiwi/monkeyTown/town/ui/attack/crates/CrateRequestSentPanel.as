package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import assets.ui.SupplyDropRequestSentPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class CrateRequestSentPanel extends HideRevealView
   {
       
      
      private const _clip:SupplyDropRequestSentPanelClip = new SupplyDropRequestSentPanelClip();
      
      private var _okButton:ButtonControllerBase;
      
      public function CrateRequestSentPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      public function init() : void
      {
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton = new ButtonControllerBase(this._clip.coolButton);
         this._okButton.setClickFunction(hide);
      }
   }
}
