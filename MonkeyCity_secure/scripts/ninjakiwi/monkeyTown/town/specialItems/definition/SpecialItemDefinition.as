package ninjakiwi.monkeyTown.town.specialItems.definition
{
   import ninjakiwi.data.NKDefinition;
   
   public class SpecialItemDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","gameDescription","rarity","chanceRangeStart","maxPerMap","minCityIndex","charges","iconGraphicClass","logic"];
       
      
      public var id:String;
      
      public var name:String;
      
      public var gameDescription:String;
      
      public var rarity:int;
      
      public var chanceRangeStart:int;
      
      public var maxPerMap:int;
      
      public var minCityIndex:int = 0;
      
      public var charges:int = -1;
      
      public var iconGraphicClass:Class;
      
      public var logic:Class;
      
      public function SpecialItemDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : SpecialItemDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : SpecialItemDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function GameDescription(param1:String) : SpecialItemDefinition
      {
         this.gameDescription = param1;
         return this;
      }
      
      public function Rarity(param1:int) : SpecialItemDefinition
      {
         this.rarity = param1;
         return this;
      }
      
      public function ChanceRangeStart(param1:int) : SpecialItemDefinition
      {
         this.chanceRangeStart = param1;
         return this;
      }
      
      public function MaxPerMap(param1:int) : SpecialItemDefinition
      {
         this.maxPerMap = param1;
         return this;
      }
      
      public function MinCityIndex(param1:int) : SpecialItemDefinition
      {
         this.minCityIndex = param1;
         return this;
      }
      
      public function Charges(param1:int) : SpecialItemDefinition
      {
         this.charges = param1;
         return this;
      }
      
      public function IconGraphicClass(param1:Class) : SpecialItemDefinition
      {
         this.iconGraphicClass = param1;
         return this;
      }
      
      public function Logic(param1:Class) : SpecialItemDefinition
      {
         this.logic = param1;
         return this;
      }
   }
}
