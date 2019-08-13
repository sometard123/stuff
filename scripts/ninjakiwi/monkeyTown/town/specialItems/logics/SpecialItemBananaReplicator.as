package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class SpecialItemBananaReplicator extends SpecialItem
   {
      
      public static var HAS_REPLICATOR:Boolean = false;
      
      public static const BONUS_CAPACITY:Number = 150;
       
      
      public function SpecialItemBananaReplicator(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function clear() : void
      {
         super.clear();
         HAS_REPLICATOR = false;
      }
      
      override protected function applyAbility() : void
      {
         super.applyAbility();
         HAS_REPLICATOR = true;
      }
      
      override public function extractTreasureFromTile(param1:Tile, param2:TownMap) : void
      {
         super.extractTreasureFromTile(param1,param2);
      }
   }
}
