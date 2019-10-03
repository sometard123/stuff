package assets.btdmodule
{
   import flash.display.MovieClip;
   
   public dynamic class SkullMarker extends MovieClip
   {
       
      
      public function SkullMarker()
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
