package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.MonkeyKnowledgeMadnessIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   
   public class MonkeyKnowledgeMadnessEventMenuItem extends EventsMenuItem
   {
       
      
      public function MonkeyKnowledgeMadnessEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Monkey Knowledge Madness";
         typeID = "monkeyKnowledgeMadness";
         displayPriority = 0;
         _iconClass = MonkeyKnowledgeMadnessIconClip;
      }
   }
}
