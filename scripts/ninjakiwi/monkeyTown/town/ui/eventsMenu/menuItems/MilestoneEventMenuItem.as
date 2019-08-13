package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.CTMilestonesIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MilestoneEventMenuItem extends EventsMenuItem
   {
       
      
      public function MilestoneEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "CT Milestones Event";
         typeID = "ctMilestones";
         displayPriority = 0;
         _iconClass = CTMilestonesIconClip;
      }
      
      override public function onOpen() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().contestedTerritoryPanel);
      }
   }
}
