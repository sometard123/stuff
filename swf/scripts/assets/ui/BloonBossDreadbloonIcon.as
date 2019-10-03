package assets.ui
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class BloonBossDreadbloonIcon extends MovieClip
   {
       
      
      public var timeField:TextField;
      
      public function BloonBossDreadbloonIcon()
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
