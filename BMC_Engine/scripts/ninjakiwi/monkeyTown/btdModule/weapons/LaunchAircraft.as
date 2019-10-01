package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.entities.AircraftCarrierAircraft;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class LaunchAircraft extends Standard
   {
       
      
      private var aircraftWeapon_:Vector.<Weapon> = null;
      
      public function LaunchAircraft()
      {
         super();
      }
      
      public function set aircraftWeapon(param1:Vector.<Weapon>) : void
      {
         if(this.aircraftWeapon_ != param1)
         {
            this.aircraftWeapon_ = param1;
            dispatchEvent(new PropertyModEvent("aircraftWeapon"));
         }
      }
      
      public function get aircraftWeapon() : Vector.<Weapon>
      {
         return this.aircraftWeapon_;
      }
      
      public function AircraftWeapon(param1:Vector.<Weapon>) : LaunchAircraft
      {
         this.aircraftWeapon = param1;
         return this;
      }
      
      public function Range(param1:Number) : LaunchAircraft
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : LaunchAircraft
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : LaunchAircraft
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : LaunchAircraft
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : LaunchAircraft
      {
         proxied = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:AircraftCarrierAircraft = new AircraftCarrierAircraft();
         _loc5_.initialise(param1,param3,this.aircraftWeapon);
         param1.level.addEntity(_loc5_);
      }
   }
}
