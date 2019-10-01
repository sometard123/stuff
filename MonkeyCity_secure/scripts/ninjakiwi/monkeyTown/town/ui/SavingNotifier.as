package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.SavingNotificationClip;
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import ninjakiwi.net.RequestQueuer;
   import org.osflash.signals.Signal;
   
   public class SavingNotifier extends Sprite
   {
      
      private static var notifierOnSignal:Signal = new Signal();
      
      private static var notifierOffSignal:Signal = new Signal();
      
      private static var trafficGateOnSignal:Signal = new Signal();
      
      private static var trafficGateOffSignal:Signal = new Signal();
       
      
      private var _stage:Stage;
      
      private var _clip:SavingNotificationClip;
      
      private var _requestCount:int = 0;
      
      private var _isInCity:Boolean = true;
      
      private var _isGatingTraffic:Boolean = false;
      
      public function SavingNotifier()
      {
         this._clip = new SavingNotificationClip();
         super();
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            this._clip.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         RequestQueuer.executingSaveRequestSignal.add(this.onRequestBegin);
         RequestQueuer.endedSaveRequestSignal.add(this.onRequestEnd);
         SavingNotifier.notifierOnSignal.add(this.onRequestBegin);
         SavingNotifier.notifierOffSignal.add(this.onRequestEnd);
         SavingNotifier.trafficGateOnSignal.add(this.onTrafficGateOn);
         SavingNotifier.trafficGateOffSignal.add(this.onTrafficGateOff);
         TransitionSignals.beganLoadingBTDGame.add(this.onBeginLoadingBTD);
         TransitionSignals.endTransitionFromBTDToCity.add(this.onReturnToCity);
         this.alpha = 0;
      }
      
      public static function triggerOn() : void
      {
         notifierOnSignal.dispatch();
      }
      
      public static function triggerOff() : void
      {
         notifierOffSignal.dispatch();
      }
      
      public static function trafficGateOn() : void
      {
         trafficGateOnSignal.dispatch();
      }
      
      public static function trafficGateOff() : void
      {
         trafficGateOffSignal.dispatch();
      }
      
      private function onBeginLoadingBTD() : void
      {
         this._isInCity = false;
         this.resize();
      }
      
      private function onReturnToCity() : void
      {
         this._isInCity = true;
         this.resize();
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         this._clip.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = this._clip.stage;
         this._stage.addEventListener(Event.RESIZE,this.resize);
         this.resize();
      }
      
      private function onRequestBegin() : void
      {
         this._requestCount++;
         this.reveal();
      }
      
      public function onRequestEnd() : void
      {
         this._requestCount--;
         if(this._requestCount === 0 && CoreDataPersistence.getInstance().isSaving == false && CityDataPersistence.getInstance().isSaving == false)
         {
            this.hide();
         }
      }
      
      private function onTrafficGateOn() : void
      {
         this.reveal();
      }
      
      private function onTrafficGateOff() : void
      {
         if(this._requestCount === 0 && CoreDataPersistence.getInstance().isSaving == false && CityDataPersistence.getInstance().isSaving == false)
         {
            this.hide();
         }
      }
      
      private function resize(param1:Event = null) : void
      {
         if(this._isInCity)
         {
            x = 4;
            y = 65;
         }
         else
         {
            x = 4;
            y = 5;
         }
      }
      
      public function reveal() : void
      {
         addChild(this._clip);
         this._clip.animation.play();
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.3,{"alpha":1});
      }
      
      public function hide() : void
      {
         var that:SavingNotifier = null;
         that = this;
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.3,{
            "alpha":0,
            "delay":0.2,
            "onComplete":function():void
            {
               if(that.contains(_clip))
               {
                  removeChild(_clip);
               }
               _clip.animation.stop();
            }
         });
      }
   }
}
