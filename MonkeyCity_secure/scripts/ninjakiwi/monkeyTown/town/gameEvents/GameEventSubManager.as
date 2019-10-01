package ninjakiwi.monkeyTown.town.gameEvents
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.utils.DateTool;
   import org.osflash.signals.Signal;
   
   public class GameEventSubManager
   {
       
      
      public const persistentDataChangedSignal:Signal = new Signal();
      
      public const gameplayEvents:Vector.<GameplayEvent> = new Vector.<GameplayEvent>();
      
      private const _onEventBecomesActiveCallbacks:Array = [];
      
      private const _onEventBecomesActiveTimer:Timer = new Timer(100,1);
      
      private const _onCurrentEventEndsCallbacks:Array = [];
      
      private const _onCurrentEventEndsTimer:Timer = new Timer(10000,1);
      
      private var _eventWaitingToEnd:GameplayEvent = null;
      
      public function GameEventSubManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._onEventBecomesActiveTimer.addEventListener(TimerEvent.TIMER,this.onEventBecomesActiveTimer);
         this._onCurrentEventEndsTimer.addEventListener(TimerEvent.TIMER,this.onCurrentEventEnds);
      }
      
      public function get typeID() : String
      {
         return "not set for: " + getQualifiedClassName(this);
      }
      
      public function addEvent(param1:GameplayEvent) : void
      {
         this.gameplayEvents.push(param1);
      }
      
      public function clear(param1:GameplayEvent) : void
      {
         this.gameplayEvents.length = 0;
      }
      
      public function setPersistentData(param1:Object) : void
      {
      }
      
      public function getPersistentData() : Object
      {
         return null;
      }
      
      protected function save() : void
      {
         this.persistentDataChangedSignal.dispatch();
      }
      
      public function findCurrentEvent() : GameplayEvent
      {
         var _loc2_:GameplayEvent = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.gameplayEvents.length)
         {
            _loc2_ = this.gameplayEvents[_loc1_];
            if(DateTool.timeRangeIsCurrent(_loc2_.startTime,_loc2_.endTime))
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function findNextEvent() : GameplayEvent
      {
         var _loc3_:GameplayEvent = null;
         var _loc1_:GameplayEvent = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.gameplayEvents.length)
         {
            _loc3_ = this.gameplayEvents[_loc2_];
            if(DateTool.timeIsInFuture(_loc3_.startTime) && (_loc1_ == null || _loc1_.endTime < _loc3_.endTime))
            {
               _loc1_ = _loc3_;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function callWhenNextEventBecomesActive(param1:Function) : Boolean
      {
         var _loc2_:GameplayEvent = this.findNextEvent();
         if(_loc2_ !== null)
         {
            if(this._onEventBecomesActiveCallbacks.indexOf(param1) === -1)
            {
               this._onEventBecomesActiveCallbacks.push(param1);
            }
            this.startEventActivateTimer(_loc2_.startTime);
            return true;
         }
         return false;
      }
      
      private function startEventActivateTimer(param1:Number) : void
      {
         var _loc2_:Number = param1 - MonkeySystem.getInstance().getSecureTime();
         if(_loc2_ >= 0)
         {
            this._onEventBecomesActiveTimer.reset();
            this._onEventBecomesActiveTimer.delay = _loc2_ + 100;
            this._onEventBecomesActiveTimer.repeatCount = 1;
            this._onEventBecomesActiveTimer.start();
         }
      }
      
      private function onEventBecomesActiveTimer(param1:TimerEvent) : void
      {
         var _loc4_:GameplayEvent = null;
         var _loc2_:GameplayEvent = this.findCurrentEvent();
         if(_loc2_ === null)
         {
            _loc4_ = this.findNextEvent();
            if(_loc4_ !== null)
            {
               this.startEventActivateTimer(_loc4_.startTime);
            }
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._onEventBecomesActiveCallbacks.length)
         {
            this._onEventBecomesActiveCallbacks[_loc3_](_loc2_,this);
            _loc3_++;
         }
         this._onEventBecomesActiveCallbacks.length = 0;
      }
      
      public function callWhenCurrentEventEnds(param1:Function) : Boolean
      {
         var _loc2_:GameplayEvent = this.findCurrentEvent();
         if(_loc2_ !== null)
         {
            if(this._onCurrentEventEndsCallbacks.indexOf(param1) === -1)
            {
               this._onCurrentEventEndsCallbacks.push(param1);
            }
            this.startEventEndsTimer(_loc2_.endTime);
            this._eventWaitingToEnd = _loc2_;
            return true;
         }
         return false;
      }
      
      private function startEventEndsTimer(param1:Number) : void
      {
         var _loc2_:Number = param1 - MonkeySystem.getInstance().getSecureTime();
         if(_loc2_ >= 0)
         {
            this._onCurrentEventEndsTimer.reset();
            this._onCurrentEventEndsTimer.delay = _loc2_ + 100;
            this._onCurrentEventEndsTimer.repeatCount = 1;
            this._onCurrentEventEndsTimer.start();
         }
      }
      
      private function onCurrentEventEnds(param1:TimerEvent) : void
      {
         var _loc2_:GameplayEvent = this.findCurrentEvent();
         if(_loc2_ === this._eventWaitingToEnd)
         {
            this.startEventEndsTimer(this._eventWaitingToEnd.endTime);
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._onCurrentEventEndsCallbacks.length)
         {
            this._onCurrentEventEndsCallbacks[_loc3_](this._eventWaitingToEnd,this);
            _loc3_++;
         }
         this._onCurrentEventEndsCallbacks.length = 0;
      }
   }
}
