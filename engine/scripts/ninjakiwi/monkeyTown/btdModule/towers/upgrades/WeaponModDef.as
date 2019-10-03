package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class WeaponModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var range_:Number = 0;
      
      private var rangeAsScale_:Boolean = false;
      
      private var reloadTime_:Number = 0;
      
      private var reloadTimeAsScale_:Boolean = false;
      
      private var power_:Number = 0;
      
      private var projectileMod_:ProjectileModDef = null;
      
      private var addChild_:Weapon = null;
      
      private var removeChild_:Weapon = null;
      
      private var spread_:Number = 0;
      
      private var count_:int = 0;
      
      private var specific_:String = null;
      
      public function WeaponModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("range","rangeAsScale","reloadTime","reloadTimeAsScale","power","projectileMod","addChild","removeChild","spread","count");
         }
         return displayOrder;
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
      
      public function Range(param1:Number) : WeaponModDef
      {
         this.range = param1;
         return this;
      }
      
      public function set rangeAsScale(param1:Boolean) : void
      {
         if(this.rangeAsScale_ != param1)
         {
            this.rangeAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("rangeAsScale"));
         }
      }
      
      public function get rangeAsScale() : Boolean
      {
         return this.rangeAsScale_;
      }
      
      public function RangeAsScale(param1:Boolean) : WeaponModDef
      {
         this.rangeAsScale = param1;
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
      
      public function ReloadTime(param1:Number) : WeaponModDef
      {
         this.reloadTime = param1;
         return this;
      }
      
      public function set reloadTimeAsScale(param1:Boolean) : void
      {
         if(this.reloadTimeAsScale_ != param1)
         {
            this.reloadTimeAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("reloadTimeAsScale"));
         }
      }
      
      public function get reloadTimeAsScale() : Boolean
      {
         return this.reloadTimeAsScale_;
      }
      
      public function ReloadTimeAsScale(param1:Boolean) : WeaponModDef
      {
         this.reloadTimeAsScale = param1;
         return this;
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
      
      public function Power(param1:Number) : WeaponModDef
      {
         this.power = param1;
         return this;
      }
      
      public function set projectileMod(param1:ProjectileModDef) : void
      {
         if(this.projectileMod_ != param1)
         {
            this.projectileMod_ = param1;
            dispatchEvent(new PropertyModEvent("projectileMod"));
         }
      }
      
      public function get projectileMod() : ProjectileModDef
      {
         return this.projectileMod_;
      }
      
      public function ProjectileMod(param1:ProjectileModDef) : WeaponModDef
      {
         this.projectileMod = param1;
         return this;
      }
      
      public function set addChild(param1:Weapon) : void
      {
         if(this.addChild_ != param1)
         {
            this.addChild_ = param1;
            dispatchEvent(new PropertyModEvent("addChild"));
         }
      }
      
      public function get addChild() : Weapon
      {
         return this.addChild_;
      }
      
      public function AddChild(param1:Weapon) : WeaponModDef
      {
         this.addChild = param1;
         return this;
      }
      
      public function set removeChild(param1:Weapon) : void
      {
         if(this.removeChild_ != param1)
         {
            this.removeChild_ = param1;
            dispatchEvent(new PropertyModEvent("removeChild"));
         }
      }
      
      public function get removeChild() : Weapon
      {
         return this.removeChild_;
      }
      
      public function RemoveChild(param1:Weapon) : WeaponModDef
      {
         this.removeChild = param1;
         return this;
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
      
      public function Spread(param1:Number) : WeaponModDef
      {
         this.spread = param1;
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
      
      public function Count(param1:int) : WeaponModDef
      {
         this.count = param1;
         return this;
      }
      
      public function set specific(param1:String) : void
      {
         if(this.specific_ != param1)
         {
            this.specific_ = param1;
            dispatchEvent(new PropertyModEvent("specific"));
         }
      }
      
      public function get specific() : String
      {
         return this.specific_;
      }
      
      public function Specific(param1:String) : WeaponModDef
      {
         this.specific = param1;
         return this;
      }
   }
}
