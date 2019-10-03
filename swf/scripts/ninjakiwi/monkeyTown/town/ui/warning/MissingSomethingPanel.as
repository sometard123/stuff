package ninjakiwi.monkeyTown.town.ui.warning
{
   import assets.ui.MissingSomethingPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MissingSomethingPanel extends HideRevealViewPopup
   {
      
      public static const TYPE_BUILDING:int = 0;
      
      public static const TYPE_RESEARCH:int = 1;
       
      
      private const _clip:MissingSomethingPanelClip = new MissingSomethingPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function MissingSomethingPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._okButton.setClickFunction(hide);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
      }
      
      public function setMessage(param1:String, param2:int) : void
      {
         if(param2 == TYPE_BUILDING)
         {
            this._clip.bloonInflationAndDeploymentIcon.visible = true;
            this._clip.bloonResearchIcon.visible = false;
         }
         else
         {
            this._clip.bloonInflationAndDeploymentIcon.visible = false;
            this._clip.bloonResearchIcon.visible = true;
         }
         this._clip.description.text = param1;
      }
   }
}
