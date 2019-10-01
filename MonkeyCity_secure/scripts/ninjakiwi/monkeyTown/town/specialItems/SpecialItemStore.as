package ninjakiwi.monkeyTown.town.specialItems
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeRewards;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemSaveDefinition;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemStoreSaveDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.monkeyTown.utils.Random;
   import org.osflash.signals.Signal;
   
   public class SpecialItemStore
   {
      
      public static const TREASURE_CHEST_AQUIRED:Signal = new Signal(SpecialItemDefinition);
      
      public static const BLOONSTONES_AQUIRED:Signal = new Signal(int);
      
      public static const BLOONTONIUM_AQUIRED:Signal = new Signal(int);
      
      public static const CASH_AQUIRED:Signal = new Signal(int);
      
      public static const specialItemsStateChanged:Signal = new Signal();
      
      public static const specialItemsLoaded:Signal = new Signal();
      
      private static var _instance:SpecialItemStore;
       
      
      private const SPECIAL_ITEM_SEED_OFFSET:int = 10000;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const _specialItemData:SpecialItemData = SpecialItemData.getInstance();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _storedSpecialItems:Vector.<SpecialItem>;
      
      private var _storedSpecialItemsByID:Object;
      
      public function SpecialItemStore(param1:SingletonEnforcer#996)
      {
         this._storedSpecialItems = new Vector.<SpecialItem>();
         this._storedSpecialItemsByID = new Object();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use SpecialItemStore.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.reset);
      }
      
      public static function getInstance() : SpecialItemStore
      {
         if(_instance == null)
         {
            _instance = new SpecialItemStore(new SingletonEnforcer#996());
         }
         return _instance;
      }
      
      public function get specialItemsInInventory() : Vector.<SpecialItem>
      {
         return this._storedSpecialItems;
      }
      
      public function clearItems() : void
      {
         this._storedSpecialItems.length = 0;
      }
      
      public function getSaveDefinition() : SpecialItemStoreSaveDefinition
      {
         var _loc2_:SpecialItem = null;
         var _loc1_:SpecialItemStoreSaveDefinition = new SpecialItemStoreSaveDefinition();
         var _loc3_:int = 0;
         while(_loc3_ < this._storedSpecialItems.length)
         {
            _loc2_ = this._storedSpecialItems[_loc3_];
            _loc1_.specialItemSaveDefinitions.push(_loc2_.getSaveDefinition());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function populateFromSaveDefinition(param1:SpecialItemStoreSaveDefinition) : void
      {
         var _loc2_:SpecialItemSaveDefinition = null;
         var _loc3_:SpecialItemDefinition = null;
         var _loc4_:SpecialItem = null;
         this._storedSpecialItems = new Vector.<SpecialItem>();
         this._storedSpecialItemsByID = new Object();
         if(param1 == null)
         {
            specialItemsLoaded.dispatch();
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1.specialItemSaveDefinitions.length)
         {
            _loc2_ = param1.specialItemSaveDefinitions[_loc5_];
            _loc3_ = this._specialItemData.getDefinitionByID(_loc2_.definitionID);
            if(_loc3_ == null)
            {
               ErrorReporter.error("SpecialItemStore::populateFromSaveDefinition() - cannot find specialItemDefinition");
            }
            this.addSpecialItem(_loc3_,_loc2_.inStockCount);
            _loc5_++;
         }
         specialItemsLoaded.dispatch();
      }
      
      public function hasSpecialItem(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return true;
         }
         var _loc2_:SpecialItem = this._storedSpecialItemsByID[param1];
         if(_loc2_ != null)
         {
            return true;
         }
         return false;
      }
      
      private function addSpecialItem(param1:SpecialItemDefinition, param2:int) : SpecialItem
      {
         var _loc3_:SpecialItem = null;
         if(param1.logic != null)
         {
            _loc3_ = new param1.logic(param1,param2);
         }
         else
         {
            _loc3_ = new SpecialItem(param1,param2);
         }
         if(_loc3_.definition.id != this._specialItemData.CITY_CASH.id)
         {
            this._storedSpecialItems.push(_loc3_);
            this._storedSpecialItemsByID[param1.id] = _loc3_;
         }
         return _loc3_;
      }
      
      private function getRandomSpecialItem(param1:uint, param2:String) : SpecialItem
      {
         var _loc6_:SpecialItemDefinition = null;
         var _loc7_:SpecialItem = null;
         var _loc8_:int = 0;
         if(param2 === "cash")
         {
            return this.getItem(this._specialItemData.CITY_CASH);
         }
         var _loc3_:int = this._system.city.cityIndex;
         var _loc4_:Random = new Random(param1);
         var _loc5_:Vector.<SpecialItemDefinition> = this._specialItemData.treasureChestDefinitions;
         var _loc9_:Vector.<SpecialItemDefinition> = new Vector.<SpecialItemDefinition>();
         var _loc10_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc8_];
            if(_loc6_.id != this._specialItemData.CITY_CASH.id)
            {
               _loc7_ = this._storedSpecialItemsByID[_loc6_.id];
               if(_loc6_.minCityIndex >= _loc3_ && (_loc6_.charges != -1 || _loc7_ == null))
               {
                  _loc9_.push(_loc6_);
                  _loc6_.chanceRangeStart = _loc10_;
                  _loc10_ = _loc10_ + _loc6_.rarity;
               }
            }
            _loc8_++;
         }
         var _loc11_:int = _loc4_.nextInteger(_loc10_);
         _loc8_ = _loc9_.length - 1;
         while(_loc8_ >= 0)
         {
            _loc6_ = _loc9_[_loc8_];
            _loc7_ = this._storedSpecialItemsByID[_loc6_.id];
            if(_loc11_ > _loc6_.chanceRangeStart)
            {
               return this.getItem(_loc6_);
            }
            _loc8_--;
         }
         return this.getItem(this._specialItemData.CITY_CASH);
      }
      
      private function getItem(param1:SpecialItemDefinition) : SpecialItem
      {
         var _loc2_:SpecialItem = param1 == null?null:this._storedSpecialItemsByID[param1.id];
         if(_loc2_ == null)
         {
            _loc2_ = this.addSpecialItem(param1,param1.charges);
         }
         else
         {
            _loc2_.addToStock(param1.charges);
         }
         return _loc2_;
      }
      
      public function acquiredSpecialItem(param1:String) : SpecialItem
      {
         var _loc2_:SpecialItem = this.getItem(this._specialItemData.getDefinitionByID(param1));
         specialItemsStateChanged.dispatch();
         TownUI.getInstance().treasurePanel.foundTreasure(_loc2_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
         return _loc2_;
      }
      
      public function extractTreasureFromTile(param1:Tile, param2:TownMap) : SpecialItem
      {
         var _loc3_:String = null;
         var _loc4_:uint = param1.seed + this.SPECIAL_ITEM_SEED_OFFSET;
         var _loc5_:SpecialItem = this.getRandomSpecialItem(_loc4_,param1.treasureType);
         if(_loc5_ == null)
         {
            _loc5_ = this.getItem(this._specialItemData.CITY_CASH);
         }
         _loc5_.extractTreasureFromTile(param1,param2);
         param1.clearTreasureChest();
         TREASURE_CHEST_AQUIRED.dispatch(_loc5_.definition);
         specialItemsStateChanged.dispatch();
         var _loc6_:Object = MonkeyKnowledgeRewards.getInstance().giveTreasureCaptureRewards();
         TownUI.getInstance().treasurePanel.foundTreasureChest(_loc5_,_loc6_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
         return _loc5_;
      }
      
      public function awardRandomItem() : void
      {
         var _loc1_:uint = 1 + uint(Math.random() * uint.MAX_VALUE - 1) + this.SPECIAL_ITEM_SEED_OFFSET;
         var _loc2_:SpecialItem = this.getRandomSpecialItem(_loc1_,this._specialItemData.ITEM);
         TREASURE_CHEST_AQUIRED.dispatch(_loc2_.definition);
         specialItemsStateChanged.dispatch();
         TownUI.getInstance().treasurePanel.foundTreasureChest(_loc2_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
      }
      
      public function acquiredBloonstones(param1:int) : void
      {
         TownUI.getInstance().informationBar.lockDisplay();
         var _loc2_:int = GameMods.awardBloonstones(param1);
         TownUI.getInstance().informationBar.addRewardDisplay(TownUI.getInstance().treasurePanel.hideStartSignal,0,0,0,0,0,_loc2_);
         TownUI.getInstance().informationBar.unlockDisplay();
         TownUI.getInstance().treasurePanel.foundBloonstones(_loc2_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
      }
      
      public function acquiredBloontoniums(param1:int) : void
      {
         TownUI.getInstance().informationBar.lockDisplay();
         var _loc2_:int = GameMods.awardBloontonium(param1);
         TownUI.getInstance().informationBar.addRewardDisplay(TownUI.getInstance().treasurePanel.hideStartSignal,0,0,0,0,_loc2_,0);
         TownUI.getInstance().informationBar.unlockDisplay();
         TownUI.getInstance().treasurePanel.foundBloontoniums(_loc2_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
      }
      
      public function acquiredCash(param1:int) : void
      {
         TownUI.getInstance().informationBar.lockDisplay();
         var _loc2_:int = GameMods.awardCash(param1);
         TownUI.getInstance().informationBar.addRewardDisplay(TownUI.getInstance().treasurePanel.hideStartSignal,0,0,_loc2_,0);
         TownUI.getInstance().informationBar.unlockDisplay();
         TownUI.getInstance().treasurePanel.foundCash(_loc2_);
         PanelManager.getInstance().showPanel(TownUI.getInstance().treasurePanel);
      }
      
      private function reset(... rest) : void
      {
         var _loc2_:int = 0;
         if(this._storedSpecialItems != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this._storedSpecialItems.length)
            {
               this._storedSpecialItems[_loc2_].clear();
               _loc2_++;
            }
         }
         this._storedSpecialItems.length = 0;
         this._storedSpecialItemsByID = {};
      }
   }
}

class SingletonEnforcer#996
{
    
   
   function SingletonEnforcer#996()
   {
      super();
   }
}
