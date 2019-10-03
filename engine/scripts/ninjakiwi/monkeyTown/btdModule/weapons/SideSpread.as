package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.towers.AircraftCarrier;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SideSpread extends Standard
   {
      
      public static var towerRotationVec:Vector2 = new Vector2();
      
      private static var angleTempVect:Vector2 = new Vector2();
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var fireFromRight_:String = null;
      
      private var fireFromLeft_:String = null;
      
      private var angle_:Number;
      
      private var count_:int;
      
      private var rotate_:Boolean = true;
      
      public function SideSpread()
      {
         super();
      }
      
      public function set angle(param1:Number) : void
      {
         if(this.angle_ != param1)
         {
            this.angle_ = param1;
            dispatchEvent(new PropertyModEvent("angle"));
         }
      }
      
      public function get angle() : Number
      {
         return this.angle_;
      }
      
      public function Angle(param1:Number) : SideSpread
      {
         this.angle = param1;
         return this;
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
      
      public function Count(param1:int) : SideSpread
      {
         this.count = param1;
         return this;
      }
      
      public function set fireFromRight(param1:String) : void
      {
         if(this.fireFromRight_ != param1)
         {
            this.fireFromRight_ = param1;
            dispatchEvent(new PropertyModEvent("fireFromRight"));
         }
      }
      
      public function get fireFromRight() : String
      {
         return this.fireFromRight_;
      }
      
      public function FireFromRight(param1:String) : SideSpread
      {
         this.fireFromRight_ = param1;
         return this;
      }
      
      public function set fireFromLeft(param1:String) : void
      {
         if(this.fireFromLeft_ != param1)
         {
            this.fireFromLeft_ = param1;
            dispatchEvent(new PropertyModEvent("fireFromLeft"));
         }
      }
      
      public function get fireFromLeft() : String
      {
         return this.fireFromLeft_;
      }
      
      public function FireFromLeft(param1:String) : SideSpread
      {
         this.fireFromLeft = param1;
         return this;
      }
      
      public function Range(param1:Number) : SideSpread
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SideSpread
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SideSpread
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SideSpread
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SideSpread
      {
         proxied = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc7_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Projectile = null;
         var _loc5_:String = null;
         if(param3 != null)
         {
            angleTempVect.x = param3.x - param2.x;
            angleTempVect.y = param3.y - param2.y;
            towerRotationVec.x = 1;
            towerRotationVec.y = 0;
            towerRotationVec.rotation = param1.rotation;
            _loc10_ = towerRotationVec.angleBetween(angleTempVect);
            if(_loc10_ < 0)
            {
               if(param1.def.display != AircraftCarrier)
               {
                  param1.rotation = angleTempVect.rotation + Math.PI / 2;
               }
               _loc5_ = this.fireFromLeft;
            }
            else
            {
               if(param1.def.display != AircraftCarrier)
               {
                  param1.rotation = angleTempVect.rotation - Math.PI / 2;
               }
               _loc5_ = this.fireFromRight;
            }
         }
         var _loc6_:Number = angleTempVect.rotation - this.angle / 2;
         _loc7_ = this.angle / (this.count - 1);
         var _loc8_:Projectile = null;
         _loc9_ = 0;
         while(_loc9_ < this.count)
         {
            _loc11_ = Pool.get(Projectile);
            _loc11_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
            _loc11_.owner = param1;
            _loc11_.x = param2.x;
            _loc11_.y = param2.y;
            _loc11_.lifespan = range / power;
            _loc11_.velocity.x = power;
            _loc11_.velocity.y = 0;
            _loc11_.velocity.rotateBy(_loc6_ + _loc7_ * _loc9_);
            _loc11_.rotation = _loc11_.velocity.rotation;
            param1.level.addProjectile(_loc11_);
            _loc8_ = _loc11_;
            _loc9_++;
         }
         if(_loc8_ != null)
         {
            this.extraPiercePrecision = _loc8_.pierceRemainder;
         }
         _loc9_ = 0;
         while(_loc9_ < param1.addonClips.length)
         {
            if(param1.def.displayAddons[_loc9_].ref == _loc5_)
            {
               param1.addonClips[_loc9_].gotoAndPlay(0);
            }
            _loc9_++;
         }
      }
   }
}
