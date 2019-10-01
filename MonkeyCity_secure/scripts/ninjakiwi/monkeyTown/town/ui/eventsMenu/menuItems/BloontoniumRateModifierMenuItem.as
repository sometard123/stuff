package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.BloontoniumMeltdownIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class BloontoniumRateModifierMenuItem extends EventsMenuItem
   {
       
      
      public function BloontoniumRateModifierMenuItem(param1:GameplayEvent)
      {
         super(param1);
         typeID = "bloontoniumRateModifier";
         name = "Bloontonium Meltdown";
         displayPriority = 0;
         _iconClass = BloontoniumMeltdownIconClip;
      }
   }
}
