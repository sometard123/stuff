package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.EventsMenuPlaceholderIcon;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class DefaultEventMenuItem extends EventsMenuItem
   {
       
      
      public function DefaultEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Default Event";
         displayPriority = 0;
         _iconClass = EventsMenuPlaceholderIcon;
      }
   }
}
