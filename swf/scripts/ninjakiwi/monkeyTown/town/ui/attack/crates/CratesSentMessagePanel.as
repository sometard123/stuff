package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import assets.ui.SupplyDropSentPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class CratesSentMessagePanel extends HideRevealView
   {
       
      
      private var _clip:SupplyDropSentPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public function CratesSentMessagePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new SupplyDropSentPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.coolButton);
         super(param1,param2);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
         addChild(this._clip);
      }
   }
}
