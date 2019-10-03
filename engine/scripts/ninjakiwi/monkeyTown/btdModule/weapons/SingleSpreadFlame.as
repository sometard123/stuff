package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class SingleSpreadFlame extends Standard implements HasSpread
   {
      
      private static var angleTempVect:Vector2 = new Vector2();
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var rotate_:Boolean = true;
      
      private var spread_:Number = 0;
      
      private var tempRotation:Vector2;
      
      private var _pierceOverage:Number = 0;
      
      public function SingleSpreadFlame()
      {
         this.tempRotation = new Vector2();
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
      
      public function Spread(param1:Number) : SingleSpreadFlame
      {
         this.spread = param1;
         return this;
      }
      
      public function Range(param1:Number) : SingleSpreadFlame
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SingleSpreadFlame
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SingleSpreadFlame
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SingleSpreadFlame
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SingleSpreadFlame
      {
         proxied = param1;
         return this;
      }
      
      public function set rotate(param1:Boolean) : void
      {
         if(this.rotate_ != param1)
         {
            this.rotate_ = param1;
            dispatchEvent(new PropertyModEvent("rotate"));
         }
      }
      
      public function get rotate() : Boolean
      {
         return this.rotate_;
      }
      
      public function Rotate(param1:Boolean) : SingleSpreadFlame
      {
         this.rotate = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Projectile = null;
         var _loc7_:Number = NaN;
         _loc5_ = Pool.get(Projectile);
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc6_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc6_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc6_;
         }
         _loc5_.initialise(projectile,param1.level,param1.buffs,this,param1,_loc6_,this.extraPiercePrecision);
         _loc5_.owner = param1;
         _loc5_.x = param2.x;
         _loc5_.y = param2.y;
         this.extraPiercePrecision = _loc5_.pierceRemainder;
         if(this.rotate && param3 != null)
         {
            _loc5_.velocity.x = param3.x - _loc5_.x;
            _loc5_.velocity.y = param3.y - _loc5_.y;
            param1.rotation = _loc5_.velocity.rotation;
         }
         _loc7_ = range;
         if(param4 != null)
         {
            this.tempRotation.x = param4.x;
            this.tempRotation.y = param4.y;
            this.tempRotation.rotateBy(param2.rotation);
            _loc5_.x = _loc5_.x + this.tempRotation.x;
            _loc5_.y = _loc5_.y + this.tempRotation.y;
            _loc7_ = _loc7_ - param4.magnitude;
         }
         _loc5_.lifespan = _loc7_ / power;
         if(param3 != null)
         {
            _loc5_.velocity.x = param3.x - param1.x;
            _loc5_.velocity.y = param3.y - param1.y;
            _loc5_.velocity.magnitude = power;
         }
         else
         {
            _loc5_.velocity.x = power;
            _loc5_.velocity.y = 0;
            _loc5_.velocity.rotation = param2.rotation;
         }
         _loc5_.velocity.rotation = _loc5_.velocity.rotation + (Rndm.random() * this.spread - this.spread / 2);
         _loc5_.rotation = _loc5_.velocity.rotation;
         param1.level.addProjectile(_loc5_);
      }
   }
}
