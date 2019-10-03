package ninjakiwi.monkeyTown.town.ui.clock
{
   import flash.display.DisplayObjectContainer;
   import org.osflash.signals.Signal;
   
   public class DamageClockManager extends ClockManager
   {
       
      
      public var userClickedDamageClockSignal:Signal;
      
      public function DamageClockManager(param1:DisplayObjectContainer)
      {
         this.userClickedDamageClockSignal = new Signal(DamageClock);
         super(param1);
      }
   }
}
