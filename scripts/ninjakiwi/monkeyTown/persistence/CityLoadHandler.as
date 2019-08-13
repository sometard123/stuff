package ninjakiwi.monkeyTown.persistence
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.city.CityInfoSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.terrainGenerator.WorldSeed;
   
   public class CityLoadHandler
   {
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static const _resourceStore:ResourceStore = ResourceStore.getInstance();
       
      
      public function CityLoadHandler()
      {
         super();
      }
      
      public static function regenerateCity(param1:Object, param2:Function) : void
      {
         var cityInfo:CityInfoSaveDefinition = null;
         var data:Object = param1;
         var callback:Function = param2;
         var contentObject:Object = data[CityDataPersistence.CONTENT_KEY];
         var cityName:String = data.cityInfo.name;
         cityInfo = data.cityInfo;
         var worldSeed:WorldSeed = contentObject[CityDataPersistence.WORLD_SEED_KEY];
         var upgradeTreeSaveData:Object = contentObject[CityDataPersistence.UPGRADE_TREE_KEY];
         var tileSaveDefinitions:Vector.<TileSaveDefinition> = Vector.<TileSaveDefinition>(contentObject[CityDataPersistence.TILES_KEY]);
         _system.city.setIsActive(false);
         _system.city.name = cityInfo.name;
         _system.city.cityIndex = cityInfo.cityIndex;
         _system.city.populateFromSaveData(cityInfo,upgradeTreeSaveData);
         WorldViewSignals.buildWorldEndSignal.addOnce(function():void
         {
            if(callback != null)
            {
               callback();
            }
            _system.city.setIsActive(true);
         });
         var townMapSaveDefinition:TownMapSaveDefinition = new TownMapSaveDefinition();
         townMapSaveDefinition.worldSeed = worldSeed;
         townMapSaveDefinition.terrainData = data.content.terrainData;
         townMapSaveDefinition.tileSaveDefinitions = tileSaveDefinitions;
         MonkeyCityMain.getInstance().populateFromSaveDefinition(townMapSaveDefinition);
         _system.city.contestedTerritoryData = data.contestedTerritory;
      }
   }
}
