package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy
{
   import assets.projectile.BurnyLargeExplosion;
   import assets.projectile.BurnyMediumExplosion;
   import assets.projectile.BurnyNuclearExplosion;
   import assets.projectile.BurnySlightlyLargerExplosion;
   import assets.projectile.CorrosiveSplat;
   import assets.projectile.DissloverShot;
   import assets.projectile.GlueSplat;
   import assets.projectile.LargeExplosion;
   import assets.projectile.MediumExplosion;
   import assets.projectile.NuclearExplosion;
   import assets.projectile.SlightlyLargerExplosion;
   import assets.projectile.SmallExplosion;
   import assets.projectile.SpikeMineBall;
   import assets.sound.GlueSplatter;
   import assets.sounds.ExplosionBig;
   import assets.sounds.ExplosionHuge;
   import assets.sounds.ExplosionMedium;
   import assets.sounds.ExplosionSmall;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SpawnProjectile extends BehaviorDestroy
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var projectile_:ProjectileDef;
      
      private var lifespan_:Number = 0.1;
      
      public function SpawnProjectile()
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
      
      public function Projectile(param1:ProjectileDef) : SpawnProjectile
      {
         this.projectile = param1;
         return this;
      }
      
      public function set lifespan(param1:Number) : void
      {
         if(this.lifespan_ != param1)
         {
            this.lifespan_ = param1;
            dispatchEvent(new PropertyModEvent("lifespan"));
         }
      }
      
      public function get lifespan() : Number
      {
         return this.lifespan_;
      }
      
      public function Lifespan(param1:Number) : SpawnProjectile
      {
         this.lifespan = param1;
         return this;
      }
      
      override public function execute(param1:Projectile) : void
      {
         var _loc2_:Projectile = null;
         if(param1.def.display == SpikeMineBall && !Main.instance.game.level.isRoundInProgress())
         {
            return;
         }
         param1.pierce = 0;
         _loc2_ = Pool.get(Projectile);
         _loc2_.initialise(this.projectile,param1.level,param1.owner.buffs,null,null,0,this.extraPiercePrecision);
         if(_loc2_.def.display == GlueSplat && param1.def.display == DissloverShot)
         {
            _loc2_.clip.initialise(CorrosiveSplat,1);
         }
         this.extraPiercePrecision = _loc2_.pierceRemainder;
         _loc2_.owner = param1.owner;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.lifespan = this.lifespan;
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
         if(this.projectile.display == GlueSplat)
         {
            new MaxSound(GlueSplatter).play();
         }
         param1.level.addProjectile(_loc2_);
      }
   }
}
