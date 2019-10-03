package TitleScreen_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   
   public dynamic class BoomerangHut_19 extends MovieClip
   {
       
      
      public function BoomerangHut_19()
      {
         super();
         addFrameScript(20,this.frame21);
      }
      
      function frame21() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
