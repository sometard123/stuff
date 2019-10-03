package assets
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class BloonariusEntrance extends MovieClip
   {
       
      
      public function BloonariusEntrance()
      {
         super();
         addFrameScript(9,this.frame10,29,this.frame30);
      }
      
      function frame10() : *
      {
         this.dispatchEvent(new Event("BossEnter"));
      }
      
      function frame30() : *
      {
         stop();
      }
   }
}
