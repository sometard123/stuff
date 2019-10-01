package assets.btdmodule.ui
{
   import flash.display.MovieClip;
   
   public dynamic class AntiBossButtonReadyEffect extends MovieClip
   {
       
      
      public function AntiBossButtonReadyEffect()
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
