package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Single extends Standard
   {
       
      
      private var rotate_:Boolean = true;
      
      private var tempRotation:Vector2;
      
      private var extraPiercePrecision:Number = 0;
      
      private var _pierceOverage:Number = 0;
      
      public function Single(param1:String = null)
      {
         this.tempRotation = new Vector2();
         super(param1);
      }
      
      public function Range(param1:Number) : Single
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : Single
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : Single
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : Single
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Single
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Single
      {
         isBaseWeapon = param1;
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
      
      public function Rotate(param1:Boolean) : Single
      {
         this.rotate = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Projectile = null;
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
         if(param4 != null)
         {
            this.tempRotation.x = param4.x;
            this.tempRotation.y = param4.y;
            this.tempRotation.rotateBy(param2.rotation);
            _loc5_.x = _loc5_.x + this.tempRotation.x;
            _loc5_.y = _loc5_.y + this.tempRotation.y;
         }
         _loc5_.lifespan = range / power;
         if(param3 != null)
         {
            _loc5_.velocity.x = param3.x - _loc5_.x;
            _loc5_.velocity.y = param3.y - _loc5_.y;
            _loc5_.velocity.magnitude = power;
         }
         else
         {
            _loc5_.velocity.x = power;
            _loc5_.velocity.y = 0;
            _loc5_.velocity.rotation = param2.rotation;
         }
         _loc5_.rotation = _loc5_.velocity.rotation;
         _loc5_.target = param3 as Bloon;
         param1.level.addProjectile(_loc5_);
      }
   }
}
