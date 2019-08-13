package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.MonkeyTeamsIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class MonkeyTeamEventMenuItem extends EventsMenuItem
   {
       
      
      public function MonkeyTeamEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Monkey Team";
         typeID = "monkeyTeam";
         displayPriority = 0;
         _iconClass = MonkeyTeamsIconClip;
      }
   }
}
