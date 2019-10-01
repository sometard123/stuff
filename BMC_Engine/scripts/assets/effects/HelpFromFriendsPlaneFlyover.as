package assets.effects
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class HelpFromFriendsPlaneFlyover extends MovieClip
   {
       
      
      public function HelpFromFriendsPlaneFlyover()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      function frame40() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}
