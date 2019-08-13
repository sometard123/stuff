package ninjakiwi.monkeyTown.town.data.definitions
{
   public class TerrainSpecialPropertyDefinition
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var terrainType:String;
      
      public var description:String;
      
      public var quantityPerMap:int;
      
      public var levelModifier:int;
      
      public var graphicClass:String;
      
      public function TerrainSpecialPropertyDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : TerrainSpecialPropertyDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : TerrainSpecialPropertyDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function TerrainType(param1:String) : TerrainSpecialPropertyDefinition
      {
         this.terrainType = param1;
         return this;
      }
      
      public function Description(param1:String) : TerrainSpecialPropertyDefinition
      {
         this.description = param1;
         return this;
      }
      
      public function QuantityPerMap(param1:int) : TerrainSpecialPropertyDefinition
      {
         this.quantityPerMap = param1;
         return this;
      }
      
      public function LevelModifier(param1:int) : TerrainSpecialPropertyDefinition
      {
         this.levelModifier = param1;
         return this;
      }
      
      public function GraphicClass(param1:String) : TerrainSpecialPropertyDefinition
      {
         this.graphicClass = param1;
         return this;
      }
   }
}
