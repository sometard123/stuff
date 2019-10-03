package ninjakiwi.monkeyTown.town.fogOfWar
{
   import assets.fog.StampGraphic;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import org.osflash.signals.Signal;
   
   public class FogOfWar
   {
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var viewDistance:int = 9;
      
      private var _fogWidth:int;
      
      private var _fogHeight:int;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      private var _fogBitmapData:BitmapData;
      
      private var _fogBitmap:Bitmap;
      
      private var _fogVector:Vector.<uint>;
      
      private var _visibilityMapVector:Vector.<Boolean>;
      
      private var _largeFogBitmapData:BitmapData;
      
      private var _largeFogBitmap:Bitmap;
      
      private var _map:TownMap;
      
      private var _fogStamp:BitmapData;
      
      private var _stampVector:Vector.<uint>;
      
      public const paddingTop:int = 3;
      
      public const paddingBottom:int = 2;
      
      public const paddingLeft:int = 2;
      
      public const paddingRight:int = 2;
      
      public const updatedSignal:Signal = new Signal();
      
      public var fogColor:uint = 4.27819008E9;
      
      private var _active:Boolean = true;
      
      private var _visibilityExpandAmount:int = 1;
      
      private var _destPoint:Point;
      
      public function FogOfWar(param1:int, param2:int, param3:TownMap)
      {
         this._mapWidth = this._system.TOWN_MAP_WIDTH_GRIDSPACE;
         this._mapHeight = this._system.TOWN_MAP_HEIGHT_GRIDSPACE;
         this._destPoint = new Point(0,0);
         super();
         this._fogWidth = param1 + this.paddingLeft + this.paddingRight;
         this._fogHeight = param2 + this.paddingTop + this.paddingBottom;
         this._map = param3;
         this._map.fog = this;
         this._fogVector = new Vector.<uint>(this._fogWidth * this._fogHeight);
         this._visibilityMapVector = new Vector.<Boolean>(this._fogWidth * this._fogHeight);
         this._fogBitmapData = new BitmapData(this._fogWidth,this._fogHeight,true);
         this._fogBitmap = new Bitmap(this._fogBitmapData);
         this._largeFogBitmapData = new BitmapData(this._fogWidth * this._system.TOWN_GRID_UNIT_SIZE,this._fogHeight * this._system.TOWN_GRID_UNIT_SIZE,true,0);
         this._largeFogBitmap = new Bitmap(this._largeFogBitmapData);
         this.initStamp();
      }
      
      public static function rgbatohex(param1:uint, param2:uint, param3:uint, param4:uint) : uint
      {
         return param4 << 24 | param1 << 16 | param2 << 8 | param3;
      }
      
      public function update() : void
      {
         this.drawLowResFog();
         this.drawHiResFog();
         this.cacheVisibilityMap();
         this.updatedSignal.dispatch();
      }
      
      public function clearFogAroundLocation(param1:int, param2:int) : void
      {
         this.applyStamp(param1,param2);
         this.drawHiResFog();
         this.updateVisibilityAroundLocation(param1,param2);
         this.updatedSignal.dispatch();
      }
      
      private function drawLowResFog() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Tile = null;
         var _loc3_:Tile = null;
         var _loc5_:int = 0;
         this._fogBitmapData.fillRect(this._fogBitmapData.rect,this.fogColor);
         this._fogVector = this._fogBitmapData.getVector(this._fogBitmapData.rect);
         var _loc4_:int = 0;
         while(_loc4_ < this._mapHeight)
         {
            _loc5_ = 0;
            while(_loc5_ < this._mapWidth)
            {
               _loc2_ = this._map.tileAt(_loc5_,_loc4_);
               if(_loc2_.isCaptured)
               {
                  this.applyStamp(_loc5_ + this.paddingLeft,_loc4_ + this.paddingTop);
               }
               _loc5_++;
            }
            this._fogBitmapData.setVector(this._fogBitmapData.rect,this._fogVector);
            _loc4_++;
         }
      }
      
      private function applyStamp(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc14_:int = 0;
         var _loc5_:RGBA = new RGBA#626();
         var _loc6_:RGBA = new RGBA#626();
         var _loc7_:int = this._fogStamp.width * 0.5;
         var _loc8_:int = this._fogStamp.height * 0.5;
         var _loc9_:int = param1 - _loc7_;
         var _loc10_:int = param2 - _loc8_;
         var _loc13_:int = 0;
         while(_loc13_ < this._fogStamp.height)
         {
            _loc14_ = 0;
            while(_loc14_ < this._fogStamp.width)
            {
               _loc11_ = _loc9_ + _loc14_;
               _loc12_ = _loc10_ + _loc13_;
               if(!(_loc11_ < 0 || _loc11_ > this._fogWidth || _loc12_ < 0 || _loc12_ > this._fogHeight))
               {
                  _loc3_ = _loc14_ + _loc13_ * this._fogStamp.width;
                  _loc5_.fromHex(this._stampVector[_loc3_]);
                  _loc4_ = _loc11_ + _loc12_ * this._fogWidth;
                  if(_loc4_ < this._fogVector.length)
                  {
                     _loc6_.fromHex(this._fogVector[_loc4_]);
                     if(_loc6_.alpha > _loc5_.alpha)
                     {
                        _loc6_.alpha = _loc5_.alpha;
                        this._fogVector[_loc4_] = _loc6_.toHex();
                     }
                  }
               }
               _loc14_++;
            }
            _loc13_++;
         }
      }
      
      private function initStamp() : void
      {
         this._fogStamp = new BitmapData(this.viewDistance + 1,this.viewDistance + 1,true,0);
         var _loc1_:StampGraphic = new StampGraphic();
         _loc1_.width = this._fogStamp.width;
         _loc1_.height = this._fogStamp.height;
         this._fogStamp.draw(_loc1_,_loc1_.transform.matrix);
         this._stampVector = this._fogStamp.getVector(this._fogStamp.rect);
      }
      
      public function locationIsVisible(param1:int, param2:int) : Boolean
      {
         if(!this._active)
         {
            return true;
         }
         var _loc3_:RGBA = new RGBA#626();
         var _loc4_:int = param1 + this.paddingLeft + (param2 + this.paddingTop) * this._fogWidth;
         if(_loc4_ < 0 || _loc4_ >= this._visibilityMapVector.length)
         {
            return false;
         }
         return this._visibilityMapVector[_loc4_];
      }
      
      private function cacheVisibilityMap() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:RGBA = new RGBA#626();
         var _loc4_:int = 0;
         while(_loc4_ < this._fogHeight)
         {
            _loc5_ = 0;
            while(_loc5_ < this._fogWidth)
            {
               _loc3_ = _loc5_ + _loc4_ * this._fogWidth;
               this._visibilityMapVector[_loc3_] = false;
               _loc1_.fromHex(this._fogVector[_loc3_]);
               if(_loc1_.alpha < 255)
               {
                  this._visibilityMapVector[_loc3_] = true;
               }
               else
               {
                  _loc6_ = _loc4_ - this._visibilityExpandAmount;
                  while(_loc6_ <= _loc4_ + this._visibilityExpandAmount)
                  {
                     _loc7_ = _loc5_ - this._visibilityExpandAmount;
                     while(_loc7_ <= _loc5_ + this._visibilityExpandAmount)
                     {
                        _loc2_ = _loc7_ + _loc6_ * this._fogWidth;
                        if(!(_loc2_ < 0 || _loc2_ >= this._fogVector.length))
                        {
                           _loc1_.fromHex(this._fogVector[_loc2_]);
                           if(_loc1_.alpha < 255)
                           {
                              this._visibilityMapVector[_loc3_] = true;
                           }
                        }
                        _loc7_++;
                     }
                     _loc6_++;
                  }
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      private function updateVisibilityAroundLocation(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:RGBA = new RGBA#626();
         var _loc5_:int = this._visibilityExpandAmount + this.viewDistance;
         var _loc6_:int = param2 - _loc5_;
         while(_loc6_ <= param2 + _loc5_)
         {
            _loc7_ = param1 - _loc5_;
            while(_loc7_ <= param1 + _loc5_)
            {
               _loc3_ = _loc7_ + _loc6_ * this._fogWidth;
               this._visibilityMapVector[_loc3_] = true;
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      private function drawHiResFog() : void
      {
         var _loc1_:Number = this._system.TOWN_GRID_UNIT_SIZE;
         var _loc2_:Matrix = new Matrix();
         _loc2_.scale(_loc1_,_loc1_);
         this._largeFogBitmapData.fillRect(this._largeFogBitmapData.rect,0);
         var _loc3_:int = this._system.TOWN_GRID_UNIT_SIZE;
         this._fogBitmap.filters = [new BlurFilter(_loc3_,_loc3_,BitmapFilterQuality.HIGH)];
         this._largeFogBitmapData.draw(this._fogBitmap,_loc2_);
         this._fogBitmap.filters = null;
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         if(!this._active)
         {
            return;
         }
         var _loc3_:Rectangle = param2.clone();
         _loc3_.x = _loc3_.x - -this.paddingLeft * this._system.TOWN_GRID_UNIT_SIZE;
         _loc3_.y = _loc3_.y - -this.paddingTop * this._system.TOWN_GRID_UNIT_SIZE;
         param1.copyPixels(this._largeFogBitmapData,_loc3_,this._destPoint,null,null,true);
      }
      
      public function hextoargb(param1:uint) : RGBA#626
      {
         var _loc2_:RGBA = new RGBA#626();
         _loc2_.alpha = param1 >> 24 & 255;
         _loc2_.red = param1 >> 16 & 255;
         _loc2_.green = param1 >> 8 & 255;
         _loc2_.blue = param1 & 255;
         return _loc2_;
      }
      
      public function setFullFog() : void
      {
         this._largeFogBitmapData.fillRect(this._largeFogBitmapData.rect,this.fogColor);
      }
      
      public function get largeFogBitmap() : Bitmap
      {
         return this._largeFogBitmap;
      }
      
      public function get fogBitmap() : Bitmap
      {
         return this._fogBitmap;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
      }
   }
}

class RGBA#626
{
    
   
   public var alpha:uint;
   
   public var red:uint;
   
   public var green:uint;
   
   public var blue:uint;
   
   function RGBA#626()
   {
      super();
   }
   
   public function fromHex(param1:Number) : RGBA#626
   {
      var _loc2_:RGBA = new RGBA#626();
      this.alpha = param1 >> 24 & 255;
      this.red = param1 >> 16 & 255;
      this.green = param1 >> 8 & 255;
      this.blue = param1 & 255;
      return _loc2_;
   }
   
   public function toHex() : uint
   {
      return this.alpha << 24 | this.red << 16 | this.green << 8 | this.blue;
   }
}
