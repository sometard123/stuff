package ninjakiwi.monkeyTown.btdModule.events
{
   import flash.events.Event;
   
   public class PropertyModEvent extends Event
   {
      
      public static const mod:String = "MOD";
       
      
      public var property:String = null;
      
      public function PropertyModEvent(param1:String)
      {
         this.property = param1;
         super(mod);
      }
   }
}
