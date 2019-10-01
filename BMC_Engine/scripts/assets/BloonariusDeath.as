package assets
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class BloonariusDeath extends MovieClip
   {
       
      
      public function BloonariusDeath()
      {
         super();
         addFrameScript(53,this.frame54,70,this.frame71);
      }
      
      function frame54() : *
      {
         this.dispatchEvent(new Event("RemoveBoss"));
      }
      
      function frame71() : *
      {
         this.dispatchEvent(new Event("Finished"));
         stop();
      }
   }
}
