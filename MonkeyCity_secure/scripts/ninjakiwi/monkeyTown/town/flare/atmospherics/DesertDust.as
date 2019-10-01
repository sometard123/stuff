package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.display.tileSystem.Camera;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class DesertDust
   {
       
      
      public var clip:BitClipCustom;
      
      private var _map:TownMap;
      
      private var _camera:Camera;
      
      private var _puffs:Vector.<DesertDustPuff>;
      
      private var _spawnCountDown:int = 0;
      
      private var _system:MonkeySystem;
      
      private const NUMBER_OF_PUFFS:uint = 10;
      
      private const COUNTDOWN_MAX:uint = 120;
      
      private const WAIT_FOR_FREE_DUST_FRAMES:uint = 5;
      
      public function DesertDust(param1:TownMap, param2:Camera)
      {
         this.clip = new BitClipCustom();
         this._puffs = new Vector.<DesertDustPuff>();
         this._system = MonkeySystem.getInstance();
         super();
         this._map = param1;
         this._camera = param2;
         this.init();
      }
      
      public function tick() : void
      {
         var _loc1_:DesertDustPuff = null;
         var _loc2_:int = 0;
         this._spawnCountDown--;
         if(this._spawnCountDown < 0)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < this._puffs.length)
            {
               if(!this._puffs[_loc2_].isActive)
               {
                  _loc1_ = this._puffs[_loc2_];
                  break;
               }
               _loc2_++;
            }
            if(_loc1_ !== null)
            {
               _loc1_.spawn();
               this._spawnCountDown = Math.random() * this.COUNTDOWN_MAX;
            }
            else
            {
               this._spawnCountDown = this.WAIT_FOR_FREE_DUST_FRAMES;
            }
         }
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.NUMBER_OF_PUFFS)
         {
            this._puffs.push(new DesertDustPuff(this._map,this._camera));
            _loc1_++;
         }
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         var _loc3_:DesertDustPuff = null;
         if(!this._system.map.worldIsReady)
         {
            return;
         }
         this.tick();
         var _loc4_:int = 0;
         while(_loc4_ < this._puffs.length)
         {
            _loc3_ = this._puffs[_loc4_];
            _loc3_.render(param1,param2);
            _loc4_++;
         }
      }
   }
}

import flash.display.BitmapData;
import flash.geom.Rectangle;
import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
import ninjakiwi.monkeyTown.display.tileSystem.Camera;
import ninjakiwi.monkeyTown.system.MonkeySystem;
import ninjakiwi.monkeyTown.town.townMap.TownMap;

class DesertDustPuff
{
    
   
   public var x:Number;
   
   public var y:Number;
   
   public var clip:BitClipCustom;
   
   public var _camera:Camera;
   
   private var _system:MonkeySystem;
   
   private var _isActive:Boolean = false;
   
   private var _map:TownMap;
   
   function DesertDustPuff(param1:TownMap, param2:Camera)
   {
      this.clip = new BitClipCustom();
      this._system = MonkeySystem.getInstance();
      super();
      this._map = param1;
      this._camera = param2;
      this.init();
   }
   
   private function init() : void
   {
      this.clip.addAnimation("assets.flare.DesertDust",null,1);
   }
   
   private function update() : void
   {
      if(this.clip.currentFrame === this.clip.totalFrames)
      {
         this.clip.gotoAndStop(1);
         this._isActive = false;
      }
   }
   
   public function spawn() : void
   {
      this.x = Math.random() * this._camera.width + this._camera.x;
      this.y = Math.random() * this._camera.height + this._camera.y;
      this.clip.gotoAndPlay(1);
      this._isActive = true;
   }
   
   public function render(param1:BitmapData, param2:Rectangle) : void
   {
      if(this._isActive)
      {
         this.update();
         this.clip.x = this.x - param2.x;
         this.clip.y = this.y - param2.y;
         this.clip.render(param1,param1.rect);
      }
   }
   
   public function get isActive() : Boolean
   {
      return this._isActive;
   }
}
