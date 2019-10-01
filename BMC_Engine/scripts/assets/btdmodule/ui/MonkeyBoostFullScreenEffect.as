package assets.btdmodule.ui
{
   import flash.display.MovieClip;
   
   public dynamic class MonkeyBoostFullScreenEffect extends MovieClip
   {
       
      
      public function MonkeyBoostFullScreenEffect()
      {
         super();
         addFrameScript(7,this.frame8);
      }
      
      function frame8() : *
      {
         stop();
      }
   }
}
