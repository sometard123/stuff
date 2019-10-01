package assets.ui
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class BloonBossBloonariusIcon extends MovieClip
   {
       
      
      public var timeField:TextField;
      
      public function BloonBossBloonariusIcon()
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
