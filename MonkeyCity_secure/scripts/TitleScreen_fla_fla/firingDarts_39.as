package TitleScreen_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.SharedObject;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.town.ui.promo.time;
   
   public dynamic class firingDarts_39 extends MovieClip
   {
       
      
      public function firingDarts_39()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
