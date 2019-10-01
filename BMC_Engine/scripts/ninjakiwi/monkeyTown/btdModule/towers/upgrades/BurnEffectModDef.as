package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class BurnEffectModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var burnInterval_:Number = 0;
      
      public function BurnEffectModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","burnInterval");
         }
         return displayOrder;
      }
      
      public function set lifespan(param1:Number) : void
      {
         if(this.lifespan_ != param1)
         {
            this.lifespan_ = param1;
            dispatchEvent(new PropertyModEvent("lifespan"));
         }
      }
      
      public function get lifespan() : Number
      {
         return this.lifespan_;
      }
      
      public function Lifespan(param1:Number) : BurnEffectModDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set burnInterval(param1:Number) : void
      {
         if(this.burnInterval_ != param1)
         {
            this.burnInterval_ = param1;
            dispatchEvent(new PropertyModEvent("burnInterval"));
         }
      }
      
      public function get burnInterval() : Number
      {
         return this.burnInterval_;
      }
      
      public function BurnInterval(param1:Number) : BurnEffectModDef
      {
         this.burnInterval = param1;
         return this;
      }
   }
}
