package TitleScreen_fla_fla
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuStack;
   import ninjakiwi.monkeyTown.town.ui.pvp.SortByDropdown;
   
   public dynamic class bank_17 extends MovieClip
   {
       
      
      public function bank_17()
      {
         super();
         addFrameScript(33,this.frame34);
      }
      
      function frame34() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
