package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   
   public class BeaconBlitzMenuItem extends EventsMenuItem
   {
       
      
      public function BeaconBlitzMenuItem(param1:GameplayEvent)
      {
         super(param1);
         typeID = "beaconRechargeTimeModifier";
         name = "Beacon Blitz";
         displayPriority = 0;
         _iconClass = BloonBeaconIcon;
      }
   }
}