package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assets.projectile.ApprenticeBreath;
   import assets.projectile.ApprenticeDisspate;
   import assets.towers.Phoenix;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LifetimeAddPhoenix;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.weapons.Single;
   
   public class Pheonix extends Entity
   {
      
      private static const BASE_DURATION:Number = 25;
       
      
      public var extraPiercePrecision:Number = 0;
      
      protected var clip:Clip = null;
      
      protected var owner:Tower = null;
      
      protected var location:Vector2;
      
      protected var destroyTimer:GameSpeedTimer = null;
      
      protected var offsetVector:Vector2;
      
      protected var dragonsBreathDissipate:ProjectileDef;
      
      protected var dragonsBreathProjectile:ProjectileDef;
      
      protected var dragonsBreathWeapon:Single;
      
      public function Pheonix()
      {
         this.location = new Vector2(150,0);
         this.offsetVector = new Vector2(30,0);
         super();
         this.dragonsBreathDissipate = new ProjectileDef().Display(ApprenticeDisspate).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).AdditiveBlend(true);
         this.dragonsBreathProjectile = new ProjectileDef().Display(ApprenticeBreath).Pierce(5).Radius(10).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).AdditiveBlend(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).Behavior(new BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(this.dragonsBreathDissipate).Lifespan(10 / 30)));
         this.dragonsBreathWeapon = new Single().Range(200).Power(560).ReloadTime(0.08).Projectile(this.dragonsBreathProjectile);
      }
      
      public function initialise(param1:Tower) : void
      {
         var buff:Buff = null;
         var owner:Tower = param1;
         this.owner = owner;
         this.clip = new Clip();
         this.clip.initialise(Phoenix,0);
         this.clip.looping = true;
         z = 10;
         var buffedDuration:Number = BASE_DURATION;
         var i:int = 0;
         while(i < owner.buffs.length)
         {
            buff = owner.buffs[i];
            if(buff.buffMethodModuleClass == LifetimeAddPhoenix)
            {
               buffedDuration = buffedDuration + buff.buffValue;
            }
            i++;
         }
         this.destroyTimer = new GameSpeedTimer(buffedDuration);
         this.destroyTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            destroy();
         });
      }
      
      override public function process(param1:Number) : void
      {
         var _loc5_:Bloon = null;
         var _loc6_:Vector.<Bloon> = null;
         var _loc7_:Bloon = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Projectile = null;
         this.location.rotateBy(Math.PI * 2 * 0.15 * param1);
         x = 350 + this.location.x;
         y = 260 + this.location.y;
         rotation = this.location.rotation + Math.PI / 2;
         var _loc2_:Vector.<Vector.<Bloon>> = this.owner.level.collisionGrid.getCellsInRange(x,y,200);
         var _loc3_:Number = Math.pow(200,2);
         var _loc4_:Number = 999999999;
         _loc5_ = null;
         for each(_loc6_ in _loc2_)
         {
            for each(_loc7_ in _loc6_)
            {
               if(!_loc7_.isInTunnel)
               {
                  _loc8_ = _loc7_.x - x;
                  _loc9_ = _loc7_.y - y;
                  _loc10_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
                  if(_loc10_ <= _loc3_ && _loc10_ < _loc4_)
                  {
                     _loc5_ = _loc7_;
                     _loc4_ = _loc10_;
                  }
               }
            }
         }
         if(_loc5_)
         {
            _loc11_ = Pool.get(Projectile);
            _loc11_.initialise(this.dragonsBreathWeapon.projectile,this.owner.level,this.owner.buffs,null,this.owner,0,this.extraPiercePrecision);
            _loc11_.owner = this.owner;
            this.extraPiercePrecision = _loc11_.pierceRemainder;
            this.offsetVector.x = 30;
            this.offsetVector.y = 0;
            this.offsetVector.rotateBy(rotation);
            _loc11_.x = x + this.offsetVector.x;
            _loc11_.y = y + this.offsetVector.y;
            _loc11_.lifespan = this.dragonsBreathWeapon.range / this.dragonsBreathWeapon.power;
            _loc11_.velocity.x = _loc5_.x - _loc11_.x;
            _loc11_.velocity.y = _loc5_.y - _loc11_.y;
            _loc11_.velocity.magnitude = this.dragonsBreathWeapon.power;
            _loc11_.rotation = _loc11_.velocity.rotation;
            this.owner.level.addProjectile(_loc11_);
         }
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawRotated(param1,x,y,rotation);
      }
   }
}
