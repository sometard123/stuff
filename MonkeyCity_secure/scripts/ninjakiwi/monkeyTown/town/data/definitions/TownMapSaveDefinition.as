package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.town.terrainGenerator.WorldSeed;
   
   public class TownMapSaveDefinition
   {
       
      
      public var worldSeed:WorldSeed = null;
      
      public var tileSaveDefinitions:Vector.<TileSaveDefinition> = null;
      
      public var terrainData:String = null;
      
      public function TownMapSaveDefinition()
      {
         super();
      }
   }
}
