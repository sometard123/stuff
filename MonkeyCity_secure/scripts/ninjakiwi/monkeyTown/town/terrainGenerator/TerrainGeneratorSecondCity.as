package ninjakiwi.monkeyTown.town.terrainGenerator
{
   import com.lgrey.vectors.LGVector2D;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.tile.TileFactory;
   import ninjakiwi.monkeyTown.town.townMap.TilesByType;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import ninjakiwi.monkeyTown.utils.WeightingManager;
   
   public class TerrainGeneratorSecondCity extends TerrainGenerator
   {
       
      
      private var _desertWeights:WeightingManager;
      
      public function TerrainGeneratorSecondCity()
      {
         this._desertWeights = new WeightingManager();
         super();
      }
      
      override public function configureParameters() : void
      {
         super.configureParameters();
         desertMaximumAltitude = 170;
         desertThreshold = 125;
         TileFactory.getInstance().setSecondWorldTileSet();
         doTutorialSetup = false;
         this.initWeights();
      }
      
      private function initWeights() : void
      {
         this._desertWeights.addWeightedItem(tileDefinitions.DESERT,1);
         this._desertWeights.addWeightedItem(tileDefinitions.DESERT_ARID_GRASSLANDS,1);
         this._desertWeights.addWeightedItem(tileDefinitions.DESERT_BADLANDS,1);
         this._desertWeights.addWeightedItem(tileDefinitions.DESERT_HIGHLANDS,1);
      }
      
      override protected function generateDeserts() : void
      {
         var _loc6_:Tile = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         RND.setSeed(_worldSeed.desertSeed);
         var _loc1_:Array = getPerlinNoise(4.5,4.5,2,_worldSeed.desertSeed,0.2);
         var _loc2_:int = 0;
         while(_loc2_ < system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc8_ = 0;
            while(_loc8_ < system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(isInsideVillage(_loc8_,_loc2_) || _map.tileAt(_loc8_,_loc2_).type == tileDefinitions.RIVER))
               {
                  _loc9_ = getAltitude(_loc8_,_loc2_);
                  if(!(_loc9_ > desertMaximumAltitude || _map.tileAt(_loc8_,_loc2_).type == tileDefinitions.LAKE))
                  {
                     _loc10_ = _loc1_[_loc8_ + _loc2_ * system.TOWN_MAP_WIDTH_GRIDSPACE];
                     if(_loc10_ > desertThreshold)
                     {
                        _map.setTileOfType(this._desertWeights.getRandomItem(),_loc8_,_loc2_);
                     }
                  }
               }
               _loc8_++;
            }
            _loc2_++;
         }
         var _loc3_:LGVector2D = new LGVector2D(villagePosition.x + 1,villagePosition.y + 1);
         var _loc4_:LGVector2D = new LGVector2D();
         var _loc5_:IntPoint2D = new IntPoint2D();
         var _loc7_:int = 0;
         while(_loc7_ < 150)
         {
            _loc4_.set(1 + RND.nextNumber() * 4,0);
            _loc4_.setAngleDeg(RND.nextNumber() * 360);
            _loc5_.set(_loc3_.x + _loc4_.x,_loc3_.y + _loc4_.y);
            if(!isInsideVillage(_loc5_.x,_loc5_.y))
            {
               _loc6_ = _map.tileAtPoint(_loc5_);
               if(_loc6_.type !== tileDefinitions.DESERT && _loc6_.type !== tileDefinitions.RIVER)
               {
                  _map.setTileOfType(this._desertWeights.getRandomItem(),_loc5_.x,_loc5_.y);
               }
            }
            _loc7_++;
         }
      }
      
      override protected function getSpecialTerrainPropertyTasks(param1:TilesByType, param2:int) : Array
      {
         return super.getSpecialTerrainPropertyTasks(param1,param2).concat([{
            "propertyDefinition":tileDefinitions.SANDSTORM_DEFINITION,
            "terrainTiles":param1.desertAridGrasslands,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":tileDefinitions.DRY_AS_A_BONE_DEFINITION,
            "terrainTiles":param1.desertBadlands,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":tileDefinitions.ZZZOMG_DEFINITION,
            "terrainTiles":param1.desertHighlands,
            "defaultMinDistance":param2
         }]);
      }
   }
}
