package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.CrazyCreditEventIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class CrazyCreditEventMenuItem extends EventsMenuItem
   {
       
      
      public function CrazyCreditEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Crazy Credit";
         typeID = "cashBloonstoneExchangeRateModifier";
         displayPriority = 0;
         _iconClass = CrazyCreditEventIconClip;
      }
   }
}
