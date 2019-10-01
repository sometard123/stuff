package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class StunEffectDef extends EventDispatcher
   {
      
      private static var stunCounter:Dictionary = new Dictionary();
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var lifespan_:Number = 0;
      
      private var cantEffect_:Vector.<int> = null;
      
      private var inherit_:Boolean = true;
      
      private var stunCount:uint = 0;
      
      public function StunEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("lifespan","cantEffect","inherit");
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
      
      public function Lifespan(param1:Number) : StunEffectDef
      {
         this.lifespan = param1;
         return this;
      }
      
      public function set cantEffect(param1:Vector.<int>) : void
      {
         if(this.cantEffect_ != param1)
         {
            this.cantEffect_ = param1;
            dispatchEvent(new PropertyModEvent("cantEffect"));
         }
      }
      
      public function get cantEffect() : Vector.<int>
      {
         return this.cantEffect_;
      }
      
      public function CantEffect(param1:Vector.<int>) : StunEffectDef
      {
         this.cantEffect = param1;
         return this;
      }
      
      public function set inherit(param1:Boolean) : void
      {
         if(this.inherit_ != param1)
         {
            this.inherit_ = param1;
            dispatchEvent(new PropertyModEvent("inherit"));
         }
      }
      
      public function get inherit() : Boolean
      {
         return this.inherit_;
      }
      
      public function Inherit(param1:Boolean) : StunEffectDef
      {
         this.inherit = param1;
         return this;
      }
      
      public function StunsOnEveryNthBloonHit(param1:uint) : StunEffectDef
      {
         this.stunCount = param1;
         return this;
      }
      
      public function isStunning(param1:Projectile) : Boolean
      {
         if(this.stunCount == 0)
         {
            return true;
         }
         stunCounter[param1]++;
         if(stunCounter[param1] >= this.stunCount)
         {
            stunCounter[param1] = 0;
            return true;
         }
         return false;
      }
   }
}
