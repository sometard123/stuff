package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui
{
   import assets.ui.BloonBeaconVictoryPanelClip;
   import flash.display.DisplayObjectContainer;
   
   public class BloonBeaconVictoryPanel extends BloonBeaconRechargePanel
   {
       
      
      public function BloonBeaconVictoryPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2,false);
         _clip = new BloonBeaconVictoryPanelClip();
         init(param1);
      }
      
      override protected function onCancelClick() : void
      {
         super.onCancelClick();
      }
      
      override protected function updateCost() : void
      {
      }
   }
}
