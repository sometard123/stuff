package ninjakiwi.monkeyTown.ui
{
   import assets.ui.ShutdownOverlayClip;
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.net.RequestQueuer;
   
   public class ShutDownOverlay extends Sprite
   {
       
      
      private var _clip:ShutdownOverlayClip;
      
      private const PING_FREQUENCY:Number = 30000.0;
      
      private var _timeToPing:Number = 30000.0;
      
      private var _timeOfLastTimerUpdate:Number = 30000.0;
      
      private var pingTimer:Timer;
      
      private var _isActive:Boolean = false;
      
      public function ShutDownOverlay()
      {
         this._clip = new ShutdownOverlayClip();
         this.pingTimer = new Timer(100);
         super();
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this.pingTimer.addEventListener(TimerEvent.TIMER,this.updatePingCounter);
         RequestQueuer.shutDownSignal.add(this.onShutDownSignal);
         MonkeySystem.getInstance().flashStage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize();
         this.hideSpinner();
         this.alpha = 0;
      }
      
      private function onShutDownSignal() : void
      {
         if(this._isActive)
         {
            return;
         }
         this._isActive = true;
         RequestQueuer.statusOKSignal.add(this.close);
         Main.instance.topLevelUIContainer.addChild(this);
         TweenLite.to(this,0.4,{"alpha":1});
         this._clip.counterField.visible = false;
         this._clip.counterField.text = "";
         this._clip.messageField.text = "Please wait while we save your data...";
         this.showSpinner();
         setTimeout(this.postSavePeriod,10000);
      }
      
      private function postSavePeriod() : void
      {
         if(Main.instance.returnToHomeScreenLocked)
         {
            setTimeout(this.postSavePeriod,2000);
            return;
         }
         this._clip.messageField.text = "The game session will now end...";
         setTimeout(this.endSession,3000);
      }
      
      private function endSession() : void
      {
         Main.instance.returnToHomeScreen();
         setTimeout(this.startPingPhase,3000);
      }
      
      private function startPingPhase() : void
      {
         this._clip.messageField.text = "Checking for end of Maintenance in...";
         this.startPingCountdown();
      }
      
      private function hideSpinner() : void
      {
         this._clip.spinner.stop();
         this._clip.spinner.visible = false;
      }
      
      private function showSpinner() : void
      {
         this._clip.counterField.text = "";
         this._clip.counterField.visible = false;
         this._clip.spinner.play();
         this._clip.spinner.visible = true;
      }
      
      private function startPingCountdown() : void
      {
         this._timeToPing = this.PING_FREQUENCY;
         this._timeOfLastTimerUpdate = getTimer();
         this.pingTimer.reset();
         this.pingTimer.start();
         this.hideSpinner();
      }
      
      private function stopPingCountdown() : void
      {
         this.pingTimer.stop();
         this.pingTimer.reset();
      }
      
      private function updatePingCounter(param1:TimerEvent) : void
      {
         var _loc2_:Number = getTimer();
         var _loc3_:Number = _loc2_ - this._timeOfLastTimerUpdate;
         this._timeToPing = this._timeToPing - _loc3_;
         this.hideSpinner();
         this._clip.counterField.visible = true;
         this._clip.counterField.text = Math.floor(Math.max(this._timeToPing / 1000,0)).toString();
         if(this._timeToPing <= 0)
         {
            this.stopPingCountdown();
            this.ping();
         }
         this._timeOfLastTimerUpdate = _loc2_;
      }
      
      private function ping() : void
      {
         this.showSpinner();
         this._clip.messageField.text = "Checking server status...";
         Kloud.checkStatus(function(param1:Object):void
         {
            if(false === param1.hasOwnProperty("status") || param1.status !== "shutdown")
            {
               close();
            }
            else
            {
               startPingPhase();
            }
         });
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc2_:Stage = MonkeySystem.getInstance().flashStage;
         if(_loc2_ !== null)
         {
            this.x = int(_loc2_.stageWidth * 0.5);
            this.y = int(_loc2_.stageHeight * 0.5);
            this._clip.background.width = _loc2_.stageWidth * 1.3;
            this._clip.background.height = _loc2_.stageHeight * 1.3;
         }
      }
      
      private function close() : void
      {
         var that:ShutDownOverlay = null;
         this._isActive = false;
         RequestQueuer.statusOKSignal.remove(this.close);
         that = this;
         TweenLite.to(this,0.5,{
            "alpha":0,
            "onComplete":function():void
            {
               if(that.parent && that.parent.contains(that))
               {
                  that.parent.removeChild(that);
               }
            }
         });
      }
   }
}
