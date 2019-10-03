package ninjakiwi.monkeyTown.data
{
   import ninjakiwi.data.GoogleSpreadsheetTool;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.PopulationData;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   
   public class TerrainTowerRestrictionsData
   {
      
      private static var _data:Object;
      
      private static var _hasBeenInitialised:Boolean = false;
      
      private static var _buildingData:BuildingData = BuildingData.getInstance();
       
      
      public function TerrainTowerRestrictionsData()
      {
         super();
      }
      
      public static function processData(param1:Object) : void
      {
         var item:Object = null;
         var terrainKey:String = null;
         var transformedData:Object = null;
         var pairs:Array = null;
         var pair:Array = null;
         var key:String = null;
         var i:int = 0;
         var data:Object = param1;
         for(terrainKey in data)
         {
            try
            {
               transformedData = {};
               pairs = data[terrainKey].costModifiers.split(";");
               i = 0;
               while(i < pairs.length)
               {
                  pair = pairs[i].split(":");
                  key = pair[0];
                  transformedData[key] = Number(GoogleSpreadsheetTool.coerceValue(pair[1],Number));
                  i++;
               }
               data[terrainKey].costModifiers = transformedData;
            }
            catch(err:Error)
            {
               data[terrainKey].costModifiers = {};
            }
            try
            {
               data[terrainKey].disallowed = data[terrainKey].disallowed.split(";");
            }
            catch(err:Error)
            {
               data[terrainKey].costModifiers = [];
               continue;
            }
         }
         _data = data;
         _hasBeenInitialised = true;
      }
      
      public static function isTowerAllowedForTerrain(param1:String, param2:String) : Boolean
      {
         if(!_hasBeenInitialised)
         {
            return true;
         }
         var _loc3_:Object = _data[param1];
         if(_loc3_ === null)
         {
            return true;
         }
         var _loc4_:Array = _loc3_.disallowed;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] === param2)
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public static function getCostModifierForTerrainAndTower(param1:String, param2:String) : Number
      {
         var _loc3_:Number = 1;
         if(!_hasBeenInitialised)
         {
            return _loc3_;
         }
         var _loc4_:Object = _data[param1];
         if(_loc4_ === null)
         {
            return _loc3_;
         }
         var _loc5_:Object = _loc4_.costModifiers;
         if(_loc5_.hasOwnProperty(param2) && _loc5_[param2] is Number)
         {
            return _loc5_[param2];
         }
         return 1;
      }
      
      public static function getTowerTerrainReport(param1:String) : Object
      {
         var _loc5_:PopulationDefinition = null;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc2_:Object = {
            "restricted":[],
            "favored":[]
         };
         var _loc3_:Array = PopulationData.getInstance().populationDefinitions;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = getCostModifierForTerrainAndTower(param1,_loc5_.id);
            if(_loc6_ < 1)
            {
               _loc2_.favored.push(_loc5_);
            }
            _loc7_ = isTowerAllowedForTerrain(param1,_loc5_.id);
            if(!_loc7_)
            {
               _loc2_.restricted.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
