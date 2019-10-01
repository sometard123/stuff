package ninjakiwi.monkeyTown.town.flare.borderlands
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntityManager;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class Cliffs
   {
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var height:int;
      
      private var _staticEntityManager:SpriteEntityManager;
      
      private var _animatedEntityManager:SpriteEntityManager;
      
      private var _grassGraphic:BitmapData;
      
      private var _riverPosition:int;
      
      private const _cliffsLeftDefault:Array = ["Cliff1LeftClip","Cliff2LeftClip"];
      
      private const _cliffsRightDefault:Array = ["Cliff1RightClip","Cliff2RightClip"];
      
      private const _cliffsLeftDesert:Array = ["DesertCliff1LeftClip","DesertCliff2LeftClip"];
      
      private const _cliffsRightDesert:Array = ["DesertCliff1RightClip","DesertCliff2RightClip"];
      
      private var _cliffsLeft:Array;
      
      private var _cliffsRight:Array;
      
      private const _waterfallDefaultClassName:String = "assets.flare.CliffRiverWaterFallClip";
      
      private const _waterfallDesertClassName:String = "assets.flare.DesertCliffRiverWaterFallClip";
      
      private var _waterfallClassName:String = "assets.flare.CliffRiverWaterFallClip";
      
      private const _grassTileDefaultClassName:String = "assets.flare.DesertCliffGrassTile";
      
      private const _grassTileDesertClassName:String = "assets.flare.CliffGrassTile";
      
      private var _grassTileClassName:String = "assets.flare.DesertCliffGrassTile";
      
      private const _grassGraphicNameDefault:String = "CliffGrassTileClip";
      
      private const _grassGraphicNameDesert:String = "DesertCliffGrassTile";
      
      private var _grassGraphicName:String = "CliffGrassTileClip";
      
      private var cliffOverlap:int = 35;
      
      private var _map:TownMap;
      
      private var _position:Point;
      
      public function Cliffs(param1:TownMap)
      {
         this.height = this._system.HORIZON_HEIGHT;
         this._staticEntityManager = new SpriteEntityManager();
         this._animatedEntityManager = new SpriteEntityManager();
         this._cliffsLeft = this._cliffsLeftDefault;
         this._cliffsRight = this._cliffsRightDefault;
         this._position = new Point();
         super();
         this._map = param1;
         this.init();
      }
      
      public function tick() : void
      {
         this._animatedEntityManager.tick();
      }
      
      private function init() : void
      {
         this.configureDefaultCity();
         this.initGrassBitmap();
      }
      
      public function configureDefaultCity() : void
      {
         this._cliffsLeft = this._cliffsLeftDefault;
         this._cliffsRight = this._cliffsRightDefault;
         this._waterfallClassName = this._waterfallDefaultClassName;
         this._grassTileClassName = this._grassTileDefaultClassName;
         this._grassGraphicName = this._grassGraphicNameDefault;
      }
      
      public function configureSecondCity() : void
      {
         this._cliffsLeft = this._cliffsLeftDesert;
         this._cliffsRight = this._cliffsRightDesert;
         this._waterfallClassName = this._waterfallDesertClassName;
         this._grassTileClassName = this._grassTileDesertClassName;
         this._grassGraphicName = this._grassGraphicNameDesert;
      }
      
      public function generate() : void
      {
         this.clear();
         if(MonkeySystem.getInstance().city.cityIndex === 0)
         {
            this.configureDefaultCity();
         }
         else
         {
            this.configureSecondCity();
         }
         this._riverPosition = this._map.riverEndPosition * this._system.TOWN_GRID_UNIT_SIZE;
         this.generateCliffs(this._cliffsLeft,-1);
         this.generateCliffs(this._cliffsRight,1);
         this.makeWaterfall();
      }
      
      public function clear() : void
      {
         this._staticEntityManager.clear();
         this._animatedEntityManager.clear();
      }
      
      private function makeWaterfall() : void
      {
         var _loc1_:SpriteEntity = null;
         _loc1_ = new SpriteEntity();
         _loc1_.setGraphicByClassName(this._waterfallClassName);
         _loc1_.x = this._riverPosition;
         _loc1_.y = this._system.TOWN_MAP_PIXEL_HEIGHT;
         this._animatedEntityManager.register(_loc1_);
      }
      
      public function generateCliffs(param1:Array, param2:int) : void
      {
         var _loc4_:SpriteEntity = null;
         var _loc5_:String = null;
         var _loc8_:int = 0;
         var _loc3_:Boolean = true;
         var _loc6_:int = this._riverPosition + (this._system.TOWN_GRID_UNIT_SIZE * 1.5 - this.cliffOverlap) * param2;
         var _loc7_:int = 0;
         while(_loc3_)
         {
            _loc4_ = new SpriteEntity();
            if(_loc7_ < 2)
            {
               _loc8_ = _loc7_;
            }
            else
            {
               _loc8_ = Math.random() * param1.length;
            }
            _loc5_ = "assets.flare." + param1[_loc8_];
            _loc4_.setGraphicByClassName(_loc5_);
            _loc4_.x = _loc6_;
            _loc4_.y = this._system.TOWN_MAP_PIXEL_HEIGHT;
            _loc6_ = _loc6_ + (_loc4_.clip.bmd.data.width - this.cliffOverlap) * param2;
            this._staticEntityManager.register(_loc4_);
            if(param2 == 1)
            {
               if(_loc6_ > this._system.TOWN_MAP_PIXEL_WIDTH)
               {
                  _loc3_ = false;
               }
            }
            else if(_loc6_ < 0)
            {
               _loc3_ = false;
            }
            _loc7_++;
         }
      }
      
      private function initGrassBitmap() : void
      {
         var grassClass:Class = null;
         try
         {
            grassClass = getDefinitionByName(this._grassTileClassName) as Class;
         }
         catch(e:Error)
         {
            return;
         }
         var grass:MovieClip = new grassClass();
         this._grassGraphic = new BitmapData(grass.width,grass.height,false,4294901760);
         this._grassGraphic.draw(grass);
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderGrass(param1,param2);
         this._staticEntityManager.render(param1,param2);
         this._animatedEntityManager.render(param1,param2);
      }
      
      private function renderGrass(param1:BitmapData, param2:Rectangle) : void
      {
         var _loc3_:int = Math.ceil(param1.width / this._grassGraphic.width) + 1;
         this._position.x = -param2.x % this._grassGraphic.width;
         this._position.y = this._system.TOWN_MAP_PIXEL_HEIGHT - param2.y + this._system.TOWN_GRID_UNIT_SIZE * 0.5;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param1.copyPixels(this._grassGraphic,this._grassGraphic.rect,this._position);
            this._position.x = this._position.x + this._grassGraphic.width;
            _loc4_++;
         }
      }
   }
}
