package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class FireAtMouse extends Standard implements HasSpread
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var spread_:Number = 0;
      
      private var tmpRotation:Vector2;
      
      public function FireAtMouse()
      {
         this.tmpRotation = new Vector2();
         super();
      }
      
      public function set spread(param1:Number) : void
      {
         if(this.spread_ != param1)
         {
            this.spread_ = param1;
            dispatchEvent(new PropertyModEvent("spread"));
         }
      }
      
      public function get spread() : Number
      {
         return this.spread_;
      }
      
      public function Spread(param1:Number) : FireAtMouse
      {
         this.spread = param1;
         return this;
      }
      
      public function Range(param1:Number) : FireAtMouse
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : FireAtMouse
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : FireAtMouse
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : FireAtMouse
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : FireAtMouse
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : FireAtMouse
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Vector2 = null;
         var _loc6_:Projectile = null;
         var _loc7_:Vector2 = null;
         _loc5_ = new Vector2();
         if(param1.targetingSystem == TowerDef.TARGETS_MOUSE)
         {
            _loc7_ = param1.level.getMousePos();
            _loc5_.x = _loc7_.x;
            _loc5_.y = _loc7_.y;
         }
         else if(param1.targetingSystem == TowerDef.TARGETS_RETICLE)
         {
            _loc5_ = FireAtReticle.GetLocation(param1);
         }
         _loc6_ = Pool.get(Projectile);
         _loc6_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
         _loc6_.owner = param1;
         _loc6_.x = param2.x;
         _loc6_.y = param2.y;
         this.extraPiercePrecision = _loc6_.pierceRemainder;
         _loc6_.lifespan = range / power;
         _loc6_.velocity.x = _loc5_.x - _loc6_.x;
         _loc6_.velocity.y = _loc5_.y - _loc6_.y;
         param1.rotation = _loc6_.velocity.rotation;
         _loc6_.velocity.magnitude = power;
         _loc6_.velocity.rotateBy(Rndm.random() * this.spread - this.spread / 2);
         _loc6_.rotation = _loc6_.velocity.rotation;
         if(param4)
         {
            this.tmpRotation.x = param4.x;
            this.tmpRotation.y = param4.y;
            this.tmpRotation.rotateBy(_loc6_.velocity.rotation);
            _loc6_.x = _loc6_.x + this.tmpRotation.x;
            _loc6_.y = _loc6_.y + this.tmpRotation.y;
         }
         param1.level.addProjectile(_loc6_);
      }
   }
}
