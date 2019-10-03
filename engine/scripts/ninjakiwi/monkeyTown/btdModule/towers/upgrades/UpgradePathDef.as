package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class UpgradePathDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var base_:TowerDef;
      
      private var upgrades_:Vector.<Vector.<UpgradeDef>>;
      
      public function UpgradePathDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("base","upgrades");
         }
         return displayOrder;
      }
      
      public function set base(param1:TowerDef) : void
      {
         if(this.base_ != param1)
         {
            this.base_ = param1;
            dispatchEvent(new PropertyModEvent("base"));
         }
      }
      
      public function get base() : TowerDef
      {
         return this.base_;
      }
      
      public function Base(param1:TowerDef) : UpgradePathDef
      {
         this.base = param1;
         return this;
      }
      
      public function set upgrades(param1:Vector.<Vector.<UpgradeDef>>) : void
      {
         if(this.upgrades_ != param1)
         {
            this.upgrades_ = param1;
            dispatchEvent(new PropertyModEvent("upgrades"));
         }
      }
      
      public function get upgrades() : Vector.<Vector.<UpgradeDef>>
      {
         return this.upgrades_;
      }
      
      public function Upgrades(param1:Array) : UpgradePathDef
      {
         var _loc2_:Array = null;
         var _loc3_:Vector.<UpgradeDef> = null;
         var _loc4_:UpgradeDef = null;
         if(this.upgrades == null)
         {
            this.upgrades = new Vector.<Vector.<UpgradeDef>>();
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = new Vector.<UpgradeDef>();
            for each(_loc4_ in _loc2_)
            {
               _loc3_.push(_loc4_);
            }
            this.upgrades.push(_loc3_);
         }
         return this;
      }
   }
}
