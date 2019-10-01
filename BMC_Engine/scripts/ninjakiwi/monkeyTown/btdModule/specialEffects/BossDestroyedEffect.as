package ninjakiwi.monkeyTown.btdModule.specialEffects
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.BossBlastWindStreak;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.StunEffectDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import org.osflash.signals.Signal;
   
   public class BossDestroyedEffect extends MovieClip
   {
      
      public static const DESTROY_EFFECT_FINISHED:Signal = new Signal();
      
      private static const POP_INTERVAL_MIN:Number = 0.1;
      
      private static const POP_INTERVAL_MAX:Number = 0.3;
      
      private static const ANIM_REMOVE_BOSS:String = "RemoveBoss";
      
      private static const ANIM_FINISHED_ID:String = "Finished";
       
      
      public var _deathAnimation:MovieClip = null;
      
      public var _stunEffect:StunEffectDef = null;
      
      private var _deathSound:MaxSound = null;
      
      private var _lastGameTime:Number = 0;
      
      private var _isActivated:Boolean = false;
      
      private var _affectedBloons:Vector.<Bloon> = null;
      
      private var _popCountdowns:Vector.<Number> = null;
      
      private var _bossBloon:Bloon = null;
      
      private var _removeBossFrame:int = -1;
      
      public function BossDestroyedEffect(param1:MovieClip, param2:Class)
      {
         super();
         this._deathAnimation = param1;
         this._deathAnimation.gotoAndStop(1);
         this._deathAnimation.visible = false;
         addChild(this._deathAnimation);
         this._deathSound = new MaxSound(param2);
         this._stunEffect = new StunEffectDef();
         this._affectedBloons = new Vector.<Bloon>();
         this._popCountdowns = new Vector.<Number>();
         this._stunEffect.Lifespan(1000000);
         this._stunEffect.cantEffect = new Vector.<int>();
         SpecialTrackBoss.onBossSpawnedSignal.add(this.onBossSpawned);
         Bloon.eventDispatcher.addEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDestroyed);
         this._deathAnimation.addEventListener(ANIM_REMOVE_BOSS,this.onRemoveBoss);
      }
      
      private static function get gameTime() : Number
      {
         return Main.instance.game.getGameTime();
      }
      
      public function reset(... rest) : void
      {
         Main.instance.game.level.removeEventListener(BloonEvent.ADD,this.onBloonAdded);
         Main.instance.removeEventListener(Event.ENTER_FRAME,this.update);
         this._affectedBloons.length = 0;
         this._popCountdowns.length = 0;
         this._isActivated = false;
         this._deathAnimation.stop();
         Bloon.postBossDestroyed = false;
      }
      
      public function clean() : void
      {
         this.reset();
         Bloon.eventDispatcher.removeEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDestroyed);
         this._deathAnimation.addEventListener(ANIM_REMOVE_BOSS,this.onRemoveBoss);
         Main.instance.game.level.removeEventListener(BloonEvent.ADD,this.onBloonAdded);
         Main.instance.removeEventListener(Event.ENTER_FRAME,this.update);
         this._deathAnimation.removeEventListener(ANIM_FINISHED_ID,this.onDeathAnimationFinished);
         SpecialTrackBoss.onBossSpawnedSignal.remove(this.onBossSpawned);
         this._deathAnimation = null;
         this._bossBloon = null;
      }
      
      public function activate() : void
      {
         var _loc3_:Bloon = null;
         this.reset();
         var _loc1_:Vector.<Bloon> = Main.instance.game.level.bloons;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            this.addAffectedBloon(_loc3_);
            _loc2_++;
         }
         Main.instance.game.level.addEventListener(BloonEvent.ADD,this.onBloonAdded);
         Main.instance.addEventListener(Event.ENTER_FRAME,this.update);
         this._isActivated = true;
         this._deathAnimation.x = this._bossBloon.x;
         this._deathAnimation.y = this._bossBloon.y;
         this._deathAnimation.visible = true;
         this._deathAnimation.gotoAndPlay(1);
         this._deathAnimation.removeEventListener(ANIM_FINISHED_ID,this.onDeathAnimationFinished);
         this._deathAnimation.addEventListener(ANIM_FINISHED_ID,this.onDeathAnimationFinished);
         this._deathAnimation.rotation = this.getBossVisualRotation();
         this._bossBloon.isMoving = false;
         this._deathSound.play();
      }
      
      public function update(... rest) : void
      {
         var _loc7_:Bloon = null;
         var _loc8_:Bloon = null;
         var _loc9_:int = 0;
         var _loc2_:Number = gameTime;
         if(false == this._isActivated)
         {
            this._lastGameTime = _loc2_;
            return;
         }
         var _loc3_:Number = _loc2_ - this._lastGameTime;
         var _loc4_:Vector.<Bloon> = new Vector.<Bloon>();
         var _loc5_:int = 0;
         while(_loc5_ < this._affectedBloons.length)
         {
            _loc7_ = this._affectedBloons[_loc5_];
            if(!(_loc7_ == null || _loc7_.type == -1 || _loc7_.health <= 0 || _loc7_.isBoss))
            {
               this._popCountdowns[_loc5_] = this._popCountdowns[_loc5_] - _loc3_;
               if(this._popCountdowns[_loc5_] <= 0)
               {
                  _loc4_.push(_loc7_);
                  this._popCountdowns[_loc5_] = this.getCountdownTime();
               }
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_];
            _loc9_ = 1;
            if(_loc8_.health > 1)
            {
               _loc9_ = _loc8_.maxHealth * 0.2;
            }
            _loc8_.damage(_loc9_,1,null);
            _loc6_++;
         }
         this._lastGameTime = _loc2_;
      }
      
      private function onDeathAnimationFinished(... rest) : void
      {
         this._deathAnimation.gotoAndStop(1);
         this._deathAnimation.visible = false;
         this._bossBloon.destroy();
         DESTROY_EFFECT_FINISHED.dispatch();
      }
      
      public function changeDeathAnimation(param1:MovieClip) : void
      {
         if(this._deathAnimation)
         {
            this._deathAnimation.gotoAndStop(1);
            this._deathAnimation.visible = false;
            removeChild(this._deathAnimation);
         }
         this._deathAnimation = param1;
         this._deathAnimation.gotoAndStop(1);
         this._deathAnimation.visible = false;
         addChild(this._deathAnimation);
         this._deathAnimation.removeEventListener(ANIM_FINISHED_ID,this.onDeathAnimationFinished);
      }
      
      private function addAffectedBloon(param1:Bloon) : void
      {
         param1.applyStun(this._stunEffect,true);
         this._affectedBloons.push(param1);
         this._popCountdowns.push(this.getCountdownTime());
      }
      
      private function getCountdownTime() : Number
      {
         var _loc1_:Number = (POP_INTERVAL_MAX - POP_INTERVAL_MIN) * Math.random();
         _loc1_ = _loc1_ + POP_INTERVAL_MIN;
         return _loc1_;
      }
      
      private function onBloonAdded(param1:BloonEvent) : void
      {
         if(param1.bloon.isBoss)
         {
            return;
         }
         this.addAffectedBloon(param1.bloon);
      }
      
      private function onBossSpawned(param1:Bloon) : void
      {
         this.reset();
         this._bossBloon = param1;
      }
      
      private function onBossDestroyed(... rest) : void
      {
         this.activate();
      }
      
      private function onRemoveBoss(... rest) : void
      {
         this._bossBloon.clip.bloonVisible = false;
         this._bossBloon.clip.propVisible = false;
      }
      
      private function getBossVisualRotation() : Number
      {
         var _loc3_:int = 0;
         if(null == this._bossBloon)
         {
            return 0;
         }
         var _loc1_:Number = this._bossBloon.rotation;
         var _loc2_:int = this._bossBloon.clip.getBloonFrame().getRotationCount();
         _loc1_ = _loc1_ + Math.PI / _loc2_;
         while(_loc1_ < 0)
         {
            _loc1_ = _loc1_ + Math.PI * 2;
         }
         while(_loc1_ >= Math.PI * 2)
         {
            _loc1_ = _loc1_ - Math.PI * 2;
         }
         _loc3_ = Math.floor(_loc2_ * _loc1_ / (Math.PI * 2));
         var _loc4_:Number = 0;
         var _loc5_:Number = _loc3_ / _loc2_;
         _loc4_ = _loc5_ * 360;
         if(_loc4_ > 180)
         {
            _loc4_ = _loc4_ - 360;
         }
         return _loc4_;
      }
   }
}
