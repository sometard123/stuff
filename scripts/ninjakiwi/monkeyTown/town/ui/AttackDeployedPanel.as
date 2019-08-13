package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.AttackDeployedClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class AttackDeployedPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:AttackDeployedClip = new AttackDeployedClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function AttackDeployedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
      }
   }
}
