package ninjakiwi.monkeyTown.btdModule.projectiles.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class DamageEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var damage_:int = 0;
      
      private var cantBreak_:Vector.<int> = null;
      
      private var canBreakIce_:Boolean = true;
      
      private var moabScale_:Number = 1;
      
      private var bossScale_:Number = 1;
      
      private var hugeScale_:Number = 1;
      
      private var ceramicScale_:Number = 1;
      
      private var showPop_:Boolean = true;
      
      private var peelLayer_:Boolean = false;
      
      private var kill_:Boolean = false;
      
      private var ceramicAdd_:Number = 0;
      
      private var purgeRegenChance_:Number = 0;
      
      public function DamageEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("damage","cantBreak","canBreakIce","moabScale","bossScale","hugeScale","ceramicScale","showPop","peelLayer","kill","ceramicAdd","purgeRegenChance");
         }
         return displayOrder;
      }
      
      public function set damage(param1:int) : void
      {
         if(this.damage_ != param1)
         {
            this.damage_ = param1;
            dispatchEvent(new PropertyModEvent("damage"));
         }
      }
      
      public function get damage() : int
      {
         return this.damage_;
      }
      
      public function Damage(param1:int) : DamageEffectDef
      {
         this.damage = param1;
         return this;
      }
      
      public function set cantBreak(param1:Vector.<int>) : void
      {
         if(this.cantBreak_ != param1)
         {
            this.cantBreak_ = param1;
            dispatchEvent(new PropertyModEvent("cantBreak"));
         }
      }
      
      public function get cantBreak() : Vector.<int>
      {
         return this.cantBreak_;
      }
      
      public function CantBreak(param1:Vector.<int>) : DamageEffectDef
      {
         this.cantBreak = param1;
         return this;
      }
      
      public function set canBreakIce(param1:Boolean) : void
      {
         if(this.canBreakIce_ != param1)
         {
            this.canBreakIce_ = param1;
            dispatchEvent(new PropertyModEvent("canBreakIce"));
         }
      }
      
      public function get canBreakIce() : Boolean
      {
         return this.canBreakIce_;
      }
      
      public function CanBreakIce(param1:Boolean) : DamageEffectDef
      {
         this.canBreakIce = param1;
         return this;
      }
      
      public function set moabScale(param1:Number) : void
      {
         if(this.moabScale_ != param1)
         {
            this.moabScale_ = param1;
            dispatchEvent(new PropertyModEvent("moabScale"));
         }
      }
      
      public function get moabScale() : Number
      {
         return this.moabScale_;
      }
      
      public function set bossScale(param1:Number) : void
      {
         if(this.bossScale_ != param1)
         {
            this.bossScale_ = param1;
            dispatchEvent(new PropertyModEvent("bossScale"));
         }
      }
      
      public function get bossScale() : Number
      {
         return this.bossScale_;
      }
      
      public function set hugeScale(param1:Number) : void
      {
         if(this.hugeScale_ != param1)
         {
            this.hugeScale_ = param1;
            dispatchEvent(new PropertyModEvent("hugeScale"));
         }
      }
      
      public function get hugeScale() : Number
      {
         return this.hugeScale_;
      }
      
      public function MOABScale(param1:Number) : DamageEffectDef
      {
         this.moabScale = param1;
         return this;
      }
      
      public function BossScale(param1:Number) : DamageEffectDef
      {
         this.bossScale = param1;
         return this;
      }
      
      public function HugeScale(param1:Number) : DamageEffectDef
      {
         this.hugeScale = param1;
         return this;
      }
      
      public function set ceramicScale(param1:Number) : void
      {
         if(this.ceramicScale_ != param1)
         {
            this.ceramicScale_ = param1;
            dispatchEvent(new PropertyModEvent("ceramicScale"));
         }
      }
      
      public function get ceramicScale() : Number
      {
         return this.ceramicScale_;
      }
      
      public function CeramicScale(param1:Number) : DamageEffectDef
      {
         this.ceramicScale = param1;
         return this;
      }
      
      public function set showPop(param1:Boolean) : void
      {
         if(this.showPop_ != param1)
         {
            this.showPop_ = param1;
            dispatchEvent(new PropertyModEvent("showPop"));
         }
      }
      
      public function get showPop() : Boolean
      {
         return this.showPop_;
      }
      
      public function ShowPop(param1:Boolean) : DamageEffectDef
      {
         this.showPop = param1;
         return this;
      }
      
      public function set peelLayer(param1:Boolean) : void
      {
         if(this.peelLayer_ != param1)
         {
            this.peelLayer_ = param1;
            dispatchEvent(new PropertyModEvent("peelLayer"));
         }
      }
      
      public function get peelLayer() : Boolean
      {
         return this.peelLayer_;
      }
      
      public function PeelLayer(param1:Boolean) : DamageEffectDef
      {
         this.peelLayer = param1;
         return this;
      }
      
      public function set kill(param1:Boolean) : void
      {
         if(this.kill_ != param1)
         {
            this.kill_ = param1;
            dispatchEvent(new PropertyModEvent("kill"));
         }
      }
      
      public function get kill() : Boolean
      {
         return this.kill_;
      }
      
      public function Kill(param1:Boolean) : DamageEffectDef
      {
         this.kill = param1;
         return this;
      }
      
      public function set ceramicAdd(param1:Number) : void
      {
         if(this.ceramicAdd_ != param1)
         {
            this.ceramicAdd_ = param1;
            dispatchEvent(new PropertyModEvent("ceramicAdd"));
         }
      }
      
      public function get ceramicAdd() : Number
      {
         return this.ceramicAdd_;
      }
      
      public function CeramicAdd(param1:Number) : DamageEffectDef
      {
         this.ceramicAdd = param1;
         return this;
      }
      
      public function set purgeRegenChance(param1:Number) : void
      {
         if(this.purgeRegenChance_ != param1)
         {
            this.purgeRegenChance_ = param1;
            dispatchEvent(new PropertyModEvent("purgeRegenChance"));
         }
      }
      
      public function get purgeRegenChance() : Number
      {
         return this.purgeRegenChance_;
      }
      
      public function PurgeRegenChance(param1:Number) : DamageEffectDef
      {
         this.purgeRegenChance = param1;
         return this;
      }
   }
}
