package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.tower.BuccaneerCannonsLeft;
   import assets.tower.BuccaneerCannonsRight;
   import assets.towers.CannonShipCannonsLeft;
   import assets.towers.CannonShipCannonsRight;
   import assets.towers.LeftBack;
   import assets.towers.LeftFront;
   import assets.towers.LongerCannonsLeft;
   import assets.towers.LongerCannonsRight;
   import assets.towers.PiratesCannonsLeft;
   import assets.towers.PiratesCannonsRight;
   import assets.towers.RightBack;
   import assets.towers.RightFront;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SideSingle extends Standard
   {
      
      public static var towerRotationVec:Vector2 = new Vector2();
       
      
      private var fireFromRight_:String = null;
      
      private var fireFromLeft_:String = null;
      
      private var _pierceOverage:Number = 0;
      
      public function SideSingle()
      {
         super();
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
      
      public function FireFromRight(param1:String) : SideSingle
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
      
      public function FireFromLeft(param1:String) : SideSingle
      {
         this.fireFromLeft = param1;
         return this;
      }
      
      public function Range(param1:Number) : SideSingle
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SideSingle
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SideSingle
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SideSingle
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SideSingle
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : SideSingle
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Projectile = null;
         var _loc7_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:Class = null;
         _loc5_ = Pool.get(Projectile);
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc6_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc6_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc6_;
         }
         _loc5_.initialise(projectile,param1.level,param1.buffs,this,param1,_loc6_);
         _loc5_.owner = param1;
         _loc5_.x = param2.x;
         _loc5_.y = param2.y;
         _loc5_.lifespan = range / power;
         _loc7_ = null;
         towerRotationVec.x = 0;
         towerRotationVec.y = 0;
         if(param3 != null)
         {
            _loc5_.velocity.x = param3.x - _loc5_.x;
            _loc5_.velocity.y = param3.y - _loc5_.y;
            _loc5_.velocity.magnitude = power;
            towerRotationVec.x = 1;
            towerRotationVec.y = 0;
            towerRotationVec.rotation = param1.rotation;
            _loc9_ = towerRotationVec.angleBetween(_loc5_.velocity);
            if(_loc9_ < 0)
            {
               param1.rotation = _loc5_.velocity.rotation + Math.PI / 2;
               _loc7_ = this.fireFromLeft;
            }
            else
            {
               param1.rotation = _loc5_.velocity.rotation - Math.PI / 2;
               _loc7_ = this.fireFromRight;
            }
            _loc10_ = param1.def.displayAddons[0].clip;
            if(_loc10_ == BuccaneerCannonsLeft || BuccaneerCannonsRight || _loc10_ == LongerCannonsLeft || LongerCannonsRight)
            {
               towerRotationVec.x = -7;
               towerRotationVec.y = _loc7_ == this.fireFromLeft?Number(-60):Number(60);
               towerRotationVec.rotateBy(param1.rotation);
            }
            else if(_loc10_ == LeftBack || _loc10_ == RightBack || _loc10_ == LeftFront || _loc10_ == RightFront)
            {
               towerRotationVec.x = 0;
               towerRotationVec.y = _loc7_ == this.fireFromLeft?Number(-70):Number(70);
               towerRotationVec.rotateBy(param1.rotation);
            }
            else if(_loc10_ == CannonShipCannonsLeft || _loc10_ == CannonShipCannonsRight || _loc10_ == PiratesCannonsLeft || _loc10_ == PiratesCannonsRight)
            {
               towerRotationVec.x = 0;
               towerRotationVec.y = _loc7_ == this.fireFromLeft?Number(-70):Number(70);
               towerRotationVec.rotateBy(param1.rotation);
            }
         }
         else
         {
            _loc5_.velocity.x = power;
            _loc5_.velocity.y = 0;
            _loc5_.velocity.rotation = param2.rotation;
         }
         _loc5_.x = param2.x + towerRotationVec.x;
         _loc5_.y = param2.y + towerRotationVec.y;
         _loc5_.rotation = _loc5_.velocity.rotation;
         param1.level.addProjectile(_loc5_);
         var _loc8_:int = 0;
         while(_loc8_ < param1.addonClips.length)
         {
            if(param1.def.displayAddons[_loc8_].ref == _loc7_)
            {
               param1.addonClips[_loc8_].gotoAndPlay(0);
            }
            _loc8_++;
         }
      }
   }
}
