package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class SpecialItemCityCash extends SpecialItem
   {
       
      
      private const DEFAULT_COIN:int = 50;
      
      private var awardCoin:int = 50;
      
      public function SpecialItemCityCash(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function extractTreasureFromTile(param1:Tile, param2:TownMap) : void
      {
         super.extractTreasureFromTile(param1,param2);
         this.awardCoin = param2.getDifficultyAtLocationPoint(param1.positionTilespace) * 200;
         TownUI.getInstance().informationBar.lockDisplay();
         TownUI.getInstance().informationBar.addRewardDisplay(TownUI.getInstance().treasurePanel.hideStartSignal,0,0,GameMods.awardCash(this.awardCoin));
         TownUI.getInstance().informationBar.unlockDisplay();
      }
      
      override public function getStringForRevealedUI() : String
      {
         return LocalisationConstants.FOUND_CITY_CASH.split("<cash>").join(this.awardCoin);
      }
   }
}
