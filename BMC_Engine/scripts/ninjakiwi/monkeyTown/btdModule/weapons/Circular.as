package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Circular extends Standard
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var count_:int;
      
      private var _pierceOverage:Number = 0;
      
      public function Circular(param1:String = null)
      {
         super(param1);
      }
      
      public function set count(param1:int) : void
      {
         if(this.count_ != param1)
         {
            this.count_ = param1;
            dispatchEvent(new PropertyModEvent("count"));
         }
      }
      
      public function get count() : int
      {
         return this.count_;
      }
      
      public function Count(param1:int) : Circular
      {
         this.count = param1;
         return this;
      }
      
      public function Range(param1:Number) : Circular
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : Circular
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : Circular
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : Circular
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Circular
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Circular
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Projectile = null;
         if(param1.def == null)
         {
            return;
         }
         _loc5_ = 2 * Math.PI / this.count;
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc6_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc6_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc6_;
         }
         var _loc7_:Projectile = null;
         _loc8_ = 0;
         while(_loc8_ < this.count)
         {
            _loc9_ = Pool.get(Projectile);
            _loc9_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
            _loc9_.owner = param1;
            _loc9_.x = param2.x;
            _loc9_.y = param2.y;
            _loc9_.lifespan = range / power;
            _loc9_.velocity.x = power;
            _loc9_.velocity.y = 0;
            _loc9_.velocity.rotateBy(param1.rotation + _loc5_ * _loc8_);
            _loc9_.rotation = _loc9_.velocity.rotation;
            param1.level.addProjectile(_loc9_);
            _loc7_ = _loc9_;
            _loc8_++;
         }
         if(_loc7_ != null)
         {
            this.extraPiercePrecision = _loc7_.pierceRemainder;
         }
      }
   }
}
