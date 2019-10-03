package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class BurnEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var burnInterval_:Number = 0;
      
      private var cantBurn_:Vector.<int>;
      
      public function BurnEffectDef()
      {
         this.cantBurn_ = Vector.<int>([]);
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","burnInterval","cantBurn");
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
      
      public function Lifespan(param1:Number) : BurnEffectDef
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
      
      public function BurnInterval(param1:Number) : BurnEffectDef
      {
         this.burnInterval = param1;
         return this;
      }
      
      public function set cantBurn(param1:Vector.<int>) : void
      {
         if(this.cantBurn_ != param1)
         {
            this.cantBurn_ = param1;
            dispatchEvent(new PropertyModEvent("cantBurn"));
         }
      }
      
      public function get cantBurn() : Vector.<int>
      {
         return this.cantBurn_;
      }
      
      public function CantBurn(param1:Vector.<int>) : BurnEffectDef
      {
         this.cantBurn = param1;
         return this;
      }
   }
}
