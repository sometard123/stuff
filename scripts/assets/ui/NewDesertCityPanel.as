package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class NewDesertCityPanel extends MovieClip
   {
       
      
      public var lock:MovieClip;
      
      public var startNewDesertCityBtn:StartNewDesertCityBtn;
      
      public function NewDesertCityPanel()
      {
         super();
         addFrameScript(23,this.frame24);
      }
      
      function frame24() : *
      {
         stop();
         this.dispatchEvent(new Event("onDesertUnlockAnimComplete"));
      }
   }
}
