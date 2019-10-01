package ninjakiwi.monkeyTown.btdModule.towers.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class AreaEffectDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var upgrade_:UpgradeDef;
      
      private var costScale_:Number = 1;
      
      private var popCashScale_:Number = 1;
      
      public function AreaEffectDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("upgrade","costScale","popCashScale");
         }
         return displayOrder;
      }
      
      public function set upgrade(param1:UpgradeDef) : void
      {
         if(this.upgrade_ != param1)
         {
            this.upgrade_ = param1;
            dispatchEvent(new PropertyModEvent("upgrade"));
         }
      }
      
      public function get upgrade() : UpgradeDef
      {
         return this.upgrade_;
      }
      
      public function Upgrade(param1:UpgradeDef) : AreaEffectDef
      {
         this.upgrade = param1;
         return this;
      }
      
      public function set costScale(param1:Number) : void
      {
         if(this.costScale_ != param1)
         {
            this.costScale_ = param1;
            dispatchEvent(new PropertyModEvent("costScale"));
         }
      }
      
      public function get costScale() : Number
      {
         return this.costScale_;
      }
      
      public function CostScale(param1:Number) : AreaEffectDef
      {
         this.costScale = param1;
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
      
      public function PopCashScale(param1:Number) : AreaEffectDef
      {
         this.popCashScale = param1;
         return this;
      }
   }
}
