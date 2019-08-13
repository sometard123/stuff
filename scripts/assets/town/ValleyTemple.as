package assets.town
{
   import flash.display.MovieClip;
   
   public dynamic class ValleyTemple extends MovieClip
   {
       
      
      public function ValleyTemple()
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
