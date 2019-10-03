package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.BountifulHarvestIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class BananaFarmModifierEventMenuItem extends EventsMenuItem
   {
       
      
      public function BananaFarmModifierEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         typeID = "bananaFarmRateModifier";
         name = "Bountiful Harvest";
         displayPriority = 0;
         _iconClass = BountifulHarvestIconClip;
      }
   }
}
