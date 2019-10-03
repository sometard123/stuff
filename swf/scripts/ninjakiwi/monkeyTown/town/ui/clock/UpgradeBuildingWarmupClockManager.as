package ninjakiwi.monkeyTown.town.ui.clock
{
   import flash.display.DisplayObjectContainer;
   import org.osflash.signals.Signal;
   
   public class UpgradeBuildingWarmupClockManager extends ClockManager
   {
       
      
      public const userClickedUpgradeClockSignal:Signal = new Signal(UpgradeBuildingWarmupClock);
      
      public function UpgradeBuildingWarmupClockManager(param1:DisplayObjectContainer)
      {
         super(param1);
      }
   }
}
