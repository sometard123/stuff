package InGameUI_fla_fla
{
   import flash.display.MovieClip;
   
   public dynamic class FieryPitFireAll_330 extends MovieClip
   {
       
      
      public function FieryPitFireAll_330()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         gotoAndPlay(Math.ceil(Math.random() * this.totalFrames));
      }
   }
}
