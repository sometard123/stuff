package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.MiniLandGrabIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class MiniLandGrabEventMenuItem extends EventsMenuItem
   {
       
      
      public function MiniLandGrabEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Mini Land-grab";
         typeID = "miniLandGrab";
         displayPriority = 0;
         _iconClass = MiniLandGrabIconClip;
      }
   }
}
