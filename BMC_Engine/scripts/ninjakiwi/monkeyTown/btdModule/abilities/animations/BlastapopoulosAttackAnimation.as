package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.bloons.FireballClip;
   import assets.effects.LavaParticleClip;
   import com.lgrey.vectors.LGVector2D;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import org.osflash.signals.Signal;
   
   public class BlastapopoulosAttackAnimation extends Entity
   {
       
      
      private var _wasPooled:Boolean = false;
      
      private var _fireballClip:Clip;
      
      private const speed:Number = 8;
      
      private const speedSquared:Number = 64.0;
      
      private var _trajectory:LGVector2D;
      
      private var _vectorToTarget:LGVector2D;
      
      private var _tower:Tower = null;
      
      private var _targetLocation:LGVector2D;
      
      private var _bossBloon:Bloon = null;
      
      private var _animationSteps:int;
      
      private var _yOffsetFactor:Number = 0;
      
      private var _yOffsetHeight:Number = 0;
      
      public const hitTowerSignal:Signal = new Signal(Tower);
      
      public function BlastapopoulosAttackAnimation()
      {
         this._fireballClip = new Clip();
         this._trajectory = new LGVector2D();
         this._vectorToTarget = new LGVector2D();
         this._targetLocation = new LGVector2D();
         super();
         this._fireballClip.initialise(FireballClip,1);
         this._fireballClip.play();
         this._fireballClip.looping = true;
         z = 5000;
      }
      
      public static function create(param1:Bloon, param2:Tower) : BlastapopoulosAttackAnimation
      {
         var _loc3_:BlastapopoulosAttackAnimation = Pool.get(BlastapopoulosAttackAnimation);
         _loc3_._wasPooled = true;
         _loc3_.init(param1,param2);
         return _loc3_;
      }
      
      public function init(param1:Bloon, param2:Tower) : void
      {
         Main.instance.game.level.addEntity(this);
         this._tower = param2;
         this._tower.isProjectileIncoming = true;
         Level.towerSoldSignal.add(this.onTowerSold);
         this._targetLocation.x = this._tower.x;
         this._targetLocation.y = this._tower.y;
         this._bossBloon = param1;
         this.fireAtTarget();
      }
      
      private function onTowerSold(param1:Tower) : void
      {
         if(param1 === this._tower)
         {
            this._tower = null;
         }
      }
      
      private function fireAtTarget() : void
      {
         x = this._bossBloon.x;
         y = this._bossBloon.y;
         this._vectorToTarget.x = this._targetLocation.x - this._bossBloon.x;
         this._vectorToTarget.y = this._targetLocation.y - this._bossBloon.y;
         var _loc1_:Number = this._vectorToTarget.getLength();
         this._animationSteps = _loc1_ / this.speed;
         this._yOffsetFactor = Math.PI / this._animationSteps;
         this._yOffsetHeight = _loc1_ / 5;
         this._trajectory.x = this._targetLocation.x - this._bossBloon.x;
         this._trajectory.y = this._targetLocation.y - this._bossBloon.y;
         this._trajectory.setLength(this.speed);
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         x = x + this._trajectory.x;
         y = y + this._trajectory.y;
         this._animationSteps--;
         if(this._animationSteps <= 0)
         {
            if(this._tower !== null)
            {
               this.hitTowerSignal.dispatch(this._tower);
            }
            this.explode();
            this.clean();
         }
         this._fireballClip.process();
         var _loc2_:SmokeParticle = new SmokeParticle(LavaParticleClip,this._bossBloon.z + 1);
         _loc2_.x = x + (Math.random() - 0.5) * 10;
         _loc2_.y = y - this.getYOffset() + (Math.random() - 0.5) * 10;
         _loc2_.velocity.copy(this._trajectory);
         _loc2_.velocity.rotateByDeg(180 + (Math.random() - 0.5) * 30);
         _loc2_.velocity.setLength(2);
         _loc2_.clip.framerateModifier = 0.7;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this._fireballClip.quickDraw(param1,x,y - this.getYOffset());
      }
      
      private function getYOffset() : Number
      {
         return Math.sin(this._animationSteps * this._yOffsetFactor) * this._yOffsetHeight;
      }
      
      private function explode() : void
      {
         var _loc1_:BlastapopoulosHitExplosion = null;
         _loc1_ = BlastapopoulosHitExplosion.create();
         _loc1_.x = x;
         _loc1_.y = y;
      }
      
      private function clean() : void
      {
         Main.instance.game.level.cull(this);
         this.hitTowerSignal.removeAll();
         if(this._tower)
         {
            this._tower.isProjectileIncoming = false;
            this._tower = null;
         }
         if(this._wasPooled)
         {
            this._wasPooled = false;
            Pool.release(this);
         }
      }
   }
}
