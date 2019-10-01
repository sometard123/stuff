package assets.effects
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class CrateAnimation extends MovieClip
   {
       
      
      public function CrateAnimation()
      {
         super();
         addFrameScript(24,this.frame25,39,this.frame40);
      }
      
      function frame25() : *
      {
         this.dispatchEvent(new Event("CrateImpact"));
      }
      
      function frame40() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}
