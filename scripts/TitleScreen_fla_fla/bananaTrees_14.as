package TitleScreen_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.DefaultEventMenuItem;
   
   public dynamic class bananaTrees_14 extends MovieClip
   {
       
      
      public function bananaTrees_14()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      function frame31() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
