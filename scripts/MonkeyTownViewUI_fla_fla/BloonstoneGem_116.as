package MonkeyTownViewUI_fla_fla
{
   import flash.display.MovieClip;
   import flash.utils.setTimeout;
   
   public dynamic class BloonstoneGem_116 extends MovieClip
   {
       
      
      public function BloonstoneGem_116()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         setTimeout(function():void
         {
            play();
         },Math.random() * 3000);
      }
   }
}
