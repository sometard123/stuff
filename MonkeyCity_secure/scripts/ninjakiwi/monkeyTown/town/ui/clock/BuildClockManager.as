package ninjakiwi.monkeyTown.town.ui.clock
{
   import flash.display.DisplayObjectContainer;
   import org.osflash.signals.Signal;
   
   public class BuildClockManager extends ClockManager
   {
       
      
      public var userClickedBuildClockSignal:Signal;
      
      public function BuildClockManager(param1:DisplayObjectContainer)
      {
         this.userClickedBuildClockSignal = new Signal(BuildClock);
         super(param1);
      }
   }
}
