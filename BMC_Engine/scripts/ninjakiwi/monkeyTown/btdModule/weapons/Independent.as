package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.projectile.RoboDart;
   import assets.projectile.RoboLaser;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class Independent extends Weapon implements HasReloadTime, HasChildWeapons, HasRange
   {
       
      
      private var reloadTime_:Number;
      
      private var childWeapons_:Vector.<Weapon>;
      
      private var range_:Number;
      
      private var angleTemp:Vector2;
      
      private var angleTemp2:Vector2;
      
      private var offsets_:Vector.<Vector2> = null;
      
      public function Independent()
      {
         this.angleTemp = new Vector2();
         this.angleTemp2 = new Vector2();
         super();
      }
      
      public function set range(param1:Number) : void
      {
         if(this.range_ != param1)
         {
            this.range_ = param1;
            dispatchEvent(new PropertyModEvent("range"));
         }
      }
      
      public function get range() : Number
      {
         return this.range_;
      }
      
      public function Range(param1:Number) : Independent
      {
         this.range = param1;
         return this;
      }
      
      public function set offsets(param1:Vector.<Vector2>) : void
      {
         if(this.offsets_ != param1)
         {
            this.offsets_ = param1;
            dispatchEvent(new PropertyModEvent("offsets"));
         }
      }
      
      public function get offsets() : Vector.<Vector2>
      {
         return this.offsets_;
      }
      
      public function Offsets(param1:Vector.<Vector2>) : Independent
      {
         this.offsets = param1;
         return this;
      }
      
      public function set reloadTime(param1:Number) : void
      {
         if(this.reloadTime_ != param1)
         {
            this.reloadTime_ = param1;
            dispatchEvent(new PropertyModEvent("reloadTime"));
         }
      }
      
      public function get reloadTime() : Number
      {
         return this.reloadTime_;
      }
      
      public function ReloadTime(param1:Number) : Independent
      {
         this.reloadTime = param1;
         return this;
      }
      
      public function set childWeapons(param1:Vector.<Weapon>) : void
      {
         if(this.childWeapons_ != param1)
         {
            this.childWeapons_ = param1;
            dispatchEvent(new PropertyModEvent("childWeapons"));
         }
      }
      
      public function get childWeapons() : Vector.<Weapon>
      {
         return this.childWeapons_;
      }
      
      public function ChildWeapons(param1:Vector.<Weapon>) : Independent
      {
         this.childWeapons = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Independent
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Independent
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc6_:Vector.<Bloon> = null;
         var _loc8_:Projectile = null;
         var _loc5_:Vector.<Bloon> = param1.targetsByPriority;
         _loc6_ = new Vector.<Bloon>();
         _loc6_.push(_loc5_[_loc5_.length - 1]);
         if(_loc5_.length > 1)
         {
            _loc6_.push(_loc5_[_loc5_.length - 2]);
         }
         else
         {
            _loc6_.push(_loc5_[_loc5_.length - 1]);
         }
         this.angleTemp.x = _loc6_[0].x - param1.x;
         this.angleTemp.y = _loc6_[0].y - param1.y;
         this.angleTemp2.x = _loc6_[1].x - param1.x;
         this.angleTemp2.y = _loc6_[1].y - param1.y;
         if(!isNaN(this.angleTemp.angleBetween(this.angleTemp2)))
         {
            param1.rotation = this.angleTemp.rotation + this.angleTemp.angleBetween(this.angleTemp2) / 2;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this.childWeapons.length)
         {
            this.childWeapons[_loc7_].execute(param1,param2,_loc6_[_loc7_],this.offsets[_loc7_]);
            _loc8_ = param1.level.allProjectiles[param1.level.allProjectiles.length - 1];
            this.angleTemp.x = _loc8_.velocity.x;
            this.angleTemp.y = _loc8_.velocity.y;
            this.angleTemp.magnitude = 1;
            if(_loc8_.def.display == RoboDart || _loc8_.def.display == RoboLaser)
            {
               _loc8_.x = _loc8_.x + this.angleTemp.x * 40;
               _loc8_.y = _loc8_.y + this.angleTemp.y * 40;
            }
            else
            {
               _loc8_.x = _loc8_.x + this.angleTemp.x * 20;
               _loc8_.y = _loc8_.y + this.angleTemp.y * 20;
            }
            this.angleTemp.x = this.offsets[_loc7_].x;
            this.angleTemp.y = this.offsets[_loc7_].y;
            this.angleTemp.rotateBy(param1.rotation);
            this.angleTemp2.x = param1.x + this.angleTemp.x;
            this.angleTemp2.y = param1.y + this.angleTemp.y;
            this.angleTemp.x = _loc6_[_loc7_].x - this.angleTemp2.x;
            this.angleTemp.y = _loc6_[_loc7_].y - this.angleTemp2.y;
            param1.addonClips[_loc7_].looping = false;
            param1.addonClips[_loc7_].play();
            if(param1.addonClips[_loc7_].frameIndex == param1.addonClips[_loc7_].frameCount - 1)
            {
               param1.addonClips[_loc7_].gotoAndPlay(1);
            }
            param1.addonRotation[param1.addonClips[_loc7_]] = this.angleTemp.rotation;
            _loc7_++;
         }
      }
   }
}
