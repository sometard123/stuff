package ninjakiwi.monkeyTown.display.tileSystem
{
   import com.lgrey.utils.LGMathUtil;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.BuildingFactory;
   import ninjakiwi.monkeyTown.town.tile.TileFactory;
   
   public class TileMap
   {
       
      
      protected var LGMath:LGMathUtil;
      
      public var system:MonkeySystem;
      
      protected var _tiles:Vector.<Tile>;
      
      protected var _width:int;
      
      protected var _height:int;
      
      protected var _renderWidthTileSpace:int;
      
      protected var _renderHeightTileSpace:int;
      
      protected var _tileWidth:int;
      
      protected var _tileHeight:int;
      
      protected var _tileFactory:TileFactory;
      
      protected var _buildingFactory:BuildingFactory;
      
      public var tilesWithFences:Vector.<Vector.<Tile>>;
      
      public function TileMap(param1:int, param2:int, param3:int, param4:int)
      {
         this.LGMath = LGMathUtil.getInstance();
         this.system = MonkeySystem.getInstance();
         this._tileFactory = TileFactory.getInstance();
         this._buildingFactory = BuildingFactory.getInstance();
         this.tilesWithFences = new Vector.<Vector.<Tile>>();
         super();
         this._width = param1;
         this._height = param2;
         this._tileWidth = param3;
         this._tileHeight = param4;
         this.init(true);
      }
      
      public function clear() : void
      {
         var _loc1_:int = this._tiles.length;
         var _loc2_:int = 0;
         while(_loc2_ < this._tiles.length)
         {
            if(this._tiles[_loc2_])
            {
               this._tiles[_loc2_].clear();
            }
            _loc2_++;
         }
         this.initCachedTilesWithFences();
      }
      
      private function init(param1:Boolean = false) : void
      {
         this._renderWidthTileSpace = this.system.RENDER_SURFACE_WIDTH / this.system.TOWN_GRID_UNIT_SIZE + 2;
         this._renderHeightTileSpace = this.system.RENDER_SURFACE_HEIGHT / this.system.TOWN_GRID_UNIT_SIZE + 2;
         this._tiles = new Vector.<Tile>(this._width * this._height);
         if(param1)
         {
            this.populateWithBlankTiles();
         }
         this.initCachedTilesWithFences();
         this.system.resizeSignal.add(this.onResize);
      }
      
      public function populateWithBlankTiles() : void
      {
         var _loc1_:Tile = null;
         var _loc3_:int = 0;
         this._tiles.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc1_ = new Tile();
               _loc1_.x = _loc3_ * this.system.TOWN_GRID_UNIT_SIZE;
               _loc1_.y = _loc2_ * this.system.TOWN_GRID_UNIT_SIZE;
               _loc1_.positionTilespace.set(_loc3_,_loc2_);
               this._tiles[_loc3_ + _loc2_ * this._width] = _loc1_;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function setPropsOfTile() : void
      {
      }
      
      public function setTileOfType(param1:String, param2:int, param3:int) : Tile
      {
         if(param2 < 0 || param2 >= this._width)
         {
            return null;
         }
         if(param3 < 0 || param3 >= this._height)
         {
            return null;
         }
         var _loc4_:Tile = this._tileFactory.makeRandomTileOfType(param1,true);
         _loc4_.x = param2 * this.system.TOWN_GRID_UNIT_SIZE;
         _loc4_.y = param3 * this.system.TOWN_GRID_UNIT_SIZE;
         _loc4_.positionTilespace.set(param2,param3);
         this._tiles[param2 + param3 * this._width] = _loc4_;
         return _loc4_;
      }
      
      public function setTile(param1:Tile, param2:int, param3:int) : void
      {
         if(param2 < 0 || param2 >= this._width)
         {
            return;
         }
         if(param3 < 0 || param3 >= this._height)
         {
            return;
         }
         param1.x = param2 * this.system.TOWN_GRID_UNIT_SIZE;
         param1.y = param3 * this.system.TOWN_GRID_UNIT_SIZE;
         param1.positionTilespace.set(param2,param3);
         this._tiles[param2 + param3 * this._width] = param1;
      }
      
      public function tileAt(param1:int, param2:int, param3:Boolean = false) : Tile
      {
         if(!param3)
         {
            if(param1 < 0 || param1 >= this._width)
            {
               return null;
            }
            if(param2 < 0 || param2 >= this._height)
            {
               return null;
            }
         }
         else
         {
            param1 = this.LGMath.clamp(param1,0,this._width - 1);
            param2 = this.LGMath.clamp(param2,0,this._height - 1);
         }
         return this._tiles[param1 + param2 * this._width];
      }
      
      private function onResize(param1:int, param2:int) : void
      {
         this._renderWidthTileSpace = this.LGMath.clamp(param1 / this.system.TOWN_GRID_UNIT_SIZE + 2,0,this.system.TOWN_MAP_WIDTH_GRIDSPACE);
         this._renderHeightTileSpace = this.LGMath.clamp(param2 / this.system.TOWN_GRID_UNIT_SIZE + 2,0,this.system.TOWN_MAP_HEIGHT_GRIDSPACE);
      }
      
      public function findTilesRequiringRedraw() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = this._tiles.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this._tiles[_loc2_].requiresRedraw = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this._tiles[_loc2_].applyRedrawFlagToAffectedNeighbours(this);
            _loc2_++;
         }
      }
      
      private function initCachedTilesWithFences() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._height)
         {
            this.tilesWithFences[_loc1_] = new Vector.<Tile>();
            _loc1_++;
         }
      }
      
      public function cacheTilesWithFences() : void
      {
         var _loc1_:Vector.<Tile> = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Tile = null;
         _loc2_ = 0;
         while(_loc2_ < this._height)
         {
            _loc1_ = this.tilesWithFences[_loc2_];
            _loc1_.length = 0;
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc4_ = this._tiles[_loc3_ + _loc2_ * this._width];
               if(_loc4_.fence.hasVisibleFencePieces())
               {
                  _loc1_.push(_loc4_);
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function render(param1:BitmapData, param2:Rectangle, param3:Boolean = false) : void
      {
         var _loc8_:Tile = null;
         var _loc9_:Vector.<Tile> = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc4_:int = this.LGMath.clamp(param2.x / this._tileWidth,0,this._width - this._renderWidthTileSpace);
         var _loc5_:int = this.LGMath.clamp(_loc4_ + this._renderWidthTileSpace,this._renderWidthTileSpace,this._width);
         var _loc6_:int = this.LGMath.clamp(param2.y / this._tileHeight,0,this._height - this._renderHeightTileSpace);
         var _loc7_:int = this.LGMath.clamp(_loc6_ + this._renderHeightTileSpace,this._renderHeightTileSpace,this._height);
         if(_loc4_ < 0)
         {
         }
         var _loc10_:Array = [];
         _loc11_ = _loc6_;
         while(_loc11_ < _loc7_)
         {
            _loc12_ = _loc4_;
            while(_loc12_ < _loc5_)
            {
               _loc8_ = this._tiles[_loc12_ + _loc11_ * this._width];
               _loc8_.render(param1,param2);
               _loc12_++;
            }
            _loc11_++;
         }
      }
      
      public function renderWholeMap(param1:BitmapData) : void
      {
         var _loc2_:Tile = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._height)
         {
            _loc4_ = 0;
            while(_loc4_ < this._width)
            {
               _loc2_ = this._tiles[_loc4_ + _loc3_ * this._width];
               _loc2_.render(param1,param1.rect);
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function setVisibilityOfBlockOfTiles(param1:int, param2:int, param3:int, param4:int) : void
      {
      }
      
      public function get tiles() : Vector.<Tile>
      {
         return this._tiles;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
   }
}
