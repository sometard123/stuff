package ContestedTerritory_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class BanksFullAnimation_91 extends MovieClip
   {
       
      
      public function BanksFullAnimation_91()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      function frame31() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
