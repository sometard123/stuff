package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision
{
   import assets.projectile.BurnyLargeExplosion;
   import assets.projectile.BurnyMediumExplosion;
   import assets.projectile.BurnyNuclearExplosion;
   import assets.projectile.BurnySlightlyLargerExplosion;
   import assets.projectile.CorrosiveSplat;
   import assets.projectile.DissloverShot;
   import assets.projectile.GlueShot;
   import assets.projectile.GlueSplat;
   import assets.projectile.IceBurst;
   import assets.projectile.IceBurstLarge;
   import assets.projectile.IceBurstMedium;
   import assets.projectile.IceExplosion;
   import assets.projectile.IceExplosionLarge;
   import assets.projectile.IceExplosionMedium;
   import assets.projectile.LargeExplosion;
   import assets.projectile.MediumExplosion;
   import assets.projectile.NuclearExplosion;
   import assets.projectile.SlightlyLargerExplosion;
   import assets.projectile.SmallExplosion;
   import assets.sound.GlueSplatter;
   import assets.sound.IceExplode;
   import assets.sounds.ExplosionBig;
   import assets.sounds.ExplosionHuge;
   import assets.sounds.ExplosionMedium;
   import assets.sounds.ExplosionSmall;
   import assets.towers.BloonDissolver;
   import assets.towers.BloonLiquifier;
   import assets.towers.CorrosiveGlue;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class CollisionSpawnProjectile extends BehaviorCollision
   {
       
      
      private var projectile_:ProjectileDef;
      
      public function CollisionSpawnProjectile()
      {
         super();
      }
      
      public function set projectile(param1:ProjectileDef) : void
      {
         if(this.projectile_ != param1)
         {
            this.projectile_ = param1;
            dispatchEvent(new PropertyModEvent("projectile"));
         }
      }
      
      public function get projectile() : ProjectileDef
      {
         return this.projectile_;
      }
      
      public function Projectile(param1:ProjectileDef) : CollisionSpawnProjectile
      {
         this.projectile = param1;
         return this;
      }
      
      override public function execute(param1:Projectile) : void
      {
         var _loc2_:Projectile = null;
         var _loc3_:ProjectileDef = null;
         param1.pierce = 0;
         _loc2_ = Pool.get(Projectile);
         if(param1.def.display == DissloverShot && param1.owner && (param1.owner.def.display == BloonDissolver || param1.owner.def.display == BloonLiquifier))
         {
            _loc3_ = new ProjectileDef().Display(CorrosiveSplat).Radius(this.projectile.radius).Pierce(this.projectile.pierce).EffectMask(param1.def.effectMask).GlueEffect(param1.def.glueEffect);
            _loc2_.initialise(_loc3_,param1.level,param1.owner.buffs,null,param1.owner);
         }
         else if(param1.def.display == GlueShot && param1.owner.def && param1.owner && (param1.owner.def.display == CorrosiveGlue || param1.owner.def.display == GlueSplatter))
         {
            _loc3_ = new ProjectileDef().Display(GlueSplat).Radius(this.projectile.radius).Pierce(this.projectile.pierce).EffectMask(param1.def.effectMask).GlueEffect(param1.def.glueEffect);
            _loc2_.initialise(_loc3_,param1.level,param1.owner.buffs,null,param1.owner);
         }
         else
         {
            _loc2_.initialise(this.projectile,param1.level,param1.owner.buffs,null,param1.owner);
         }
         _loc2_.owner = param1.owner;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.lifespan = 0.1;
         _loc2_.rotation = param1.rotation;
         if(this.projectile.display == SmallExplosion)
         {
            new MaxSound(ExplosionSmall).play();
         }
         if(this.projectile.display == MediumExplosion || this.projectile.display == BurnyMediumExplosion)
         {
            new MaxSound(ExplosionMedium).play();
         }
         if(this.projectile.display == LargeExplosion || this.projectile.display == BurnyLargeExplosion || this.projectile.display == SlightlyLargerExplosion || this.projectile.display == BurnySlightlyLargerExplosion)
         {
            new MaxSound(ExplosionBig).play();
         }
         if(this.projectile.display == NuclearExplosion || this.projectile.display == BurnyNuclearExplosion)
         {
            new MaxSound(ExplosionHuge).play();
         }
         if(this.projectile.display == GlueSplat || this.projectile.display == CorrosiveSplat)
         {
            new MaxSound(GlueSplatter).play();
         }
         if(this.projectile.display == IceBurst || this.projectile.display == IceBurstMedium || this.projectile.display == IceBurstLarge || this.projectile.display == IceExplosion || this.projectile.display == IceExplosionMedium || this.projectile.display == IceExplosionLarge)
         {
            new MaxSound(IceExplode).play();
         }
         param1.level.addProjectile(_loc2_);
      }
   }
}
