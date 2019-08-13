package assets.io
{
   import assets.ui.PVPHistoryinfoBoxClip;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.osflash.signals.Signal;
   
   public dynamic class BloonBeaconTwoStateClip extends MovieClip
   {
       
      
      public var timeField:TextField;
      
      public function BloonBeaconTwoStateClip()
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
