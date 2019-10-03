package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dreadbloon
{
   import assets.bloons.DreadRegenRocksClip;
   import assets.bloons.DreadShieldClip;
   import assets.bloons.DreadbloonRockArmorEnterClip;
   import assets.sounds.DreadBloonReshieldShort;
   import com.lgrey.vectors.LGVector2D;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BuffMethodModuleSharedFunctions;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class DreadBloonShieldView extends Entity
   {
       
      
      public var quarter:int = 0;
      
      public var showRegenRocks:Boolean;
      
      private var _rocksClip:Clip;
      
      private var _enterClip:Clip;
      
      private var _regenRocks:Clip;
      
      private var _bossBloon:Bloon;
      
      private var _attackVector:LGVector2D;
      
      private var _shield:DreadBloonShield;
      
      private var _rockSpawnTimer:int;
      
      private var _hasSpawnedRock:Boolean = false;
      
      private var _rockColorTransform:ColorTransform;
      
      public var _flashLevel:Object;
      
      private var _shieldFormSound:MaxSound;
      
      private var _flashTransform:ColorTransform;
      
      public function DreadBloonShieldView(param1:DreadBloonShield)
      {
         this._rocksClip = new Clip();
         this._enterClip = new Clip();
         this._regenRocks = new Clip();
         this._attackVector = new LGVector2D();
         this._rockColorTransform = new ColorTransform();
         this._flashLevel = {"level":0};
         this._shieldFormSound = new MaxSound(DreadBloonReshieldShort);
         this._flashTransform = new ColorTransform();
         super();
         this._shield = param1;
         this._rocksClip.initialise(DreadShieldClip,16);
         this._enterClip.initialise(DreadbloonRockArmorEnterClip,1);
         this._regenRocks.initialise(DreadRegenRocksClip,1);
         this._regenRocks.looping = true;
         this._enterClip.useFramerateModifier = true;
         this._enterClip.framerateModifier = 0.3;
         z = 100000000;
         Main.instance.game.level.addEntity(this);
      }
      
      public function setBoss(param1:Bloon) : void
      {
         this._bossBloon = param1;
         this._hasSpawnedRock = false;
         this._rockSpawnTimer = 300;
         this._enterClip.stop();
      }
      
      override public function process(param1:Number) : void
      {
         if(false === this._hasSpawnedRock)
         {
            _loc2_._rockSpawnTimer = _loc2_._rockSpawnTimer - 1;
            if(this._rockSpawnTimer === 0)
            {
               this._enterClip.gotoAndPlay(0);
               this._shieldFormSound.play();
            }
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this._bossBloon === null)
         {
            return;
         }
         if(this._bossBloon.isShielded)
         {
            this.quarter = 4 - this._shield.health / this._shield.maxHealth * 4;
            this.quarter = Math.max(0,Math.min(this.quarter,3));
            this._rocksClip.gotoAndStop(this.quarter);
            if(this._hasSpawnedRock)
            {
               this._flashLevel.level = this._flashLevel.level * 0.8;
               this._rocksClip.drawRotated(param1,this._bossBloon.x,this._bossBloon.y,this._bossBloon.rotation,this.getRockFlashColorTransform());
            }
            if(this.showRegenRocks)
            {
               this._regenRocks.process();
               this._regenRocks.quickDraw(param1,this._bossBloon.x,this._bossBloon.y);
            }
            if(this._enterClip.isPlaying)
            {
               this._enterClip.quickDraw(param1,this._bossBloon.x,this._bossBloon.y);
               this._enterClip.process();
               if(this._enterClip.frameIndex === this._enterClip.frameCount - 1)
               {
                  this._enterClip.stop();
                  this._hasSpawnedRock = true;
               }
            }
         }
      }
      
      private function getRockFlashColorTransform() : ColorTransform
      {
         var _loc1_:Number = this._flashLevel.level;
         if(_loc1_ < 0.001)
         {
            return null;
         }
         this._flashTransform.redMultiplier = 1 + _loc1_;
         this._flashTransform.greenMultiplier = 1 + _loc1_;
         this._flashTransform.blueMultiplier = 1 + _loc1_;
         return this._flashTransform;
      }
      
      override public function destroy() : void
      {
         this.release();
         Main.instance.game.level.cull(this);
         super.destroy();
      }
      
      public function release() : void
      {
         this._rocksClip = null;
         this._bossBloon = null;
      }
      
      public function showRechargingAnimation() : void
      {
         this._rocksClip.gotoAndStop(0);
      }
      
      public function damage(param1:Number = 0, param2:Tower = null) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         this._flashLevel.level = 0.5;
         if(this._bossBloon === null || false === this._bossBloon.isShielded)
         {
            return;
         }
         if(param2 !== null)
         {
            this._attackVector.x = param2.x - this._bossBloon.x;
            this._attackVector.y = param2.y - this._bossBloon.y;
            _loc3_ = 125;
            if(this._attackVector.getLength() > _loc3_)
            {
               this._attackVector.setLength(_loc3_);
            }
            _loc4_ = 0.15;
            if(param2.def !== null && param2.def.id === "DartlingGun")
            {
               _loc4_ = 0.4;
            }
            this._attackVector.setAngle(this._attackVector.getAngle() + (Math.random() - 0.5) * _loc4_);
         }
      }
   }
}
