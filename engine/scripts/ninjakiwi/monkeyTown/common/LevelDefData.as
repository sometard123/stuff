package ninjakiwi.monkeyTown.common
{
   import flash.utils.ByteArray;
   
   public class LevelDefData
   {
      
      private static const TrackDifficultiesCSV:Class = LevelDefData_TrackDifficultiesCSV;
      
      private static var _levelDefNamesByTerrainCity1:Object = {
         Constants.TERRAIN_DESERT.valueOf():["Desert1Def","Desert2Def","Desert3Def","Desert4Def","Desert5Def"],
         Constants.TERRAIN_FOREST.valueOf():["Forest1Def","Forest2Def","Forest3Def","Forest4Def","Forest5Def"],
         Constants.TERRAIN_GRASS.valueOf():["Grass1Def","Grass2Def","Grass3Def","Grass4Def","Grass5Def","Grass6Def"],
         Constants.TERRAIN_HEAVY_FOREST.valueOf():["HeavyForest1Def","HeavyForest2Def","HeavyForest3Def","HeavyForest4Def","HeavyForest5Def"],
         Constants.TERRAIN_HILLS.valueOf():["Hills1Def","Hills2Def","Hills3Def","Hills4Def","Hills5Def"],
         Constants.TERRAIN_JUNGLE.valueOf():["Jungle1Def","Jungle2Def","Jungle3Def","Jungle4Def","Jungle5Def"],
         Constants.TERRAIN_LAKE.valueOf():["Lake1Def","Lake2Def","Lake3Def","Lake4Def","Lake5Def"],
         Constants.TERRAIN_MOUNTAINS.valueOf():["Mountain1Def","Mountain2Def","Mountain3Def","Mountain4Def","Mountain5Def"],
         Constants.TERRAIN_VOLCANO.valueOf():["Volcano1Def","Volcano2Def","Volcano3Def","Volcano4Def"],
         Constants.TERRAIN_SNOW.valueOf():["Snow1Def","Snow2Def","Snow3Def","Snow4Def","Snow5Def"],
         Constants.TERRAIN_RIVER.valueOf():["River1Def","River2Def","River3Def","River4Def","River5Def"],
         Constants.TERRAIN_WATTLE.valueOf():["WattleTreesDef"],
         Constants.TERRAIN_TRANQUIL.valueOf():["TranquilGladeDef"],
         Constants.GLACIER.valueOf():["GlacierDef"],
         Constants.TERRAIN_SHIPWRECK.valueOf():["ShipwreckDef"],
         Constants.STICKY_SAP_PLANT.valueOf():["StickySapDef"],
         Constants.PHASE_CRYSTAL.valueOf():["PhaseCrystal1Def"],
         Constants.TERRAIN_RUINS.valueOf():["Ruins1Def"],
         Constants.MOAB_GRAVEYARD.valueOf():["MOABGraveyardDef"],
         Constants.TERRAIN_CAVE.valueOf():["CaveDef"],
         Constants.TERRAIN_BOSS_VORTEX.valueOf():["VortexDef"],
         Constants.TERRAIN_BOSS_BLOONARIUS.valueOf():["BloonariusDef"],
         Constants.TERRAIN_BOSS_BLASTAPOPOULOS.valueOf():["BlastapopoulosDef"],
         Constants.TERRAIN_BOSS_DREADBLOON.valueOf():["DreadbloonDef"]
      };
      
      private static var _levelDefNamesByTerrainCity2:Object;
      
      public static var trackDifficulties:Object = {};
      
      {
         setUpLevelDifficultiesData();
         function staticInitSecondCityTerrain():void
         {
            var patch:Function = function(param1:String, param2:Array):void
            {
               if(!_levelDefNamesByTerrainCity2.hasOwnProperty(param1))
               {
                  _levelDefNamesByTerrainCity2[param1] = param2;
               }
               else
               {
                  _levelDefNamesByTerrainCity2[param1] = _levelDefNamesByTerrainCity2[param1].concat(param2);
               }
            };
            _levelDefNamesByTerrainCity2 = JSON.parse(JSON.stringify(_levelDefNamesByTerrainCity1));
            patch(Constants.TERRAIN_DESERT.valueOf(),["Desert6Def"]);
            patch(Constants.TERRAIN_GRASS.valueOf(),["Grass7Def"]);
            patch(Constants.TERRAIN_FOREST.valueOf(),["Forest6Def"]);
            patch(Constants.TERRAIN_HEAVY_FOREST.valueOf(),["HeavyForest6Def"]);
            patch(Constants.TERRAIN_HILLS.valueOf(),["Hills6Def"]);
            patch(Constants.TERRAIN_JUNGLE.valueOf(),["Jungle6Def"]);
            patch(Constants.TERRAIN_LAKE.valueOf(),["Lake6Def"]);
            patch(Constants.TERRAIN_MOUNTAINS.valueOf(),["Mountain6Def"]);
            patch(Constants.TERRAIN_VOLCANO.valueOf(),["Volcano5Def"]);
            patch(Constants.TERRAIN_RIVER.valueOf(),["River6Def"]);
            patch(Constants.TERRAIN_DESERT_BADLANDS.valueOf(),["DesertBadlands1Def","DesertBadlands2Def","DesertBadlands3Def","DesertBadlands4Def"]);
            patch(Constants.TERRAIN_DESERT_HIGHLANDS.valueOf(),["DesertHighlands1Def","DesertHighlands2Def","DesertHighlands3Def","DesertHighlands4Def"]);
            patch(Constants.TERRAIN_DESERT_ARID_GRASSLANDS.valueOf(),["DesertGrasslands1Def","DesertGrasslands2Def","DesertGrasslands3Def","DesertGrasslands4Def"]);
            patch(Constants.SANDSTORM.valueOf(),["SandstormDef"]);
            patch(Constants.DRY_AS_A_BONE.valueOf(),["DryAsABoneDef"]);
            patch(Constants.ZZZZOMG.valueOf(),["ZZZZOMGDef"]);
         }();
      }
      
      public function LevelDefData()
      {
         super();
      }
      
      private static function setUpLevelDifficultiesData() : void
      {
         var _loc4_:Array = null;
         var _loc1_:ByteArray = new TrackDifficultiesCSV() as ByteArray;
         var _loc2_:String = _loc1_.readUTFBytes(_loc1_.length);
         var _loc3_:Array = _loc2_.split("\n");
         var _loc5_:int = 2;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_].split(",");
            trackDifficulties["" + _loc4_[0]] = Number(_loc4_[1]);
            _loc5_++;
         }
      }
      
      public static function getLevelDefNamesByTerrain(param1:String, param2:int) : Array
      {
         switch(param2)
         {
            case 0:
            default:
               return _levelDefNamesByTerrainCity1[param1];
            case 1:
               return _levelDefNamesByTerrainCity2[param1];
         }
      }
      
      public static function getAllTerrains() : Array
      {
         var _loc2_:Array = null;
         var _loc1_:Array = [];
         for each(_loc2_ in _levelDefNamesByTerrainCity2)
         {
            _loc1_ = _loc1_.concat(_loc2_);
         }
         return _loc1_;
      }
      
      private static function getSortedTracks(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = Number(trackDifficulties[String(param1[_loc4_])]) || Number(1);
            _loc2_.push({
               "def":param1[_loc4_],
               "trackDifficulty":_loc3_,
               "index":_loc4_
            });
            _loc4_++;
         }
         _loc2_.sortOn(["trackDifficulty","index"],Array.NUMERIC);
         return _loc2_;
      }
      
      public static function getTrackDifficulty(param1:String) : Number
      {
         if(trackDifficulties[param1] != null)
         {
            return trackDifficulties[param1];
         }
         return 1;
      }
      
      public static function getTrackIndex(param1:String, param2:String, param3:int) : int
      {
         var _loc4_:Array = getLevelDefNamesByTerrain(param1,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(param2 == String(_loc4_[_loc5_]))
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return 0;
      }
      
      public static function selectRandomTrackByDifficultyBias(param1:Array, param2:Number) : Object
      {
         var _loc3_:Array = getSortedTracks(param1);
         var _loc4_:int = int(param2 * _loc3_.length);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         else if(_loc4_ > _loc3_.length - 1)
         {
            _loc4_ = _loc3_.length - 1;
         }
         return _loc3_[_loc4_];
      }
      
      public static function getActualTrackDifficultyRating(param1:String, param2:Number, param3:int) : Number
      {
         var _loc7_:String = null;
         var _loc4_:Array = getLevelDefNamesByTerrain(param1,param3);
         if(_loc4_ === null)
         {
            _loc7_ = "LevelDefData::getActualTrackDifficultyRating() - no level definitions for terrain: " + param1;
         }
         var _loc5_:Array = getSortedTracks(_loc4_);
         var _loc6_:int = int(param2 * _loc5_.length);
         return _loc5_[_loc6_].trackDifficulty;
      }
   }
}
