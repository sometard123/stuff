package ninjakiwi.monkeyTown.btdModule.ingame
{
   import ninjakiwi.monkeyTown.btdModule.towers.CostRoundUtil;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class TowerPickerDef
   {
       
      
      private var id_:int = -1;
      
      private var tower_:TowerDef = null;
      
      private var button_:Class = null;
      
      private var cost_:int = 0;
      
      private var nkUpgradeID_:int = 0;
      
      private var hotKey_:int = 0;
      
      private var unlockTier_:int = 0;
      
      private var unlockCost_:int = 0;
      
      private var unlockTier4Cost_:int = 0;
      
      public var menuOrder:int;
      
      public var towersAvailable:int = 0;
      
      public function TowerPickerDef()
      {
         super();
      }
      
      public function get id() : int
      {
         return this.id_;
      }
      
      public function set id(param1:int) : void
      {
         this.id_ = param1;
      }
      
      public function Id(param1:int) : TowerPickerDef
      {
         this.id_ = param1;
         return this;
      }
      
      public function set tower(param1:TowerDef) : void
      {
         this.tower_ = param1;
      }
      
      public function get tower() : TowerDef
      {
         return this.tower_;
      }
      
      public function Tower(param1:TowerDef) : TowerPickerDef
      {
         this.tower = param1;
         return this;
      }
      
      public function set button(param1:Class) : void
      {
         this.button_ = param1;
      }
      
      public function get button() : Class
      {
         return this.button_;
      }
      
      public function Button(param1:Class) : TowerPickerDef
      {
         this.button = param1;
         return this;
      }
      
      public function set cost(param1:int) : void
      {
         this.cost_ = CostRoundUtil.getRoundedCost(param1);
      }
      
      public function get cost() : int
      {
         return this.cost_;
      }
      
      public function Cost(param1:int) : TowerPickerDef
      {
         this.cost = param1;
         return this;
      }
      
      public function set nkUpgradeID(param1:int) : void
      {
         this.nkUpgradeID_ = param1;
      }
      
      public function get nkUpgradeID() : int
      {
         return this.nkUpgradeID_;
      }
      
      public function NkUpgradeID(param1:int) : TowerPickerDef
      {
         this.nkUpgradeID = param1;
         return this;
      }
      
      public function set hotKey(param1:int) : void
      {
         this.hotKey_ = param1;
      }
      
      public function get hotKey() : int
      {
         return this.hotKey_;
      }
      
      public function HotKey(param1:int) : TowerPickerDef
      {
         this.hotKey = param1;
         return this;
      }
      
      public function set unlockTier(param1:int) : void
      {
         this.unlockTier_ = param1;
      }
      
      public function get unlockTier() : int
      {
         return this.unlockTier_;
      }
      
      public function UnlockTier(param1:int) : TowerPickerDef
      {
         this.unlockTier_ = param1;
         return this;
      }
      
      public function set unlockCost(param1:int) : void
      {
         this.unlockCost_ = param1;
      }
      
      public function get unlockCost() : int
      {
         return this.unlockCost_;
      }
      
      public function UnlockCost(param1:int) : TowerPickerDef
      {
         this.unlockCost_ = param1;
         return this;
      }
      
      public function set unlockTier4Cost(param1:int) : void
      {
         this.unlockTier4Cost_ = param1;
      }
      
      public function get unlockTier4Cost() : int
      {
         return this.unlockTier4Cost_;
      }
      
      public function UnlockTier4Cost(param1:int) : TowerPickerDef
      {
         this.unlockTier4Cost_ = param1;
         return this;
      }
   }
}
