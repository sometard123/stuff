package ninjakiwi.monkeyTown.btdModule.levels
{
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.Grass1Def;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.LevelDef;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class LevelDefFactory
   {
      
      public static const instance:LevelDefFactory = new LevelDefFactory();
      
      {
         validateLevelDefData();
      }
      
      public function LevelDefFactory()
      {
         super();
      }
      
      private static function validateLevelDefData() : void
      {
         var key:String = null;
         var list:Array = null;
         var className:String = null;
         var allTerrains:Array = LevelDefData.getAllTerrains();
         var i:int = 0;
         while(i < allTerrains.length)
         {
            className = "ninjakiwi.monkeyTown.btdModule.levels.levelDefs." + allTerrains[i];
            try
            {
               getDefinitionByName(className) as Class;
            }
            catch(e:Error)
            {
               t.obj(e);
            }
            i++;
         }
      }
      
      public function getLevelDef(param1:BTDGameRequest) : LevelDef
      {
         var levelDef:LevelDef = null;
         var levelDefClassName:String = null;
         var levelDefClass:Class = null;
         var defData:Object = null;
         var numberOfDefs:int = 0;
         var qualifiedClassName:String = null;
         var gameRequest:BTDGameRequest = param1;
         var possibleLevelDefNames:Array = LevelDefData.getLevelDefNamesByTerrain(gameRequest.terrainType,gameRequest.cityIndex);
         var defIndex:int = 0;
         if(possibleLevelDefNames !== null)
         {
            numberOfDefs = possibleLevelDefNames.length;
            if(gameRequest.tileUniqueData.trackID === -1)
            {
               defData = LevelDefData.selectRandomTrackByDifficultyBias(possibleLevelDefNames,gameRequest.trackSelectionBias);
               defIndex = defData.index;
               gameRequest.tileUniqueData.trackID = defIndex;
            }
            else
            {
               defIndex = gameRequest.tileUniqueData.trackID;
            }
            if(defIndex >= possibleLevelDefNames.length)
            {
               defIndex = possibleLevelDefNames.length - 1;
            }
            levelDefClassName = possibleLevelDefNames[defIndex];
            try
            {
               qualifiedClassName = "ninjakiwi.monkeyTown.btdModule.levels.levelDefs." + levelDefClassName;
               levelDefClass = getDefinitionByName(qualifiedClassName) as Class;
            }
            catch(e:Error)
            {
               t.obj(e);
            }
            levelDef = new (levelDefClass as Class)();
            gameRequest.tileUniqueData.trackClassName = levelDef.assetClassName.split(".").pop();
         }
         else
         {
            levelDef = new Grass1Def();
         }
         return levelDef;
      }
   }
}
