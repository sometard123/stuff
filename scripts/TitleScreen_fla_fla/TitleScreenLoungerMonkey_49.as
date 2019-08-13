package TitleScreen_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class TitleScreenLoungerMonkey_49 extends MovieClip
   {
       
      
      public function TitleScreenLoungerMonkey_49()
      {
         super();
         addFrameScript(16,this.frame17,148,this.frame149,161,this.frame162);
      }
      
      function frame17() : *
      {
         this.dispatchEvent(new Event("revealComplete"));
      }
      
      function frame149() : *
      {
         gotoAndPlay(18);
      }
      
      function frame162() : *
      {
         dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}
