package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   
   public class StunEffectModDef extends EventDispatcher
   {
       
      
      private var lifespan_:Number = 0;
      
      private var lifespanAsScale_:Boolean = false;
      
      private var cantEffect_:Vector.<int> = null;
      
      public function StunEffectModDef()
      {
         super();
      }
      
      public function get lifespan() : Number
      {
         return this.lifespan_;
      }
      
      public function set lifespan(param1:Number) : void
      {
         this.lifespan_ = param1;
      }
      
      public function Lifespan(param1:Number) : StunEffectModDef
      {
         this.lifespan_ = param1;
         return this;
      }
      
      public function get lifespanAsScale() : Boolean
      {
         return this.lifespanAsScale_;
      }
      
      public function set lifespanAsScale(param1:Boolean) : void
      {
         this.lifespanAsScale_ = param1;
      }
      
      public function LifespanAsScale(param1:Boolean) : StunEffectModDef
      {
         this.lifespanAsScale_ = param1;
         return this;
      }
      
      public function get cantEffect() : Vector.<int>
      {
         return this.cantEffect_;
      }
      
      public function set cantEffect(param1:Vector.<int>) : void
      {
         this.cantEffect_ = param1;
      }
      
      public function CantEffect(param1:Vector.<int>) : StunEffectModDef
      {
         this.cantEffect_ = param1;
         return this;
      }
   }
}
