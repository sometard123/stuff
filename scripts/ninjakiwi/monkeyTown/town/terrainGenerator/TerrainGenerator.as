package ninjakiwi.monkeyTown.town.terrainGenerator
{
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainSpecialPropertyDefinition;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.tile.TileFactory;
   import ninjakiwi.monkeyTown.town.tileProps.RiverTileSet;
   import ninjakiwi.monkeyTown.town.townMap.TilesByType;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import ninjakiwi.monkeyTown.utils.Perlin;
   import ninjakiwi.monkeyTown.utils.Random;
   
   public class TerrainGenerator
   {
      
      public static const DEBUG_FEEDBACK:Boolean = true;
       
      
      public var riverTileSet:RiverTileSet;
      
      protected var _altitudeMap:Array;
      
      protected var _map:TownMap = null;
      
      public var treeThreshold:int;
      
      public var heavyTreeThreshold:int;
      
      public var hillsMinimumAltitude:int;
      
      public var mountainMinimumAltitude:int;
      
      public var volcanoMinimumAltitude:int;
      
      public var desertMaximumAltitude:int;
      
      public var desertThreshold:int;
      
      public var snowThreshold:int;
      
      public var jungleThreshold:int;
      
      public var lakeLowAltitudeMinimum:int;
      
      public var lakeLowAltitudeMaximum:int;
      
      public var lakeHighAltitudeMinimum:int;
      
      public var lakeHighAltitudeMaximum:int;
      
      public var villagePosition:IntPoint2D;
      
      public var postGenerateCallbackFunction:Function;
      
      protected var _seedReadIndex:int = 0;
      
      protected var _worldSeed:WorldSeed;
      
      protected var _creatingNewWorld:Boolean = true;
      
      protected const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public const system:MonkeySystem = MonkeySystem.getInstance();
      
      protected const _buildingData:BuildingData = BuildingData.getInstance();
      
      public const tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      protected const RUINS_MIN_DISTANCE_TO_CENTER:Number = 7;
      
      protected const PROBABILITY_OF_SPECIAL_MOD_TILE:Number = 0.2;
      
      protected var doTutorialSetup:Boolean = false;
      
      protected var _villageWidth:int = 3;
      
      protected var _villageHeight:int = 3;
      
      protected const RND:Random = this._system.RND;
      
      protected var _offsets:Array;
      
      protected const terrainsWithoutDifficultyMods:Array = [this.tileDefinitions.GRASS,this.tileDefinitions.FOREST,this.tileDefinitions.HEAVY_FOREST,this.tileDefinitions.MOUNTAINS];
      
      public function TerrainGenerator()
      {
         this.riverTileSet = new RiverTileSet();
         this.villagePosition = new IntPoint2D();
         this._offsets = [new IntPoint2D(0,-1),new IntPoint2D(1,-1),new IntPoint2D(1,0),new IntPoint2D(1,1),new IntPoint2D(0,1),new IntPoint2D(-1,1),new IntPoint2D(-1,0),new IntPoint2D(-1,-1)];
         super();
         this.configureParameters();
      }
      
      public function generateTerrain(param1:TownMap, param2:Function, param3:WorldSeed = null) : WorldSeed
      {
         var _loc4_:uint = 0;
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Generating terrain...");
         this.configureParameters();
         if(param3 !== null)
         {
            this._creatingNewWorld = false;
            this._worldSeed = param3;
            this._worldSeed.randomiseSeeded(this._worldSeed.metaSeed);
         }
         else
         {
            this._creatingNewWorld = true;
            this._worldSeed = new WorldSeed();
            if(this._system.useUserSeed)
            {
               if(this._system.userSeed === 0)
               {
                  this._system.userSeed = 1;
               }
               _loc4_ = this._system.userSeed;
            }
            else
            {
               _loc4_ = Math.random() * int.MAX_VALUE + 1;
            }
            this._worldSeed.randomiseSeeded(_loc4_);
         }
         if(DEBUG_FEEDBACK)
         {
            t.obj(this._worldSeed);
         }
         this.postGenerateCallbackFunction = param2;
         this.villagePosition.set(param1.width * 0.5 - 1,param1.height * 0.5 - 1);
         this._map = param1;
         setTimeout(this.generateStep,16);
         return this._worldSeed;
      }
      
      public function configureParameters() : void
      {
         this.treeThreshold = 125;
         this.heavyTreeThreshold = 160;
         this.hillsMinimumAltitude = 147;
         this.mountainMinimumAltitude = 154;
         this.volcanoMinimumAltitude = 172;
         this.desertMaximumAltitude = 114;
         this.desertThreshold = 149;
         this.snowThreshold = 160;
         this.jungleThreshold = 158;
         this.lakeLowAltitudeMinimum = 68;
         this.lakeLowAltitudeMaximum = 71;
         this.lakeHighAltitudeMinimum = 149;
         this.lakeHighAltitudeMaximum = 152;
         this.doTutorialSetup = true;
         TileFactory.getInstance().setFirstWorldTileSet();
      }
      
      public function setSeed(param1:WorldSeed) : void
      {
         this._worldSeed = param1;
      }
      
      public function setMap(param1:TownMap) : void
      {
         this._map = param1;
      }
      
      protected function generateStep() : void
      {
         var _loc4_:uint = 0;
         var _loc1_:Boolean = false;
         this.generateAltitudeMap();
         this.fillWithGrass();
         this.generateRiver();
         this.generateTrees();
         this.generateHills();
         this.generateJungle();
         this.generateLakes();
         this.generateDeserts();
         this.generateSnow();
         this.makeWorldCorrections();
         this.addDifficultyNoise();
         this.addVariantHints();
         var _loc2_:TilesByType = this._map.getTilesByType();
         var _loc3_:Boolean = this.generateTerrainSpecialProperties(_loc2_);
         if(!DEBUG_FEEDBACK)
         {
         }
         this.addTileExtras();
         if(this._creatingNewWorld)
         {
            _loc1_ = _loc3_ && this.validateWorld();
            if(_loc3_)
            {
            }
         }
         else
         {
            _loc1_ = true;
         }
         if(!_loc1_)
         {
            this._map.clear();
            _loc4_ = Math.random() * int.MAX_VALUE + 1;
            this._worldSeed.randomiseSeeded(_loc4_);
            setTimeout(this.generateStep,16);
         }
         else
         {
            this.generationComplete();
         }
      }
      
      protected function generationComplete() : void
      {
         this.beautify();
         if(this._creatingNewWorld)
         {
            this.addSpecialItems();
         }
         if(this.postGenerateCallbackFunction != null)
         {
            this.postGenerateCallbackFunction();
         }
      }
      
      protected function validateWorld() : Boolean
      {
         var _loc1_:Tile = null;
         var _loc8_:* = null;
         var _loc9_:TerrainDefinition = null;
         var _loc10_:int = 0;
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:int = 0;
         while(_loc3_ < this.tileDefinitions.terrainDefinitions.length)
         {
            _loc2_[this.tileDefinitions.terrainDefinitions[_loc3_]] = 0;
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc10_ = 0;
            while(_loc10_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               _loc1_ = this._map.tileAt(_loc10_,_loc4_);
               _loc2_[_loc1_.terrainDefinition]++;
               _loc10_++;
            }
            _loc4_++;
         }
         var _loc5_:int = 36 * 27;
         var _loc6_:int = this._system.TOWN_MAP_WIDTH_GRIDSPACE * this._system.TOWN_MAP_HEIGHT_GRIDSPACE;
         var _loc7_:Number = _loc5_ / _loc6_;
         for(_loc8_ in _loc2_)
         {
            _loc9_ = _loc8_ as TerrainDefinition;
         }
         for(_loc8_ in _loc2_)
         {
            _loc9_ = _loc8_ as TerrainDefinition;
            if(_loc9_ != this.tileDefinitions.RUINS_DEFINITION)
            {
               if(_loc9_.minimumOnMap > 0 && _loc2_[_loc8_] * _loc7_ < _loc9_.minimumOnMap)
               {
                  return false;
               }
               if(_loc9_.maximumOnMap > 0 && _loc2_[_loc8_] * _loc7_ > _loc9_.maximumOnMap)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function addDifficultyNoise() : void
      {
         var _loc1_:Tile = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         this.RND.setSeed(this._worldSeed.difficultyNoiseSeed);
         var _loc2_:Number = 0;
         var _loc3_:Number = Constants.DIFFICULTY_VARIANCE_EASY_THRESHOLD;
         var _loc4_:Number = 1000;
         var _loc5_:int = 0;
         while(_loc5_ < this._map.height)
         {
            _loc6_ = 0;
            while(_loc6_ < this._map.width)
            {
               _loc1_ = this._map.tileAt(_loc6_,_loc5_);
               _loc2_ = this._map.getNaturalDifficultyAtLocation(_loc6_,_loc5_);
               if(_loc2_ > _loc3_)
               {
                  _loc7_ = Math.max(_loc2_ * 0.1,1);
                  _loc1_.difficultyModifier = Math.round((this.RND.nextNumber() * 2 - 1) * _loc7_);
                  _loc1_.difficultyModifier = Math.round(_loc1_.difficultyModifier * _loc4_) / _loc4_;
                  _loc1_.trackSelectionBias = this.RND.nextNumber();
               }
               else
               {
                  _loc1_.trackSelectionBias = this.RND.nextNumber() * 0.5;
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function addTileExtras() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.RND.setSeed(this._worldSeed.tileExtrasSeed);
         var _loc1_:int = 2;
         _loc2_ = 0;
         while(_loc2_ < this._map.height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._map.width)
            {
               _loc4_ = this._map.tileAt(_loc3_,_loc2_);
               if(_loc4_.terrainSpecialProperty === null && this.RND.nextNumber() < this.PROBABILITY_OF_SPECIAL_MOD_TILE)
               {
                  _loc5_ = int(this.RND.nextNumber() * _loc1_);
                  _loc6_ = this._map.getDifficultyAtTile(_loc4_);
                  switch(_loc5_)
                  {
                     case 0:
                        if(_loc6_ >= Constants.MINIMUM_CAMO_TILE_DIFFICULTY)
                        {
                           _loc4_.isCamoTile = true;
                        }
                        break;
                     case 1:
                        if(_loc6_ >= Constants.MINIMUM_REGEN_TILE_DIFFICULTY)
                        {
                           _loc4_.isRegenTile = true;
                        }
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         this.RND.setSeed(this._worldSeed.tileExtrasSeed);
         _loc2_ = 0;
         while(_loc2_ < this._map.height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._map.width)
            {
               _loc4_ = this._map.tileAt(_loc3_,_loc2_);
               _loc4_.setSeed(this.RND.nextInteger());
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function addVariantHints() : void
      {
         var _loc1_:Tile = null;
         var _loc3_:int = 0;
         this.RND.setSeed(this._worldSeed.variantHintSeed);
         var _loc2_:int = 0;
         while(_loc2_ < this._map.height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._map.width)
            {
               _loc1_ = this._map.tileAt(_loc3_,_loc2_);
               _loc1_.variantHint = this.RND.nextInteger();
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      protected function addSpecialItems() : void
      {
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         this.RND.setSeed(this._worldSeed.specialItemsSeed);
         var _loc1_:IntPoint2D = new IntPoint2D();
         var _loc2_:Tile = null;
         var _loc3_:int = 3;
         var _loc4_:int = 3;
         var _loc5_:int = 3;
         var _loc6_:SpecialItemData = SpecialItemData.getInstance();
         var _loc7_:Array = _loc6_.itemPlacementData.slice();
         var _loc10_:int = this.villagePosition.y - 1;
         _loc9_ = _loc7_[_loc7_.length - 1].ring;
         while(_loc9_ < _loc10_)
         {
            _loc7_.push({
               "ring":_loc9_,
               "type":"item"
            });
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc8_ = _loc7_[_loc9_];
            _loc5_ = _loc8_.ring;
            _loc2_ = null;
            while(!this.tileIsValidSpecialItemLocation(_loc2_))
            {
               if(this.RND.nextNumber() < 0.5)
               {
                  if(this.RND.nextNumber() < 0.5)
                  {
                     _loc1_.x = this.villagePosition.x - _loc5_;
                  }
                  else
                  {
                     _loc1_.x = this.villagePosition.x + _loc5_ + _loc3_ - 1;
                  }
                  _loc1_.y = this.villagePosition.y - _loc5_ + int(this.RND.nextNumber() * (_loc4_ + _loc5_ * 2));
               }
               else
               {
                  if(this.RND.nextNumber() < 0.5)
                  {
                     _loc1_.y = this.villagePosition.y - _loc5_;
                  }
                  else
                  {
                     _loc1_.y = this.villagePosition.y + _loc5_ + _loc4_ - 1;
                  }
                  _loc1_.x = this.villagePosition.x - _loc5_ + int(this.RND.nextNumber() * (_loc3_ + _loc5_ * 2));
               }
               _loc2_ = this._map.tileAt(_loc1_.x,_loc1_.y);
            }
            _loc2_.addTreasureChest(_loc8_.type);
            _loc9_++;
         }
         var _loc11_:int = _loc7_[_loc7_.length - 1].ring;
         var _loc12_:int = this.villagePosition.x - _loc11_ - 1;
         var _loc13_:int = this.villagePosition.x + _loc3_ + _loc11_ + 1;
         var _loc14_:int = this.system.TOWN_MAP_WIDTH_GRIDSPACE - _loc13_;
         var _loc15_:int = _loc12_ - 1;
         var _loc16_:int = _loc14_ > _loc15_?int(_loc15_):int(_loc14_);
         _loc9_ = 0;
         while(_loc9_ < _loc16_)
         {
            if(this.RND.nextNumber() < 0.5)
            {
               _loc17_ = _loc12_ - _loc9_;
            }
            else
            {
               _loc17_ = _loc13_ + _loc9_;
            }
            _loc2_ = null;
            _loc18_ = 0;
            while(!this.tileIsValidSpecialItemLocation(_loc2_))
            {
               _loc18_++;
               if(_loc18_ > 500)
               {
                  break;
               }
               _loc2_ = this._map.tileAt(_loc17_,this.RND.nextInteger(this.system.TOWN_MAP_HEIGHT_GRIDSPACE));
            }
            _loc2_.addTreasureChest(_loc6_.ITEM);
            _loc9_ = _loc9_ + 1;
         }
      }
      
      protected function shuffleArray(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         if(param1.length > 1)
         {
            _loc2_ = param1.length - 1;
            while(_loc2_ > 0)
            {
               _loc3_ = this.RND.nextInteger(param1.length);
               _loc4_ = param1[_loc3_];
               param1[_loc3_] = param1[_loc2_];
               param1[_loc2_] = _loc4_;
               _loc2_--;
            }
         }
      }
      
      public function tileIsValidSpecialItemLocation(param1:Tile) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.type == this.tileDefinitions.RIVER || param1.type == this.tileDefinitions.LAKE || param1.terrainSpecialProperty != null || param1.hasTreasureChest)
         {
            return false;
         }
         if(this.isInsideVillage(param1.positionTilespace.x,param1.positionTilespace.y))
         {
            return false;
         }
         return true;
      }
      
      protected function isInsideVillage(param1:int, param2:int, param3:int = 0) : Boolean
      {
         if(param1 >= this.villagePosition.x - param3 && param1 < this.villagePosition.x + this._villageWidth + param3 * 2 && param2 >= this.villagePosition.y - param3 && param2 < this.villagePosition.y + this._villageHeight + param3 * 2)
         {
            return true;
         }
         return false;
      }
      
      protected function distanceFromVillageEdge(param1:Tile) : int
      {
         this.villagePosition.x = this._map.width * 0.5 - 1;
         this.villagePosition.y = this._map.height * 0.5 - 1;
         if(this.isInsideVillage(param1.positionTilespace.x,param1.positionTilespace.y))
         {
            return -1;
         }
         var _loc2_:int = Math.abs(param1.positionTilespace.x - this.villagePosition.x);
         if(param1.positionTilespace.x > this.villagePosition.x)
         {
            _loc2_ = _loc2_ - this._villageWidth;
         }
         var _loc3_:int = Math.abs(param1.positionTilespace.y - this.villagePosition.y);
         if(param1.positionTilespace.y > this.villagePosition.y)
         {
            _loc3_ = _loc3_ - this._villageHeight;
         }
         return _loc2_ > _loc3_?int(_loc2_):int(_loc3_);
      }
      
      protected function distanceToCenter(param1:int, param2:int) : Number
      {
         var _loc3_:Number = Math.sqrt(Math.pow(param1 - this.villagePosition.x,2) + Math.pow(param2 - this.villagePosition.y,2));
         return _loc3_;
      }
      
      protected function generateAltitudeMap() : void
      {
         this.RND.setSeed(this._worldSeed.altitudeMapSeed);
         this._altitudeMap = this.getPerlinNoise(7,7,3,this._worldSeed.altitudeMapSeed);
      }
      
      protected function getAltitude(param1:int, param2:int) : int
      {
         return this._altitudeMap[param1 + param2 * this.system.TOWN_MAP_WIDTH_GRIDSPACE];
      }
      
      protected function fillWithGrass() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc2_ = 0;
            while(_loc2_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               this._map.setTileOfType(this.tileDefinitions.GRASS,_loc2_,_loc1_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function generateTrees() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.RND.setSeed(this._worldSeed.treeSeed);
         var _loc1_:Array = this.getPerlinNoise(3.5,3.5,2,this._worldSeed.treeSeed);
         var _loc2_:int = 0;
         while(_loc2_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc3_ = 0;
            while(_loc3_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(this.isInsideVillage(_loc3_,_loc2_) || this._map.tileAt(_loc3_,_loc2_).type == this.tileDefinitions.RIVER))
               {
                  _loc4_ = _loc1_[_loc3_ + _loc2_ * this.system.TOWN_MAP_WIDTH_GRIDSPACE];
                  if(_loc4_ > this.heavyTreeThreshold)
                  {
                     this._map.setTileOfType(this.tileDefinitions.HEAVY_FOREST,_loc3_,_loc2_);
                  }
                  else if(_loc4_ > this.treeThreshold)
                  {
                     this._map.setTileOfType(this.tileDefinitions.FOREST,_loc3_,_loc2_);
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      protected function generateHills() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.RND.setSeed(this._worldSeed.hillSeed);
         var _loc1_:int = 0;
         while(_loc1_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc2_ = 0;
            while(_loc2_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(this.isInsideVillage(_loc2_,_loc1_) || this._map.tileAt(_loc2_,_loc1_).type == this.tileDefinitions.RIVER))
               {
                  _loc3_ = this.getAltitude(_loc2_,_loc1_);
                  if(_loc3_ > this.volcanoMinimumAltitude)
                  {
                     this._map.setTileOfType(this.tileDefinitions.VOLCANO,_loc2_,_loc1_);
                  }
                  else if(_loc3_ > this.mountainMinimumAltitude)
                  {
                     this._map.setTileOfType(this.tileDefinitions.MOUNTAINS,_loc2_,_loc1_);
                  }
                  else if(_loc3_ > this.hillsMinimumAltitude)
                  {
                     this._map.setTileOfType(this.tileDefinitions.HILLS,_loc2_,_loc1_);
                  }
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function generateSnow() : void
      {
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Tile = null;
         var _loc8_:Boolean = false;
         this.RND.setSeed(this._worldSeed.snowSeed);
         var _loc2_:Vector.<IntPoint2D> = new Vector.<IntPoint2D>(4);
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc2_[_loc3_] = new IntPoint2D();
            _loc3_++;
         }
         _loc2_[0].x = (this.RND.nextInteger(20) + 10) * this.RND.sign();
         _loc2_[0].y = (this.RND.nextInteger(20) + 10) * this.RND.sign();
         _loc2_[0].x = _loc2_[0].x + this.villagePosition.x;
         _loc2_[0].y = _loc2_[0].y + this.villagePosition.y;
         _loc1_ = 1;
         while(_loc1_ < 4)
         {
            _loc2_[_loc1_].x = _loc2_[0].x + (this.RND.nextInteger(3) + 1) * this.RND.sign();
            _loc2_[_loc1_].y = _loc2_[0].y + (this.RND.nextInteger(3) + 1) * this.RND.sign();
            _loc1_++;
         }
         var _loc4_:int = 3;
         var _loc5_:int = 0;
         while(_loc5_ < this._map.height)
         {
            _loc6_ = 0;
            while(_loc6_ < this._map.width)
            {
               _loc7_ = this._map.tileAt(_loc6_,_loc5_);
               if(!(_loc7_ === null || this.isInsideVillage(_loc6_,_loc5_) || this.isNearRiver(_loc6_,_loc5_)))
               {
                  _loc8_ = false;
                  _loc1_ = 0;
                  while(_loc1_ < 4)
                  {
                     if(this.distanceToPoint(_loc6_,_loc5_,_loc2_[_loc1_].x,_loc2_[_loc1_].y) <= _loc4_)
                     {
                        _loc8_ = true;
                     }
                     _loc1_++;
                  }
                  if(_loc8_)
                  {
                     this._map.setTileOfType(this.tileDefinitions.SNOW,_loc6_,_loc5_);
                  }
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      protected function distanceToPoint(param1:int, param2:int, param3:int, param4:int) : Number
      {
         return Math.sqrt((param1 - param3) * (param1 - param3) + (param2 - param4) * (param2 - param4));
      }
      
      protected function generateLakes() : void
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Tile = null;
         this.RND.setSeed(this._worldSeed.lakeSeed);
         var _loc1_:IntPoint2D = new IntPoint2D();
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc6_ = 0;
            while(_loc6_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(this.isInsideVillage(_loc6_,_loc4_) || this.isNearRiver(_loc6_,_loc4_)))
               {
                  _loc7_ = this.getAltitude(_loc6_,_loc4_);
                  if(_loc7_ > this.lakeLowAltitudeMinimum && _loc7_ < this.lakeLowAltitudeMaximum || _loc7_ > this.lakeHighAltitudeMinimum && _loc7_ < this.lakeHighAltitudeMaximum)
                  {
                     _loc3_ = this.generateBlob(_loc6_,_loc4_,5 + this.RND.nextNumber(3));
                     _loc2_.push(_loc3_);
                  }
               }
               _loc6_++;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_];
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc1_ = _loc3_[_loc8_];
               _loc9_ = this._map.tileAt(_loc1_.x,_loc1_.y);
               if(!(this.isInsideVillage(_loc1_.x,_loc1_.y) || this.isNearRiver(_loc1_.x,_loc1_.y)))
               {
                  this._map.setTileOfType(this.tileDefinitions.LAKE,_loc3_[_loc8_].x,_loc3_[_loc8_].y);
               }
               _loc8_++;
            }
            _loc5_++;
         }
      }
      
      protected function generateDeserts() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.RND.setSeed(this._worldSeed.desertSeed);
         var _loc1_:Array = this.getPerlinNoise(4.5,4.5,2,this._worldSeed.desertSeed,0.2);
         var _loc2_:int = 0;
         while(_loc2_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc3_ = 0;
            while(_loc3_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(this.isInsideVillage(_loc3_,_loc2_) || this._map.tileAt(_loc3_,_loc2_).type == this.tileDefinitions.RIVER))
               {
                  _loc4_ = this.getAltitude(_loc3_,_loc2_);
                  if(!(_loc4_ > this.desertMaximumAltitude || this._map.tileAt(_loc3_,_loc2_).type == this.tileDefinitions.LAKE))
                  {
                     _loc5_ = _loc1_[_loc3_ + _loc2_ * this.system.TOWN_MAP_WIDTH_GRIDSPACE];
                     if(_loc5_ > this.desertThreshold)
                     {
                        this._map.setTileOfType(this.tileDefinitions.DESERT,_loc3_,_loc2_);
                     }
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      protected function generateJungle() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.RND.setSeed(this._worldSeed.jungleSeed);
         var _loc1_:Array = this.getPerlinNoise(7,7,3,this._worldSeed.jungleSeed);
         var _loc2_:int = 0;
         while(_loc2_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc3_ = 0;
            while(_loc3_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               if(!(this.isInsideVillage(_loc3_,_loc2_) || this._map.tileAt(_loc3_,_loc2_).type == this.tileDefinitions.RIVER))
               {
                  _loc4_ = _loc1_[_loc3_ + _loc2_ * this.system.TOWN_MAP_WIDTH_GRIDSPACE];
                  if(_loc4_ > this.jungleThreshold)
                  {
                     this._map.setTileOfType(this.tileDefinitions.JUNGLE,_loc3_,_loc2_);
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      protected function makeWorldCorrections() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         var _loc7_:int = 0;
         this.RND.setSeed(this._worldSeed.worldCorrectionsSeed);
         var _loc5_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = this.villagePosition.x - 1;
            while(_loc2_ < this.villagePosition.x + 4)
            {
               _loc3_ = this.villagePosition.y - 1 + _loc1_ * 4;
               _loc5_.push(this._map.tileAt(_loc2_,_loc3_));
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_ = this.villagePosition.y;
         while(_loc3_ < this.villagePosition.y + 3)
         {
            _loc1_ = 0;
            while(_loc1_ < 2)
            {
               _loc2_ = this.villagePosition.x - 1 + 4 * _loc1_;
               _loc5_.push(this._map.tileAt(_loc2_,_loc3_));
               _loc1_++;
            }
            _loc3_++;
         }
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc7_];
            if(_loc4_.terrainDefinition.levelModifier != 0 || _loc4_.terrainDefinition.groundType === this.tileDefinitions.WATER_GROUND || _loc4_.terrainDefinition === this.tileDefinitions.HILLS_DEFINITION)
            {
               _loc6_.push({
                  "tile":_loc4_,
                  "type":this.getNoModTerrainType()
               });
            }
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc8_].tile;
            this._map.setTileOfType(_loc6_[_loc8_].type,_loc4_.positionTilespace.x,_loc4_.positionTilespace.y);
            _loc8_++;
         }
         if(this.doTutorialSetup)
         {
            this._map.setTileOfType(this.tileDefinitions.GRASS,this.villagePosition.x + 3,this.villagePosition.y);
         }
      }
      
      protected function getNoModTerrainType() : String
      {
         return this.terrainsWithoutDifficultyMods[this.RND.nextInteger(this.terrainsWithoutDifficultyMods.length)];
      }
      
      protected function generateBorders() : void
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
         {
            _loc1_ = this._map.tileAt(_loc2_,0);
            _loc1_.clear();
            this._map.setTileOfType(this.tileDefinitions.SKY,_loc2_,0);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
         {
            _loc1_ = this._map.tileAt(_loc2_,1);
            _loc1_.clear();
            this._map.setTileOfType(this.tileDefinitions.HORIZON,_loc2_,1);
            _loc2_++;
         }
      }
      
      protected function generateRiver() : void
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         var _loc5_:int = 1;
         this.RND.setSeed(this._worldSeed.riverSeed);
         var _loc6_:int = this.RND.nextInteger(2) === 0?-1:1;
         var _loc7_:int = this.RND.nextInteger(6);
         var _loc8_:int = _loc6_ > 0?int(this.villagePosition.x + 4 + _loc7_):int(this.villagePosition.x - 2 - _loc7_);
         var _loc9_:int = _loc8_;
         var _loc10_:int = this.villagePosition.y;
         _loc2_ = 0;
         while(_loc10_ < this._map.height)
         {
            _loc1_ = this._map.tileAt(_loc9_,_loc10_);
            _loc3_ = _loc2_;
            switch(_loc3_)
            {
               case -1:
                  _loc2_ = this.RND.nextInteger(2) - 1;
                  break;
               case 0:
                  _loc2_ = this.RND.nextInteger(3) - 1;
                  break;
               case 1:
                  _loc2_ = this.RND.nextInteger(2);
            }
            if(_loc2_ == 0 && this.isInsideVillage(_loc9_,_loc10_ + 1,_loc5_))
            {
               if(_loc3_ != 0)
               {
                  _loc2_ = _loc3_;
               }
               else
               {
                  _loc2_ = -1;
               }
            }
            if(_loc2_ != 0 && this.isInsideVillage(_loc9_ + _loc2_,_loc10_,_loc5_))
            {
               _loc2_ = 0;
            }
            _loc9_ = _loc9_ + _loc2_;
            if(_loc9_ < 1)
            {
               _loc9_ = 1;
               _loc2_ = 0;
            }
            if(_loc9_ > this._map.width - 2)
            {
               _loc9_ = this._map.width - 2;
               _loc2_ = 0;
            }
            if(_loc2_ == 0)
            {
               _loc10_++;
            }
            if(_loc1_.terrainDefinition.groundType != this.tileDefinitions.WATER_GROUND)
            {
               switch(_loc2_)
               {
                  case -1:
                     switch(_loc3_)
                     {
                        case -1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.rightToLeft);
                           _loc1_.features.riverDirection = this.riverTileSet.rightToLeft;
                           break;
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToLeft);
                           _loc1_.features.riverDirection = this.riverTileSet.topToLeft;
                     }
                     break;
                  case 0:
                     switch(_loc3_)
                     {
                        case -1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.rightToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.rightToBottom;
                           break;
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.topToBottom;
                           break;
                        case 1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.leftToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.leftToBottom;
                     }
                     break;
                  case 1:
                     switch(_loc3_)
                     {
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToRight);
                           _loc1_.features.riverDirection = this.riverTileSet.topToRight;
                           break;
                        case 1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.leftToRight);
                           _loc1_.features.riverDirection = this.riverTileSet.leftToRight;
                     }
               }
               _loc1_.type = this.tileDefinitions.RIVER;
               _loc1_.terrainDefinition = this.tileDefinitions.RIVER_DEFINITION;
               _loc1_.clearLayersOfType(Tile.PROPS_LAYER);
            }
         }
         this._map.riverEndPosition = _loc9_;
         _loc10_ = this.villagePosition.y - 1;
         _loc9_ = _loc8_;
         _loc3_ = 0;
         _loc2_ = 0;
         while(_loc10_ >= 0)
         {
            _loc1_ = this._map.tileAt(_loc9_,_loc10_);
            _loc3_ = _loc2_;
            switch(_loc3_)
            {
               case -1:
                  _loc2_ = this.RND.nextInteger(2) - 1;
                  break;
               case 0:
                  _loc2_ = this.RND.nextInteger(3) - 1;
                  break;
               case 1:
                  _loc2_ = this.RND.nextInteger(2);
            }
            if(_loc2_ == 0 && this.isInsideVillage(_loc9_,_loc10_ + 1,_loc5_))
            {
               if(_loc3_ != 0)
               {
                  _loc2_ = _loc3_;
               }
               else
               {
                  _loc2_ = -1;
               }
            }
            if(_loc2_ != 0 && this.isInsideVillage(_loc9_ + _loc2_,_loc10_,_loc5_))
            {
               _loc2_ = 0;
            }
            _loc9_ = _loc9_ + _loc2_;
            if(_loc9_ < 1)
            {
               _loc9_ = 1;
               _loc2_ = 0;
            }
            if(_loc9_ > this._map.width - 2)
            {
               _loc9_ = this._map.width - 2;
               _loc2_ = 0;
            }
            if(_loc2_ == 0)
            {
               _loc10_--;
            }
            if(_loc1_.terrainDefinition.groundType != this.tileDefinitions.WATER_GROUND)
            {
               switch(_loc2_)
               {
                  case -1:
                     switch(_loc3_)
                     {
                        case -1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.leftToRight);
                           _loc1_.features.riverDirection = this.riverTileSet.leftToRight;
                           break;
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.leftToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.leftToBottom;
                     }
                     break;
                  case 0:
                     switch(_loc3_)
                     {
                        case -1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToRight);
                           _loc1_.features.riverDirection = this.riverTileSet.topToRight;
                           break;
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.topToBottom;
                           break;
                        case 1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.topToLeft);
                           _loc1_.features.riverDirection = this.riverTileSet.topToLeft;
                     }
                     break;
                  case 1:
                     switch(_loc3_)
                     {
                        case 0:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.rightToBottom);
                           _loc1_.features.riverDirection = this.riverTileSet.rightToBottom;
                           break;
                        case 1:
                           _loc1_.addLayerFromClipClass(Tile.GROUND_LAYER,this.riverTileSet.rightToLeft);
                           _loc1_.features.riverDirection = this.riverTileSet.rightToLeft;
                     }
               }
               _loc1_.type = this.tileDefinitions.RIVER;
               _loc1_.terrainDefinition = this.tileDefinitions.RIVER_DEFINITION;
               _loc1_.clearLayersOfType(Tile.PROPS_LAYER);
            }
         }
         this._map.riverBeginPosition = _loc9_;
      }
      
      protected function isNearRiver(param1:int, param2:int) : Boolean
      {
         var _loc3_:Tile = this._map.tileAt(param1,param2);
         if(_loc3_ && _loc3_.type == this.tileDefinitions.RIVER)
         {
            return true;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._offsets.length)
         {
            _loc3_ = this._map.tileAt(param1 + this._offsets[_loc4_].x,param2 + this._offsets[_loc4_].y);
            if(_loc3_ && _loc3_.type == this.tileDefinitions.RIVER)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      protected function getSpecialTerrainPropertyTasks(param1:TilesByType, param2:int) : Array
      {
         var _loc3_:int = 6;
         var _loc4_:int = 5;
         var _loc5_:int = 5;
         return [{
            "propertyDefinition":this.tileDefinitions.WATTLE_TREES_DEFINITION,
            "terrainTiles":param1.lightForest,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.TRANQUIL_GLADE_DEFINITION,
            "terrainTiles":param1.heavyForest,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.STICKY_SAP_PLANT_DEFINITION,
            "terrainTiles":param1.jungle,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.SHIPWRECK_DEFINITION,
            "terrainTiles":param1.lakes,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.GLACIER_DEFINITION,
            "terrainTiles":param1.snow,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.MOAB_GRAVEYARD_DEFINITION,
            "terrainTiles":param1.desert,
            "defaultMinDistance":_loc5_
         },{
            "propertyDefinition":this.tileDefinitions.CAVES_DEFINITION,
            "terrainTiles":param1.mountains,
            "defaultMinDistance":param2
         },{
            "propertyDefinition":this.tileDefinitions.PHASE_CRYSTAL_DEFINITION,
            "terrainTiles":param1.volcanoes,
            "defaultMinDistance":_loc3_,
            "padding":new IntPoint2D(1,2)
         },{
            "propertyDefinition":this.tileDefinitions.CONSECRATED_GROUND_DEFINITION,
            "terrainTiles":param1.landTiles,
            "defaultMinDistance":_loc4_,
            "padding":new IntPoint2D(3,3)
         }];
      }
      
      protected function generateTerrainSpecialProperties(param1:TilesByType) : Boolean
      {
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Object = null;
         this.RND.setSeed(this._worldSeed.terrainSpecialPropertiesSeed);
         var _loc2_:int = 3;
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Array = this.getSpecialTerrainPropertyTasks(param1,_loc2_);
         var _loc6_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc9_];
            _loc8_ = TerrainSpecialPropertyDefinition(_loc7_.propertyDefinition).quantityPerMap;
            _loc13_ = 0;
            while(_loc13_ < _loc8_)
            {
               _loc6_.push(_loc7_);
               _loc13_++;
            }
            _loc9_++;
         }
         this.shuffleArray(_loc6_);
         var _loc10_:Number = _loc2_;
         var _loc11_:int = 0;
         while(_loc11_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc11_];
            _loc4_.push(this.applyTerrainSpecialProperty(_loc7_.propertyDefinition,_loc7_.terrainTiles,int(_loc10_ = Number(_loc10_ + 0.5)),_loc7_.defaultMinDistance));
            _loc11_++;
         }
         var _loc12_:int = 0;
         while(_loc12_ < _loc4_.length)
         {
            _loc14_ = _loc4_[_loc12_];
            if(_loc14_.success === false)
            {
               return false;
            }
            _loc12_++;
         }
         return true;
      }
      
      protected function applyTerrainSpecialProperty(param1:TerrainSpecialPropertyDefinition, param2:Vector.<Tile>, param3:int, param4:int = 0, param5:int = 20) : Object
      {
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Tile = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:int = param5 - param4;
         var _loc8_:Vector.<Tile> = param2.slice();
         var _loc9_:Boolean = false;
         this.shuffleTilesVector(_loc8_);
         _loc10_ = param3;
         loop0:
         while(_loc10_ < param3 + _loc6_)
         {
            _loc7_ = _loc10_;
            if(_loc7_ > param5)
            {
               _loc7_ = _loc7_ - _loc6_;
            }
            _loc12_ = 0;
            while(true)
            {
               if(_loc12_ >= _loc8_.length)
               {
                  _loc10_++;
                  continue loop0;
               }
               _loc11_ = _loc8_[_loc12_];
               _loc13_ = this.distanceFromVillageEdge(_loc11_);
               if(_loc13_ !== _loc7_ || _loc11_.terrainSpecialProperty !== null || _loc11_.type == this.tileDefinitions.RIVER || _loc11_.building !== null || _loc11_.hasTreasureChest)
               {
                  continue;
               }
               if(param1 === this.tileDefinitions.CONSECRATED_GROUND_DEFINITION)
               {
                  if(!this.checkTileHasSurroundingLandForFootprint(_loc11_,this._buildingData.TEMPLE_COMPLEX.width,this._buildingData.TEMPLE_COMPLEX.height))
                  {
                     continue;
                  }
                  break;
               }
               if(param1 === this.tileDefinitions.PHASE_CRYSTAL_DEFINITION)
               {
                  if(!this.checkTileHasSurroundingLandForFootprint(_loc11_,this._buildingData.CRYSTAL_FUSION_ARRAY.width,this._buildingData.CRYSTAL_FUSION_ARRAY.height))
                  {
                     continue;
                  }
                  break;
               }
               break;
            }
            _loc11_.terrainSpecialProperty = param1;
            _loc11_.clearLayersOfType(Tile.PROPS_LAYER);
            _loc11_.addLayerFromClipClass(Tile.PROPS_LAYER,param1.graphicClass,true,true);
            _loc9_ = true;
            break;
         }
         if(_loc9_)
         {
         }
         return {
            "success":_loc9_,
            "definition":param1
         };
      }
      
      protected function checkTileHasSurroundingLandForFootprint(param1:Tile, param2:int, param3:int, param4:Boolean = true) : Boolean
      {
         var _loc10_:Tile = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc5_:Boolean = true;
         var _loc6_:int = param1.positionTilespace.x - (param2 - 1);
         var _loc7_:int = param1.positionTilespace.y - (param3 - 1);
         var _loc8_:int = param1.positionTilespace.x;
         var _loc9_:int = param1.positionTilespace.y;
         var _loc11_:int = _loc6_;
         loop0:
         while(_loc11_ <= _loc8_)
         {
            _loc12_ = _loc7_;
            while(true)
            {
               if(_loc12_ > _loc9_)
               {
                  _loc11_++;
                  continue loop0;
               }
               _loc5_ = true;
               _loc13_ = _loc11_;
               loop2:
               while(_loc13_ < _loc11_ + param2)
               {
                  _loc14_ = _loc12_;
                  while(_loc14_ < _loc12_ + param3)
                  {
                     _loc10_ = this._map.tileAt(_loc13_,_loc14_);
                     if(!(!param4 && _loc10_ === param1))
                     {
                        if(_loc10_.terrainDefinition === this.tileDefinitions.RIVER_DEFINITION || _loc10_.terrainDefinition === this.tileDefinitions.LAKE_DEFINITION || _loc10_.terrainSpecialProperty !== null)
                        {
                           _loc5_ = false;
                           break loop2;
                        }
                     }
                     _loc14_++;
                  }
                  _loc13_++;
               }
               if(_loc5_)
               {
                  break;
               }
               _loc12_++;
            }
            return true;
         }
         return false;
      }
      
      public function correctBadlyPlacedSpecialTerrainProperties() : void
      {
         var _loc2_:Tile = null;
         var _loc3_:Tile = null;
         var _loc4_:Tile = null;
         var _loc9_:Object = null;
         this.RND.setSeed(this._worldSeed.terrainSpecialPropertiesSeed);
         var _loc1_:Vector.<Tile> = this._map.tiles;
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_];
            if(_loc1_[_loc5_].terrainSpecialProperty === this.tileDefinitions.CONSECRATED_GROUND_DEFINITION)
            {
               _loc4_ = _loc2_;
            }
            else if(_loc1_[_loc5_].terrainSpecialProperty === this.tileDefinitions.PHASE_CRYSTAL_DEFINITION)
            {
               _loc3_ = _loc2_;
            }
            _loc5_++;
         }
         var _loc6_:TilesByType = this._map.getTilesByType();
         var _loc7_:Array = [{
            "tile":_loc3_,
            "footprint":new Rectangle(0,0,1,2),
            "tiles":_loc6_.volcanoes,
            "preferredDistance":6,
            "minimumDistance":6
         },{
            "tile":_loc4_,
            "footprint":new Rectangle(0,0,3,3),
            "tiles":_loc6_.landTiles,
            "preferredDistance":6,
            "minimumDistance":6
         }];
         var _loc8_:Boolean = false;
         var _loc10_:int = 0;
         while(_loc10_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc10_];
            if(!this.checkTileHasSurroundingLandForFootprint(_loc9_.tile,_loc9_.footprint.width,_loc9_.footprint.height,false))
            {
               this.moveSpecialTerrainPropertyToValidTile(_loc9_.tile,_loc9_.footprint,_loc9_.tiles,_loc9_.preferredDistance,_loc9_.minimumDistance);
               _loc8_ = true;
            }
            _loc10_++;
         }
         if(_loc8_)
         {
            CityDataPersistence.getInstance().saveValue(CityDataPersistence.TERRAIN_DATA_KEY,this._map.getCompressedTerrainJSON());
            AnalyticsUtil.track("corrected_special_terrain");
         }
      }
      
      protected function moveSpecialTerrainPropertyToValidTile(param1:Tile, param2:Rectangle, param3:Vector.<Tile>, param4:int, param5:int = 0, param6:int = 20) : void
      {
         var _loc7_:TerrainSpecialPropertyDefinition = param1.terrainSpecialProperty;
         var _loc8_:Object = this.applyTerrainSpecialProperty(_loc7_,param3,param4,param5,param6);
         if(_loc8_.success)
         {
            param1.terrainSpecialProperty = null;
            param1.clearLayersOfType(Tile.PROPS_LAYER);
         }
      }
      
      public function testMoveConsecrated() : void
      {
      }
      
      protected function shuffleTilesVector(param1:Vector.<Tile>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         if(param1.length > 1)
         {
            _loc2_ = param1.length - 1;
            while(_loc2_ > 0)
            {
               _loc3_ = this.RND.nextInteger(param1.length);
               _loc4_ = param1[_loc3_];
               param1[_loc3_] = param1[_loc2_];
               param1[_loc2_] = _loc4_;
               _loc2_--;
            }
         }
      }
      
      protected function shuffleTileList(param1:Vector.<Tile>) : Vector.<Tile>
      {
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         var _loc2_:int = param1.length - 1;
         while(_loc2_ > 0)
         {
            _loc3_ = this.RND.nextInteger(_loc2_ + 1);
            _loc4_ = param1[_loc2_];
            param1[_loc2_] = param1[_loc3_];
            param1[_loc3_] = _loc4_;
            _loc2_--;
         }
         return param1;
      }
      
      protected function generateBlob(param1:int, param2:int, param3:int = 8, param4:Number = 1) : Array
      {
         var blob:Array = null;
         var fullVal:int = 0;
         var grid:Array = null;
         var centerOfImage:IntPoint2D = null;
         var testDirection:int = 0;
         var i:int = 0;
         var hit:Boolean = false;
         var aroundPointX:int = param1;
         var aroundPointY:int = param2;
         var steps:int = param3;
         var probabilityOfSkipping:Number = param4;
         var addPoint:Function = function(param1:int, param2:int):void
         {
            grid[param1][param2] = fullVal;
            blob.push(new IntPoint2D(param1 + aroundPointX - centerOfImage.x,param2 + aroundPointY - centerOfImage.y));
         };
         blob = [];
         var gridWidth:int = 100;
         var gridHeight:int = 100;
         var emptyVal:int = 0;
         fullVal = 1;
         grid = this.make2DArray(gridWidth,gridHeight,emptyVal);
         centerOfImage = new IntPoint2D(gridWidth * 0.5,gridHeight * 0.5);
         var currentPoint:IntPoint2D = new IntPoint2D(centerOfImage.x,centerOfImage.y);
         var testPoint:IntPoint2D = new IntPoint2D();
         addPoint(currentPoint.x,currentPoint.y);
         var j:int = 0;
         while(j < steps)
         {
            testDirection = this.RND.nextInteger(this._offsets.length);
            i = 0;
            while(i < this._offsets.length)
            {
               testPoint.x = currentPoint.x + this._offsets[this.wrap(testDirection,this._offsets.length)].x;
               testPoint.y = currentPoint.y + this._offsets[this.wrap(testDirection,this._offsets.length)].y;
               hit = grid[testPoint.x][testPoint.y] == emptyVal;
               if(hit)
               {
                  break;
               }
               testDirection++;
               i++;
            }
            currentPoint.x = testPoint.x;
            currentPoint.y = testPoint.y;
            addPoint(currentPoint.x,currentPoint.y);
            j++;
         }
         return blob;
      }
      
      protected function make2DArray(param1:int, param2:int, param3:* = 0) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            _loc4_[_loc5_] = [];
            _loc6_ = 0;
            while(_loc6_ < param2)
            {
               _loc4_[_loc5_][_loc6_] = param3;
               _loc6_++;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      protected function wrap(param1:int, param2:int) : int
      {
         while(param1 < 0)
         {
            param1 = param1 + param2;
         }
         while(param1 >= param2)
         {
            param1 = param1 - param2;
         }
         return param1;
      }
      
      public function beautify() : void
      {
         var _loc2_:int = 0;
         this.RND.setSeed(this._worldSeed.beautifySeed);
         var _loc1_:int = 0;
         while(_loc1_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc2_ = 0;
            while(_loc2_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               this._map.tileAt(_loc2_,_loc1_).beautify(this._map);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function getPerlinNoise(param1:Number, param2:Number, param3:int, param4:uint, param5:Number = 0.5) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc6_:Array = [];
         var _loc7_:Perlin = new Perlin(param3,param4);
         var _loc8_:int = 0;
         while(_loc8_ < this.system.TOWN_MAP_WIDTH_GRIDSPACE)
         {
            _loc9_ = 0;
            while(_loc9_ < this.system.TOWN_MAP_HEIGHT_GRIDSPACE)
            {
               _loc10_ = _loc7_.noise(_loc8_ / param1,_loc9_ / param2);
               _loc11_ = 255 * (_loc10_ * 0.5 + 0.5);
               _loc6_[_loc8_ + _loc9_ * this.system.TOWN_MAP_WIDTH_GRIDSPACE] = _loc11_;
               _loc9_++;
            }
            _loc8_++;
         }
         return _loc6_;
      }
   }
}
