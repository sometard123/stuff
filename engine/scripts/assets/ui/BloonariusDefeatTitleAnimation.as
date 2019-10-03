package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BloonariusDefeatTitleAnimation extends MovieClip
   {
       
      
      public function BloonariusDefeatTitleAnimation()
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
