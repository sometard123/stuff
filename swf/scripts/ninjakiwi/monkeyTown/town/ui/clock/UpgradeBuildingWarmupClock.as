package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.town.WarmupClockClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   
   public class UpgradeBuildingWarmupClock extends Clock
   {
       
      
      public var targetPath:UpgradePathStateDefinition = null;
      
      public var upgradeableTarget:UpgradeableBuilding = null;
      
      public function UpgradeBuildingWarmupClock(param1:ClockManager, param2:Function, param3:UpgradeableBuilding, param4:int)
      {
         _clip = new WarmupClockClip();
         this.upgradeableTarget = param3;
         super(param1,param2,param3,param4);
      }
      
      override public function simulateClick() : void
      {
         UpgradeBuildingWarmupClockManager(manager).userClickedUpgradeClockSignal.dispatch(this);
      }
      
      override protected function onRollover(param1:MouseEvent) : void
      {
         super.onRollover(param1);
         setSkipCostText(getBloonstonesRequiredToSkip());
      }
      
      override public function update(param1:Number, param2:Number = 1.0) : void
      {
         super.update(param1,GameMods.getModifier(GameModConstants.UPGRADE_SPEED_MOD));
      }
   }
}
