package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import com.lgrey.utils.LGMathUtil;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   
   public class Cloud extends SpriteEntity
   {
       
      
      private var _atmosphericsManager:AtmosphericsManager;
      
      private var _cloudPuffs:Vector.<CloudPuff>;
      
      private var _rainDrops:Vector.<RainDrop>;
      
      private var _availableDrops:Vector.<RainDrop>;
      
      private var stormIntensity:StormIntensity;
      
      public var rainIntensity:Number = 0.8;
      
      public var altitude:int = 100;
      
      private var _lastStormIntensity:Number = 0;
      
      private var LGMath:LGMathUtil;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function Cloud(param1:AtmosphericsManager, param2:int = 3)
      {
         this._cloudPuffs = new Vector.<CloudPuff>();
         this._rainDrops = new Vector.<RainDrop>();
         this._availableDrops = new Vector.<RainDrop>();
         this.stormIntensity = new StormIntensity();
         this.LGMath = LGMathUtil.getInstance();
         super();
         this._atmosphericsManager = param1;
         clip = null;
         this.initPuffs(param2);
      }
      
      private function initPuffs(param1:int) : void
      {
         var _loc2_:CloudPuff = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = new CloudPuff();
            _loc2_.clip.addAnimation("assets.flare.CloudClip",null,1);
            _loc2_.offset.x = (Math.random() - 0.5) * 100;
            _loc2_.offset.y = (Math.random() - 0.5) * 50;
            this._cloudPuffs.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function spawnDrop() : void
      {
         var _loc1_:RainDrop = null;
         if(this._availableDrops.length > 0)
         {
            _loc1_ = this._availableDrops.pop();
         }
         else
         {
            _loc1_ = new RainDrop(this);
            this._rainDrops.push(_loc1_);
            this._atmosphericsManager.midEntityManager.register(_loc1_);
         }
         this.placeDrop(_loc1_);
      }
      
      private function spawnRainbow() : void
      {
         var _loc1_:Rainbow = null;
         _loc1_ = new Rainbow();
         _loc1_.x = x - this._atmosphericsManager.windSpeed.x * 50;
         _loc1_.y = y;
         this._atmosphericsManager.midEntityManager.register(_loc1_);
      }
      
      private function spawnLightning() : void
      {
         var _loc1_:LightningBolt = null;
         _loc1_ = new LightningBolt();
         var _loc2_:CloudPuff = this._cloudPuffs[int(Math.random() * this._cloudPuffs.length)];
         _loc1_.x = x + _loc2_.offset.x + (Math.random() - 0.5) * 30;
         _loc1_.y = y + _loc2_.offset.y;
         this._atmosphericsManager.midEntityManager.register(_loc1_);
         _loc1_.clip.play();
      }
      
      public function placeDrop(param1:RainDrop) : void
      {
         var _loc2_:CloudPuff = null;
         _loc2_ = this._cloudPuffs[int(Math.random() * this._cloudPuffs.length)];
         param1.x = x + (Math.random() - 0.5) * 100 + _loc2_.offset.x;
         param1.y = y + (Math.random() - 0.5) * 30 + _loc2_.offset.y;
         param1.clip.play();
      }
      
      public function onDropHitGround(param1:RainDrop) : void
      {
         this._availableDrops.push(param1);
      }
      
      public function clearRaindrops() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._rainDrops.length)
         {
            this._atmosphericsManager.topEntityManager.deregister(this._rainDrops[_loc1_]);
            _loc1_++;
         }
         this._rainDrops.length = 0;
         this._availableDrops.length = 0;
      }
      
      override public function tick() : void
      {
         x = x + (this._atmosphericsManager.windSpeed.x - this._atmosphericsManager.windSpeed.x * Math.random() * 0.2);
         y = y + this._atmosphericsManager.windSpeed.y;
         if(x > this._system.TOWN_MAP_PIXEL_WIDTH + 300)
         {
            x = -300;
            y = this._system.TOWN_MAP_PIXEL_HEIGHT * 0.5 + (Math.random() * 2 - 1) * (this._system.TOWN_MAP_PIXEL_HEIGHT * 0.5);
         }
         this.updateRain();
      }
      
      private function updateRain() : void
      {
         var _loc1_:Number = 0.6;
         var _loc2_:Number = 0.75;
         var _loc3_:Number = 3;
         var _loc4_:Number = this.stormIntensity.getIntensity();
         var _loc5_:Number = 0.3;
         if(this._lastStormIntensity > _loc1_ && _loc4_ < _loc1_ && Math.random() < _loc5_)
         {
            this.spawnRainbow();
         }
         var _loc6_:Number = 0.45;
         if(_loc4_ < _loc6_)
         {
            this.setCloudDarkness(0);
         }
         else
         {
            this.setCloudDarkness(this.LGMath.remapValueToRange(_loc4_,_loc6_,1,0,1));
         }
         if(_loc4_ > _loc1_)
         {
            this.rainIntensity = this.LGMath.remapValueToRange(_loc4_,_loc1_,1,0.3,_loc3_);
         }
         else
         {
            this.rainIntensity = 0;
         }
         var _loc7_:int = Math.ceil(this.rainIntensity);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            if(Math.random() < this.rainIntensity - _loc8_)
            {
               this.spawnDrop();
            }
            _loc8_++;
         }
         if(_loc4_ > _loc2_ && Math.random() < _loc4_ * 0.03)
         {
            this.spawnLightning();
         }
         this._lastStormIntensity = _loc4_;
      }
      
      private function setCloudDarkness(param1:Number) : void
      {
         var _loc2_:BitClipCustom = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._cloudPuffs.length)
         {
            _loc2_ = this._cloudPuffs[_loc3_].clip;
            _loc2_.gotoAndStop(int(param1 * _loc2_.totalFrames) + 1);
            _loc3_++;
         }
      }
      
      override public function render(param1:BitmapData, param2:Rectangle) : void
      {
         var _loc3_:CloudPuff = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._cloudPuffs.length)
         {
            _loc3_ = this._cloudPuffs[_loc4_];
            _loc3_.update();
            _loc3_.clip.x = x + _loc3_.offset.x - param2.x;
            _loc3_.clip.y = y + _loc3_.offset.y - param2.y;
            _loc3_.clip.render(param1,param1.rect);
            _loc4_++;
         }
      }
   }
}

