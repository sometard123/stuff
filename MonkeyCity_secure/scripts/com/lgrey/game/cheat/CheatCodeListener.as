package com.lgrey.game.cheat
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class CheatCodeListener
   {
      
      public static const cheatDetectedSignal:Signal = new Signal(String);
      
      private static const _KEY_BUFFER_LENGTH:uint = 16;
       
      
      private var _stage:Stage;
      
      private var _cheatCodes:Array;
      
      private var _keyBuffer:Array;
      
      private var _keyLogPosition:uint = 0;
      
      private var _checkCounter:int = 0;
      
      private var _callbacks:Dictionary;
      
      public function CheatCodeListener(param1:Stage)
      {
         this._cheatCodes = [];
         this._keyBuffer = [];
         this._callbacks = new Dictionary();
         super();
         this._stage = param1;
         this._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
      }
      
      public function registerCheatCode(param1:String, param2:Function = null) : void
      {
         this._cheatCodes.push(param1);
         if(param2 != null)
         {
            this._callbacks[param1] = param2;
         }
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         this.logKey(String.fromCharCode(param1.keyCode).toLowerCase());
         this.checkForCheats();
      }
      
      private function checkTimerHandler(param1:TimerEvent) : void
      {
         this.checkForCheats();
      }
      
      private function init(param1:Stage) : void
      {
      }
      
      private function logKey(param1:String) : void
      {
         this._keyBuffer[this._keyLogPosition] = param1;
         this._keyLogPosition++;
         this._keyLogPosition = this.wrapIndex(this._keyLogPosition);
      }
      
      private function checkForCheats() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc7_:Boolean = true;
         var _loc9_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._cheatCodes.length)
         {
            _loc3_ = this._cheatCodes[_loc1_].length;
            _loc9_ = 0;
            _loc8_ = this._cheatCodes[_loc1_];
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.wrapIndex(this._keyLogPosition - _loc3_ + _loc2_);
               _loc5_ = _loc8_.charAt(_loc2_);
               _loc6_ = this._keyBuffer[_loc4_];
               if(_loc5_ == _loc6_)
               {
                  _loc9_++;
               }
               if(_loc9_ == _loc3_)
               {
                  this.cheatDetected(_loc8_);
                  this.clearBuffer();
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function cheatDetected(param1:String) : void
      {
         cheatDetectedSignal.dispatch(param1);
         var _loc2_:Function = this._callbacks[param1];
         if(_loc2_ != null)
         {
            _loc2_.call();
         }
      }
      
      private function clearBuffer() : void
      {
         this._keyBuffer = [];
      }
      
      private function wrapIndex(param1:int) : uint
      {
         while(param1 >= _KEY_BUFFER_LENGTH)
         {
            param1 = param1 - _KEY_BUFFER_LENGTH;
         }
         while(param1 < 0)
         {
            param1 = param1 + _KEY_BUFFER_LENGTH;
         }
         return param1;
      }
   }
}
