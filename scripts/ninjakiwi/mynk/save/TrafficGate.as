package ninjakiwi.mynk.save
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.analytics.ErrorMessageTracking;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.pvp.TimeUntilPacifistTracker;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.callback;
   import ninjakiwi.monkeyTown.userServices.kong.urlLoader;
   import org.osflash.signals.Signal;
   
   public class TrafficGate
   {
      
      private static const flushAllSignal:Signal = new Signal();
       
      
      private var _gateGroups:Dictionary;
      
      public function TrafficGate()
      {
         this._gateGroups = new Dictionary();
         super();
         flushAllSignal.add(this.flush);
      }
      
      public static function flushAll() : void
      {
         flushAllSignal.dispatch();
      }
      
      public function callFunction(param1:Function, ... rest) : void
      {
         this.createGate(param1,KeyClass,rest);
      }
      
      public function callFunctionForTarget(param1:Function, param2:*, ... rest) : void
      {
         this.createGate(param1,param2,rest);
      }
      
      private function createGate(param1:Function, param2:*, param3:Array) : void
      {
         var _loc4_:Dictionary = this._gateGroups[param1];
         if(_loc4_ === null)
         {
            this._gateGroups[param1] = _loc6_;
            _loc4_ = _loc6_;
         }
         var _loc5_:GatedFunction = _loc4_[param2];
         if(_loc5_ === null)
         {
            _loc5_ = new GatedFunction(param1);
            _loc4_[param2] = _loc5_;
         }
         _loc5_.callFunction(param3);
      }
      
      public function clear() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:GatedFunction = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for(_loc3_ in this._gateGroups)
         {
            _loc1_ = this._gateGroups[_loc3_];
            for(_loc4_ in _loc1_)
            {
               _loc2_ = _loc1_[_loc4_];
               _loc2_.clear();
               delete _loc1_[_loc4_];
            }
            delete this._gateGroups[_loc3_];
         }
      }
      
      public function flush() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:GatedFunction = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for(_loc3_ in this._gateGroups)
         {
            _loc1_ = this._gateGroups[_loc3_];
            for(_loc4_ in _loc1_)
            {
               _loc2_ = _loc1_[_loc4_];
               if(_loc2_.timer.running)
               {
                  _loc2_.timer.stop();
                  _loc2_.onTimer();
               }
            }
         }
         this.clear();
      }
   }
}

import flash.events.TimerEvent;
import flash.utils.Timer;

class GatedFunction
{
    
   
   private var delayBeforeSaveLong:int = 4000;
   
   private var delayBeforeSaveShort:int = 3000;
   
   private var _function:Function;
   
   private var _arguments:Array = null;
   
   private var _isWaiting:Boolean = false;
   
   private var _timer:Timer;
   
   public var targetKey;
   
   function GatedFunction(param1:Function)
   {
      super();
      this._function = param1;
      this.init();
   }
   
   private function init() : void
   {
      this._timer = new Timer(this.delayBeforeSaveShort,1);
      this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
   }
   
   public function callFunction(param1:Array) : void
   {
      this._arguments = param1;
      if(this._isWaiting)
      {
         this.timer.delay = this.delayBeforeSaveLong;
      }
      else
      {
         this.wait();
      }
   }
   
   public function wait() : void
   {
      this.timer.reset();
      this.timer.delay = this.delayBeforeSaveShort;
      this.timer.start();
      this._isWaiting = true;
   }
   
   public function onTimer(... rest) : void
   {
      this._function.apply(null,this._arguments);
      this._isWaiting = false;
      this._arguments = null;
   }
   
   public function clear() : void
   {
      this._function = null;
      this._arguments = null;
      this._isWaiting = false;
      this.timer.reset();
      this._timer = null;
      this.targetKey = null;
   }
   
   public function get timer() : Timer
   {
      return this._timer;
   }
}

class KeyClass
{
    
   
   function KeyClass()
   {
      super();
   }
}
