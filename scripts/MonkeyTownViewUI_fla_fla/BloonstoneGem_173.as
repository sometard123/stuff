package MonkeyTownViewUI_fla_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   
   public dynamic class BloonstoneGem_173 extends MovieClip
   {
       
      
      public function BloonstoneGem_173()
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
