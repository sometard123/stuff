package ContestedTerritory_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class CoinBurst_89 extends MovieClip
   {
       
      
      public function CoinBurst_89()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      function frame31() : *
      {
         dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}
