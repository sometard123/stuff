package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SpawnSpreadCollision extends BehaviorCollision
   {
       
      
      private var projectile_:ProjectileDef;
      
      public function SpawnSpreadCollision()
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
      
      public function Projectile(param1:ProjectileDef) : SpawnSpreadCollision
      {
         this.projectile = param1;
         return this;
      }
      
      override public function execute(param1:Projectile) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Projectile = null;
         var _loc2_:int = 8;
         var _loc3_:Number = Math.PI * 2 * 7 / 8;
         _loc4_ = 0;
         _loc5_ = _loc3_ / (_loc2_ - 1);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc7_ = Pool.get(Projectile);
            _loc7_.initialise(this.projectile,param1.level,param1.owner.buffs,null);
            _loc7_.owner = param1.owner;
            _loc7_.x = param1.x;
            _loc7_.y = param1.y;
            _loc7_.pierce = 1;
            _loc7_.lifespan = 0.2;
            _loc7_.velocity.x = 500;
            _loc7_.velocity.y = 0;
            _loc7_.velocity.rotateBy(_loc4_ + _loc5_ * _loc6_);
            _loc7_.id = param1.id;
            param1.level.addProjectile(_loc7_);
            _loc6_++;
         }
      }
   }
}
