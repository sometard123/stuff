package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.ads.VideoAds;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class VideoAdPanelController
   {
       
      
      private var _clip:MovieClip;
      
      private var _owner:HideRevealView;
      
      private var _watchVideoButton:ButtonControllerBase;
      
      public function VideoAdPanelController(param1:MovieClip, param2:HideRevealView)
      {
         super();
         this._clip = param1;
         this._owner = param2;
         this.init();
      }
      
      private function init() : void
      {
         this._watchVideoButton = new ButtonControllerBase(this._clip.watchVideoButton);
         this._watchVideoButton.lock(3);
         this._watchVideoButton.setClickFunction(this.onWatchVideoButtonClicked);
      }
      
      public function doVideoAvailableCheck() : void
      {
         this._watchVideoButton.lock(3);
         this._clip.visible = false;
         this._clip.alpha = 0;
         VideoAds.videoAvailabilitySignal.addOnce(function checkAvailability(param1:Boolean):void
         {
            if(param1)
            {
               makeAvailable();
            }
         });
         VideoAds.checkInventory();
      }
      
      public function makeAvailable() : void
      {
         this._watchVideoButton.unlock(1);
         this._clip.alpha = 0;
         this._clip.visible = true;
         TweenLite.to(this._clip,0.3,{"alpha":1});
      }
      
      private function onWatchVideoButtonClicked() : void
      {
         VideoAds.gotoWatchVideo();
      }
   }
}
