package ninjakiwi.monkeyTown.btdModule.math
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class CubicBezierDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var a_:Vector2;
      
      private var b_:Vector2;
      
      private var c_:Vector2;
      
      private var d_:Vector2;
      
      public function CubicBezierDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("a","b","c","d");
         }
         return displayOrder;
      }
      
      public function set a(param1:Vector2) : void
      {
         if(this.a_ != param1)
         {
            this.a_ = param1;
            dispatchEvent(new PropertyModEvent("a"));
         }
      }
      
      public function get a() : Vector2
      {
         return this.a_;
      }
      
      public function A(param1:Vector2) : CubicBezierDef
      {
         this.a = param1;
         return this;
      }
      
      public function set b(param1:Vector2) : void
      {
         if(this.b_ != param1)
         {
            this.b_ = param1;
            dispatchEvent(new PropertyModEvent("b"));
         }
      }
      
      public function get b() : Vector2
      {
         return this.b_;
      }
      
      public function B(param1:Vector2) : CubicBezierDef
      {
         this.b = param1;
         return this;
      }
      
      public function set c(param1:Vector2) : void
      {
         if(this.c_ != param1)
         {
            this.c_ = param1;
            dispatchEvent(new PropertyModEvent("c"));
         }
      }
      
      public function get c() : Vector2
      {
         return this.c_;
      }
      
      public function C(param1:Vector2) : CubicBezierDef
      {
         this.c = param1;
         return this;
      }
      
      public function set d(param1:Vector2) : void
      {
         if(this.d_ != param1)
         {
            this.d_ = param1;
            dispatchEvent(new PropertyModEvent("d"));
         }
      }
      
      public function get d() : Vector2
      {
         return this.d_;
      }
      
      public function D(param1:Vector2) : CubicBezierDef
      {
         this.d = param1;
         return this;
      }
   }
}
