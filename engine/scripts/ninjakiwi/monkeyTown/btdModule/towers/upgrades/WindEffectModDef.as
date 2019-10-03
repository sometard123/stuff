package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class WindEffectModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var chance_:Number = 0;
      
      public function WindEffectModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("chance");
         }
         return displayOrder;
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
      
      public function Chance(param1:Number) : WindEffectModDef
      {
         this.chance = param1;
         return this;
      }
   }
}
