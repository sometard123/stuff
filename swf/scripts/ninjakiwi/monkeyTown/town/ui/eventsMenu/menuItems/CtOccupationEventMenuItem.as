package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.CTOccupationIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class CtOccupationEventMenuItem extends EventsMenuItem
   {
       
      
      public function CtOccupationEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "CT Occupation Event";
         typeID = "ctOccupation";
         displayPriority = 0;
         _iconClass = CTOccupationIconClip;
      }
      
      override public function onOpen() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().contestedTerritoryPanel);
      }
   }
}
