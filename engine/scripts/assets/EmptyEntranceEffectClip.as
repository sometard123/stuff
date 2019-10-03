package assets
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class EmptyEntranceEffectClip extends MovieClip
   {
       
      
      public function EmptyEntranceEffectClip()
      {
         super();
         addFrameScript(1,this.frame2,2,this.frame3);
      }
      
      function frame2() : *
      {
         this.dispatchEvent(new Event("BossEnter"));
      }
      
      function frame3() : *
      {
         stop();
      }
   }
}
