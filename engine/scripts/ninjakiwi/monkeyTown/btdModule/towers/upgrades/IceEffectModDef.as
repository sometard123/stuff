package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class IceEffectModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var lifespanAsScale_:Boolean = false;
      
      private var permafrost_:Number = 0;
      
      private var freezeLayers_:int = 0;
      
      public function IceEffectModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","permafrost","freezeLayers");
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
      
      public function Lifespan(param1:Number) : IceEffectModDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set lifespanAsScale(param1:Boolean) : void
      {
         if(this.lifespanAsScale_ != param1)
         {
            this.lifespanAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("lifespanAsScale"));
         }
      }
      
      public function get lifespanAsScale() : Boolean
      {
         return this.lifespanAsScale_;
      }
      
      public function LifespanAsScale(param1:Boolean) : IceEffectModDef
      {
         this.lifespanAsScale = param1;
         return this;
      }
      
      public function set permafrost(param1:Number) : void
      {
         if(this.permafrost_ != param1)
         {
            this.permafrost_ = param1;
            dispatchEvent(new PropertyModEvent("permafrost"));
         }
      }
      
      public function get permafrost() : Number
      {
         return this.permafrost_;
      }
      
      public function Permafrost(param1:Number) : IceEffectModDef
      {
         this.permafrost = param1;
         return this;
      }
      
      public function set freezeLayers(param1:int) : void
      {
         if(this.freezeLayers_ != param1)
         {
            this.freezeLayers_ = param1;
            dispatchEvent(new PropertyModEvent("freezeLayers"));
         }
      }
      
      public function get freezeLayers() : int
      {
         return this.freezeLayers_;
      }
      
      public function FreezeLayers(param1:int) : IceEffectModDef
      {
         this.freezeLayers = param1;
         return this;
      }
   }
}
