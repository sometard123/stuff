package ninjakiwi.monkeyTown.town.data.definitions
{
   public class TerrainDefinition
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var levelModifier:int;
      
      public var edgeSetID:String;
      
      public var groundType:String;
      
      public var minimumOnMap:int;
      
      public var maximumOnMap:int;
      
      public function TerrainDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : TerrainDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : TerrainDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function LevelModifier(param1:int) : TerrainDefinition
      {
         this.levelModifier = param1;
         return this;
      }
      
      public function EdgeSetID(param1:String) : TerrainDefinition
      {
         this.edgeSetID = param1;
         return this;
      }
      
      public function GroundType(param1:String) : TerrainDefinition
      {
         this.groundType = param1;
         return this;
      }
      
      public function MinimumOnMap(param1:int) : TerrainDefinition
      {
         this.minimumOnMap = param1;
         return this;
      }
      
      public function MaximumOnMap(param1:int) : TerrainDefinition
      {
         this.maximumOnMap = param1;
         return this;
      }
   }
}
