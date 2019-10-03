package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   
   public class BeaconModifiersEventMenuItem extends EventsMenuItem
   {
       
      
      public function BeaconModifiersEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         typeID = "beaconModifiers";
         name = "Bitty Beacon Blitz";
         displayPriority = 0;
         _iconClass = BloonBeaconIcon;
      }
   }
}
