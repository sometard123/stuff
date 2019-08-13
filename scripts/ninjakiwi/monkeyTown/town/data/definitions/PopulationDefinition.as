package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class PopulationDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","iconClass","populationCount","populationCountString"];
       
      
      public var id:String;
      
      public var name:String;
      
      public var iconClass:Class;
      
      public var populationCount:int = 1;
      
      public var populationCountString:String = "one";
      
      public function PopulationDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : PopulationDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : PopulationDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function IconClass(param1:Class) : PopulationDefinition
      {
         this.iconClass = param1;
         return this;
      }
      
      public function PopulationCount(param1:int) : PopulationDefinition
      {
         this.populationCount = param1;
         return this;
      }
      
      public function PopulationCountString(param1:String) : PopulationDefinition
      {
         this.populationCountString = param1;
         return this;
      }
   }
}
