package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class ProjectileModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var pierce_:int = 0;
      
      private var pierceAsScale_:Boolean = false;
      
      private var radius_:Number = 0;
      
      private var display_:Vector.<ProjectileDisplayMod> = null;
      
      private var damageEffectMod_:DamageEffectModDef = null;
      
      private var iceEffectMod_:IceEffectModDef = null;
      
      private var glueEffectMod_:GlueEffectModDef = null;
      
      private var stunEffectMod_:StunEffectModDef = null;
      
      private var burnEffectMod_:BurnEffectModDef = null;
      
      private var windeffectMod_:WindEffectModDef = null;
      
      private var behaviorMod_:ProjectileBehaviorModDef = null;
      
      private var removeFromEffectMask_:Vector.<int> = null;
      
      private var popCashScale_:Number = 0;
      
      public function ProjectileModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("pierce","pierceAsScale","radius","display","damageEffectMod","iceEffectMod","glueEffectMod","burnEffectMod","windeffectMod","behaviorMod","removeFromEffectMask","popCashScale");
         }
         return displayOrder;
      }
      
      public function set pierce(param1:int) : void
      {
         if(this.pierce_ != param1)
         {
            this.pierce_ = param1;
            dispatchEvent(new PropertyModEvent("pierce"));
         }
      }
      
      public function get pierce() : int
      {
         return this.pierce_;
      }
      
      public function Pierce(param1:int) : ProjectileModDef
      {
         this.pierce = param1;
         return this;
      }
      
      public function set pierceAsScale(param1:Boolean) : void
      {
         if(this.pierceAsScale_ != param1)
         {
            this.pierceAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("pierceAsScale"));
         }
      }
      
      public function get pierceAsScale() : Boolean
      {
         return this.pierceAsScale_;
      }
      
      public function PierceAsScale(param1:Boolean) : ProjectileModDef
      {
         this.pierceAsScale = param1;
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
      
      public function Radius(param1:Number) : ProjectileModDef
      {
         this.radius = param1;
         return this;
      }
      
      public function set display(param1:Vector.<ProjectileDisplayMod>) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Vector.<ProjectileDisplayMod>
      {
         return this.display_;
      }
      
      public function Display(param1:Vector.<ProjectileDisplayMod>) : ProjectileModDef
      {
         this.display = param1;
         return this;
      }
      
      public function set damageEffectMod(param1:DamageEffectModDef) : void
      {
         if(this.damageEffectMod_ != param1)
         {
            this.damageEffectMod_ = param1;
            dispatchEvent(new PropertyModEvent("damageEffectMod"));
         }
      }
      
      public function get damageEffectMod() : DamageEffectModDef
      {
         return this.damageEffectMod_;
      }
      
      public function DamageEffectMod(param1:DamageEffectModDef) : ProjectileModDef
      {
         this.damageEffectMod = param1;
         return this;
      }
      
      public function set iceEffectMod(param1:IceEffectModDef) : void
      {
         if(this.iceEffectMod_ != param1)
         {
            this.iceEffectMod_ = param1;
            dispatchEvent(new PropertyModEvent("iceEffectMod"));
         }
      }
      
      public function get iceEffectMod() : IceEffectModDef
      {
         return this.iceEffectMod_;
      }
      
      public function IceEffectMod(param1:IceEffectModDef) : ProjectileModDef
      {
         this.iceEffectMod = param1;
         return this;
      }
      
      public function set glueEffectMod(param1:GlueEffectModDef) : void
      {
         if(this.glueEffectMod_ != param1)
         {
            this.glueEffectMod_ = param1;
            dispatchEvent(new PropertyModEvent("glueEffectMod"));
         }
      }
      
      public function get glueEffectMod() : GlueEffectModDef
      {
         return this.glueEffectMod_;
      }
      
      public function GlueEffectMod(param1:GlueEffectModDef) : ProjectileModDef
      {
         this.glueEffectMod = param1;
         return this;
      }
      
      public function set burnEffectMod(param1:BurnEffectModDef) : void
      {
         if(this.burnEffectMod_ != param1)
         {
            this.burnEffectMod_ = param1;
            dispatchEvent(new PropertyModEvent("burnEffectMod"));
         }
      }
      
      public function get burnEffectMod() : BurnEffectModDef
      {
         return this.burnEffectMod_;
      }
      
      public function BurnEffectMod(param1:BurnEffectModDef) : ProjectileModDef
      {
         this.burnEffectMod = param1;
         return this;
      }
      
      public function set windeffectMod(param1:WindEffectModDef) : void
      {
         if(this.windeffectMod_ != param1)
         {
            this.windeffectMod_ = param1;
            dispatchEvent(new PropertyModEvent("windeffectMod"));
         }
      }
      
      public function get windeffectMod() : WindEffectModDef
      {
         return this.windeffectMod_;
      }
      
      public function WindeffectMod(param1:WindEffectModDef) : ProjectileModDef
      {
         this.windeffectMod = param1;
         return this;
      }
      
      public function set behaviorMod(param1:ProjectileBehaviorModDef) : void
      {
         if(this.behaviorMod_ != param1)
         {
            this.behaviorMod_ = param1;
            dispatchEvent(new PropertyModEvent("behaviorMod"));
         }
      }
      
      public function get behaviorMod() : ProjectileBehaviorModDef
      {
         return this.behaviorMod_;
      }
      
      public function BehaviorMod(param1:ProjectileBehaviorModDef) : ProjectileModDef
      {
         this.behaviorMod = param1;
         return this;
      }
      
      public function set removeFromEffectMask(param1:Vector.<int>) : void
      {
         if(this.removeFromEffectMask_ != param1)
         {
            this.removeFromEffectMask_ = param1;
            dispatchEvent(new PropertyModEvent("removeFromEffectMask"));
         }
      }
      
      public function get removeFromEffectMask() : Vector.<int>
      {
         return this.removeFromEffectMask_;
      }
      
      public function RemoveFromEffectMask(param1:Vector.<int>) : ProjectileModDef
      {
         this.removeFromEffectMask = param1;
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
      
      public function PopCashScale(param1:Number) : ProjectileModDef
      {
         this.popCashScale = param1;
         return this;
      }
      
      public function get stunEffectMod() : StunEffectModDef
      {
         return this.stunEffectMod_;
      }
      
      public function set stunEffectMod(param1:StunEffectModDef) : void
      {
         this.stunEffectMod_ = param1;
      }
      
      public function StunEffectMod(param1:StunEffectModDef) : ProjectileModDef
      {
         this.stunEffectMod_ = param1;
         return this;
      }
   }
}
