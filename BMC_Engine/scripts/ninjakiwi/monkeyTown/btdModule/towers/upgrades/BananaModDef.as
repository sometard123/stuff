package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class BananaModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var cashPerRound_:int = 0;
      
      private var cashPerPacket_:int = 0;
      
      private var lifespan_:Number = 0;
      
      private var cashScale_:Number = 0;
      
      public function BananaModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("cashPerRound","cashPerPacket","lifespan","cashScale");
         }
         return displayOrder;
      }
      
      public function set cashPerRound(param1:int) : void
      {
         if(this.cashPerRound_ != param1)
         {
            this.cashPerRound_ = param1;
            dispatchEvent(new PropertyModEvent("cashPerRound"));
         }
      }
      
      public function get cashPerRound() : int
      {
         return this.cashPerRound_;
      }
      
      public function CashPerRound(param1:int) : BananaModDef
      {
         this.cashPerRound = param1;
         return this;
      }
      
      public function set cashPerPacket(param1:int) : void
      {
         if(this.cashPerPacket_ != param1)
         {
            this.cashPerPacket_ = param1;
            dispatchEvent(new PropertyModEvent("cashPerPacket"));
         }
      }
      
      public function get cashPerPacket() : int
      {
         return this.cashPerPacket_;
      }
      
      public function CashPerPacket(param1:int) : BananaModDef
      {
         this.cashPerPacket = param1;
         return this;
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
      
      public function Lifespan(param1:Number) : BananaModDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set cashScale(param1:Number) : void
      {
         if(this.cashScale_ != param1)
         {
            this.cashScale_ = param1;
            dispatchEvent(new PropertyModEvent("cashScale"));
         }
      }
      
      public function get cashScale() : Number
      {
         return this.cashScale_;
      }
      
      public function CashScale(param1:Number) : BananaModDef
      {
         this.cashScale = param1;
         return this;
      }
   }
}
