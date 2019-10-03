package ninjakiwi.monkeyTown.display.tileSystem.persistence
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   
   public class TileSaveDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["x","y","isCaptured","terrainDefinitionID","buildingSaveDef","features","hasTreasureChest","treasureType","uniqueDataDefinition"];
       
      
      public var x:int;
      
      public var y:int;
      
      public var isCaptured:Boolean = false;
      
      public var terrainDefinitionID:String = null;
      
      public var buildingSaveDef:BuildingSaveDefinition = null;
      
      public var features:Object = null;
      
      public var hasTreasureChest:Boolean = false;
      
      public var treasureType:int = 0;
      
      public var uniqueDataDefinition:TileUniqueDataDefinition = null;
      
      public function TileSaveDefinition()
      {
         super();
      }
      
      public function X(param1:int) : TileSaveDefinition
      {
         this.x = param1;
         return this;
      }
      
      public function Y(param1:int) : TileSaveDefinition
      {
         this.y = param1;
         return this;
      }
      
      public function IsCaptured(param1:Boolean) : TileSaveDefinition
      {
         this.isCaptured = param1;
         return this;
      }
      
      public function TerrainDefinitionID(param1:String) : TileSaveDefinition
      {
         this.terrainDefinitionID = param1;
         return this;
      }
      
      public function BuildingSaveDef(param1:BuildingSaveDefinition) : TileSaveDefinition
      {
         this.buildingSaveDef = param1;
         return this;
      }
      
      public function Features(param1:Object) : TileSaveDefinition
      {
         this.features = param1;
         return this;
      }
      
      public function HasTreasureChest(param1:Boolean) : TileSaveDefinition
      {
         this.hasTreasureChest = param1;
         return this;
      }
      
      public function TreasureType(param1:int) : TileSaveDefinition
      {
         this.treasureType = param1;
         return this;
      }
      
      public function UniqueDataDefinition(param1:TileUniqueDataDefinition) : TileSaveDefinition
      {
         this.uniqueDataDefinition = param1;
         return this;
      }
   }
}
