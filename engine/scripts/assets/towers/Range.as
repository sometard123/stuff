package assets.towers
{
   import flash.display.MovieClip;
   
   public dynamic class Range extends MovieClip
   {
       
      
      public function Range()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
