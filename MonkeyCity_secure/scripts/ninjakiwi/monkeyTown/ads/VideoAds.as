package ninjakiwi.monkeyTown.ads
{
   import assets.ui.CTOccupationIconClip;
   import flash.external.ExternalInterface;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import org.osflash.signals.Signal;
   
   public class VideoAds
   {
      
      public static const videoAvailabilitySignal:Signal = new Signal(Boolean);
      
      private static var _currentIGCBalance:int = 0;
      
      private static var _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static var _resourceStore:ResourceStore = ResourceStore.getInstance();
       
      
      public function VideoAds()
      {
         super();
         this.setupExternalInterface();
      }
      
      public static function checkInventory() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("checkInventory",MonkeySystem.getInstance().nkGatewayUser.loginInfo.id,"18524");
         }
         else
         {
            videoAvailabilitySignal.dispatch(false);
         }
      }
      
      public static function gotoWatchVideo() : void
      {
         ErrorReporter.externalLog("VideoAds::gotoWatchVideo()");
         SoundMixer.soundTransform = new SoundTransform(0);
         _currentIGCBalance = _system.nkGatewayUser.igcAmount;
         if(ExternalInterface.available)
         {
            ErrorReporter.externalLog("VideoAds::gotoWatchVideo() EI available");
            ExternalInterface.call("getVideo");
            ExternalInterface.call("console.log","asked to watch a video");
         }
         else
         {
            ErrorReporter.externalLog("VideoAds::gotoWatchVideo() External Interface not available");
         }
      }
      
      private function setupExternalInterface() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("gotAVideo",this.gotAVideo);
            ExternalInterface.addCallback("watchedVideo",this.watchedVideo);
            ExternalInterface.addCallback("cancelledVideo",this.cancelledVideo);
            ExternalInterface.addCallback("noVideos",this.noVideos);
            ExternalInterface.call("getVideo");
         }
      }
      
      public function init() : void
      {
         _currentIGCBalance = _system.nkGatewayUser.igcAmount;
         checkInventory();
      }
      
      private function gotAVideo(param1:*) : void
      {
         videoAvailabilitySignal.dispatch(true);
      }
      
      private function noVideos(param1:*) : void
      {
         SoundMixer.soundTransform = new SoundTransform(1);
         videoAvailabilitySignal.dispatch(false);
      }
      
      private function watchedVideo(param1:*) : void
      {
         ExternalInterface.call("console.log","watched a video");
         this.updateBS();
      }
      
      private function cancelledVideo(param1:*) : void
      {
         SoundMixer.soundTransform = new SoundTransform(1);
      }
      
      private function updateBS() : void
      {
         if(_system.nkGatewayUser === null)
         {
            return;
         }
         _system.nkGatewayUser.awardIgc(0,"301","woot").then(function ok(param1:int):void
         {
            var _loc2_:int = param1 - _currentIGCBalance;
            _currentIGCBalance = param1;
            if(_loc2_ < 3)
            {
               _loc2_ = 3;
            }
            if(_loc2_ > 25)
            {
               _loc2_ = 25;
            }
            _resourceStore.bloonstonesDirect = _resourceStore.bloonstonesDirect + _loc2_;
         },function notOK(param1:Object):void
         {
         });
      }
   }
}
