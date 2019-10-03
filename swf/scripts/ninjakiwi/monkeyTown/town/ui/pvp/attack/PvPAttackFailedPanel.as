package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.ui.AttackFailedPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPAttackFailedPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:AttackFailedPanelClip = new AttackFailedPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function PvPAttackFailedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._okButton.setClickFunction(hide);
         this._clip.gotoAndStop(1);
         this.isModal = true;
         this.addChild(this._clip);
      }
      
      public function setState(param1:String) : void
      {
         if(param1 == PvPMain.STATE_PACIFIST)
         {
            this._clip.gotoAndStop(1);
         }
         else if(param1 == PvPMain.STATE_MAXATTACKS)
         {
            this._clip.gotoAndStop(2);
         }
         else if(param1 == PvPMain.STATE_ALREADY)
         {
            this._clip.gotoAndStop(3);
         }
         else
         {
            this._clip.gotoAndStop(4);
         }
      }
   }
}
