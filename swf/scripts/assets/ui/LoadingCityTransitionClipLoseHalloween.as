package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class LoadingCityTransitionClipLoseHalloween extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var viewArea:MovieClip;
      
      public function LoadingCityTransitionClipLoseHalloween()
      {
         super();
         addFrameScript(11,this.frame12,118,this.frame119);
      }
      
      function frame12() : *
      {
         stop();
         this.dispatchEvent(new Event("openAnimationComplete"));
      }
      
      function frame119() : *
      {
         stop();
         this.dispatchEvent(new Event("closeAnimationComplete"));
      }
   }
}
