package assets.bloons
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class BlastapopoulosEntranceAnimationClip extends MovieClip
   {
       
      
      public function BlastapopoulosEntranceAnimationClip()
      {
         super();
         addFrameScript(1,this.frame2,55,this.frame56);
      }
      
      function frame2() : *
      {
         this.dispatchEvent(new Event("BossEnter"));
      }
      
      function frame56() : *
      {
         stop();
      }
   }
}
