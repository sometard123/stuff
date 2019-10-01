package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class DreadbloonDefeatTitleAnimation extends MovieClip
   {
       
      
      public function DreadbloonDefeatTitleAnimation()
      {
         super();
         addFrameScript(15,this.frame16);
      }
      
      function frame16() : *
      {
         stop();
      }
   }
}