import com.lgrey.vectors.LGVector2D;
import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;

class CloudPuff
{
   
   private static const speed:Number = 0.005;
    
   
   public var clip:BitClipCustom;
   
   public var offset:LGVector2D;
   
   private var spreadX:Number = 70;
   
   private var spreadY:Number = 40;
   
   private var counter:Number;
   
   private var rates:Array;
   
   function CloudPuff()
   {
      this.clip = new BitClipCustom();
      this.offset = new LGVector2D();
      this.counter = Math.random() * 1000;
      this.rates = [Math.random(),Math.random()];
      super();
   }
   
   public function update() : void
   {
      this.counter = this.counter + speed;
      this.offset.x = Math.sin(this.counter * this.rates[0]) * this.spreadX;
      this.offset.y = Math.sin(this.counter * this.rates[1]) * this.spreadY;
   }
}

class StormIntensity
{
   
   private static const speed:Number = 0.01;
    
   
   private var counter:Number = 0;
   
   private var rates:Array;
   
   public var maximumIntensity:Number = 1;
   
   function StormIntensity()
   {
      this.rates = [Math.random(),Math.random()];
      super();
   }
   
   public function getIntensity() : Number
   {
      this.counter = this.counter + speed;
      return (Math.sin(this.rates[0] * this.counter) * Math.sin(this.rates[1] * this.counter) * 0.5 + 0.5) * this.maximumIntensity;
   }
}
