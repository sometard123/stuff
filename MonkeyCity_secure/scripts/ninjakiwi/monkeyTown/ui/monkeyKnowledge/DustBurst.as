package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.greensock.TweenLite;
   import com.lgrey.vectors.LGVector2D;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.dust.Particle;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class DustBurst
   {
      
      public static var reachedTargetSignal:Signal = new Signal();
      
      public static const GOAL_MODE_FREE:int = 0;
      
      public static const GOAL_MODE_LOWER_LEFT_CORNER:int = 1;
       
      
      public var burstForce:Number = 50;
      
      public var friction1:Number = 0.5;
      
      public var friction1Variance:Number = 0.4;
      
      public var friction2:Number = 0.1;
      
      public var goalAttraction:Number = 0;
      
      public var goalAttractionMax:Number = 5;
      
      public var goal:LGVector2D;
      
      public var goalVariance:Number = 10;
      
      public var particlesPerBurst:int = 50;
      
      public const completeSignal:Signal = new Signal(DustBurst);
      
      protected var _pool:KnowledgeParticlesPool;
      
      protected var _particles:Vector.<Particle>;
      
      protected var _visibleParticleCount:int = 0;
      
      protected var TWEEN_DURATION:Number = 2;
      
      protected var TWEEN_DURATION_VARIANCE:Number = 0.5;
      
      protected var idle:Boolean = true;
      
      public var goalMode:int = 0;
      
      public function DustBurst(param1:KnowledgeParticlesPool)
      {
         this.goal = new LGVector2D();
         this._particles = new Vector.<Particle>();
         super();
         this._pool = param1;
      }
      
      public function go(param1:Rectangle, param2:String = "default") : void
      {
         var p:Particle = null;
         var that:DustBurst = null;
         var rect:Rectangle = param1;
         var type:String = param2;
         this.idle = false;
         this._pool.getParticles(this.particlesPerBurst,this._particles,type);
         var i:int = 0;
         var len:int = this._particles.length;
         while(i < len)
         {
            p = this._particles[i];
            p.x = rect.x + rect.width * Math.random();
            p.y = rect.y + rect.height * Math.random();
            p.goal.x = this.goal.x + (Math.random() * 2 - 0.5) * this.goalVariance;
            p.goal.y = this.goal.y + (Math.random() * 2 - 0.5) * this.goalVariance;
            p.friction = this.friction1 - Math.random() * this.friction1 * this.friction1Variance;
            p.velocity.x = (Math.random() - 0.5) * 2 * this.burstForce;
            p.velocity.y = (Math.random() - 0.5) * 2 * this.burstForce;
            i++;
         }
         this._visibleParticleCount = this._particles.length;
         that = this;
         TweenLite.delayedCall(0.4,function():void
         {
            TweenLite.to(that,1,{"goalAttraction":goalAttractionMax});
            var j:int = 0;
            while(j < _particles.length)
            {
               p = _particles[j];
               TweenLite.delayedCall(Math.random() * 0.5,function(param1:Particle):void
               {
                  param1.friction = friction2;
               },[p]);
               j++;
            }
         });
      }
      
      public function update() : void
      {
         var _loc3_:Particle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.idle)
         {
            return;
         }
         var _loc1_:LGVector2D = new LGVector2D();
         var _loc2_:LGVector2D = new LGVector2D();
         var _loc4_:int = 0;
         var _loc5_:int = this._particles.length;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = this._particles[_loc4_];
            if(_loc3_.visible)
            {
               _loc2_.x = _loc3_.goal.x - _loc3_.x;
               _loc2_.y = _loc3_.goal.y - _loc3_.y;
               _loc6_ = _loc2_.getLength();
               if(this.goalAttraction > 0)
               {
               }
               _loc2_.setLength(this.goalAttraction);
               _loc3_.velocity.x = _loc3_.velocity.x + _loc2_.x;
               _loc3_.velocity.y = _loc3_.velocity.y + _loc2_.y;
               _loc7_ = _loc3_.velocity.getLength();
               _loc3_.velocity.x = _loc3_.velocity.x * (1 - _loc3_.friction);
               _loc3_.velocity.y = _loc3_.velocity.y * (1 - _loc3_.friction);
               if(this.goalMode == GOAL_MODE_LOWER_LEFT_CORNER)
               {
                  if(_loc3_.x < this.goal.x && _loc3_.y > this.goal.y || _loc6_ < 15)
                  {
                     this.retireParticle(_loc3_);
                     reachedTargetSignal.dispatch();
                  }
               }
               else if(_loc6_ < 15)
               {
                  this.retireParticle(_loc3_);
                  reachedTargetSignal.dispatch();
               }
            }
            _loc4_++;
         }
         if(this._visibleParticleCount == 0)
         {
            this.complete();
         }
      }
      
      public function clear() : void
      {
         this._pool.returnParticles(this._particles);
         this._particles.length = 0;
         this.idle = true;
      }
      
      protected function retireParticle(param1:Particle) : void
      {
         param1.visible = false;
         this._visibleParticleCount--;
      }
      
      protected function complete() : void
      {
         this._pool.returnParticles(this._particles);
         this._particles.length = 0;
         this.completeSignal.dispatch(this);
         this.idle = true;
      }
      
      public function get particles() : Vector.<Particle>
      {
         return this._particles;
      }
   }
}
