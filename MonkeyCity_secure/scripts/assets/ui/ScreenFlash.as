package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class ScreenFlash extends MovieClip
   {
       
      
      public function ScreenFlash()
      {
         super();
         addFrameScript(20,this.frame21);
      }
      
      function frame21() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
