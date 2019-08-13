package ninjakiwi.monkeyTown.ui.videoAds
{
   import assets.ui.WatchVideoPanelClip;
   import flash.display.DisplayObjectContainer;
   
   public class VideoPromptInterstitialGeneric extends VideoPromptInterstitial
   {
       
      
      private var _clip:WatchVideoPanelClip;
      
      public function VideoPromptInterstitialGeneric(param1:DisplayObjectContainer)
      {
         this._clip = new WatchVideoPanelClip();
         super(param1);
         initialiseView(this._clip);
      }
   }
}
