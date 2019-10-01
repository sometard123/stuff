package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   
   public class BittyBeaconsMenuItem extends EventsMenuItem
   {
       
      
      public function BittyBeaconsMenuItem(param1:GameplayEvent)
      {
         super(param1);
         typeID = "beaconRechargeCostModifier";
         name = "Bitty Beacons";
         displayPriority = 0;
         _iconClass = BloonBeaconIcon;
      }
   }
}
