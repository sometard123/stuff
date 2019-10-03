package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class IceEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var shards_:Boolean = false;
      
      private var viral_:Boolean = false;
      
      private var permafrost_:Number = 1;
      
      private var freezeLayers_:int = 1;
      
      private var arcticWind_:Number = 1;
      
      public function IceEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","shards","viral","permafrost","freezeLayers","arcticWind");
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
      
      public function Lifespan(param1:Number) : IceEffectDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set shards(param1:Boolean) : void
      {
         if(this.shards_ != param1)
         {
            this.shards_ = param1;
            dispatchEvent(new PropertyModEvent("shards"));
         }
      }
      
      public function get shards() : Boolean
      {
         return this.shards_;
      }
      
      public function Shards(param1:Boolean) : IceEffectDef
      {
         this.shards = param1;
         return this;
      }
      
      public function set viral(param1:Boolean) : void
      {
         if(this.viral_ != param1)
         {
            this.viral_ = param1;
            dispatchEvent(new PropertyModEvent("viral"));
         }
      }
      
      public function get viral() : Boolean
      {
         return this.viral_;
      }
      
      public function Viral(param1:Boolean) : IceEffectDef
      {
         this.viral = param1;
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
      
      public function Permafrost(param1:Number) : IceEffectDef
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
      
      public function FreezeLayers(param1:int) : IceEffectDef
      {
         this.freezeLayers = param1;
         return this;
      }
      
      public function set arcticWind(param1:Number) : void
      {
         if(this.arcticWind_ != param1)
         {
            this.arcticWind_ = param1;
            dispatchEvent(new PropertyModEvent("arcticWind"));
         }
      }
      
      public function get arcticWind() : Number
      {
         return this.arcticWind_;
      }
      
      public function ArcticWind(param1:Number) : IceEffectDef
      {
         this.arcticWind = param1;
         return this;
      }
   }
}
