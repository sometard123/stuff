package ninjakiwi.monkeyTown.btdModule.weapons
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class FireAtReticle extends Standard implements HasSpread
   {
      
      public static var locations:Dictionary = new Dictionary();
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var spread_:Number = 0;
      
      public function FireAtReticle(param1:String = null)
      {
         super(param1);
      }
      
      public static function ResetLocations() : void
      {
         locations = new Dictionary();
      }
      
      public static function GetLocation(param1:Tower) : Vector2
      {
         if(param1 == null)
         {
            return new Vector2(-2000,-2000);
         }
         if(locations[param1.id] == null)
         {
            locations[param1.id] = new Vector2();
            locations[param1.id].x = param1.x;
            locations[param1.id].y = param1.y;
         }
         return locations[param1.id];
      }
      
      public static function SetLocation(param1:Tower, param2:Number, param3:Number) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(locations[param1.id] == null)
         {
            locations[param1.id] = new Vector2();
         }
         locations[param1.id].x = param2;
         locations[param1.id].y = param3;
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
      
      public function Spread(param1:Number) : FireAtReticle
      {
         this.spread = param1;
         return this;
      }
      
      public function Range(param1:Number) : FireAtReticle
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : FireAtReticle
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : FireAtReticle
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : FireAtReticle
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : FireAtReticle
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : FireAtReticle
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Vector2 = null;
         var _loc6_:Projectile = null;
         var _loc7_:Vector2 = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         _loc5_ = GetLocation(param1);
         _loc6_ = Pool.get(Projectile);
         _loc6_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
         _loc6_.owner = param1;
         _loc6_.x = param2.x;
         _loc6_.y = param2.y;
         this.extraPiercePrecision = _loc6_.pierceRemainder;
         _loc7_ = new Vector2();
         _loc7_.x = Rndm.random() * this.spread;
         _loc7_.y = 0;
         _loc7_.rotation = Rndm.random() * Math.PI * 2;
         _loc6_.velocity.x = (_loc5_.x - _loc6_.x) * 0.95;
         _loc6_.velocity.y = (_loc5_.y - _loc6_.y) * 0.95;
         var _loc8_:Number = _loc6_.velocity.magnitude / power;
         if(_loc8_ == 0)
         {
            _loc8_ = 0.025;
         }
         _loc6_.velocity.x = _loc6_.velocity.x + _loc7_.x;
         _loc6_.velocity.y = _loc6_.velocity.y + _loc7_.y;
         _loc6_.lifespan = _loc8_;
         _loc6_.velocity.magnitude = power;
         _loc6_.rotation = _loc6_.velocity.rotation;
         param1.level.addProjectile(_loc6_);
      }
   }
}
