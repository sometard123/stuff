package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.projectile.IceShard;
   import assets.towers.SuperMonkey;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileAddBloonjitsu;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class Spread extends Standard
   {
      
      private static var angleTempVect:Vector2 = new Vector2();
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var angle_:Number;
      
      private var count_:int;
      
      private var rotate_:Boolean = true;
      
      private var randRotate_:Boolean = false;
      
      private var offset_:Number = 0;
      
      private var tempRotation:Vector2;
      
      private var percentUntilExtraProjectile:Number = 0;
      
      private var _pierceOverage:Number = 0;
      
      public function Spread()
      {
         this.tempRotation = new Vector2();
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
      
      public function Angle(param1:Number) : Spread
      {
         this.angle = param1;
         return this;
      }
      
      public function set offset(param1:Number) : void
      {
         if(this.offset_ != param1)
         {
            this.offset_ = param1;
            dispatchEvent(new PropertyModEvent("offset"));
         }
      }
      
      public function get offset() : Number
      {
         return this.offset_;
      }
      
      public function Offset(param1:Number) : Spread
      {
         this.offset = param1;
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
      
      public function Count(param1:int) : Spread
      {
         this.count = param1;
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
      
      public function Rotate(param1:Boolean) : Spread
      {
         this.rotate = param1;
         return this;
      }
      
      public function set randRotate(param1:Boolean) : void
      {
         if(this.randRotate_ != param1)
         {
            this.randRotate_ = param1;
            dispatchEvent(new PropertyModEvent("randRotate"));
         }
      }
      
      public function get randRotate() : Boolean
      {
         return this.randRotate_;
      }
      
      public function RandRotate(param1:Boolean) : Spread
      {
         this.randRotate_ = param1;
         return this;
      }
      
      public function Range(param1:Number) : Spread
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : Spread
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : Spread
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : Spread
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Spread
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Spread
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Number = NaN;
         var _loc14_:Buff = null;
         var _loc15_:Projectile = null;
         if(param1.def == null)
         {
            return;
         }
         if(param3 != null)
         {
            angleTempVect.x = param3.x - param2.x;
            angleTempVect.y = param3.y - param2.y;
            if(this.rotate)
            {
               param1.rotation = angleTempVect.rotation;
            }
         }
         else
         {
            angleTempVect.x = 1;
            angleTempVect.y = 0;
            angleTempVect.rotation = param1.rotation;
         }
         if(this.randRotate)
         {
            angleTempVect.rotation = Rndm.random() * Math.PI * 2;
         }
         if(this.offset != 0)
         {
            angleTempVect.rotation = angleTempVect.rotation + this.offset;
         }
         _loc5_ = angleTempVect.rotation - this.angle / 2;
         var _loc6_:Number = 0;
         var _loc7_:int = this.count;
         if(param1.def.display == SuperMonkey)
         {
            _loc7_ = 1;
         }
         var _loc8_:Number = 0;
         var _loc9_:int = 0;
         while(_loc9_ < param1.def.buffs.length)
         {
            _loc14_ = param1.def.buffs[_loc9_];
            if(_loc14_.buffMethodModuleClass == ProjectileAdd)
            {
               _loc8_ = _loc8_ + _loc14_.buffValue;
            }
            else if(_loc14_.buffMethodModuleClass == ProjectileAddBloonjitsu)
            {
               if(param1.baseDef.label == "Bloonjitsu Master")
               {
                  _loc8_ = _loc8_ + _loc14_.buffValue;
               }
            }
            _loc9_++;
         }
         var _loc10_:int = int(_loc8_ + this.percentUntilExtraProjectile);
         this.percentUntilExtraProjectile = (_loc8_ + this.percentUntilExtraProjectile) % 1;
         _loc7_ = _loc7_ + _loc10_;
         if(_loc7_ > 1 && this.angle > 0)
         {
            _loc6_ = this.angle / (_loc7_ - 1);
         }
         else
         {
            _loc6_ = 0;
         }
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc11_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc11_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc11_;
         }
         var _loc12_:Projectile = null;
         var _loc13_:int = 0;
         while(_loc13_ < _loc7_)
         {
            _loc15_ = Pool.get(Projectile);
            _loc15_.initialise(projectile,param1.level,param1.buffs,this,param1,_loc11_,this.extraPiercePrecision);
            if(projectile.display == IceShard)
            {
               _loc15_.hitBloons.push(Bloon(param2).id);
            }
            _loc15_.owner = param1;
            _loc15_.x = param2.x;
            _loc15_.y = param2.y;
            if(param4 != null)
            {
               this.tempRotation.x = param4.x;
               this.tempRotation.y = param4.y;
               this.tempRotation.rotateBy(param1.rotation);
               _loc15_.x = _loc15_.x + this.tempRotation.x;
               _loc15_.y = _loc15_.y + this.tempRotation.y;
            }
            _loc15_.lifespan = range / power;
            _loc15_.velocity.x = power;
            _loc15_.velocity.y = 0;
            _loc15_.velocity.rotateBy(_loc5_ + _loc6_ * _loc13_);
            _loc15_.rotation = _loc15_.velocity.rotation;
            param1.level.addProjectile(_loc15_);
            _loc12_ = _loc15_;
            _loc13_++;
         }
         if(_loc12_ != null)
         {
            this.extraPiercePrecision = _loc12_.pierceRemainder;
         }
      }
   }
}
