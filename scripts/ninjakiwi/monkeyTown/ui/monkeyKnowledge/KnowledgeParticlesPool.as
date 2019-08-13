package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import flash.events.KeyboardEvent;
   import ninjakiwi.monkeyTown.dust.Particle;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   
   public class KnowledgeParticlesPool
   {
      
      public static const GREEN:int = 0;
      
      public static const RED:int = 1;
      
      public static const PURPLE:int = 2;
      
      public static const GOLD:int = 3;
      
      public static const NORMAL_PARTICLES:String = "default";
      
      public static const SECRET_PARTICLES:String = "secret";
      
      public static const NORMAL_PARTICLES_RANGE:AnimationRange = new AnimationRange(1,5,"default");
      
      public static const SECRET_PARTICLES_RANGE:AnimationRange = new AnimationRange(1,5,"secret");
       
      
      private var particlesPerBurst:int = 20;
      
      private var animationCount:int = 4;
      
      private var _availableParticles:Vector.<Particle>;
      
      private var rangesByType:Object;
      
      public function KnowledgeParticlesPool()
      {
         this._availableParticles = new Vector.<Particle>();
         this.rangesByType = {
            "default":NORMAL_PARTICLES_RANGE,
            "secret":SECRET_PARTICLES_RANGE
         };
         super();
         this.addParticles(this.particlesPerBurst * this.animationCount);
      }
      
      public static function getColorIDByString(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case MonkeyKnowledge.COMMON:
               _loc2_ = GREEN;
               break;
            case MonkeyKnowledge.UNCOMMON:
               _loc2_ = RED;
               break;
            case MonkeyKnowledge.RARE:
               _loc2_ = PURPLE;
               break;
            case MonkeyKnowledge.LEGENDARY:
               _loc2_ = GOLD;
         }
         return _loc2_;
      }
      
      private function addParticles(param1:int) : void
      {
         var _loc3_:Particle = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new Particle();
            _loc3_.addAnimation("assets.ui.GenericParticleClip1","default1");
            _loc3_.addAnimation("assets.ui.GenericParticleClip2","default2");
            _loc3_.addAnimation("assets.ui.GenericParticleClip3","default3");
            _loc3_.addAnimation("assets.ui.GenericParticleClip4","default4");
            _loc3_.addAnimation("assets.ui.GenericParticleClip5","default5");
            _loc3_.addAnimation("assets.ui.GenericParticleSecretClip1","secret1");
            _loc3_.addAnimation("assets.ui.GenericParticleSecretClip2","secret2");
            _loc3_.addAnimation("assets.ui.GenericParticleSecretClip3","secret3");
            _loc3_.addAnimation("assets.ui.GenericParticleSecretClip4","secret4");
            _loc3_.addAnimation("assets.ui.GenericParticleSecretClip5","secret5");
            _loc3_.addAnimation("assets.ui.GenericParticlePopClip","pop");
            this._availableParticles.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function getParticles(param1:int, param2:Vector.<Particle>, param3:String = "default") : void
      {
         var _loc5_:Particle = null;
         if(this._availableParticles.length < param1)
         {
            this.addParticles(param1);
         }
         var _loc4_:AnimationRange = this.rangesByType[param3];
         var _loc6_:int = 0;
         while(_loc6_ < param1)
         {
            _loc5_ = this._availableParticles.pop();
            _loc5_.visible = true;
            _loc5_.selectAnimation(_loc4_.getRandomKey());
            _loc5_.gotoAndPlay(int(_loc5_.totalFrames * Math.random()));
            param2.push(_loc5_);
            _loc6_++;
         }
      }
      
      public function returnParticles(param1:Vector.<Particle>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         while(_loc2_ < _loc3_)
         {
            this._availableParticles.push(param1.pop());
            _loc2_++;
         }
      }
   }
}
