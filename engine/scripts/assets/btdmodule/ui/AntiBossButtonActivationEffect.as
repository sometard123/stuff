package assets.btdmodule.ui
{
   import com.lgrey.events.LGDataEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AntiBossButtonActivationEffect extends MovieClip
   {
       
      
      public function AntiBossButtonActivationEffect()
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
