package ninjakiwi.monkeyTown.btdModule.data
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class Unique extends EventDispatcher
   {
       
      
      private var id_ = null;
      
      public function Unique(param1:* = null)
      {
         super();
         this.id = param1;
      }
      
      public function set id(param1:String) : void
      {
         if(this.id_ != param1)
         {
            this.id_ = param1;
            dispatchEvent(new PropertyModEvent("id"));
         }
      }
      
      public function get id() : String
      {
         return this.id_;
      }
      
      public function Id(param1:String) : Unique
      {
         this.id = param1;
         return this;
      }
   }
}
