package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class EventsDataDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","priority","typeID","name"];
       
      
      public var id:String;
      
      public var priority:Number;
      
      public var typeID:String;
      
      public var name:String = "";
      
      public function EventsDataDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : EventsDataDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Priority(param1:Number) : EventsDataDefinition
      {
         this.priority = param1;
         return this;
      }
      
      public function TypeID(param1:String) : EventsDataDefinition
      {
         this.typeID = param1;
         return this;
      }
      
      public function Name(param1:String) : EventsDataDefinition
      {
         this.name = param1;
         return this;
      }
   }
}
