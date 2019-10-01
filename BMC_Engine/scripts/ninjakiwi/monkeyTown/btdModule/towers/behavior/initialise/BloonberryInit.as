package ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BloonberryInit extends BehaviorInitialise
   {
      
      public static var projectiles:Dictionary = new Dictionary();
       
      
      private var projectile_:ProjectileDef;
      
      public function BloonberryInit()
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
      
      public function ProjectileDefine(param1:ProjectileDef) : BloonberryInit
      {
         this.projectile = param1;
         return this;
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:Projectile = null;
         _loc2_ = Pool.get(Projectile);
         _loc2_.initialise(this.projectile,param1.level,param1.buffs,null);
         _loc2_.owner = param1;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.destroyOnEnd = false;
         _loc2_.lifespan = int.MAX_VALUE;
         param1.level.addProjectile(_loc2_);
         _loc2_.pierce = 10;
         param1.clip.gotoAndStop(int(param1.clip.frameCount - 1 - _loc2_.pierce / _loc2_.def.pierce * (param1.clip.frameCount - 1)));
         projectiles[param1] = _loc2_;
      }
      
      override public function cleanup(param1:Tower) : void
      {
         delete projectiles[param1];
      }
   }
}
