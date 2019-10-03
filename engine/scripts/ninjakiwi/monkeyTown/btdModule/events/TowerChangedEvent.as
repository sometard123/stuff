package ninjakiwi.monkeyTown.btdModule.events
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class TowerChangedEvent extends Event
   {
       
      
      public var tower:Tower = null;
      
      public function TowerChangedEvent(param1:String, param2:Tower)
      {
         this.tower = param2;
         super(param1);
      }
   }
}
