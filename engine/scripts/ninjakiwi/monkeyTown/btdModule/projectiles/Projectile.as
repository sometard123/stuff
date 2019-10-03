package ninjakiwi.monkeyTown.btdModule.projectiles
{
   import assets.projectile.BurnyLargeExplosion;
   import assets.projectile.BurnyMediumExplosion;
   import assets.projectile.BurnyNuclearExplosion;
   import assets.projectile.BurnySlightlyLargerExplosion;
   import assets.projectile.CorrosiveSplat;
   import assets.projectile.GlueSplat;
   import assets.projectile.GodGlueSplat;
   import assets.projectile.IceBurst;
   import assets.projectile.IceBurstLarge;
   import assets.projectile.IceBurstMedium;
   import assets.projectile.IceExplosion;
   import assets.projectile.IceExplosionLarge;
   import assets.projectile.IceExplosionMedium;
   import assets.projectile.LargeExplosion;
   import assets.projectile.MediumExplosion;
   import assets.projectile.NuclearExplosion;
   import assets.projectile.RingOfFire;
   import assets.projectile.SlightlyLargerExplosion;
   import assets.projectile.SmallExplosion;
   import assets.projectile.Tempest;
   import assets.projectile.TinyTornado;
   import assets.projectile.Tornado;
   import assets.towers.BloonsBushCreeper;
   import display.Clip;
   import display.LabelOverCommand;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.AdditiveEntity;
   import ninjakiwi.monkeyTown.btdModule.entities.LayeredEntity;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageAddCeramicSnapFreeze;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageScaleMOAB;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HitAreaScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityBlack;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityCamoSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityLeadSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LayersRemovedAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddBase;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddWhirlwind;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PurgeRegenChance;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.BehaviorDestroy;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.ObjectHelper;
   import ninjakiwi.monkeyTown.btdModule.weapons.Standard;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class Projectile extends Entity
   {
      
      public static var nextID:int = 0;
       
      
      public var id:int = 1;
      
      public var def:ProjectileDef;
      
      public var velocity:Vector2;
      
      public var stationary:Boolean = false;
      
      public var testBloons:Vector.<Vector.<Bloon>>;
      
      public var pierce:int = 0;
      
      public var owner:Tower = null;
      
      public var target:Bloon = null;
      
      public var clip:Clip;
      
      private var layerdDisplay:LayeredEntity = null;
      
      private var additiveDisplay:AdditiveEntity = null;
      
      public var lifeSpanTimer:GameSpeedTimer;
      
      public var effectMask:int = 0;
      
      public var destroyOnEnd:Boolean = true;
      
      public var numOfRegenPurged:int = 0;
      
      private var _buffedRadius:Number = 0;
      
      private var _buffedDamageEffect:DamageEffectDef = null;
      
      public var hitBloons:Vector.<uint>;
      
      public var level:Level = null;
      
      private var _extraPiercePrecision:Number = 0;
      
      public var pierceRemainder:Number = 0;
      
      public function Projectile()
      {
         this.velocity = new Vector2();
         this.clip = new Clip();
         this.lifeSpanTimer = new GameSpeedTimer(1);
         this.hitBloons = new Vector.<uint>();
         super();
      }
      
      public function initialise(param1:ProjectileDef, param2:Level, param3:Vector.<Buff>, param4:Weapon = null, param5:Tower = null, param6:int = 0, param7:Number = 0) : void
      {
         this.level = param2;
         this._extraPiercePrecision = param7;
         this.hitBloons.splice(0,this.hitBloons.length);
         this.id = nextID++;
         this.def = param1;
         this.owner = null;
         this.pierce = param1.pierce + param6;
         this.stationary = false;
         if(param1.display != null)
         {
            this.clip.initialise(param1.display,64);
            if(this.clip.hasLabel("Loop"))
            {
               this.clip.labelOver["Loop"] = new LabelOverCommand();
               this.clip.labelOver["Loop"].command = LabelOverCommand.gotoAndPlay;
               this.clip.labelOver["Loop"].frameNoTo = 0;
               this.clip.gotoLabel("Loop");
               this.clip.play();
               this.clip.looping = true;
            }
         }
         z = 2 + param1.zOffset;
         if(param1.layeredDisplay != null)
         {
            this.layerdDisplay = new LayeredEntity();
            this.layerdDisplay.initialise(param1.layeredDisplay,z,z,param2);
            param2.addEntity(this.layerdDisplay);
         }
         if(param1.additiveBlend)
         {
            this.additiveDisplay = new AdditiveEntity();
            this.additiveDisplay.initialise(param1.display,2,param2);
            param2.addEntity(this.additiveDisplay);
         }
         this.setEffectMask();
         if(param1.behavior && param1.behavior.roundOver != null)
         {
            Main.instance.game.addEventListener(LevelEvent.ROUND_OVER,this.roundOver);
         }
         this._buffedRadius = param1.radius;
         if(param1.damageEffect)
         {
            this._buffedDamageEffect = ObjectHelper.clone(param1.damageEffect) as DamageEffectDef;
         }
         this.applyBuffs(param3,param4,param5);
      }
      
      private function applyBuffs(param1:Vector.<Buff>, param2:Weapon, param3:Tower) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Standard = null;
         var _loc10_:Number = NaN;
         var _loc11_:Vector.<int> = null;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(param1 != null)
         {
            _loc8_ = 0;
            while(_loc8_ < param1.length)
            {
               if(param1[_loc8_].buffMethodModuleClass == PierceAdd)
               {
                  _loc4_ = _loc4_ + param1[_loc8_].buffValue;
               }
               else if(param1[_loc8_].buffMethodModuleClass == PierceAddBase)
               {
                  if(param2 && param2.isBaseWeapon)
                  {
                     _loc4_ = _loc4_ + param1[_loc8_].buffValue;
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == HitAreaScale)
               {
                  this._buffedRadius = this.def.radius * (this._buffedRadius / this.def.radius - (1 - param1[_loc8_].buffValue));
               }
               else if(param1[_loc8_].buffMethodModuleClass == ImmunityBlack)
               {
                  _loc6_ = _loc6_ < param1[_loc8_].buffValue?Number(param1[_loc8_].buffValue):Number(_loc6_);
               }
               else if(param1[_loc8_].buffMethodModuleClass == DamageScaleMOAB)
               {
                  if(null != this._buffedDamageEffect)
                  {
                     this._buffedDamageEffect.moabScale = this.def.damageEffect.moabScale * (this._buffedDamageEffect.moabScale / this.def.damageEffect.moabScale - (1 - param1[_loc8_].buffValue));
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == PierceAddWhirlwind && this.def.display == Tornado)
               {
                  _loc4_ = _loc4_ + param1[_loc8_].buffValue;
               }
               else if(param1[_loc8_].buffMethodModuleClass == LayersRemovedAdd)
               {
                  if(null != this._buffedDamageEffect)
                  {
                     _loc5_ = _loc5_ + param1[_loc8_].buffValue;
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == PurgeRegenChance)
               {
                  if(!(null == this._buffedDamageEffect || null == param3))
                  {
                     this._buffedDamageEffect.purgeRegenChance = this._buffedDamageEffect.purgeRegenChance + param1[_loc8_].buffValue;
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == DamageAddCeramicSnapFreeze)
               {
                  if(!(null == this._buffedDamageEffect || null == param3))
                  {
                     if(param3.upgradePaths[0] >= 2)
                     {
                        this._buffedDamageEffect.ceramicAdd = this._buffedDamageEffect.ceramicAdd + param1[_loc8_].buffValue;
                     }
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == ImmunityCamoSentry)
               {
                  if("Sentry" == param3.id || "SentrySprockets" == param3.id)
                  {
                     this.effectMask = this.effectMask & ~Bloon.IMMUNITY_NO_DETECTION;
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == PierceAddSentry)
               {
                  if("Sentry" == param3.id)
                  {
                     _loc4_ = _loc4_ + param1[_loc8_].buffValue;
                  }
               }
               else if(param1[_loc8_].buffMethodModuleClass == ImmunityLeadSentry)
               {
                  if(param3 != null)
                  {
                     if("Sentry" == param3.id)
                     {
                        _loc7_ = _loc7_ < param1[_loc8_].buffValue?Number(param1[_loc8_].buffValue):Number(_loc7_);
                     }
                  }
               }
               _loc8_++;
            }
         }
         _loc4_ = _loc4_ + ActiveAbilityEmpower.instance.getEmpoweredPierceBonus();
         this.pierce = this.pierce + int(_loc4_ + this._extraPiercePrecision);
         this.pierceRemainder = (_loc4_ + this._extraPiercePrecision) % 1;
         if(this._buffedDamageEffect && param2)
         {
            _loc9_ = param2 as Standard;
            _loc10_ = this._buffedDamageEffect.damage + _loc9_.extraDamagePrecision + _loc5_;
            this._buffedDamageEffect.Damage(_loc10_);
            _loc9_.extraDamagePrecision = _loc10_ % 1;
         }
         if(this._buffedDamageEffect)
         {
            _loc11_ = this._buffedDamageEffect.cantBreak;
            if(param3)
            {
               if(1 <= param3.degradeBlackRemainder + _loc6_)
               {
                  if(_loc11_ != null && -1 != _loc11_.indexOf(Bloon.BLACK))
                  {
                     _loc11_.splice(_loc11_.indexOf(Bloon.BLACK),1);
                     _loc11_.splice(_loc11_.indexOf(Bloon.ZEBRA),1);
                     _loc11_.splice(_loc11_.indexOf(Bloon.DDT),1);
                  }
               }
               param3.degradeBlackRemainder = (param3.degradeBlackRemainder + _loc6_) % 1;
               if(1 <= param3.pierceLeadRemainder + _loc7_)
               {
                  if(_loc11_ != null && -1 != _loc11_.indexOf(Bloon.LEAD))
                  {
                     this._buffedDamageEffect.cantBreak.splice(this._buffedDamageEffect.cantBreak.indexOf(Bloon.LEAD),1);
                  }
               }
               param3.pierceLeadRemainder = (param3.pierceLeadRemainder + _loc7_) % 1;
            }
         }
      }
      
      public function setEffectMask() : void
      {
         var _loc1_:int = 0;
         this.effectMask = 0;
         if(this.def.effectMask != null)
         {
            for each(_loc1_ in this.def.effectMask)
            {
               this.effectMask = this.effectMask | _loc1_;
            }
         }
      }
      
      private function roundOver(param1:Event) : void
      {
         this.def.behavior.roundOver.execute(this);
      }
      
      override public function destroy() : void
      {
         var _loc1_:BehaviorDestroy = null;
         var _loc2_:TrailClip = null;
         if(this.def == null)
         {
            return;
         }
         if(this.layerdDisplay != null)
         {
            this.layerdDisplay.destroy();
            this.layerdDisplay = null;
         }
         if(this.additiveDisplay != null)
         {
            this.additiveDisplay.destroy();
         }
         if(this.def.behavior && this.def.behavior.destroy)
         {
            _loc1_ = this.def.behavior.destroy;
            while(_loc1_ != null)
            {
               _loc1_.execute(this);
               _loc1_ = _loc1_.next;
            }
         }
         if(this.def.display != null)
         {
            if(this.clip.frameIndex != this.clip.frameCount - 1)
            {
               if(this.def.display == IceBurst || this.def.display == IceBurstMedium || this.def.display == IceBurstLarge || this.def.display == IceExplosion || this.def.display == IceExplosionMedium || this.def.display == IceExplosionLarge || this.def.display == RingOfFire || this.def.display == NuclearExplosion || this.def.display == LargeExplosion || this.def.display == MediumExplosion || this.def.display == SmallExplosion || this.def.display == GlueSplat || this.def.display == CorrosiveSplat || this.def.display == GodGlueSplat || this.def.display == BurnyLargeExplosion || this.def.display == BurnyMediumExplosion || this.def.display == BurnyNuclearExplosion || this.def.display == SlightlyLargerExplosion || this.def.display == BurnySlightlyLargerExplosion || this.def.display == BloonsBushCreeper)
               {
                  _loc2_ = new TrailClip();
                  _loc2_.Initialise(this.clip.sourceClass,this.clip.frameIndex);
                  _loc2_.x = x;
                  _loc2_.y = y;
                  _loc2_.rotation = rotation;
                  this.level.addEntity(_loc2_);
               }
            }
         }
         if(this.def.behavior && this.def.behavior.roundOver != null)
         {
            Main.instance.game.removeEventListener(LevelEvent.ROUND_OVER,this.roundOver);
         }
         if(this.def.behavior && this.def.behavior.lifespanOver != null)
         {
            this.def.behavior.lifespanOver.cleanup(this);
         }
         this.def = null;
         this.velocity.x = 0;
         this.velocity.y = 0;
         this.pierce = 0;
         this.owner = null;
         this.target = null;
         this.layerdDisplay = null;
         this.additiveDisplay = null;
         this.lifeSpanTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.lifespanOver);
         this.effectMask = 0;
         this.hitBloons.splice(0,this.hitBloons.length);
         this.level.removeProjectile(this);
         this.level = null;
         super.destroy();
      }
      
      public function set lifespan(param1:Number) : void
      {
         this.lifeSpanTimer.delay = param1;
         this.lifeSpanTimer.reset();
         this.lifeSpanTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.lifespanOver);
         this.lifeSpanTimer.addEventListener(GameSpeedTimer.COMPLETE,this.lifespanOver);
      }
      
      public function get buffedRadius() : Number
      {
         return this._buffedRadius;
      }
      
      public function get buffedDamageEffect() : DamageEffectDef
      {
         return this._buffedDamageEffect;
      }
      
      private function lifespanOver(param1:Event) : void
      {
         this.lifeSpanTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.lifespanOver);
         if(this.def.behavior && this.def.behavior.lifespanOver)
         {
            this.def.behavior.lifespanOver.execute(this);
         }
         else
         {
            this.destroy();
         }
      }
      
      override public function process(param1:Number) : void
      {
         if(this.def == null)
         {
            return;
         }
         if(this.def.behavior && this.def.behavior.process)
         {
            this.def.behavior.process.execute(this,param1);
         }
         else
         {
            x = x + this.velocity.x * param1;
            y = y + this.velocity.y * param1;
         }
         if(this.def == null)
         {
            return;
         }
         if(this.def.display != null)
         {
            this.clip.process();
         }
         var _loc2_:int = 50;
         if(x < -_loc2_ || x > Main.instance.bufferWidth + _loc2_ || y < -_loc2_ || y > Main.instance.bufferHeight + _loc2_)
         {
            this.destroy();
         }
         if(this.layerdDisplay)
         {
            this.layerdDisplay.x = x;
            this.layerdDisplay.y = y;
            this.layerdDisplay.rotation = rotation;
         }
         if(this.additiveDisplay)
         {
            this.additiveDisplay.x = x;
            this.additiveDisplay.y = y;
            this.additiveDisplay.rotation = rotation;
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.def == null || this.def.display == null)
         {
            return;
         }
         if(rotation == 0)
         {
            rotation = this.velocity.rotation;
         }
         if(this.layerdDisplay)
         {
            return;
         }
         if(this.additiveDisplay)
         {
            return;
         }
         if(this.def.display == Tornado || this.def.display == Tempest || this.def.display == TinyTornado)
         {
            this.clip.quickDraw(param1,x,y);
            return;
         }
         this.clip.drawRotated(param1,x,y,rotation);
      }
      
      public function handleCollision() : void
      {
         if(this.def == null)
         {
            return;
         }
         if(!(this.def.iceEffect && this.def.iceEffect.arcticWind))
         {
            this.pierce--;
         }
         if(this.def.behavior && this.def.behavior.collision)
         {
            this.def.behavior.collision.execute(this);
            if(this.def.behavior.collision.next)
            {
               this.def.behavior.collision.next.execute(this);
            }
         }
         if(this.pierce <= 0 && this.destroyOnEnd)
         {
            this.destroy();
         }
      }
   }
}
