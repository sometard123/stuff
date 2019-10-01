package ninjakiwi.monkeyTown.sound
{
   import flash.utils.Dictionary;
   
   public class EventFrequencyLimiter
   {
       
      
      private var _events:Dictionary;
      
      public function EventFrequencyLimiter()
      {
         this._events = new Dictionary();
         super();
      }
      
      public function permit(param1:*, param2:int) : Boolean
      {
         if(!this._events[param1])
         {
            return false;
         }
         var _loc3_:LimitedEvent = this._events[param1];
         if(param2 == _loc3_.timeOfLastEvent)
         {
            if(_loc3_.simultaneousEvents < _loc3_.maximumSimultaneousEvents)
            {
               _loc3_.simultaneousEvents++;
               _loc3_.timeOfLastEvent = param2;
               return true;
            }
         }
         else
         {
            _loc3_.simultaneousEvents = 0;
         }
         if(param2 - _loc3_.eventDuration > _loc3_.timeOfLastEvent)
         {
            _loc3_.timeOfLastEvent = param2;
            return true;
         }
         return false;
      }
      
      public function registerEvent(param1:*, param2:int, param3:int) : void
      {
         this._events[param1] = new LimitedEvent(param1,param2,param3);
      }
   }
}

class LimitedEvent
{
    
   
   public var id;
   
   public var timeOfLastEvent:int = 0;
   
   public var simultaneousEvents:int = 0;
   
   public var maximumSimultaneousEvents:int;
   
   public var eventDuration:Number;
   
   function LimitedEvent(param1:*, param2:int, param3:Number)
   {
      super();
      this.id = param1;
      this.maximumSimultaneousEvents = param2;
      this.eventDuration = param3;
   }
}
