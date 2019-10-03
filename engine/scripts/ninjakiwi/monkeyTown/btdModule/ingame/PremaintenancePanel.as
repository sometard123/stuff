package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.MaintenanceScheduledMessageClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PremaintenancePanel extends HideRevealViewSimple
   {
       
      
      private var _clip:MaintenanceScheduledMessageClip;
      
      private var _okButton:ButtonControllerBase;
      
      public function PremaintenancePanel(param1:DisplayObjectContainer)
      {
         this._clip = new MaintenanceScheduledMessageClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1);
         addChild(this._clip);
         this._okButton.setClickFunction(this.hide);
         this._clip.x = Main.mapArea.width * 0.5 - this._clip.width * 0.5;
         this._clip.y = Main.mapArea.height * 0.5 - this._clip.height * 0.5;
      }
      
      public function popUp() : void
      {
         TowerPlace.blockTowerPlacing = true;
         this.reveal();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         TowerPlace.blockTowerPlacing = false;
      }
   }
}
