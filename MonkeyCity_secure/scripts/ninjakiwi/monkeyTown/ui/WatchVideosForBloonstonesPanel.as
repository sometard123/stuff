package ninjakiwi.monkeyTown.ui
{
   import assets.ui.WatchVideoPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ads.VideoAds;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class WatchVideosForBloonstonesPanel extends HideRevealView
   {
      
      private static var _instance:WatchVideosForBloonstonesPanel;
       
      
      private var _clip:WatchVideoPanelClip;
      
      private var _watchVideoButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      public function WatchVideosForBloonstonesPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new WatchVideoPanelClip();
         this._watchVideoButton = new ButtonControllerBase(this._clip.watchVideoButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         super(param1,param2);
         addChild(this._clip);
         this._watchVideoButton.setClickFunction(this.onWatchVideoButtonClicked);
         this._closeButton.setClickFunction(hide);
         _instance = this;
         enableDefaultOnResize(this._clip);
         isModal = true;
      }
      
      public static function reveal() : void
      {
         _instance.reveal();
      }
      
      public static function get instance() : WatchVideosForBloonstonesPanel
      {
         return _instance;
      }
      
      private function onWatchVideoButtonClicked() : void
      {
         hide();
         VideoAds.gotoWatchVideo();
      }
   }
}
