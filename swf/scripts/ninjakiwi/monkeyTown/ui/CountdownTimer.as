package ninjakiwi.monkeyTown.ui
{
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.utils.DateTool;
   
   public class CountdownTimer
   {
       
      
      private var _targetTextField:TextField;
      
      private var _endTime:Number;
      
      private var timer:Timer;
      
      public function CountdownTimer(param1:TextField, param2:Number)
      {
         this.timer = new Timer(1000);
         super();
         this._targetTextField = param1;
         this._endTime = param2;
         this.update();
      }
      
      public function setEndTime(param1:Number) : void
      {
         this._endTime = param1;
         this.update();
      }
      
      public function setTextfield(param1:TextField) : void
      {
         this._targetTextField = param1;
         this.update();
      }
      
      public function update(param1:TimerEvent = null) : Boolean
      {
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         if(_loc2_ > this._endTime)
         {
            this._targetTextField.text = "Finished";
            this.stop();
            return false;
         }
         var _loc3_:Number = this._endTime - _loc2_;
         var _loc4_:String = DateTool.getTimeStringFromUnixTime(_loc3_);
         this._targetTextField.text = _loc4_;
         return true;
      }
      
      public function start() : void
      {
         this.timer.addEventListener(TimerEvent.TIMER,this.update);
         this.timer.reset();
         this.timer.start();
         this.update();
      }
      
      public function stop() : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER,this.update);
         this.timer.stop();
      }
   }
}
