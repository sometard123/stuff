package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import assets.projectile.Glaive;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.Orbit;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SpawnGlaives extends BehaviorRoundStart
   {
      
      public static var glaives:Dictionary = new Dictionary();
       
      
      public function SpawnGlaives()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:ProjectileDef = null;
         var _loc3_:Projectile = null;
         _loc2_ = new ProjectileDef().Display(Glaive).Pierce(int.MAX_VALUE).Radius(15).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).CanMultiEffect(true).Behavior(new BehaviorDef().Process(new Orbit()));
         glaives[param1] = new Vector.<Projectile>();
         _loc3_ = Pool.get(Projectile);
         _loc3_.initialise(_loc2_,param1.level,param1.buffs,null);
         _loc3_.owner = param1;
         _loc3_.x = param1.x + 55;
         _loc3_.y = param1.y;
         _loc3_.lifespan = 99999;
         param1.level.addProjectile(_loc3_);
         glaives[param1].push(_loc3_);
         _loc3_ = Pool.get(Projectile);
         _loc3_.initialise(_loc2_,param1.level,param1.buffs,null);
         _loc3_.owner = param1;
         _loc3_.x = param1.x - 50;
         _loc3_.y = param1.y;
         _loc3_.lifespan = 99999;
         param1.level.addProjectile(_loc3_);
         glaives[param1].push(_loc3_);
      }
   }
}
