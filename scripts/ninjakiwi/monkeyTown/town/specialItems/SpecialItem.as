package ninjakiwi.monkeyTown.town.specialItems
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemSaveDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class SpecialItem
   {
       
      
      private var _definition:SpecialItemDefinition;
      
      private var _inStockCount:int = 0;
      
      protected var _useCount:int = 0;
      
      public function SpecialItem(param1:SpecialItemDefinition, param2:int = 0)
      {
         super();
         if(param1 == null)
         {
            ErrorReporter.error("SpecialItem::SpecialItem() - definition cannot be bull");
         }
         this._definition = param1;
         this._inStockCount = param2;
         if(this._definition.charges == -1)
         {
            this.applyAbility();
         }
      }
      
      public function clear() : void
      {
      }
      
      public function getSaveDefinition() : SpecialItemSaveDefinition
      {
         return new SpecialItemSaveDefinition().DefinitionID(this._definition.id).InStockCount(this._inStockCount);
      }
      
      public function get inStockCount() : int
      {
         return this._inStockCount;
      }
      
      public function addToStock(param1:int) : void
      {
         this._inStockCount = this._inStockCount + param1;
      }
      
      public function get definition() : SpecialItemDefinition
      {
         return this._definition;
      }
      
      public function getStringForRevealedUI() : String
      {
         return this._definition.gameDescription;
      }
      
      protected function applyAbility() : void
      {
      }
      
      public function useAbility() : Boolean
      {
         if(this.inStockCount > 0)
         {
            this._useCount++;
            this._inStockCount--;
            return true;
         }
         return false;
      }
      
      protected function consumeItem() : void
      {
         SpecialItemStore.specialItemsStateChanged.dispatch();
         this._useCount = 0;
      }
      
      public function extractTreasureFromTile(param1:Tile, param2:TownMap) : void
      {
      }
   }
}
