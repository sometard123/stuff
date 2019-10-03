package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   
   public class Standard extends Weapon implements HasReloadTime, HasRange, HasPower, HasProjectile
   {
       
      
      private var range_:Number = 0;
      
      private var reloadTime_:Number = 0;
      
      private var power_:Number = 0;
      
      private var projectile_:ProjectileDef = null;
      
      private var offset_:Vector2 = null;
      
      private var extraDamagePrecision_:Number = 0;
      
      public function Standard(param1:String = null)
      {
         super(param1);
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
      
      public function set power(param1:Number) : void
      {
         if(this.power_ != param1)
         {
            this.power_ = param1;
            dispatchEvent(new PropertyModEvent("power"));
         }
      }
      
      public function get power() : Number
      {
         return this.power_;
      }
      
      public function set projectile(param1:ProjectileDef) : void
      {
         if(this.projectile_ != param1)
         {
            this.projectile_ = param1;
            dispatchEvent(new PropertyModEvent("projectile"));
         }
      }
      
      public function get projectile() : ProjectileDef
      {
         return this.projectile_;
      }
      
      public function get extraDamagePrecision() : Number
      {
         return this.extraDamagePrecision_;
      }
      
      public function set extraDamagePrecision(param1:Number) : void
      {
         if(this.extraDamagePrecision_ != param1)
         {
            this.extraDamagePrecision_ = param1;
            dispatchEvent(new PropertyModEvent("extraDamagePrecision"));
         }
      }
   }
}
