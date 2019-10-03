package ninjakiwi.monkeyTown.town.ui.clock
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.ISimulateClickable;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class Clock extends Sprite implements ISimulateClickable
   {
      
      public static const skippedSignal:PrioritySignal = new PrioritySignal();
       
      
      public var timeOfLastUpdate:Number = -1;
      
      public var manager:ClockManager = null;
      
      public var positionOnMap:LGVector2D;
      
      public var target:Building;
      
      public var onUpdateSignal:Signal;
      
      public var onCompleteSignal:Signal;
      
      protected var _progress:Number = 0;
      
      protected var _clip:MovieClip;
      
      protected var _totalTime:int = 10000;
      
      protected var _timeStarted:Number = -1;
      
      protected var _callbackOnCompleteFunction:Function;
      
      protected var _completeNowPopup:CompleteNowPopup;
      
      private var _lock:Boolean = false;
      
      protected const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function Clock(param1:ClockManager, param2:Function, param3:Building, param4:int)
      {
         var manager:ClockManager = param1;
         var callbackOnCompleteFunction:Function = param2;
         var target:Building = param3;
         var totalDuration:int = param4;
         this.positionOnMap = new LGVector2D();
         this.onUpdateSignal = new Signal();
         this.onCompleteSignal = new Signal();
         super();
         if(this._clip == null)
         {
            this._clip = new ClockClip();
         }
         this.manager = manager;
         this.target = target;
         this.totalSeconds = totalDuration * 60;
         this._callbackOnCompleteFunction = callbackOnCompleteFunction;
         this._timeStarted = this._system.getSecureTime();
         this.timeOfLastUpdate = this._timeStarted;
         manager.addClock(this);
         this.initFinishNowPopup();
         this._clip.timeField.text = this.getTimeString(this._timeStarted);
         addChild(this._clip);
         this._clip.addEventListener(MouseEvent.CLICK,function onClick(param1:MouseEvent):void
         {
            if(MonkeyCityMain.getInstance().mouseManager.state)
            {
               simulateClick();
            }
         });
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      public function get timeText() : String
      {
         return this._clip.timeField.text;
      }
      
      protected function initFinishNowPopup() : void
      {
         this._completeNowPopup = new CompleteNowPopup(this._clip);
         addChild(this._completeNowPopup);
      }
      
      protected function onRollover(param1:MouseEvent) : void
      {
      }
      
      protected function onRollout(param1:MouseEvent) : void
      {
      }
      
      public function simulateClick() : void
      {
      }
      
      public function set totalSeconds(param1:Number) : void
      {
         this._totalTime = param1 * 1000;
      }
      
      public function get progress() : Number
      {
         return this._progress;
      }
      
      public function syncPositionToTarget() : void
      {
         var _loc1_:Number = int(this._system.TOWN_GRID_UNIT_SIZE * 0.5);
         x = this.target.mapCoordinates.x * this._system.TOWN_GRID_UNIT_SIZE + _loc1_ * this.target.definition.width;
         y = this.target.mapCoordinates.y * this._system.TOWN_GRID_UNIT_SIZE + _loc1_ * this.target.definition.height - _loc1_ * 0.5;
      }
      
      public function update(param1:Number, param2:Number = 1.0) : void
      {
         var _loc5_:Number = NaN;
         param1 = this._system.getSecureTime();
         var _loc3_:Number = (param1 - this._timeStarted) * param2;
         var _loc4_:Number = this._totalTime - _loc3_;
         if(_loc4_ < 0 || this._totalTime < 0)
         {
            _loc5_ = _loc4_ < 0?Number(Math.abs(_loc4_)):Number(0);
            this.completed(_loc5_);
            return;
         }
         if(this._totalTime > 0)
         {
            this._progress = _loc3_ / this._totalTime;
         }
         else
         {
            this._progress = 0;
         }
         this._clip.gotoAndStop(Math.ceil(this._progress * this._clip.totalFrames));
         this._clip.timeField.text = this.getTimeString(param1,param2);
         this.onUpdateSignal.dispatch();
      }
      
      public function getTimeString(param1:Number, param2:Number = 1.0) : String
      {
         var _loc12_:* = null;
         var _loc3_:Number = (param1 - this._timeStarted) * param2;
         var _loc4_:Number = this._totalTime - _loc3_;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:int = _loc4_ / 1000;
         var _loc6_:Number = _loc5_ % 60;
         var _loc7_:Number = Math.floor(_loc5_ % 3600 / 60);
         var _loc8_:Number = Math.floor(_loc5_ / (60 * 60));
         var _loc9_:String = _loc8_ == 0?"":this.zeroPad(_loc8_,2);
         var _loc10_:String = this.zeroPad(_loc7_,2);
         var _loc11_:String = this.zeroPad(_loc6_,2);
         if(_loc8_ > 0)
         {
            _loc12_ = _loc9_ + "h " + _loc10_ + "m";
         }
         else if(_loc7_ > 0)
         {
            _loc12_ = _loc10_ + ":" + _loc11_;
         }
         else
         {
            _loc12_ = _loc11_ + "s";
         }
         return _loc12_;
      }
      
      public function zeroPad(param1:int, param2:int) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      private function completed(param1:Number, param2:Boolean = true) : void
      {
         if(this.isLocked())
         {
            return;
         }
         this._lock = true;
         if(param1 > 0)
         {
         }
         if(this._callbackOnCompleteFunction != null)
         {
            this._callbackOnCompleteFunction(param1);
         }
         this.onCompleteSignal.dispatch();
         this.manager.killClock(this,param2);
      }
      
      public function getSaveDefinition() : ClockSaveDefinition
      {
         var _loc1_:ClockSaveDefinition = new ClockSaveDefinition();
         _loc1_.timeElapsed = this._system.getSecureTime() - this._timeStarted;
         _loc1_.timeOfLastUpdate = this.timeOfLastUpdate;
         return _loc1_;
      }
      
      public function populateFromSaveDefinition(param1:ClockSaveDefinition) : void
      {
         this._timeStarted = param1.timeOfLastUpdate - param1.timeElapsed;
         this.timeOfLastUpdate = param1.timeOfLastUpdate;
         var _loc2_:Number = this._system.getSecureTime();
         var _loc3_:Number = _loc2_ - this._timeStarted;
         var _loc4_:Number = this._totalTime - _loc3_;
         if(_loc4_ <= 0)
         {
            this.visible = false;
         }
      }
      
      public function getBloonstonesRequiredToSkip() : Number
      {
         var _loc15_:Number = NaN;
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:Number = _loc1_ - this._timeStarted;
         var _loc3_:Number = this._totalTime - _loc2_;
         var _loc4_:Number = _loc3_ / 1000 / 60;
         var _loc5_:int = 30;
         var _loc6_:int = 90;
         var _loc7_:int = 240;
         var _loc8_:int = _loc5_;
         var _loc9_:int = _loc5_ + _loc6_;
         var _loc10_:int = _loc5_ + _loc6_ + _loc7_;
         var _loc11_:int = 1;
         var _loc12_:int = 3;
         var _loc13_:int = 6;
         var _loc14_:int = 12;
         if(_loc4_ < _loc8_)
         {
            _loc15_ = _loc4_;
         }
         else if(_loc4_ < _loc9_)
         {
            _loc15_ = _loc5_ / _loc11_ + (_loc4_ - _loc5_) / _loc12_;
         }
         else if(_loc4_ < _loc10_)
         {
            _loc15_ = _loc5_ / _loc11_ + _loc6_ / _loc12_ + (_loc4_ - (_loc5_ + _loc6_)) / _loc13_;
         }
         else
         {
            _loc15_ = _loc5_ / _loc11_ + _loc6_ / _loc12_ + _loc7_ / _loc13_ + (_loc4_ - (_loc5_ + _loc6_ + _loc7_)) / _loc14_;
         }
         return Math.ceil(_loc15_);
      }
      
      public function setSkipCostText(param1:int) : void
      {
         this._completeNowPopup.setCost(param1);
      }
      
      public function skip() : void
      {
         if(this.isLocked())
         {
            return;
         }
         skippedSignal.dispatch();
         this.completed(0);
      }
      
      private function onReset() : void
      {
         if(this.manager != null)
         {
            this.manager.killClock(this,false);
         }
      }
      
      public function isLocked() : Boolean
      {
         return this._lock;
      }
   }
}
