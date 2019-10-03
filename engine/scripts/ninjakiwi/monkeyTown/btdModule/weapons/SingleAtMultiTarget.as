package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SingleAtMultiTarget extends Standard
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var rotate_:Boolean = true;
      
      private var tempRotation:Vector2;
      
      private var count_:int;
      
      private var _pierceOverage:Number = 0;
      
      public function SingleAtMultiTarget()
      {
         this.tempRotation = new Vector2();
         super();
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
      
      public function Count(param1:int) : SingleAtMultiTarget
      {
         this.count = param1;
         return this;
      }
      
      public function Range(param1:Number) : SingleAtMultiTarget
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SingleAtMultiTarget
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SingleAtMultiTarget
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SingleAtMultiTarget
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SingleAtMultiTarget
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
      
      public function Rotate(param1:Boolean) : SingleAtMultiTarget
      {
         this.rotate = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc8_:Entity = null;
         var _loc9_:Projectile = null;
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc5_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc5_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc5_;
         }
         var _loc6_:Projectile = null;
         var _loc7_:int = 0;
         while(_loc7_ < this.count)
         {
            _loc8_ = param3;
            if(_loc7_ < param1.targetsByPriority.length)
            {
               _loc8_ = param1.targetsByPriority[param1.targetsByPriority.length - 1 - _loc7_];
            }
            _loc9_ = Pool.get(Projectile);
            _loc9_.initialise(projectile,param1.level,param1.buffs,this,param1,_loc5_,this.extraPiercePrecision);
            _loc9_.owner = param1;
            _loc9_.x = param2.x;
            _loc9_.y = param2.y;
            if(param4 != null)
            {
               this.tempRotation.x = param4.x;
               this.tempRotation.y = param4.y;
               this.tempRotation.rotateBy(param1.rotation);
               _loc9_.x = _loc9_.x + this.tempRotation.x;
               _loc9_.y = _loc9_.y + this.tempRotation.y;
            }
            _loc9_.lifespan = range / power;
            if(_loc8_ != null)
            {
               _loc9_.velocity.x = _loc8_.x - _loc9_.x;
               _loc9_.velocity.y = _loc8_.y - _loc9_.y;
               _loc9_.velocity.magnitude = power;
               if(this.rotate)
               {
                  param1.rotation = _loc9_.velocity.rotation;
               }
            }
            else
            {
               _loc9_.velocity.x = power;
               _loc9_.velocity.y = 0;
               _loc9_.velocity.rotation = param2.rotation;
            }
            _loc9_.rotation = _loc9_.velocity.rotation;
            param1.level.addProjectile(_loc9_);
            _loc6_ = _loc9_;
            _loc7_++;
         }
         if(_loc6_ != null)
         {
            this.extraPiercePrecision = _loc6_.pierceRemainder;
         }
      }
   }
}
