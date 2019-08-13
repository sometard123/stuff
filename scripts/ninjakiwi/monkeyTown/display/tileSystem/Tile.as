package ninjakiwi.monkeyTown.display.tileSystem
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainSpecialPropertyDefinition;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntityPlayOnce;
   import ninjakiwi.monkeyTown.town.flare.CitizensData;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.tileProps.TileEdgeSetVariantsDefinition;
   import ninjakiwi.monkeyTown.town.tileProps.fence.Fence;
   import ninjakiwi.monkeyTown.town.tileProps.fence.FenceAssetsDefinition;
   import ninjakiwi.monkeyTown.town.townMap.ColorTransformConstants;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.Signal;
   
   public class Tile
   {
      
      private static const capturedOverlay:BitClipCustom = new BitClipCustom("assets.tiles.GroundCapturedTileClip");
      
      public static const GROUND_LAYER:String = "GROUND_LAYER";
      
      public static const GROUND_EDGE_LAYER:String = "GROUND_EDGE_LAYER";
      
      public static const PROPS_LAYER:String = "PROPS_LAYER";
      
      public static const ALT_PROPS_LAYER:String = "ALT_PROPS_LAYER";
      
      public static const BUILDING_LAYER:String = "BUILDING_LAYER";
      
      public static const SPECIAL_ITEMS_LAYER:String = "SPECIAL_ITEMS_LAYER";
      
      public static const tileChangedSignal:Signal = new Signal(Tile);
      
      public static const _hoveredTiles:Array = [];
      
      private static var howManyTreasures:int = 0;
       
      
      public var x:int;
      
      public var y:int;
      
      public var positionTilespace:IntPoint2D;
      
      public var type:String;
      
      public var visible:Boolean = true;
      
      public var definition:TileDefinition = null;
      
      public var terrainSpecialProperty:TerrainSpecialPropertyDefinition = null;
      
      public var features:Object;
      
      public var building:Building = null;
      
      public var isCaptured:Boolean = false;
      
      public var isUnderPvPAttack:Boolean = false;
      
      public var pvpAttackSquare:PvPAttackSquare = null;
      
      public var fence:Fence;
      
      public var hasAnimations:Boolean = false;
      
      public var requiresRedraw:Boolean = false;
      
      public var edgeSet:TileEdgeSetVariantsDefinition = null;
      
      public var fenceAssets:FenceAssetsDefinition;
      
      public var hasTreasureChest:Boolean = false;
      
      public var treasureType:String = null;
      
      public var saveDefinition:TileSaveDefinition = null;
      
      public var difficultyModifier:Number = 0;
      
      public var trackSelectionBias:Number = 0;
      
      public var variantHint:uint = 0;
      
      public var isCamoTile:Boolean = false;
      
      public var isRegenTile:Boolean = false;
      
      public var hasCitizens:Boolean = false;
      
      public var requiresDrawFlag:Boolean = true;
      
      public var sort:Number = 0;
      
      public var facadeAnimations:Vector.<BitClipCustom>;
      
      private var _layers:Vector.<BitClipCustom>;
      
      private var _surfaceLayers:Vector.<BitClipCustom>;
      
      private var _layersAboveSurface:Vector.<BitClipCustom>;
      
      private var _groundLayers:Vector.<BitClipCustom>;
      
      private var _groundEdgeLayers:Vector.<BitClipCustom>;
      
      private var _propsLayers:Vector.<BitClipCustom>;
      
      private var _altPropsLayers:Vector.<BitClipCustom>;
      
      private var _buildingLayers:Vector.<BitClipCustom>;
      
      private var _specialItemsLayers:Vector.<BitClipCustom>;
      
      private var _terrainDefinition:TerrainDefinition = null;
      
      private var _uniqueDataDefinition:TileUniqueDataDefinition = null;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _tileDefinitions:TileDefinitions;
      
      private var _seed:int = -1;
      
      private var retainedProps:Vector.<BitClipCustom> = null;
      
      private var retainedGroundLayers:Vector.<BitClipCustom> = null;
      
      private var _hoverLocked:Boolean = false;
      
      public var tileTop:Tile;
      
      public var tileRight:Tile;
      
      public var tileBottom:Tile;
      
      public var tileLeft:Tile;
      
      public var tileRT:Tile;
      
      public var tileRB:Tile;
      
      public var tileLB:Tile;
      
      public var tileLT:Tile;
      
      public var surroundingTiles:Array;
      
      public function Tile()
      {
         this.positionTilespace = new IntPoint2D();
         this.features = {};
         this.fence = new Fence();
         this.fenceAssets = Fence.defaultFenceAssets;
         this.facadeAnimations = new Vector.<BitClipCustom>();
         this._layers = new Vector.<BitClipCustom>();
         this._surfaceLayers = new Vector.<BitClipCustom>();
         this._layersAboveSurface = new Vector.<BitClipCustom>();
         this._groundLayers = new Vector.<BitClipCustom>();
         this._groundEdgeLayers = new Vector.<BitClipCustom>();
         this._propsLayers = new Vector.<BitClipCustom>();
         this._altPropsLayers = new Vector.<BitClipCustom>();
         this._buildingLayers = new Vector.<BitClipCustom>();
         this._specialItemsLayers = new Vector.<BitClipCustom>();
         this._tileDefinitions = TileDefinitions.getInstance();
         super();
         this.fence.changedSignal.add(this.build);
      }
      
      public static function unhoverAllTiles() : void
      {
         var _loc1_:int = _hoveredTiles.length - 1;
         while(_loc1_ >= 0)
         {
            _hoveredTiles[_loc1_].unhover();
            _loc1_--;
         }
      }
      
      public function clear() : Tile
      {
         this._layers.length = 0;
         this._surfaceLayers.length = 0;
         this._layersAboveSurface.length = 0;
         this._groundLayers.length = 0;
         this._groundEdgeLayers.length = 0;
         this._propsLayers.length = 0;
         this._altPropsLayers.length = 0;
         this._buildingLayers.length = 0;
         this._specialItemsLayers.length = 0;
         this.hasAnimations = false;
         this.visible = true;
         this.fence.reset();
         this.isCaptured = false;
         this.definition = null;
         this._terrainDefinition = null;
         this.terrainSpecialProperty = null;
         this.building = null;
         return this;
      }
      
      public function build() : void
      {
         this._layers.length = 0;
         this._surfaceLayers.length = 0;
         this._layersAboveSurface.length = 0;
         this._surfaceLayers = this._groundLayers.concat(this._groundEdgeLayers);
         if(this.isCaptured)
         {
            this._surfaceLayers.push(capturedOverlay);
         }
         this._layersAboveSurface = this._altPropsLayers.length == 0?this._layersAboveSurface.concat(this._propsLayers):this._layersAboveSurface.concat(this._altPropsLayers);
         if(this._altPropsLayers.length == 0)
         {
            this._layersAboveSurface = this._layersAboveSurface.concat(this._buildingLayers);
         }
         this._layersAboveSurface = this._layersAboveSurface.concat(this._specialItemsLayers);
         this._layersAboveSurface = this._layersAboveSurface.concat(this.fence.frontLayers);
         this._layers = this._surfaceLayers.concat(this._layersAboveSurface);
         var _loc1_:int = this._layers.length;
         this.hasAnimations = false;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._layers[_loc2_].totalFrames > 1)
            {
               this.hasAnimations = true;
               break;
            }
            _loc2_++;
         }
      }
      
      public function addLayerFromClipClass(param1:String, param2:String, param3:Boolean = false, param4:Boolean = true) : BitClipCustom
      {
         var _loc5_:BitClipCustom = this.makeHoverableClipFromClassName(param2,param3);
         this.addLayerClip(param1,_loc5_,param3,param4);
         return _loc5_;
      }
      
      public function addLayerClip(param1:String, param2:BitClipCustom, param3:Boolean = false, param4:Boolean = true) : BitClipCustom
      {
         if(param2 == null)
         {
            return null;
         }
         switch(param1)
         {
            case GROUND_LAYER:
               if(param2)
               {
                  this._groundLayers.push(param2);
               }
               break;
            case GROUND_EDGE_LAYER:
               if(param2)
               {
                  this._groundEdgeLayers.push(param2);
               }
               break;
            case PROPS_LAYER:
               if(param2)
               {
                  this._propsLayers.push(param2);
               }
               break;
            case ALT_PROPS_LAYER:
               if(param2)
               {
                  this._altPropsLayers.push(param2);
               }
               break;
            case BUILDING_LAYER:
               if(param2)
               {
                  this._buildingLayers.push(param2);
               }
               break;
            case SPECIAL_ITEMS_LAYER:
               if(param2)
               {
                  this._specialItemsLayers.push(param2);
               }
         }
         if(param4)
         {
            this.build();
         }
         return param2;
      }
      
      public function clearLayersOfType(param1:String, param2:Boolean = true) : Tile
      {
         switch(param1)
         {
            case GROUND_LAYER:
               this._groundLayers.length = 0;
               break;
            case GROUND_EDGE_LAYER:
               this._groundEdgeLayers.length = 0;
               break;
            case PROPS_LAYER:
               this._propsLayers.length = 0;
               break;
            case ALT_PROPS_LAYER:
               this._altPropsLayers.length = 0;
               break;
            case BUILDING_LAYER:
               this._buildingLayers.length = 0;
               break;
            case SPECIAL_ITEMS_LAYER:
               this._specialItemsLayers.length = 0;
         }
         if(param2)
         {
            this.build();
         }
         return this;
      }
      
      public function retainPropsLayers() : void
      {
         this.retainedProps = this._propsLayers.slice();
      }
      
      public function recoverPropsLayers() : void
      {
         if(this.retainedProps === null)
         {
            return;
         }
         this._propsLayers = this.retainedProps.slice();
         this.build();
      }
      
      public function retainGroundLayers() : void
      {
         this.retainedGroundLayers = this._groundLayers.slice();
      }
      
      private function recoverGroundLayers() : void
      {
         if(this.retainedGroundLayers === null)
         {
            return;
         }
         this._groundLayers = this.retainedGroundLayers.slice();
         this.build();
      }
      
      public function restoreToVirginState() : void
      {
         this.building = null;
         this.clearLayersOfType(Tile.BUILDING_LAYER);
         this.clearLayersOfType(Tile.GROUND_LAYER);
         this.recoverGroundLayers();
         this.recoverPropsLayers();
      }
      
      public function addFacadeAnimation(param1:String, param2:Boolean = false) : BitClipCustom
      {
         var clip:BitClipCustom = null;
         var clipClass:String = param1;
         var removeOnComplete:Boolean = param2;
         clip = new BitClipCustom();
         clip.graphicsClassName = clipClass;
         clip.addAnimation(clipClass,clipClass + "_hover",1,false,false,false,new ColorTransform(1.1,1.1,1.1));
         this.facadeAnimations.push(clip);
         if(removeOnComplete)
         {
            clip.onLoopFunction = function():void
            {
               removeFacadeAnimation(clip);
            };
         }
         return clip;
      }
      
      public function removeFacadeAnimation(param1:BitClipCustom) : void
      {
         var _loc2_:BitClipCustom = null;
         var _loc3_:int = this.facadeAnimations.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = this.facadeAnimations[_loc3_];
            if(_loc2_ === param1)
            {
               this.facadeAnimations.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function makeHoverableClipFromClassName(param1:String, param2:Boolean = false) : BitClipCustom
      {
         var _loc3_:BitClipCustom = new BitClipCustom();
         _loc3_.graphicsClassName = param1;
         _loc3_.addAnimation(param1,param1,1,false,false,true);
         if(param2 && _loc3_.totalFrames > 1)
         {
            _loc3_.gotoAndPlay(int(Math.random() * _loc3_.totalFrames) + 1);
         }
         return _loc3_;
      }
      
      public function selectDefaultAnimation() : Tile
      {
         var _loc1_:BitClipCustom = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._layers.length)
         {
            _loc1_ = this._layers[_loc2_];
            _loc3_ = _loc1_.currentFrame;
            if(_loc1_.hasAnimation(_loc1_.graphicsClassName))
            {
               _loc1_.selectAnimation(_loc1_.graphicsClassName);
            }
            _loc1_.currentFrame = _loc3_;
            _loc2_++;
         }
         return this;
      }
      
      private function hoverDifficulty(param1:int = -1) : Tile
      {
         var _loc2_:BitClipCustom = null;
         if(this._hoverLocked)
         {
            return this;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._layers.length)
         {
            _loc2_ = this._layers[_loc3_];
            if(!_loc2_)
            {
               return this;
            }
            if(param1 === -1)
            {
               _loc2_.colorTransform = ColorTransformConstants.HOVER_COLOR_TRANSFORM;
            }
            else
            {
               _loc2_.colorTransform = ColorTransformConstants.getColorTransformForDifficulty(param1);
               _loc2_.filters = [ColorTransformConstants.HEAT_MAP_DESATURATE_FILTER];
            }
            _loc3_++;
         }
         return this;
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         var _loc2_:BitClipCustom = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._layers.length)
         {
            _loc2_ = this._layers[_loc3_];
            _loc2_.colorTransform = param1;
            _loc3_++;
         }
      }
      
      public function lockHover() : void
      {
         this._hoverLocked = true;
      }
      
      public function unlockHover() : void
      {
         this._hoverLocked = false;
      }
      
      public function hover() : Tile
      {
         this.hoverDifficulty(-1);
         _hoveredTiles.push(this);
         return this;
      }
      
      public function unhover() : Tile
      {
         var _loc2_:BitClipCustom = null;
         if(this._hoverLocked)
         {
            return this;
         }
         var _loc1_:Vector.<BitClipCustom> = this._layers.concat(this._propsLayers);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(!_loc2_)
            {
               return this;
            }
            _loc2_.colorTransform = null;
            _loc2_.filters = [];
            _loc3_++;
         }
         var _loc4_:int = _hoveredTiles.indexOf(this);
         if(_loc4_ !== -1)
         {
            _hoveredTiles.splice(_loc4_,1);
         }
         this.clearLayersOfType(ALT_PROPS_LAYER);
         return this;
      }
      
      public function selectTransformedAnimationByKey(param1:String) : Tile
      {
         var _loc2_:BitClipCustom = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._layers.length)
         {
            _loc2_ = this._layers[_loc3_];
            _loc4_ = _loc2_.currentFrame;
            _loc2_.selectAnimation(_loc2_.graphicsClassName + param1);
            _loc2_.currentFrame = _loc4_;
            _loc3_++;
         }
         return this;
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this._layers);
      }
      
      public function renderLayers(param1:BitmapData, param2:Rectangle, param3:Vector.<BitClipCustom>) : void
      {
         var _loc4_:BitClipCustom = null;
         if(!this.visible)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param3.length)
         {
            _loc4_ = param3[_loc5_];
            _loc4_.x = this.x;
            _loc4_.y = this.y;
            _loc4_.render(param1,param2);
            _loc5_++;
         }
      }
      
      public function renderFenceBack(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this.fence.backLayers);
      }
      
      public function renderFenceMid(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this.fence.midLayers);
      }
      
      public function renderSurfaceLayers(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this._surfaceLayers);
      }
      
      public function renderLayersAboveSurface(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this._layersAboveSurface);
      }
      
      public function renderFacadeAnimations(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderLayers(param1,param2,this.facadeAnimations);
      }
      
      public function beautify(param1:TileMap) : Tile
      {
         if(!this.edgeSet)
         {
            return this;
         }
         var _loc2_:Tile = new Tile();
         _loc2_.terrainDefinition = this._tileDefinitions.GRASS_DEFINITION;
         var _loc3_:String = this._terrainDefinition.groundType;
         this.tileTop = param1.tileAt(this.positionTilespace.x,this.positionTilespace.y - 1,true);
         this.tileRight = param1.tileAt(this.positionTilespace.x + 1,this.positionTilespace.y,true);
         this.tileBottom = param1.tileAt(this.positionTilespace.x,this.positionTilespace.y + 1,true);
         this.tileLeft = param1.tileAt(this.positionTilespace.x - 1,this.positionTilespace.y,true);
         this.tileRT = param1.tileAt(this.positionTilespace.x + 1,this.positionTilespace.y - 1,true);
         this.tileRB = param1.tileAt(this.positionTilespace.x + 1,this.positionTilespace.y + 1,true);
         this.tileLB = param1.tileAt(this.positionTilespace.x - 1,this.positionTilespace.y + 1,true);
         this.tileLT = param1.tileAt(this.positionTilespace.x - 1,this.positionTilespace.y - 1,true);
         this.surroundingTiles = [this.tileTop,this.tileRight,this.tileBottom,this.tileLeft,this.tileRT,this.tileRB,this.tileLB,this.tileLT];
         if(this.positionTilespace.y == 0)
         {
            this.tileTop = _loc2_;
            this.tileLT = _loc2_;
            this.tileRT = _loc2_;
         }
         var _loc4_:Boolean = this.tileTop.terrainDefinition.groundType != _loc3_ && this.tileTop.terrainDefinition.groundType == this.tileRT.terrainDefinition.groundType && this.tileTop.terrainDefinition.groundType == this.tileRight.terrainDefinition.groundType;
         var _loc5_:Boolean = this.tileRight.terrainDefinition.groundType != _loc3_ && this.tileRight.terrainDefinition.groundType == this.tileRB.terrainDefinition.groundType && this.tileRight.terrainDefinition.groundType == this.tileBottom.terrainDefinition.groundType;
         var _loc6_:Boolean = this.tileBottom.terrainDefinition.groundType != _loc3_ && this.tileBottom.terrainDefinition.groundType == this.tileLB.terrainDefinition.groundType && this.tileBottom.terrainDefinition.groundType == this.tileLeft.terrainDefinition.groundType;
         var _loc7_:Boolean = this.tileLeft.terrainDefinition.groundType != _loc3_ && this.tileLeft.terrainDefinition.groundType == this.tileLT.terrainDefinition.groundType && this.tileTop.terrainDefinition.groundType == this.tileLeft.terrainDefinition.groundType;
         var _loc8_:Boolean = !_loc4_ && this.tileTop.terrainDefinition.groundType != _loc3_ && this.tileTop.terrainDefinition.groundType == this.tileRight.terrainDefinition.groundType && (this.edgeSet.roShamBo > this.tileTop.edgeSet.roShamBo || this.tileRT.terrainDefinition.groundType != _loc3_);
         var _loc9_:Boolean = !_loc5_ && this.tileRight.terrainDefinition.groundType != _loc3_ && this.tileRight.terrainDefinition.groundType == this.tileBottom.terrainDefinition.groundType && (this.edgeSet.roShamBo > this.tileRight.edgeSet.roShamBo || this.tileRB.terrainDefinition.groundType != _loc3_);
         var _loc10_:Boolean = !_loc6_ && this.tileBottom.terrainDefinition.groundType != _loc3_ && this.tileBottom.terrainDefinition.groundType == this.tileLeft.terrainDefinition.groundType && (this.edgeSet.roShamBo > this.tileBottom.edgeSet.roShamBo || this.tileLB.terrainDefinition.groundType != _loc3_);
         var _loc11_:Boolean = !_loc7_ && this.tileLeft.terrainDefinition.groundType != _loc3_ && this.tileLeft.terrainDefinition.groundType == this.tileTop.terrainDefinition.groundType && (this.edgeSet.roShamBo > this.tileLeft.edgeSet.roShamBo || this.tileLT.terrainDefinition.groundType != _loc3_);
         if(_loc4_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileTop.edgeSet.cornerRT),false,false);
         }
         if(_loc5_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileRight.edgeSet.cornerRB),false,false);
         }
         if(_loc6_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileBottom.edgeSet.cornerLB),false,false);
         }
         if(_loc7_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileLeft.edgeSet.cornerLT),false,false);
         }
         if(_loc8_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileTop.edgeSet.cornerRT),false,false);
         }
         if(_loc9_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileRight.edgeSet.cornerRB),false,false);
         }
         if(_loc10_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileBottom.edgeSet.cornerLB),false,false);
         }
         if(_loc11_)
         {
            this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileLeft.edgeSet.cornerLT),false,false);
         }
         this.edgeTest(this._tileDefinitions.GRASS_GROUND);
         this.edgeTest(this._tileDefinitions.DESERT_GROUND,this._tileDefinitions.WATER_GROUND);
         this.edgeTest(this._tileDefinitions.DESERT_GROUND,this._tileDefinitions.SNOW_GROUND);
         this.edgeTest(this._tileDefinitions.SNOW_GROUND,this._tileDefinitions.WATER_GROUND);
         this.build();
         return this;
      }
      
      private function edgeTest(param1:String, param2:String = null) : void
      {
         var _loc3_:String = this.terrainDefinition.groundType;
         if(_loc3_ == this._tileDefinitions.SNOW)
         {
         }
         if(param2 && param2 != _loc3_ || _loc3_ == param1)
         {
            return;
         }
         if(this.tileTop.terrainDefinition.groundType == param1)
         {
            if(this.tileLT.terrainDefinition.groundType != _loc3_ && this.tileRT.terrainDefinition.groundType != _loc3_)
            {
               this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileTop.edgeSet.edgeTop),false,false);
            }
            else
            {
               if(this.tileLT.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileTop.edgeSet.edgeTopHalfLeft),false,false);
               }
               if(this.tileRT.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileTop.edgeSet.edgeTopHalfRight),false,false);
               }
            }
         }
         if(this.tileRight.terrainDefinition.groundType == param1)
         {
            if(this.tileRT.terrainDefinition.groundType != _loc3_ && this.tileRB.terrainDefinition.groundType != _loc3_)
            {
               this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileRight.edgeSet.edgeRight),false,false);
            }
            else
            {
               if(this.tileRT.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileRight.edgeSet.edgeRightHalfTop),false,false);
               }
               if(this.tileRB.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileRight.edgeSet.edgeRightHalfBottom),false,false);
               }
            }
         }
         if(this.tileBottom.terrainDefinition.groundType == param1)
         {
            if(this.tileRB.terrainDefinition.groundType != _loc3_ && this.tileLB.terrainDefinition.groundType != _loc3_)
            {
               this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileBottom.edgeSet.edgeBottom),false,false);
            }
            else
            {
               if(this.tileRB.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileBottom.edgeSet.edgeBottomHalfRight),false,false);
               }
               if(this.tileLB.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileBottom.edgeSet.edgeBottomHalfLeft),false,false);
               }
            }
         }
         if(this.tileLeft.terrainDefinition.groundType == param1)
         {
            if(this.tileLB.terrainDefinition.groundType != _loc3_ && this.tileLT.terrainDefinition.groundType != _loc3_)
            {
               this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileLeft.edgeSet.edgeLeft),false,false);
            }
            else
            {
               if(this.tileLB.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileLeft.edgeSet.edgeLeftHalfBottom),false,false);
               }
               if(this.tileLT.terrainDefinition.groundType != _loc3_)
               {
                  this.addLayerClip(GROUND_LAYER,this.createClipVariant(this.tileLeft.edgeSet.edgeLeftHalfTop),false,false);
               }
            }
         }
      }
      
      public function createClipVariant(param1:Array) : BitClipCustom
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:String = param1[this._system.RND.nextInteger(param1.length)];
         var _loc3_:BitClipCustom = new BitClipCustom();
         _loc3_.addAnimation(_loc2_,null,1);
         return _loc3_;
      }
      
      public function applyRedrawFlagToAffectedNeighbours(param1:TileMap) : void
      {
         if(this.hasAnimations)
         {
            this.tileTop.requiresRedraw = true;
            this.tileRight.requiresRedraw = true;
            this.tileBottom.requiresRedraw = true;
            this.tileLeft.requiresRedraw = true;
            this.tileRT.requiresRedraw = true;
            this.tileRB.requiresRedraw = true;
            this.tileLB.requiresRedraw = true;
            this.tileLT.requiresRedraw = true;
         }
      }
      
      public function getSaveDefinition() : TileSaveDefinition
      {
         var _loc1_:SpecialItemData = SpecialItemData.getInstance();
         if(!this.isCaptured && !this.hasTreasureChest && !this._uniqueDataDefinition)
         {
            return null;
         }
         if(this.saveDefinition == null)
         {
            this.saveDefinition = new TileSaveDefinition();
         }
         this.saveDefinition.x = this.positionTilespace.x;
         this.saveDefinition.y = this.positionTilespace.y;
         this.saveDefinition.isCaptured = this.isCaptured;
         this.saveDefinition.features = this.features;
         this.saveDefinition.terrainDefinitionID = this._terrainDefinition.id;
         this.saveDefinition.hasTreasureChest = this.hasTreasureChest;
         if(this.hasTreasureChest)
         {
            this.saveDefinition.treasureType = this.treasureType === _loc1_.CASH?int(_loc1_.CASH_ID):int(_loc1_.ITEM_ID);
         }
         this.saveDefinition.uniqueDataDefinition = this.uniqueDataDefinition;
         if(this.building && this.building.homeTile == this)
         {
            this.saveDefinition.buildingSaveDef = this.building.getSaveDefinition();
         }
         else
         {
            this.saveDefinition.buildingSaveDef = null;
         }
         return this.saveDefinition;
      }
      
      public function populateFromSaveDefinition(param1:TileSaveDefinition, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SpecialItemData = SpecialItemData.getInstance();
         this.x = param1.x * this._system.TOWN_GRID_UNIT_SIZE;
         this.y = param1.y * this._system.TOWN_GRID_UNIT_SIZE;
         this.positionTilespace = new IntPoint2D(param1.x,param1.y);
         this.isCaptured = param1.isCaptured;
         this.uniqueDataDefinition = param1.uniqueDataDefinition;
         this.features = Object(param1.features);
         if(param1.hasTreasureChest)
         {
            if(this.isCaptured)
            {
               this.hasTreasureChest = false;
            }
            else
            {
               this.hasTreasureChest = true;
               if(param1.treasureType === _loc4_.CASH_ID)
               {
                  this.addTreasureChest(_loc4_.CASH);
               }
               else
               {
                  this.addTreasureChest(_loc4_.ITEM);
               }
            }
         }
      }
      
      private function getGraphicsClassNames(param1:Vector.<BitClipCustom>) : Vector.<String>
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = new Vector.<String>();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_.push(param1[_loc2_].graphicsClassName);
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function clearTreasureChest() : void
      {
         this.hasTreasureChest = false;
         this._specialItemsLayers.length = 0;
         var treasureCollectedAnimation:SpriteEntityPlayOnce = new SpriteEntityPlayOnce("assets.tiles.TreasureChest",function(param1:SpriteEntityPlayOnce):void
         {
            _specialItemsLayers.length = 0;
            build();
         });
         this._specialItemsLayers.push(treasureCollectedAnimation.clip);
         this.build();
      }
      
      public function getInformation(param1:TownMap) : String
      {
         var _loc2_:String = "";
         _loc2_ = _loc2_ + ("Terrain: " + this.terrainDefinition.name + "<br/>");
         _loc2_ = _loc2_ + ("Level: " + param1.getDifficultyAtLocation(this.positionTilespace.x,this.positionTilespace.y) + "<br/>");
         return _loc2_;
      }
      
      public function addTreasureChest(param1:String) : void
      {
         this.hasTreasureChest = true;
         this.treasureType = param1;
         var _loc2_:BitClipCustom = this.addLayerFromClipClass(Tile.SPECIAL_ITEMS_LAYER,"assets.tiles.TreasureChest");
         _loc2_.stop();
         howManyTreasures++;
      }
      
      public function addCitizens() : void
      {
         var _loc2_:String = null;
         var _loc3_:BitClipCustom = null;
         var _loc1_:Number = 0.2;
         if(this.hasCitizens || Math.random() > _loc1_)
         {
            return;
         }
         if(this.isCaptured && this.building === null)
         {
            this._tileDefinitions.GRASS_DEFINITION;
            if(this.terrainDefinition === this._tileDefinitions.GRASS_DEFINITION || this.terrainDefinition === this._tileDefinitions.HILLS_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameGrass();
            }
            else if(this.terrainDefinition === this._tileDefinitions.LAKE_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameWater();
            }
            else if(this.terrainDefinition === this._tileDefinitions.VOLCANO_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameVolcano();
            }
            else if(this.terrainDefinition === this._tileDefinitions.MOUNTAINS_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameMountains();
            }
            else if(this.terrainDefinition === this._tileDefinitions.FOREST_DEFINITION || this.terrainDefinition === this._tileDefinitions.HEAVY_FOREST_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameForest();
            }
            else if(this.terrainDefinition === this._tileDefinitions.DESERT_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameDesert();
            }
            else if(this.terrainDefinition === this._tileDefinitions.SNOW_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameSnow();
            }
            else if(this.terrainDefinition === this._tileDefinitions.JUNGLE_DEFINITION)
            {
               _loc2_ = CitizensData.getCitizenClassnameJungle();
            }
            _loc3_ = new BitClipCustom(_loc2_);
            _loc3_.gotoAndPlay(_loc3_.totalFrames * Math.random());
            this.addLayerClip(Tile.PROPS_LAYER,_loc3_);
            this.hasCitizens = true;
         }
      }
      
      public function get seed() : uint
      {
         return uint(this._seed);
      }
      
      public function setSeed(param1:int) : void
      {
         this._seed = uint(param1);
      }
      
      public function getBaseTerrainType() : String
      {
         if(this.terrainSpecialProperty !== null)
         {
            return this.terrainSpecialProperty.id;
         }
         return this.terrainDefinition.id;
      }
      
      public function get terrainDefinition() : TerrainDefinition
      {
         return this._terrainDefinition;
      }
      
      public function set terrainDefinition(param1:TerrainDefinition) : void
      {
         this.edgeSet = this._tileDefinitions.EDGE_SETS_BY_ID[param1.edgeSetID];
         this.fenceAssets = Fence.getFenceAssetsForGround(param1.groundType);
         this._terrainDefinition = param1;
      }
      
      public function get uniqueDataDefinition() : TileUniqueDataDefinition
      {
         if(this._uniqueDataDefinition === null)
         {
            this._uniqueDataDefinition = new TileUniqueDataDefinition();
         }
         return this._uniqueDataDefinition;
      }
      
      public function set uniqueDataDefinition(param1:TileUniqueDataDefinition) : void
      {
         this._uniqueDataDefinition = param1;
      }
      
      public function get hoverLocked() : Boolean
      {
         return this._hoverLocked;
      }
   }
}
