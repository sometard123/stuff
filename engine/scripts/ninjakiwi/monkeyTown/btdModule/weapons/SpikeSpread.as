package ninjakiwi.monkeyTown.btdModule.weapons
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class SpikeSpread extends Standard
   {
      
      public static var pointsInRange:Dictionary = new Dictionary();
      
      public static var fullTrackPoints:Dictionary = new Dictionary();
      
      public static var spikeTo:Dictionary = new Dictionary();
      
      public static var tempRotation:Vector2 = new Vector2();
       
      
      private var rotate_:Boolean = true;
      
      private var tempRotation:Vector2;
      
      private var fullScreen_:Boolean = false;
      
      public var extraPiercePrecision:Number = 0;
      
      private var _pierceOverage:Number = 0;
      
      public function SpikeSpread(param1:String = null)
      {
         this.tempRotation = new Vector2();
         super(param1);
      }
      
      public function Range(param1:Number) : SpikeSpread
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SpikeSpread
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SpikeSpread
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SpikeSpread
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SpikeSpread
      {
         proxied = param1;
         return this;
      }
      
      public function RequiresTarget(param1:Boolean) : SpikeSpread
      {
         requiresTarget = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : SpikeSpread
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
      
      public function Rotate(param1:Boolean) : SpikeSpread
      {
         this.rotate = param1;
         return this;
      }
      
      public function set fullTrack(param1:Boolean) : void
      {
         if(this.fullScreen_ != param1)
         {
            this.fullScreen_ = param1;
            dispatchEvent(new PropertyModEvent("fullScreen"));
         }
      }
      
      public function get fullTrack() : Boolean
      {
         return this.fullScreen_;
      }
      
      public function FullScreen(param1:Boolean) : SpikeSpread
      {
         this.fullTrack = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc7_:Projectile = null;
         var _loc5_:Vector.<Vector2> = SpikeSpread.pointsInRange[param1];
         if(_loc5_ == null)
         {
            _loc5_ = param1.level.getTrackPointsInRadius(new Vector2(param1.x,param1.y),param1.def.rangeOfVisibility);
            SpikeSpread.pointsInRange[param1] = _loc5_;
         }
         var _loc6_:Vector.<Vector2> = SpikeSpread.fullTrackPoints[param1];
         if(this.fullTrack && _loc6_ == null)
         {
            _loc6_ = param1.level.getTrackPointsInRadius(new Vector2(param1.x,param1.y),9999);
            fullTrackPoints[param1] = _loc6_;
         }
         _loc7_ = Pool.get(Projectile);
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc8_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc8_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc8_;
         }
         _loc7_.initialise(projectile,param1.level,param1.buffs,this,param1,_loc8_,this.extraPiercePrecision);
         _loc7_.effectMask = Bloon.IMMUNITY_ALL;
         _loc7_.owner = param1;
         _loc7_.x = param2.x;
         _loc7_.y = param2.y;
         this.extraPiercePrecision = _loc7_.pierceRemainder;
         _loc7_.velocity.x = power * Rndm.random() * 0.8 + power * 0.2;
         _loc7_.velocity.rotateBy(Rndm.random() * Math.PI * 2);
         spikeTo[_loc7_] = {
            "from":Pool.get(Vector2) as Vector2,
            "to":Pool.get(Vector2) as Vector2,
            "time":0,
            "delay":(!!this.fullTrack?Rndm.random() * 1:0)
         };
         spikeTo[_loc7_].from.x = _loc7_.x;
         spikeTo[_loc7_].from.y = _loc7_.y;
         var _loc9_:Vector2 = null;
         if(!this.fullTrack)
         {
            _loc7_.lifespan = 70;
            if(_loc5_.length == 0)
            {
               _loc9_ = new Vector2();
               _loc9_.x = 35 + Rndm.random() * (param1.def.rangeOfVisibility - 35) + param1.x;
               _loc9_.y = param1.y;
            }
            else
            {
               _loc9_ = _loc5_[int(_loc5_.length * Rndm.random())];
            }
         }
         else
         {
            _loc7_.lifespan = 5 + Rndm.random() * 3;
            _loc9_ = _loc6_[int(_loc6_.length * Rndm.random())];
         }
         spikeTo[_loc7_].to.x = _loc9_.x;
         spikeTo[_loc7_].to.y = _loc9_.y;
         var _loc10_:int = 0;
         var _loc11_:int = _loc7_.clip.frameCount - 1;
         if(_loc7_.pierce > _loc11_)
         {
            _loc10_ = 0;
         }
         else
         {
            _loc10_ = _loc11_ - _loc7_.pierce;
         }
         _loc7_.clip.gotoAndStop(_loc10_);
         param1.level.addProjectile(_loc7_);
      }
   }
}
