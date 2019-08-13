package EventsMenuStack_fla_fla
{
   import flash.display.MovieClip;
   import flash.utils.setTimeout;
   
   public dynamic class BloonstoneGem_17 extends MovieClip
   {
       
      
      public function BloonstoneGem_17()
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
