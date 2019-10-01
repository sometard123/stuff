package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class DamageEffectModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var damage_:int = 0;
      
      private var removeFromCantBreak_:Vector.<int> = null;
      
      private var canBreakIce_:Boolean = false;
      
      public function DamageEffectModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("damage","removeFromCantBreak","canBreakIce");
         }
         return displayOrder;
      }
      
      public function set damage(param1:int) : void
      {
         if(this.damage_ != param1)
         {
            this.damage_ = param1;
            dispatchEvent(new PropertyModEvent("damage"));
         }
      }
      
      public function get damage() : int
      {
         return this.damage_;
      }
      
      public function Damage(param1:int) : DamageEffectModDef
      {
         this.damage = param1;
         return this;
      }
      
      public function set removeFromCantBreak(param1:Vector.<int>) : void
      {
         if(this.removeFromCantBreak_ != param1)
         {
            this.removeFromCantBreak_ = param1;
            dispatchEvent(new PropertyModEvent("removeFromCantBreak"));
         }
      }
      
      public function get removeFromCantBreak() : Vector.<int>
      {
         return this.removeFromCantBreak_;
      }
      
      public function RemoveFromCantBreak(param1:Vector.<int>) : DamageEffectModDef
      {
         this.removeFromCantBreak = param1;
         return this;
      }
      
      public function set canBreakIce(param1:Boolean) : void
      {
         if(this.canBreakIce_ != param1)
         {
            this.canBreakIce_ = param1;
            dispatchEvent(new PropertyModEvent("canBreakIce"));
         }
      }
      
      public function get canBreakIce() : Boolean
      {
         return this.canBreakIce_;
      }
      
      public function CanBreakIce(param1:Boolean) : DamageEffectModDef
      {
         this.canBreakIce = param1;
         return this;
      }
   }
}
