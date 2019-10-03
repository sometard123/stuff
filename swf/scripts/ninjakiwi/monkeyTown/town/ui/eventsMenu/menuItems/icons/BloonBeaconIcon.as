package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons
{
   import assets.io.BloonBeaconTwoStateClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class BloonBeaconIcon extends MovieClip
   {
       
      
      private var _clip:BloonBeaconTwoStateClip;
      
      private var _timerField:TextField;
      
      private var _countdownTimer:CountdownTimer;
      
      public function BloonBeaconIcon()
      {
         this._clip = new BloonBeaconTwoStateClip();
         this._timerField = this._clip.timeField;
         this._countdownTimer = new CountdownTimer(this._timerField,0);
         super();
         addChild(this._clip);
         BloonBeaconSystem.getInstance().onBeaconCapturedSignal.add(this.syncBeaconState);
         BloonBeaconSystem.getInstance().onBeaconSpawned.add(this.syncBeaconState);
         BloonBeaconSystem.getInstance().beaconSystemReadySignal.add(this.syncBeaconState);
         BloonBeaconSystem.getInstance().onBeaconRecharged.add(this.syncBeaconState);
         GameSignals.CITY_IS_FINALLY_READY.add(this.syncBeaconState);
         this.syncBeaconState();
      }
      
      public function syncBeaconState(... rest) : void
      {
         var args:Array = rest;
         setTimeout(function():void
         {
            var _loc1_:Number = NaN;
            if(BloonBeaconSystem.getInstance().isBeaconActive)
            {
               _clip.gotoAndStop(1);
               _timerField.visible = false;
               _countdownTimer.stop();
            }
            else
            {
               _clip.gotoAndStop(2);
               if(ResourceStore.getInstance().townLevel < BloonBeaconEventManager.UNLOCK_LEVEL)
               {
                  _timerField.visible = false;
                  _countdownTimer.stop();
               }
               else
               {
                  _loc1_ = BloonBeaconSystem.getInstance().eventManager.beaconLastCaptureTime + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
                  _timerField.visible = true;
                  _countdownTimer.setEndTime(_loc1_);
                  _countdownTimer.start();
               }
            }
         },100);
      }
   }
}
