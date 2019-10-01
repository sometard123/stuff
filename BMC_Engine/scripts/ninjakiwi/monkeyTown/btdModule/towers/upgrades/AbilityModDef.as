package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class AbilityModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var cooldown_:Number = 0;
      
      private var cooldownAsScale_:Boolean = false;
      
      public function AbilityModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("cooldown","cooldownAsScale");
         }
         return displayOrder;
      }
      
      public function set cooldown(param1:Number) : void
      {
         if(this.cooldown_ != param1)
         {
            this.cooldown_ = param1;
            dispatchEvent(new PropertyModEvent("cooldown"));
         }
      }
      
      public function get cooldown() : Number
      {
         return this.cooldown_;
      }
      
      public function Cooldown(param1:Number) : AbilityModDef
      {
         this.cooldown = param1;
         return this;
      }
      
      public function set cooldownAsScale(param1:Boolean) : void
      {
         if(this.cooldownAsScale_ != param1)
         {
            this.cooldownAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("cooldownAsScale"));
         }
      }
      
      public function get cooldownAsScale() : Boolean
      {
         return this.cooldownAsScale_;
      }
      
      public function CooldownAsScale(param1:Boolean) : AbilityModDef
      {
         this.cooldownAsScale = param1;
         return this;
      }
   }
}
