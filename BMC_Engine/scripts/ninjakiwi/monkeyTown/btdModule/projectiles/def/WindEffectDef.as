package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class WindEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var speed_:Number = 300;
      
      private var chance_:Number = 1;
      
      public function WindEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("speed","chance");
         }
         return displayOrder;
      }
      
      public function set speed(param1:Number) : void
      {
         if(this.speed_ != param1)
         {
            this.speed_ = param1;
            dispatchEvent(new PropertyModEvent("speed"));
         }
      }
      
      public function get speed() : Number
      {
         return this.speed_;
      }
      
      public function Speed(param1:Number) : WindEffectDef
      {
         this.speed = param1;
         return this;
      }
      
      public function set chance(param1:Number) : void
      {
         if(this.chance_ != param1)
         {
            this.chance_ = param1;
            dispatchEvent(new PropertyModEvent("chance"));
         }
      }
      
      public function get chance() : Number
      {
         return this.chance_;
      }
      
      public function Chance(param1:Number) : WindEffectDef
      {
         this.chance = param1;
         return this;
      }
   }
}
