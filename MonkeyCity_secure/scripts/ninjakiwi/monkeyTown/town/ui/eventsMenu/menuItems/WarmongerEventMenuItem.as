package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.WarmongerEventIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class WarmongerEventMenuItem extends EventsMenuItem
   {
       
      
      public function WarmongerEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Warmonger";
         typeID = "warmonger";
         displayPriority = 0;
         _iconClass = WarmongerEventIconClip;
      }
   }
}
