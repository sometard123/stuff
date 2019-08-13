package ninjakiwi.monkeyTown.analytics
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import org.osflash.signals.Signal;
   
   public class IdleTracker
   {
      
      private static var _isIdle:Boolean = false;
      
      public static const enterActiveSignal:Signal = new Signal(Number);
      
      public static const enterIdleSignal:Signal = new Signal(Number);
       
      
      private var _stage:Stage = null;
      
      private var _lastActiveTime:Number = 0;
      
      private var _enteredActiveTime:Number = 0;
      
      private var _enteredIdleTime:Number = 0;
      
      private var _lastTestTime:Number = 0;
      
      private const TEST_FREQUENCY:Number = 10000.0;
      
      private const IDLE_TIMEOUT:Number = 600000.0;
      
      private const timer:Timer = new Timer(this.TEST_FREQUENCY,0);
      
      public function IdleTracker(param1:Stage)
      {
         super();
         this._stage = param1;
         this.init();
      }
      
      public static function get isIdle() : Boolean
      {
         return _isIdle;
      }
      
      private function init() : void
      {
         this._lastActiveTime = getTimer();
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.timer.addEventListener(TimerEvent.TIMER,this.update);
         this.timer.start();
      }
      
      private function update(param1:TimerEvent) : void
      {
         var _loc2_:Number = getTimer();
         if(!_isIdle && _loc2_ - this._lastTestTime > this.TEST_FREQUENCY)
         {
            this.checkForIdle(_loc2_);
         }
      }
      
      private function checkForIdle(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(param1 - this._lastActiveTime > this.IDLE_TIMEOUT)
         {
            _isIdle = true;
            this._enteredIdleTime = param1;
            _loc2_ = param1 - this._enteredActiveTime;
            enterIdleSignal.dispatch(_loc2_);
         }
      }
      
      private function resetIdleTime() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = getTimer();
         if(_isIdle)
         {
            _loc2_ = _loc1_ - this._enteredIdleTime;
            this._enteredActiveTime = _loc1_;
            enterActiveSignal.dispatch(_loc2_);
         }
         this._lastActiveTime = _loc1_;
         _isIdle = false;
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         this.resetIdleTime();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.resetIdleTime();
      }
   }
}
