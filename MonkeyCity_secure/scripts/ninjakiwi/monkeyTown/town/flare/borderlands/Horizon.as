package ninjakiwi.monkeyTown.town.flare.borderlands
{
   import assets.flare.HorizonSky;
   import assets.flare.HorizonSkyDesert;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntityManager;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class Horizon
   {
       
      
      private var mountainsBackList_Default:Array;
      
      private var mountainsMidBackList_Default:Array;
      
      private var mountainsMidList_Default:Array;
      
      private var mountainsForeList_Default:Array;
      
      private var mountainsBackList_Desert:Array;
      
      private var mountainsMidBackList_Desert:Array;
      
      private var mountainsMidList_Desert:Array;
      
      private var mountainsForeList_Desert:Array;
      
      private var mountainsBackList:Array;
      
      private var mountainsMidBackList:Array;
      
      private var mountainsMidList:Array;
      
      private var mountainsForeList:Array;
      
      private var _horizonSky:DisplayObject;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var height:int;
      
      private var _entityManager:SpriteEntityManager;
      
      private var _skyGraphic:BitmapData;
      
      private var _map:TownMap;
      
      private var _horizonRiverClass_Default:String = "assets.flare.HorizonRiver";
      
      private var _horizonRiverClass_Desert:String = "assets.flare.HorizonRiverDesert";
      
      private var _horizonRiverClass:String;
      
      public function Horizon(param1:TownMap)
      {
         this.mountainsBackList_Default = ["MountainsBack1","MountainsBack2","MountainsBack3"];
         this.mountainsMidBackList_Default = ["MountainsMidBack1","MountainsMidBack2"];
         this.mountainsMidList_Default = ["MountainsMid1","MountainsMid2","MountainsMid3","MountainsMid4"];
         this.mountainsForeList_Default = ["MountainsFore1","MountainsFore2","MountainsFore3"];
         this.mountainsBackList_Desert = ["MountainsBackDesert01","MountainsBackDesert02","MountainsBackDesert03"];
         this.mountainsMidBackList_Desert = ["MountainsMidBackDesert01","MountainsMidBackDesert02"];
         this.mountainsMidList_Desert = ["MountainsMidDesert01","MountainsMidDesert02","MountainsMidDesert03","MountainsMidDesert04"];
         this.mountainsForeList_Desert = ["MountainsForeDesert01","MountainsForeDesert02","MountainsForeDesert03"];
         this.mountainsBackList = this.mountainsBackList_Default;
         this.mountainsMidBackList = this.mountainsMidBackList_Default;
         this.mountainsMidList = this.mountainsMidList_Default;
         this.mountainsForeList = this.mountainsForeList_Default;
         this.height = this._system.HORIZON_HEIGHT;
         this._entityManager = new SpriteEntityManager();
         this._horizonRiverClass = this._horizonRiverClass_Default;
         super();
         this._map = param1;
      }
      
      public function tick() : void
      {
      }
      
      public function setCityOne() : void
      {
         this.mountainsBackList = this.mountainsBackList_Default;
         this.mountainsMidBackList = this.mountainsMidBackList_Default;
         this.mountainsMidList = this.mountainsMidList_Default;
         this.mountainsForeList = this.mountainsForeList_Default;
         this._horizonRiverClass = this._horizonRiverClass_Default;
         this._horizonSky = new HorizonSky();
      }
      
      public function setCityTwo() : void
      {
         this.mountainsBackList = this.mountainsBackList_Desert;
         this.mountainsMidBackList = this.mountainsMidBackList_Desert;
         this.mountainsMidList = this.mountainsMidList_Desert;
         this.mountainsForeList = this.mountainsForeList_Desert;
         this._horizonRiverClass = this._horizonRiverClass_Desert;
         this._horizonSky = new HorizonSkyDesert();
      }
      
      public function generate() : void
      {
         this.clear();
         this.initSkyBitmap();
         this.generateLayer(this.mountainsBackList);
         this.generateLayer(this.mountainsMidBackList);
         this.generateLayer(this.mountainsMidList);
         this.generateLayer(this.mountainsForeList);
         this.makeRiver();
         this.generateDecorations();
      }
      
      public function clear() : void
      {
         this._entityManager.clear();
      }
      
      public function makeRiver() : void
      {
         var _loc1_:SpriteEntity = null;
         _loc1_ = new SpriteEntity();
         _loc1_.setGraphicByClassName(this._horizonRiverClass);
         _loc1_.x = this._map.riverBeginPosition * this._system.TOWN_GRID_UNIT_SIZE;
         this._entityManager.register(_loc1_);
      }
      
      private function generateLayer(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SpriteEntity = null;
         var _loc4_:String = null;
         _loc2_ = Math.random() * -30;
         while(_loc2_ < this._system.TOWN_MAP_PIXEL_WIDTH)
         {
            _loc3_ = new SpriteEntity();
            _loc4_ = "assets.flare." + param1[int(Math.random() * param1.length)];
            _loc3_.setGraphicByClassName(_loc4_);
            _loc3_.x = _loc2_;
            _loc3_.y = 0;
            _loc2_ = _loc2_ + _loc3_.clip.bmd.data.width;
            this._entityManager.register(_loc3_);
         }
      }
      
      private function initSkyBitmap() : void
      {
         this._skyGraphic = new BitmapData(this._horizonSky.width,this._horizonSky.height,false,4294901760);
         this._skyGraphic.draw(this._horizonSky);
      }
      
      private function generateDecorations() : void
      {
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         if(param2.y > 0)
         {
            return;
         }
         this.renderSky(param1,param2);
         this._entityManager.render(param1,param2);
      }
      
      private function renderSky(param1:BitmapData, param2:Rectangle) : void
      {
         var _loc3_:int = Math.ceil(param1.width / this._skyGraphic.width);
         var _loc4_:Point = new Point(0,-param2.y - this.height);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            param1.copyPixels(this._skyGraphic,this._skyGraphic.rect,_loc4_);
            _loc4_.x = _loc4_.x + this._skyGraphic.width;
            _loc5_++;
         }
      }
   }
}
