package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.ProjectileHitAllDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasProjectile;
   
   public class ProjectileHitAll extends Ability
   {
       
      
      public function ProjectileHitAll()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc5_:Bloon = null;
         var _loc6_:ProjectileHitAllDef = null;
         var _loc7_:Effect = null;
         var _loc3_:Projectile = Pool.get(Projectile);
         _loc3_.initialise((param2 as ProjectileHitAllDef).projectile,param1.level,param1.buffs,null);
         _loc3_.owner = param1;
         var _loc4_:Vector.<Bloon> = param1.level.bloons.concat();
         if(_loc3_.def.glueEffect != null)
         {
            _loc3_.def.glueEffect = (param1.def.weapons[0] as HasProjectile).projectile.glueEffect;
         }
         for each(_loc5_ in _loc4_)
         {
            _loc5_.handleCollision(_loc3_);
         }
         _loc6_ = param2 as ProjectileHitAllDef;
         if(_loc6_.fullscreenEffect != null)
         {
            _loc7_ = new Effect();
            _loc7_.initialise(_loc6_.fullscreenEffect,3000);
            param1.level.addEntity(_loc7_);
         }
         super.execute(param1,param2);
      }
   }
}
