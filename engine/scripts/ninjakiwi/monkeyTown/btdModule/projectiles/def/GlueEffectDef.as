package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class GlueEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var speedScale_:Number = 1;
      
      private var corosionInterval_:Number = 0;
      
      private var soak_:Boolean = false;
      
      public function GlueEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","speedScale","corosionInterval","soak");
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
      
      public function Lifespan(param1:Number) : GlueEffectDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set speedScale(param1:Number) : void
      {
         if(this.speedScale_ != param1)
         {
            this.speedScale_ = param1;
            dispatchEvent(new PropertyModEvent("speedScale"));
         }
      }
      
      public function get speedScale() : Number
      {
         return this.speedScale_;
      }
      
      public function SpeedScale(param1:Number) : GlueEffectDef
      {
         this.speedScale = param1;
         return this;
      }
      
      public function set corosionInterval(param1:Number) : void
      {
         if(this.corosionInterval_ != param1)
         {
            this.corosionInterval_ = param1;
            dispatchEvent(new PropertyModEvent("corosionInterval"));
         }
      }
      
      public function get corosionInterval() : Number
      {
         return this.corosionInterval_;
      }
      
      public function CorosionInterval(param1:Number) : GlueEffectDef
      {
         this.corosionInterval = param1;
         return this;
      }
      
      public function set soak(param1:Boolean) : void
      {
         if(this.soak_ != param1)
         {
            this.soak_ = param1;
            dispatchEvent(new PropertyModEvent("soak"));
         }
      }
      
      public function get soak() : Boolean
      {
         return this.soak_;
      }
      
      public function Soak(param1:Boolean) : GlueEffectDef
      {
         this.soak = param1;
         return this;
      }
   }
}
