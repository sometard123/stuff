package ninjakiwi.monkeyTown.town.townMap
{
   import com.adobe.images.PNGEncoder;
   import flash.display.BitmapData;
   import flash.events.IOErrorEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.display.tileSystem.Camera;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.display.tileSystem.TileMap;
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BloonIconData;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainSpecialPropertyDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.fogOfWar.FogOfWar;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.terrainGenerator.TerrainGenerator;
   import ninjakiwi.monkeyTown.town.terrainGenerator.TerrainGeneratorSecondCity;
   import ninjakiwi.monkeyTown.town.terrainGenerator.WorldSeed;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.tileProps.fence.FenceBuilder;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class TownMap extends TileMap
   {
      
      public static var ez:Boolean = false;
      
      public static const NO_TERRAIN:String = "___no_terrain";
      
      public static const TRIVIAL_INDEX:int = 0;
      
      public static const EASY_INDEX:int = 1;
      
      public static const MEDIUM_INDEX:int = 2;
      
      public static const HARD_INDEX:int = 3;
      
      public static const VERY_HARD_INDEX:int = 4;
      
      public static const IMPOPPABLE_INDEX:int = 5;
      
      public static const DIFFICULTY_DESCRIPTIONS:Array = ["Trivial","Easy","Medium","Hard","Very hard","Impoppable"];
      
      public static var terrainDifficultyCurve:Array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
       
      
      var _tileDefinitions:TileDefinitions;
      
      var _worldIsReady:Boolean = false;
      
      var _cityIsReady:Boolean = false;
      
      public var centerOfMap:IntPoint2D;
      
      public var mouseHint:Point;
      
      public var fenceBuilder:FenceBuilder;
      
      public var refreshSurfaceLayer:Boolean = true;
      
      public var riverBeginPosition:int;
      
      public var riverEndPosition:int;
      
      private var _defaultTerrainGenerator:TerrainGenerator;
      
      private var _terrainGenerator:TerrainGenerator;
      
      private var _floatingPropClip:BitClipCustom = null;
      
      private var _persistenceUtility:TownMapPersistenceUtility;
      
      private var _hoveredTile:Tile = null;
      
      private var _surfaceLayer:BitmapData;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _strongestBloonClip:BitClipCustom = null;
      
      private var _difficultyRankPips:BitClipCustom = null;
      
      private var _lastViewedWeights:BloonWeightsDefinition;
      
      public const DIFFICULTY_RELATIONSHIP_TO_MTL:Array = [new Range#293(-Number.MAX_VALUE,0.55),new Range#293(0.55,0.8),new Range#293(0.8,1.1),new Range#293(1.1,1.4),new Range#293(1.4,1.8),new Range#293(1.8,Number.MAX_VALUE)];
      
      public const PVP_DIFFICULTY_RELATIONSHIP_TO_MTL:Array = [new Range#293(-Number.MAX_VALUE,0.55),new Range#293(0.55,1),new Range#293(1,1.15),new Range#293(1.15,1.35),new Range#293(1.35,1.8),new Range#293(1.8,Number.MAX_VALUE)];
      
      public const XP_MODIFIER_FOR_RELATIVE_DIFFICULTY:Array = [0.5,1,1,1,1,1];
      
      public const signals:TownMapSignals = new TownMapSignals();
      
      public var fog:FogOfWar;
      
      private var _adjacentTileOffsets:Array;
      
      var _worldSeed:WorldSeed = null;
      
      public function TownMap(param1:int, param2:int, param3:int, param4:int)
      {
         this._tileDefinitions = TileDefinitions.getInstance();
         this.mouseHint = new Point();
         this._defaultTerrainGenerator = new TerrainGenerator();
         this._terrainGenerator = this._defaultTerrainGenerator;
         this._persistenceUtility = new TownMapPersistenceUtility();
         this._adjacentTileOffsets = [new IntPoint2D(-1,-1),new IntPoint2D(0,-1),new IntPoint2D(1,-1),new IntPoint2D(-1,0),new IntPoint2D(1,0),new IntPoint2D(-1,1),new IntPoint2D(0,1),new IntPoint2D(1,1)];
         super(param1,param2,param3,param4);
         this.init();
      }
      
      public static function isPointInsideInitialVillage(param1:int, param2:int, param3:int = 0) : Boolean
      {
         var _loc4_:int = 3;
         var _loc5_:int = 3;
         if(param1 >= MonkeySystem.getInstance().VILLAGE_POSITION_X - param3 && param1 < MonkeySystem.getInstance().VILLAGE_POSITION_X + _loc4_ + param3 && param2 >= MonkeySystem.getInstance().VILLAGE_POSITION_Y - param3 && param2 < MonkeySystem.getInstance().VILLAGE_POSITION_Y + _loc5_ + param3)
         {
            return true;
         }
         return false;
      }
      
      private function init() : void
      {
         this.centerOfMap = new IntPoint2D(width * 0.5,height * 0.5);
         this.fenceBuilder = new FenceBuilder(this);
      }
      
      override public function clear() : void
      {
         super.clear();
         this._worldIsReady = false;
         this._cityIsReady = false;
         this.refreshSurfaceLayer = true;
         this._strongestBloonClip = null;
         this._difficultyRankPips = null;
      }
      
      public function selectTerrainGeneratorForCity(param1:int) : void
      {
         if(param1 > 0)
         {
            this._terrainGenerator = new TerrainGeneratorSecondCity();
         }
         else
         {
            this._terrainGenerator = this._defaultTerrainGenerator;
         }
         this._terrainGenerator.configureParameters();
      }
      
      public function generateTerrain(param1:Function, param2:WorldSeed = null) : void
      {
         var localThis:TownMap = null;
         var callback:Function = param1;
         var seed:WorldSeed = param2;
         this._worldIsReady = false;
         this._cityIsReady = false;
         this.clear();
         localThis = this;
         this._worldSeed = this._terrainGenerator.generateTerrain(this,function():void
         {
            if(!seed)
            {
               _buildingFactory.addInitialVillage(localThis);
               _worldIsReady = true;
            }
            callback();
         },seed);
      }
      
      public function getTerrainDifficultyAtDistance(param1:int) : Number
      {
         param1 = LGMath.clamp(param1,0,terrainDifficultyCurve.length - 1);
         var _loc2_:int = terrainDifficultyCurve[param1];
         var _loc3_:int = MonkeySystem.getInstance().city.cityIndex;
         if(_loc3_ > 0)
         {
            _loc2_ = Math.round(_loc2_ * MonkeySystem.getInstance().SECOND_CITY_DIFFICULTY_MODIFIER);
         }
         return _loc2_;
      }
      
      public function getNaturalDifficultyAtLocation(param1:int, param2:int) : Number
      {
         var _loc3_:Tile = tileAt(param1,param2);
         var _loc4_:Number = Math.abs(param1 - this.centerOfMap.x);
         var _loc5_:Number = Math.abs(param2 - this.centerOfMap.y);
         var _loc6_:int = _loc4_ > _loc5_?int(_loc4_):int(_loc5_);
         _loc6_ = _loc6_ - 2;
         _loc6_ = LGMath.clamp(_loc6_,0,terrainDifficultyCurve.length - 1);
         var _loc7_:int = this.getTerrainDifficultyAtDistance(_loc6_);
         return _loc7_;
      }
      
      public function getDifficultyAtTile(param1:Tile) : Number
      {
         var _loc2_:Number = Math.abs(param1.positionTilespace.x - this.centerOfMap.x);
         var _loc3_:Number = Math.abs(param1.positionTilespace.y - this.centerOfMap.y);
         var _loc4_:int = _loc2_ > _loc3_?int(_loc2_):int(_loc3_);
         _loc4_ = _loc4_ - 2;
         _loc4_ = LGMath.clamp(_loc4_,0,terrainDifficultyCurve.length - 1);
         var _loc5_:int = this.getTerrainDifficultyAtDistance(_loc4_);
         _loc5_ = _loc5_ + param1.terrainDefinition.levelModifier;
         _loc5_ = _loc5_ + param1.difficultyModifier;
         if(param1.terrainSpecialProperty)
         {
            _loc5_ = _loc5_ + param1.terrainSpecialProperty.levelModifier;
         }
         return _loc5_;
      }
      
      public function getDifficultyAtLocation(param1:int, param2:int) : Number
      {
         if(!this._worldIsReady)
         {
            return 0;
         }
         var _loc3_:Tile = tileAt(param1,param2);
         return this.getDifficultyAtTile(_loc3_);
      }
      
      public function getDifficultyAtLocationPoint(param1:IntPoint2D) : Number
      {
         return this.getDifficultyAtLocation(param1.x,param1.y);
      }
      
      public function getDifficultyByRank(param1:int, param2:int, param3:String) : Number
      {
         var _loc5_:Range = null;
         var _loc4_:Number = param2 * LevelDefData.getTrackDifficulty(param3);
         if(param1 === 0)
         {
            param1 = 1;
         }
         if(param1 >= 4)
         {
            if(_loc4_ < 6)
            {
               param1 = 3;
            }
         }
         if(param1 === 5)
         {
            if(_loc4_ < 10)
            {
               param1 = 4;
            }
         }
         if(param1 >= 0 && param1 < this.DIFFICULTY_RELATIONSHIP_TO_MTL.length)
         {
            _loc5_ = this.DIFFICULTY_RELATIONSHIP_TO_MTL[param1];
         }
         else
         {
            _loc5_ = new Range#293(0.8,1.1);
         }
         if(param1 == 0)
         {
            return _loc4_ * _loc5_.high;
         }
         if(param1 == 5)
         {
            return _loc4_ * _loc5_.low;
         }
         return _loc4_ * (_loc5_.low + _loc5_.high) * 0.5;
      }
      
      private function getDifficultyRankRelativeToMTL(param1:int, param2:int, param3:Number, param4:String, param5:Boolean = false) : int
      {
         var _loc6_:Range = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = MonkeySystem.getInstance().city.cityIndex;
         if(param4 !== TownMap.NO_TERRAIN)
         {
            _loc9_ = LevelDefData.getActualTrackDifficultyRating(param4,param3,_loc10_);
         }
         else
         {
            _loc9_ = 1;
         }
         var _loc11_:Number = Number(param1) * _loc9_;
         var _loc12_:Number = param2 - _loc11_;
         _loc7_ = _loc11_ / param2;
         var _loc13_:Array = this.DIFFICULTY_RELATIONSHIP_TO_MTL;
         if(param5)
         {
            _loc13_ = this.PVP_DIFFICULTY_RELATIONSHIP_TO_MTL;
         }
         var _loc14_:int = 0;
         while(_loc14_ < _loc13_.length)
         {
            _loc6_ = _loc13_[_loc14_];
            if(_loc6_.valueIsInRange(_loc7_))
            {
               _loc8_ = _loc14_;
               if(_loc8_ === 0)
               {
                  if(_loc12_ < 10)
                  {
                     _loc8_ = 1;
                  }
               }
               if(_loc8_ >= 4)
               {
                  if(_loc11_ < 6)
                  {
                     _loc8_ = 3;
                  }
               }
               if(_loc8_ === 5)
               {
                  if(_loc11_ < 10)
                  {
                     _loc8_ = 4;
                  }
               }
               break;
            }
            _loc14_++;
         }
         return _loc8_;
      }
      
      public function getDifficultyDescriptionByRank(param1:int) : String
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 >= DIFFICULTY_DESCRIPTIONS.length)
         {
            param1 = DIFFICULTY_DESCRIPTIONS.length - 1;
         }
         return DIFFICULTY_DESCRIPTIONS[param1];
      }
      
      public function getRank(param1:Tile) : int
      {
         var _loc2_:Number = this.getDifficultyAtLocationPoint(param1.positionTilespace);
         var _loc3_:Boolean = isPointInsideInitialVillage(param1.positionTilespace.x,param1.positionTilespace.y,1);
         var _loc4_:int = this.getDifficultyRankRelativeToMTL(_loc2_,this._resourceStore.townLevel,param1.trackSelectionBias,param1.type);
         var _loc5_:int = _loc4_;
         if(_loc3_ && _loc4_ > 1)
         {
            _loc4_ = 1;
         }
         if(param1.isCamoTile || param1.isRegenTile)
         {
            _loc4_ = _loc4_ + 1;
         }
         return _loc4_;
      }
      
      public function getPVPRank(param1:int, param2:int, param3:String, param4:Tile) : int
      {
         if(param3 == "" || param3 == null)
         {
            param3 = TownMap.NO_TERRAIN;
         }
         var _loc5_:int = this.getDifficultyRankRelativeToMTL(param1,param2,param4 != null?Number(param4.trackSelectionBias):Number(0.5),param3,true);
         return _loc5_ + 1;
      }
      
      public function getXPModifierForDifficultyRank(param1:int) : Number
      {
         param1 = LGMath.clamp(param1,0,this.XP_MODIFIER_FOR_RELATIVE_DIFFICULTY.length - 1);
         return this.XP_MODIFIER_FOR_RELATIVE_DIFFICULTY[param1];
      }
      
      public function tileAtPoint(param1:IntPoint2D) : Tile
      {
         return tileAt(param1.x,param1.y);
      }
      
      public function tileAtPixelSpace(param1:int, param2:int) : Tile
      {
         return tileAt(param1 / system.TOWN_GRID_UNIT_SIZE,param2 / system.TOWN_GRID_UNIT_SIZE);
      }
      
      public function isValidAttackTarget(param1:int, param2:int) : Boolean
      {
         var _loc3_:Tile = tileAt(param1,param2);
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc4_:Boolean = !_loc3_.isCaptured && this.hasAdjacentConqueredTile(param1,param2);
         return _loc4_;
      }
      
      public function hasAdjacentBuilding(param1:int, param2:int) : Boolean
      {
         var _loc3_:Tile = null;
         var _loc4_:IntPoint2D = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._adjacentTileOffsets.length)
         {
            _loc4_ = this._adjacentTileOffsets[_loc5_];
            _loc3_ = tileAt(param1 + _loc4_.x,param2 + _loc4_.y);
            if(_loc3_ && _loc3_.building != null)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function hasAdjacentConqueredTile(param1:int, param2:int) : Boolean
      {
         var _loc3_:Tile = null;
         var _loc4_:IntPoint2D = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._adjacentTileOffsets.length)
         {
            _loc4_ = this._adjacentTileOffsets[_loc5_];
            _loc3_ = tileAt(param1 + _loc4_.x,param2 + _loc4_.y);
            if(_loc3_ && _loc3_.isCaptured)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function hasAdjacentLand(param1:int, param2:int) : Boolean
      {
         var _loc3_:Tile = null;
         var _loc4_:IntPoint2D = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._adjacentTileOffsets.length)
         {
            _loc4_ = this._adjacentTileOffsets[_loc5_];
            _loc3_ = tileAt(param1 + _loc4_.x,param2 + _loc4_.y);
            if(_loc3_ && _loc3_.type != this._tileDefinitions.LAKE)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function recalculateTileVisibilityByFog(param1:Rectangle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         _loc2_ = 0;
         while(_loc2_ < _height)
         {
            _loc3_ = 0;
            while(_loc3_ < _width)
            {
               _loc4_ = _tiles[_loc3_ + _loc2_ * _width];
               if(this.fog.locationIsVisible(_loc3_,_loc2_))
               {
                  _loc4_.visible = true;
               }
               else
               {
                  _loc4_.visible = false;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         this.signals.recaculateFog.dispatch();
      }
      
      override public function render(param1:BitmapData, param2:Rectangle, param3:Boolean = false) : void
      {
         var _loc11_:Tile = null;
         var _loc12_:Vector.<Tile> = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc4_:int = 2;
         var _loc5_:int = param2.x / _tileWidth;
         var _loc6_:int = param2.y / _tileHeight;
         var _loc7_:int = LGMath.clamp(_loc5_ - _loc4_,0,_width - _renderWidthTileSpace);
         var _loc8_:int = LGMath.clamp(_loc7_ + _renderWidthTileSpace + _loc4_,_renderWidthTileSpace,_width);
         var _loc9_:int = LGMath.clamp(_loc6_ - _loc4_,0,_height - _renderHeightTileSpace);
         var _loc10_:int = LGMath.clamp(_loc9_ + _renderHeightTileSpace + _loc4_,_renderHeightTileSpace,_height);
         if(_loc7_ < 0)
         {
         }
         var _loc13_:Array = [];
         var _loc17_:Rectangle = param2.clone();
         var _loc18_:Point = new Point(0,0);
         var _loc19_:int = 0;
         _loc14_ = _loc9_;
         while(_loc14_ < _loc10_)
         {
            _loc15_ = _loc7_;
            for(; _loc15_ < _loc8_; _loc15_++)
            {
               _loc11_ = _tiles[_loc15_ + _loc14_ * _width];
               _loc11_.requiresDrawFlag = true;
               if(_loc11_.visible)
               {
                  if(_loc15_ < _loc7_ + _loc4_ && _loc15_ >= _loc4_ || _loc14_ < _loc9_ + _loc4_ && _loc14_ >= _loc4_)
                  {
                     if(_loc11_.building === null || _loc11_.building.homeTile !== _loc11_ || !(_loc11_.building.definition.width > 1 || _loc11_.building.definition.height > 1))
                     {
                        _loc11_.requiresDrawFlag = false;
                        _loc19_++;
                        continue;
                     }
                  }
                  if(!param3 || _loc11_ && (_loc11_.hasAnimations || _loc11_.requiresRedraw))
                  {
                     _loc11_.renderSurfaceLayers(param1,param2);
                     continue;
                  }
               }
            }
            _loc14_++;
         }
         _loc14_ = _loc9_;
         while(_loc14_ < _loc10_)
         {
            _loc13_.length = 0;
            _loc12_ = tilesWithFences[_loc14_];
            _loc16_ = 0;
            while(_loc16_ < _loc12_.length)
            {
               _loc11_ = _loc12_[_loc16_];
               if(!(!_loc11_.visible || !_loc11_.requiresDrawFlag))
               {
                  _loc11_.renderFenceBack(param1,param2);
               }
               _loc16_++;
            }
            _loc16_ = 0;
            while(_loc16_ < _loc12_.length)
            {
               _loc11_ = _loc12_[_loc16_];
               if(!(!_loc11_.visible || !_loc11_.requiresDrawFlag))
               {
                  _loc11_.renderFenceMid(param1,param2);
               }
               _loc16_++;
            }
            _loc15_ = _loc7_;
            while(_loc15_ < _loc8_)
            {
               _loc11_ = _tiles[_loc15_ + _loc14_ * _width];
               if(!(!_loc11_.visible || !_loc11_.requiresDrawFlag))
               {
                  if(_loc11_.facadeAnimations.length > 0)
                  {
                     _loc13_.push(_loc11_);
                  }
                  if(!param3 || _loc11_ && (_loc11_.hasAnimations || _loc11_.requiresRedraw))
                  {
                     _loc11_.renderLayersAboveSurface(param1,param2);
                  }
               }
               _loc15_++;
            }
            if(_loc13_.length > 0)
            {
               _loc16_ = 0;
               while(_loc16_ < _loc13_.length)
               {
                  _loc11_ = _loc13_[_loc16_];
                  if(!(!_loc11_.visible || !_loc11_.requiresDrawFlag))
                  {
                     _loc11_.renderFacadeAnimations(param1,param2);
                  }
                  _loc16_++;
               }
            }
            _loc14_++;
         }
         if(this._strongestBloonClip)
         {
            this._strongestBloonClip.x = this._hoveredTile.x - param2.x;
            this._strongestBloonClip.y = this._hoveredTile.y - param2.y;
            this._strongestBloonClip.gotoAndStop(1);
            this._strongestBloonClip.render(param1,param1.rect);
         }
         if(this._difficultyRankPips && !this._hoveredTile.isUnderPvPAttack)
         {
            this._difficultyRankPips.x = this._hoveredTile.x - param2.x;
            this._difficultyRankPips.y = this._hoveredTile.y - param2.y;
            this._difficultyRankPips.render(param1,param1.rect);
         }
      }
      
      public function claimTerritory(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:Tile = tileAt(param1,param2);
         if(_loc4_)
         {
            _loc4_.isCaptured = true;
            if(param3)
            {
               _loc4_.addCitizens();
            }
            this.fenceBuilder.updateFenceAroundLocation(param1,param2);
         }
      }
      
      public function updateSingleHoverWithBuildings(param1:Number, param2:Number, param3:Rectangle, param4:Boolean) : Boolean
      {
         var _loc8_:int = 0;
         var _loc5_:Tile = this.tileAtPixelSpace(param1 + param3.x,param2 + param3.y);
         if(!_loc5_)
         {
            return false;
         }
         if(this._hoveredTile && _loc5_ == this._hoveredTile)
         {
            return false;
         }
         Tile.unhoverAllTiles();
         this._hoveredTile = _loc5_;
         var _loc6_:int = this.getDifficultyAtLocationPoint(this._hoveredTile.positionTilespace);
         var _loc7_:int = this.getRank(_loc5_);
         this._lastViewedWeights = BloonPredictor.getWeightsDefinition(_loc6_,true,_loc5_.variantHint);
         if(this._lastViewedWeights.strongestBloonType && this._hoveredTile.isCaptured == false && param4 == false)
         {
            if(SpecialMissionsManager.getInstance().findSpecialMission(this._hoveredTile) != null)
            {
               this._strongestBloonClip = BloonIconData.getIconBitClipForBloonName(Constants.SPECIAL_MISSION_SYMBOL);
            }
            else if(_loc5_.isCamoTile && _loc6_ >= Constants.MINIMUM_CAMO_TILE_DIFFICULTY)
            {
               this._strongestBloonClip = BloonIconData.getIconBitClipForBloonName(this._lastViewedWeights.strongestBloonType + "_" + Constants.CAMO.valueOf());
            }
            else if(_loc5_.isRegenTile && _loc6_ >= Constants.MINIMUM_REGEN_TILE_DIFFICULTY)
            {
               this._strongestBloonClip = BloonIconData.getIconBitClipForBloonName(this._lastViewedWeights.strongestBloonType + "_" + Constants.REGEN.valueOf());
            }
            else
            {
               this._strongestBloonClip = BloonIconData.getIconBitClipForBloonName(this._lastViewedWeights.strongestBloonType);
            }
            if(SpecialMissionsManager.getInstance().findSpecialMission(this._hoveredTile) !== null)
            {
               this._difficultyRankPips = null;
            }
            else
            {
               _loc8_ = _loc7_;
               this._difficultyRankPips = BloonIconData.getDifficultyRankPips(_loc8_);
            }
         }
         else
         {
            this._strongestBloonClip = null;
            this._difficultyRankPips = null;
         }
         if(this._hoveredTile.building)
         {
            this._hoveredTile.building.setHover(true,this);
         }
         else
         {
            this._hoveredTile.hover();
         }
         return true;
      }
      
      public function clearDifficultyPips() : void
      {
         this._strongestBloonClip = null;
         this._difficultyRankPips = null;
      }
      
      public function get worldIsReady() : Boolean
      {
         return this._worldIsReady;
      }
      
      public function get hoveredTile() : Tile
      {
         return this._hoveredTile;
      }
      
      public function getTilesByType() : TilesByType
      {
         var _loc1_:TilesByType = new TilesByType();
         _loc1_.populate(_tiles);
         return _loc1_;
      }
      
      public function getCapturedTilesByType() : CapturedTilesByType
      {
         var _loc1_:CapturedTilesByType = new CapturedTilesByType();
         _loc1_.populate(_tiles);
         return _loc1_;
      }
      
      public function getTileSaveDefinitions() : Vector.<TileSaveDefinition>
      {
         return this._persistenceUtility.getTileSaveDefinitions(this,_tiles);
      }
      
      public function getTownMapSaveDefinition() : TownMapSaveDefinition
      {
         return this._persistenceUtility.getTownMapSaveDefinition(this,_tiles);
      }
      
      public function populateFromSaveDefinition(param1:TownMapSaveDefinition) : void
      {
         this._persistenceUtility.populateFromSaveDefinition(this,param1);
      }
      
      public function centerCameraOnVillage(param1:Camera, param2:Number = 0, param3:Number = 0) : void
      {
         param1.x = system.TOWN_MAP_PIXEL_WIDTH * 0.5 - system.RENDER_SURFACE_WIDTH * 0.5 + param2;
         param1.y = system.TOWN_MAP_PIXEL_HEIGHT * 0.5 - system.RENDER_SURFACE_HEIGHT * 0.5 - param3;
      }
      
      public function centerCameraOnTile(param1:Camera, param2:Tile) : void
      {
         var _loc3_:int = system.TOWN_GRID_UNIT_SIZE * 0.5;
         var _loc4_:Point = new Point(param2.positionTilespace.x * system.TOWN_GRID_UNIT_SIZE + _loc3_ - system.RENDER_SURFACE_WIDTH * 0.5,param2.positionTilespace.y * system.TOWN_GRID_UNIT_SIZE + _loc3_ - system.RENDER_SURFACE_HEIGHT * 0.5);
         param1.x = _loc4_.x;
         param1.y = _loc4_.y;
         param1.clamp();
      }
      
      public function hasTreasuresVisible() : Boolean
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         while(_loc2_ < _tiles.length)
         {
            _loc1_ = _tiles[_loc2_];
            if(_loc1_.visible && _loc1_.hasTreasureChest)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function hasSpecialTerrainVisible() : Boolean
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         while(_loc2_ < _tiles.length)
         {
            _loc1_ = _tiles[_loc2_];
            if(_loc1_.visible && _loc1_.terrainSpecialProperty !== null)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function totalCapturedCount() : int
      {
         var _loc2_:Tile = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _tiles.length)
         {
            _loc2_ = _tiles[_loc3_];
            if(_loc2_.isCaptured)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         _loc1_ = _loc1_ - 9;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function isBuildingFull() : Boolean
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         while(_loc2_ < _tiles.length)
         {
            _loc1_ = _tiles[_loc2_];
            if(_loc1_.isCaptured && _loc1_.building == null)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function saveMapImage() : void
      {
         var _loc1_:BitmapData = new BitmapData(system.TOWN_MAP_PIXEL_WIDTH,system.TOWN_MAP_PIXEL_HEIGHT,false);
         renderWholeMap(_loc1_);
         var _loc2_:String = "monkey_town_map.png";
         var _loc3_:ByteArray = PNGEncoder.encode(_loc1_);
         var _loc4_:FileReference = new FileReference();
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.saveDataToFileIOErrorHandler);
         _loc4_.save(_loc3_,_loc2_);
      }
      
      private function saveDataToFileIOErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function get lastViewedWeights() : BloonWeightsDefinition
      {
         return this._lastViewedWeights;
      }
      
      public function get worldSeed() : WorldSeed
      {
         return this._worldSeed;
      }
      
      public function get terrainGenerator() : TerrainGenerator
      {
         return this._terrainGenerator;
      }
      
      public function get cityIsReady() : Boolean
      {
         return this._cityIsReady;
      }
      
      public function set cityIsReady(param1:Boolean) : void
      {
         this._cityIsReady = param1;
      }
      
      public function invalidateHoveredTile() : void
      {
         if(this._hoveredTile)
         {
            if(this._hoveredTile.building)
            {
               this._hoveredTile.building.setHover(false,this);
            }
            else
            {
               this._hoveredTile.unhover();
            }
            this._strongestBloonClip = null;
            this._difficultyRankPips = null;
         }
      }
      
      public function getMapDescription() : String
      {
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         var _loc1_:* = "";
         _loc1_ = _loc1_ + "////BEGIN_MAP_DESCRIPTION////\r\n";
         var _loc2_:int = 0;
         while(_loc2_ < height)
         {
            _loc3_ = 0;
            while(_loc3_ < width)
            {
               _loc4_ = tileAt(_loc3_,_loc2_);
               _loc1_ = _loc1_ + ("[ " + _loc3_ + ", " + _loc2_ + " ] - ");
               _loc1_ = _loc1_ + ("ground_type : " + _loc4_.terrainDefinition.groundType + ", tile_type : " + _loc4_.type);
               if(_loc4_.terrainSpecialProperty !== null)
               {
                  _loc1_ = _loc1_ + (", special_terrain : " + _loc4_.terrainSpecialProperty.id);
               }
               if(_loc4_.hasTreasureChest)
               {
                  _loc1_ = _loc1_ + ", has_treasure = true";
               }
               _loc1_ = _loc1_ + "\r\n";
               _loc3_++;
            }
            _loc2_++;
         }
         _loc1_ = _loc1_ + "////END_MAP_DESCRIPTION////";
         return _loc1_;
      }
      
      public function getTerrainJSON() : String
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Tile = null;
         var _loc1_:Object = {};
         var _loc2_:Array = _loc1_.tiles = [];
         _loc1_.width = width;
         _loc1_.height = height;
         _loc1_.riverBeginPosition = this.riverBeginPosition;
         _loc1_.riverEndPosition = this.riverEndPosition;
         var _loc3_:String = Constants.TERRAIN_RIVER;
         var _loc4_:int = 0;
         while(_loc4_ < height)
         {
            _loc6_ = 0;
            while(_loc6_ < width)
            {
               _loc7_ = {};
               _loc8_ = tileAt(_loc6_,_loc4_);
               _loc7_.tileType = _loc8_.type;
               if(_loc7_.tileType === _loc3_)
               {
                  _loc7_.riverDirection = _loc8_.features.riverDirection;
               }
               if(_loc8_.terrainSpecialProperty !== null)
               {
                  _loc7_.specialTerrain = _loc8_.terrainSpecialProperty.id;
               }
               _loc2_.push(_loc7_);
               _loc6_++;
            }
            _loc4_++;
         }
         var _loc5_:String = JSON.stringify(_loc1_);
         return _loc5_;
      }
      
      public function getCompressedTerrainJSON() : String
      {
         var _loc1_:String = this.getTerrainJSON();
         return Squeeze.encodeAndCompressString(_loc1_);
      }
      
      public function buildTerrain(param1:Object) : void
      {
         var _loc3_:Tile = null;
         var _loc4_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:TerrainSpecialPropertyDefinition = null;
         var _loc2_:TileDefinitions = TileDefinitions.getInstance();
         var _loc5_:Array = param1.tiles;
         var _loc6_:int = 0;
         while(_loc6_ < param1.height)
         {
            _loc7_ = 0;
            while(_loc7_ < param1.width)
            {
               _loc4_ = _loc5_[_loc7_ + _loc6_ * _width];
               if(_loc4_.tileType === _loc2_.RIVER)
               {
                  _loc3_ = setTileOfType(_loc2_.GRASS,_loc7_,_loc6_);
                  _loc3_.type = _loc2_.RIVER;
                  _loc3_.addLayerFromClipClass(Tile.GROUND_LAYER,_loc4_.riverDirection);
                  _loc3_.terrainDefinition = _loc2_.RIVER_DEFINITION;
                  _loc3_.features.riverDirection = _loc4_.riverDirection;
               }
               else
               {
                  setTileOfType(_loc4_.tileType,_loc7_,_loc6_);
               }
               if(_loc4_.hasOwnProperty("specialTerrain"))
               {
                  _loc3_ = tileAt(_loc7_,_loc6_);
                  _loc8_ = _loc2_.terrainSpecialPropertyDefinitionsByID[_loc4_.specialTerrain];
                  _loc3_.terrainSpecialProperty = _loc8_;
                  _loc3_.clearLayersOfType(Tile.PROPS_LAYER,false);
                  _loc3_.addLayerFromClipClass(Tile.PROPS_LAYER,_loc8_.graphicClass,true,true);
               }
               _loc7_++;
            }
            _loc6_++;
         }
         this.riverBeginPosition = param1.riverBeginPosition;
         this.riverEndPosition = param1.riverEndPosition;
         this._terrainGenerator.addDifficultyNoise();
         this._terrainGenerator.beautify();
         this._terrainGenerator.addVariantHints();
         this._terrainGenerator.addTileExtras();
      }
      
      public function buildTerrainFromCompressedJSON(param1:String, param2:WorldSeed) : void
      {
         this._terrainGenerator.setSeed(param2);
         this._terrainGenerator.setMap(this);
         var _loc3_:Object = Squeeze.decodeCompressedJSON(param1);
         this.buildTerrain(_loc3_);
      }
      
      public function exportMapDescription() : void
      {
         this.saveTextFile(this.getMapDescription(),"map_description.txt");
      }
      
      public function saveTextFile(param1:String, param2:String) : void
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         var _loc4_:FileReference = new FileReference();
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.saveDataToFileIOErrorHandler);
         _loc4_.save(_loc3_,param2);
      }
      
      public function damageCity(param1:int) : void
      {
         var _loc2_:Building = null;
         var _loc3_:int = 0;
         var _loc4_:Array = system.city.buildingManager.getDamageableBuildings();
         _loc4_ = this.shuffleArray(_loc4_);
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc6_];
            if(param1 >= _loc2_.definition.monkeyMoneyCost)
            {
               param1 = param1 - _loc2_.definition.monkeyMoneyCost;
               _loc2_.damage();
               _loc5_++;
            }
            _loc6_++;
         }
         if(_loc5_ === 0)
         {
            _loc2_ = _loc4_[int(Math.random() * _loc4_.length)];
            if(_loc2_ != null)
            {
               _loc2_.damage();
            }
         }
      }
      
      public function getCapturedSpecialTerrains() : Object
      {
         var _loc2_:Tile = null;
         var _loc1_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < _tiles.length)
         {
            _loc2_ = _tiles[_loc3_];
            if(_loc2_.isCaptured && _loc2_.terrainSpecialProperty !== null)
            {
               _loc1_[_loc2_.terrainSpecialProperty.id] = _loc2_;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function countCapturedTilesOfType(param1:String) : int
      {
         var _loc2_:Tile = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _tiles.length)
         {
            _loc2_ = _tiles[_loc4_];
            if(_loc2_.isCaptured && _loc2_.type == param1)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function shuffleArray(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:int = param1.length;
         while(_loc2_)
         {
            _loc4_ = Math.floor(Math.random() * _loc2_--);
            _loc3_ = param1[_loc2_];
            param1[_loc2_] = param1[_loc4_];
            param1[_loc4_] = _loc3_;
         }
         return param1;
      }
      
      public function addCitizens() : void
      {
         var _loc1_:Tile = null;
         var _loc2_:int = 0;
         while(_loc2_ < _tiles.length)
         {
            _loc1_ = _tiles[_loc2_];
            _loc1_.addCitizens();
            _loc2_++;
         }
      }
   }
}

class Range#293
{
    
   
   public var low:Number;
   
   public var high:Number;
   
   function Range#293(param1:Number = 0, param2:Number = 0)
   {
      super();
      this.low = param1;
      this.high = param2;
   }
   
   public function valueIsInRange(param1:Number) : Boolean
   {
      return param1 >= this.low && param1 <= this.high;
   }
}
