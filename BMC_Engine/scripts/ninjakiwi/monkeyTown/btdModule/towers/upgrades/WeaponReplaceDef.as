package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class WeaponReplaceDef extends EventDispatcher
   {
       
      
      private var replaceWeaponID_:String = null;
      
      private var withWeapon_:Weapon = null;
      
      public function WeaponReplaceDef()
      {
         super();
      }
      
      public function get replaceWeaponID() : String
      {
         return this.replaceWeaponID_;
      }
      
      public function set replaceWeaponID(param1:String) : void
      {
         this.replaceWeaponID_ = param1;
      }
      
      public function ReplaceWeaponID(param1:String) : WeaponReplaceDef
      {
         this.replaceWeaponID_ = param1;
         return this;
      }
      
      public function get withWeapon() : Weapon
      {
         return this.withWeapon_;
      }
      
      public function set withWeapon(param1:Weapon) : void
      {
         this.withWeapon_ = param1;
      }
      
      public function WithWeapon(param1:Weapon) : WeaponReplaceDef
      {
         this.withWeapon_ = param1;
         return this;
      }
   }
}
