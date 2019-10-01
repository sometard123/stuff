package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SpawnProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SpawnProjectile extends Ability
   {
       
      
      public function SpawnProjectile()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc3_:Projectile = null;
         _loc3_ = Pool.get(Projectile);
         _loc3_.initialise((param2 as SpawnProjectileDef).projectile,param1.level,param1.buffs,null);
         _loc3_.owner = param1;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.lifespan = 0.1;
         param1.level.addProjectile(_loc3_);
         super.execute(param1,param2);
      }
   }
}
