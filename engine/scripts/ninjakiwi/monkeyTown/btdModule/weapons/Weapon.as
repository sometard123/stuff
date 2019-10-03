package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.data.Unique;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class Weapon extends Unique
   {
       
      
      private var proxied_:Boolean = false;
      
      private var requiresTarget_:Boolean = true;
      
      private var isBaseWeapon_:Boolean = false;
      
      public function Weapon(param1:String = null)
      {
         super(param1);
      }
      
      public function set proxied(param1:Boolean) : void
      {
         if(this.proxied_ != param1)
         {
            this.proxied_ = param1;
            dispatchEvent(new PropertyModEvent("proxied"));
         }
      }
      
      public function get proxied() : Boolean
      {
         return this.proxied_;
      }
      
      public function set requiresTarget(param1:Boolean) : void
      {
         if(this.requiresTarget_ != param1)
         {
            this.requiresTarget_ = param1;
            dispatchEvent(new PropertyModEvent("requiresTarget"));
         }
      }
      
      public function get requiresTarget() : Boolean
      {
         return this.requiresTarget_;
      }
      
      public function get isBaseWeapon() : Boolean
      {
         return this.isBaseWeapon_;
      }
      
      public function set isBaseWeapon(param1:Boolean) : void
      {
         this.isBaseWeapon_ = param1;
      }
      
      public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
      }
   }
}
