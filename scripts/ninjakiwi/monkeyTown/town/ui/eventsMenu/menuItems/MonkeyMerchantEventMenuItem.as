package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.TravellingMerchantIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class MonkeyMerchantEventMenuItem extends EventsMenuItem
   {
       
      
      public function MonkeyMerchantEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Monkey Merchant";
         typeID = "monkeyMerchant";
         displayPriority = 0;
         _iconClass = TravellingMerchantIconClip;
      }
   }
}
