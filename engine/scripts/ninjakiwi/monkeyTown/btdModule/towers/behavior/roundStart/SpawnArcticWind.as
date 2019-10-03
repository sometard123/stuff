package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import assets.projectile.IceBurst;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.IceEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SpawnArcticWind extends BehaviorRoundStart
   {
      
      public static var arcticWinds:Dictionary = new Dictionary();
       
      
      public var extraPiercePrecision:Number = 0;
      
      public function SpawnArcticWind()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc3_:Projectile = null;
         var _loc2_:ProjectileDef = new ProjectileDef().Display(IceBurst).Pierce(9999999).Radius(126).CanMultiEffect(true).IceEffect(new IceEffectDef().Lifespan(0).ArcticWind(0.33));
         _loc3_ = Pool.get(Projectile);
         _loc3_.initialise(_loc2_,param1.level,param1.buffs,null,param1,0,this.extraPiercePrecision);
         _loc3_.owner = param1;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.lifespan = 9999999;
         param1.level.addProjectile(_loc3_);
         this.extraPiercePrecision = _loc3_.pierceRemainder;
         arcticWinds[param1] = _loc3_;
      }
   }
}
