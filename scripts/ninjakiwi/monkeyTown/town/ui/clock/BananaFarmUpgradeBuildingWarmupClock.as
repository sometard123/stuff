package ninjakiwi.monkeyTown.town.ui.clock
{
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   
   public class BananaFarmUpgradeBuildingWarmupClock extends UpgradeBuildingWarmupClock
   {
       
      
      private var popupWrapper:Sprite;
      
      public function BananaFarmUpgradeBuildingWarmupClock(param1:ClockManager, param2:Function, param3:UpgradeableBuilding, param4:int)
      {
         this.popupWrapper = new Sprite();
         super(param1,param2,param3,param4);
      }
   }
}
