package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class UpgradeArrowButton extends MovieClip
   {
       
      
      public function UpgradeArrowButton()
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
