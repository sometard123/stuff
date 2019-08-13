package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   
   public class WildRareEventMenuItem extends EventsMenuItem
   {
       
      
      public function WildRareEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Wild Wild Rare";
         typeID = "wildRare";
         displayPriority = 0;
         _iconClass = BloonBeaconIcon;
      }
   }
}
