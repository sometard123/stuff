package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.FestivalOfBloonstonesIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class FestivalOfBloonstonesMenuItem extends EventsMenuItem
   {
       
      
      public function FestivalOfBloonstonesMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Festival Of Bloonstones";
         typeID = "bloonstoneSpend";
         displayPriority = 0;
         _iconClass = FestivalOfBloonstonesIconClip;
      }
      
      override public function onOpen() : void
      {
         if(hasRequiredLevel())
         {
            GameEventManager.getInstance().bloonstonesSpendTracker.updatePanelToNextReward();
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().gameEventsUIManager.bloonstoneSpendRewardPanel);
         }
         else
         {
            openRequiresHigherLevelPopup();
         }
      }
   }
}
