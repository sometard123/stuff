package ninjakiwi.monkeyTown.ui.videoAds
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.ads.VideoAds;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class VideoPromptInterstitial extends HideRevealView
   {
      
      private static const DEFAULT_THRESHOLD:int = 3;
      
      public static const TWO:String = "two";
      
      public static const THREE:String = "three";
      
      private static const QUEUE_THRESHOLDS:Object = {
         "two":2,
         "three":3
      };
       
      
      private var _panelController:VideoAdPanelController;
      
      private var _closeButtonController:ButtonControllerBase;
      
      private var _queueCounters:Object;
      
      private var MIN_LEVEL:int = 3;
      
      public function VideoPromptInterstitial(param1:DisplayObjectContainer)
      {
         this._queueCounters = {};
         super(param1);
         isModal = true;
      }
      
      public function initialiseView(param1:MovieClip) : void
      {
         this._panelController = new VideoAdPanelController(param1,this);
         enableDefaultOnResize(param1);
         addChild(param1);
         this._closeButtonController = new ButtonControllerBase(param1.closeButton);
         this._closeButtonController.setClickFunction(hide);
      }
      
      public function queue(param1:String = "three") : void
      {
         var that:VideoPromptInterstitial = null;
         var queueID:String = param1;
         if(ResourceStore.getInstance().townLevel < this.MIN_LEVEL)
         {
            return;
         }
         if(!this._queueCounters.hasOwnProperty(queueID))
         {
            this._queueCounters[queueID] = 0;
         }
         if(!QUEUE_THRESHOLDS.hasOwnProperty(queueID))
         {
            QUEUE_THRESHOLDS[queueID] = DEFAULT_THRESHOLD;
         }
         this._queueCounters[queueID]++;
         that = this;
         if(this._queueCounters[queueID] >= QUEUE_THRESHOLDS[queueID])
         {
            VideoAds.videoAvailabilitySignal.addOnce(function checkVideoAvailability(param1:Boolean):void
            {
               if(param1)
               {
                  PanelManager.getInstance().showPanel(that);
                  _panelController.makeAvailable();
                  _queueCounters[queueID] = 0;
               }
            });
            VideoAds.checkInventory();
         }
      }
   }
}
