package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.town.BuildClockDamagedClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   
   public class DamageClock extends Clock
   {
       
      
      public function DamageClock(param1:ClockManager, param2:Function, param3:Building, param4:int)
      {
         _clip = new BuildClockDamagedClip();
         super(param1,param2,param3,param4);
      }
      
      override public function simulateClick() : void
      {
         DamageClockManager(manager).userClickedDamageClockSignal.dispatch(this);
      }
      
      override protected function onRollover(param1:MouseEvent) : void
      {
         super.onRollover(param1);
         _completeNowPopup.setCost(getBloonstonesRequiredToSkip());
      }
      
      override public function populateFromSaveDefinition(param1:ClockSaveDefinition) : void
      {
         super.populateFromSaveDefinition(param1);
      }
   }
}
