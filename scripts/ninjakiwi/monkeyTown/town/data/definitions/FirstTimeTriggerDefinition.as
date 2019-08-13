package ninjakiwi.monkeyTown.town.data.definitions
{
   public class FirstTimeTriggerDefinition
   {
       
      
      public var id:String;
      
      public var sequence:Array;
      
      public var eventText:Array;
      
      public var buttonTypes:Array;
      
      public function FirstTimeTriggerDefinition()
      {
         this.sequence = [];
         this.eventText = [];
         this.buttonTypes = [];
         super();
      }
      
      public function Id(param1:String) : FirstTimeTriggerDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Sequence(param1:Array) : FirstTimeTriggerDefinition
      {
         this.sequence = param1;
         return this;
      }
      
      public function EventText(param1:Array) : FirstTimeTriggerDefinition
      {
         this.eventText = param1;
         return this;
      }
      
      public function ButtonTypes(param1:Array) : FirstTimeTriggerDefinition
      {
         this.buttonTypes = param1;
         return this;
      }
   }
}
