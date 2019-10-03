package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   
   public class ProjectileDef extends EventDispatcher
   {
      
      public static var display_baseof:Class = MovieClip;
      
      public static var layeredDisplay_baseof:Class = MovieClip;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var display_:Class = null;
      
      private var layeredDisplay_:Vector.<Class> = null;
      
      private var pierce_:Number = 0;
      
      private var radius_:Number = 0;
      
      private var canMultiEffect_:Boolean = false;
      
      private var effectMask_:Vector.<int>;
      
      private var damageEffect_:DamageEffectDef = null;
      
      private var iceEffect_:IceEffectDef = null;
      
      private var glueEffect_:GlueEffectDef = null;
      
      private var stunEffect_:StunEffectDef = null;
      
      private var windEffect_:WindEffectDef = null;
      
      private var burnEffect_:BurnEffectDef = null;
      
      private var behavior_:BehaviorDef = null;
      
      private var popCashScale_:Number = 1;
      
      private var removeCamo_:Boolean = false;
      
      private var removeRegen_:Boolean = false;
      
      private var numOfRegenBloonsPurged_:int = 0;
      
      private var additiveBlend_:Boolean = false;
      
      private var zOffset_:Number = 0;
      
      public function ProjectileDef()
      {
         this.effectMask_ = Vector.<int>([Bloon.IMMUNITY_NO_DETECTION]);
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("display","layeredDisplay","pierce","radius","canMultiEffect","effectMask","damageEffect","iceEffect","glueEffect","stunEffect","windEffect","burnEffect","behavior","popCashScale","removeCamo","removeRegen","numOfRegenBloonsPurged");
         }
         return displayOrder;
      }
      
      public function set display(param1:Class) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Class
      {
         return this.display_;
      }
      
      public function Display(param1:Class) : ProjectileDef
      {
         this.display = param1;
         return this;
      }
      
      public function set layeredDisplay(param1:Vector.<Class>) : void
      {
         if(this.layeredDisplay_ != param1)
         {
            this.layeredDisplay_ = param1;
            dispatchEvent(new PropertyModEvent("layeredDisplay"));
         }
      }
      
      public function get layeredDisplay() : Vector.<Class>
      {
         return this.layeredDisplay_;
      }
      
      public function LayeredDisplay(param1:Vector.<Class>) : ProjectileDef
      {
         this.layeredDisplay = param1;
         return this;
      }
      
      public function set pierce(param1:Number) : void
      {
         if(this.pierce_ != param1)
         {
            this.pierce_ = param1;
            dispatchEvent(new PropertyModEvent("pierce"));
         }
      }
      
      public function get pierce() : Number
      {
         return this.pierce_;
      }
      
      public function Pierce(param1:Number) : ProjectileDef
      {
         this.pierce = param1;
         return this;
      }
      
      public function set radius(param1:Number) : void
      {
         if(this.radius_ != param1)
         {
            this.radius_ = param1;
            dispatchEvent(new PropertyModEvent("radius"));
         }
      }
      
      public function get radius() : Number
      {
         return this.radius_;
      }
      
      public function Radius(param1:Number) : ProjectileDef
      {
         this.radius = param1;
         return this;
      }
      
      public function set canMultiEffect(param1:Boolean) : void
      {
         if(this.canMultiEffect_ != param1)
         {
            this.canMultiEffect_ = param1;
            dispatchEvent(new PropertyModEvent("canMultiEffect"));
         }
      }
      
      public function get canMultiEffect() : Boolean
      {
         return this.canMultiEffect_;
      }
      
      public function CanMultiEffect(param1:Boolean) : ProjectileDef
      {
         this.canMultiEffect = param1;
         return this;
      }
      
      public function set effectMask(param1:Vector.<int>) : void
      {
         if(this.effectMask_ != param1)
         {
            this.effectMask_ = param1;
            dispatchEvent(new PropertyModEvent("effectMask"));
         }
      }
      
      public function get effectMask() : Vector.<int>
      {
         return this.effectMask_;
      }
      
      public function EffectMask(param1:Vector.<int>) : ProjectileDef
      {
         this.effectMask = param1;
         return this;
      }
      
      public function set damageEffect(param1:DamageEffectDef) : void
      {
         if(this.damageEffect_ != param1)
         {
            this.damageEffect_ = param1;
            dispatchEvent(new PropertyModEvent("damageEffect"));
         }
      }
      
      public function get damageEffect() : DamageEffectDef
      {
         return this.damageEffect_;
      }
      
      public function DamageEffect(param1:DamageEffectDef) : ProjectileDef
      {
         this.damageEffect = param1;
         return this;
      }
      
      public function set iceEffect(param1:IceEffectDef) : void
      {
         if(this.iceEffect_ != param1)
         {
            this.iceEffect_ = param1;
            dispatchEvent(new PropertyModEvent("iceEffect"));
         }
      }
      
      public function get iceEffect() : IceEffectDef
      {
         return this.iceEffect_;
      }
      
      public function IceEffect(param1:IceEffectDef) : ProjectileDef
      {
         this.iceEffect = param1;
         return this;
      }
      
      public function set glueEffect(param1:GlueEffectDef) : void
      {
         if(this.glueEffect_ != param1)
         {
            this.glueEffect_ = param1;
            dispatchEvent(new PropertyModEvent("glueEffect"));
         }
      }
      
      public function get glueEffect() : GlueEffectDef
      {
         return this.glueEffect_;
      }
      
      public function GlueEffect(param1:GlueEffectDef) : ProjectileDef
      {
         this.glueEffect = param1;
         return this;
      }
      
      public function set stunEffect(param1:StunEffectDef) : void
      {
         if(this.stunEffect_ != param1)
         {
            this.stunEffect_ = param1;
            dispatchEvent(new PropertyModEvent("stunEffect"));
         }
      }
      
      public function get stunEffect() : StunEffectDef
      {
         return this.stunEffect_;
      }
      
      public function StunEffect(param1:StunEffectDef) : ProjectileDef
      {
         this.stunEffect = param1;
         return this;
      }
      
      public function set windEffect(param1:WindEffectDef) : void
      {
         if(this.windEffect_ != param1)
         {
            this.windEffect_ = param1;
            dispatchEvent(new PropertyModEvent("windEffect"));
         }
      }
      
      public function get windEffect() : WindEffectDef
      {
         return this.windEffect_;
      }
      
      public function WindEffect(param1:WindEffectDef) : ProjectileDef
      {
         this.windEffect = param1;
         return this;
      }
      
      public function set burnEffect(param1:BurnEffectDef) : void
      {
         if(this.burnEffect_ != param1)
         {
            this.burnEffect_ = param1;
            dispatchEvent(new PropertyModEvent("burnEffect"));
         }
      }
      
      public function get burnEffect() : BurnEffectDef
      {
         return this.burnEffect_;
      }
      
      public function BurnEffect(param1:BurnEffectDef) : ProjectileDef
      {
         this.burnEffect = param1;
         return this;
      }
      
      public function set behavior(param1:BehaviorDef) : void
      {
         if(this.behavior_ != param1)
         {
            this.behavior_ = param1;
            dispatchEvent(new PropertyModEvent("behavior"));
         }
      }
      
      public function get behavior() : BehaviorDef
      {
         return this.behavior_;
      }
      
      public function Behavior(param1:BehaviorDef) : ProjectileDef
      {
         this.behavior = param1;
         return this;
      }
      
      public function set popCashScale(param1:Number) : void
      {
         if(this.popCashScale_ != param1)
         {
            this.popCashScale_ = param1;
            dispatchEvent(new PropertyModEvent("popCashScale"));
         }
      }
      
      public function get popCashScale() : Number
      {
         return this.popCashScale_;
      }
      
      public function PopCashScale(param1:Number) : ProjectileDef
      {
         this.popCashScale = param1;
         return this;
      }
      
      public function set removeCamo(param1:Boolean) : void
      {
         if(this.removeCamo_ != param1)
         {
            this.removeCamo_ = param1;
            dispatchEvent(new PropertyModEvent("removeCamo"));
         }
      }
      
      public function get removeCamo() : Boolean
      {
         return this.removeCamo_;
      }
      
      public function RemoveCamo(param1:Boolean) : ProjectileDef
      {
         this.removeCamo = param1;
         return this;
      }
      
      public function set removeRegen(param1:Boolean) : void
      {
         if(this.removeRegen_ != param1)
         {
            this.removeRegen_ = param1;
            dispatchEvent(new PropertyModEvent("removeRegen"));
         }
      }
      
      public function get removeRegen() : Boolean
      {
         return this.removeRegen_;
      }
      
      public function RemoveRegen(param1:Boolean) : ProjectileDef
      {
         this.removeRegen = param1;
         return this;
      }
      
      public function set numOfRegenBloonsPurged(param1:int) : void
      {
         if(this.numOfRegenBloonsPurged_ != param1)
         {
            this.numOfRegenBloonsPurged_ = param1;
            dispatchEvent(new PropertyModEvent("numOfRegenBloonsPurged"));
         }
      }
      
      public function get numOfRegenBloonsPurged() : int
      {
         return this.numOfRegenBloonsPurged_;
      }
      
      public function NumOfRegenBloonsPurged(param1:int) : ProjectileDef
      {
         this.numOfRegenBloonsPurged = param1;
         return this;
      }
      
      public function set additiveBlend(param1:Boolean) : void
      {
         if(this.additiveBlend_ != param1)
         {
            this.additiveBlend_ = param1;
            dispatchEvent(new PropertyModEvent("additiveBlend"));
         }
      }
      
      public function get additiveBlend() : Boolean
      {
         return this.additiveBlend_;
      }
      
      public function AdditiveBlend(param1:Boolean) : ProjectileDef
      {
         this.additiveBlend = param1;
         return this;
      }
      
      public function set zOffset(param1:Number) : void
      {
         if(this.zOffset_ != param1)
         {
            this.zOffset_ = param1;
            dispatchEvent(new PropertyModEvent("zOffset"));
         }
      }
      
      public function get zOffset() : Number
      {
         return this.zOffset_;
      }
      
      public function ZOffset(param1:Number) : ProjectileDef
      {
         this.zOffset = param1;
         return this;
      }
   }
}
