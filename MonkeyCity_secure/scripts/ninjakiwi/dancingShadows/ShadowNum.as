package ninjakiwi.dancingShadows
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   final class ShadowNum implements INumber
   {
      
      static const MODIFIED:String = "braap braap";
      
      static const alarm:EventDispatcher = new EventDispatcher();
      
      private static const BYTE_LENGTH:int = 8;
      
      private static const _instances:Array = [];
      
      private static const _copies:Array = [];
      
      private static const _delayedCopies:Array = [];
      
      private static const _binaryDiffs:Array = [];
      
      private static const _oldValueBytes:ByteArray = new ByteArray();
      
      private static const _newValueBytes:ByteArray = new ByteArray();
      
      private static const _shuffleTimer:Timer = new Timer(100);
      
      {
         _shuffleTimer.addEventListener(TimerEvent.TIMER,testAndShuffle);
         _shuffleTimer.start();
      }
      
      private var currentValue:Number = 0;
      
      private var copyIndex:int = 0;
      
      private var scratchBytes1:ByteArray;
      
      private var scratchBytes2:ByteArray;
      
      function ShadowNum(param1:Number = 0)
      {
         this.scratchBytes1 = new ByteArray();
         this.scratchBytes2 = new ByteArray();
         super();
         addInstance(this);
         this.value = param1;
      }
      
      private static function testAndShuffle(param1:TimerEvent = null) : void
      {
         var _loc3_:ShadowNum = null;
         var _loc4_:Number = NaN;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         for each(_loc3_ in _instances)
         {
            _loc4_ = _copies[_loc3_.copyIndex];
            if(_loc4_ != _loc3_.currentValue)
            {
               _loc2_ = true;
            }
            _oldValueBytes.position = 0;
            _newValueBytes.position = 0;
            _oldValueBytes.writeDouble(_delayedCopies[_loc3_.copyIndex]);
            _loc5_ = _binaryDiffs[_loc3_.copyIndex];
            _loc6_ = 0;
            while(_loc6_ < BYTE_LENGTH)
            {
               _newValueBytes[_loc6_] = _oldValueBytes[_loc6_] ^ _loc5_[_loc6_];
               _loc6_++;
            }
            if(_loc3_.currentValue != _newValueBytes.readDouble())
            {
               _loc2_ = true;
            }
            _delayedCopies[_loc3_.copyIndex] = _loc3_.currentValue;
            _copies[_loc3_.copyIndex] = _loc3_.currentValue;
            _loc5_.position = 0;
            _loc5_.writeDouble(0);
            if(--_loc3_.copyIndex < 0)
            {
               _loc3_.copyIndex = _instances.length - 1;
            }
         }
         _copies.push(_copies.shift());
         _delayedCopies.push(_delayedCopies.shift());
         _binaryDiffs.push(_binaryDiffs.shift());
         if(_loc2_)
         {
            alarm.dispatchEvent(new Event(MODIFIED));
         }
      }
      
      private static function addInstance(param1:ShadowNum) : void
      {
         var _loc2_:int = _instances.length;
         param1.copyIndex = _loc2_;
         _instances[_loc2_] = param1;
         _copies[_loc2_] = param1.currentValue;
         _delayedCopies[_loc2_] = param1.currentValue;
         _binaryDiffs[_loc2_] = new ByteArray();
         ByteArray(_binaryDiffs[_loc2_]).length = BYTE_LENGTH;
      }
      
      public function get value() : Number
      {
         return this.currentValue;
      }
      
      public function set value(param1:Number) : void
      {
         var _loc2_:Number = _delayedCopies[this.copyIndex];
         this.writeBinaryDiff(_loc2_,param1,_binaryDiffs[this.copyIndex]);
         this.currentValue = param1;
         _copies[this.copyIndex] = param1;
      }
      
      private function writeBinaryDiff(param1:Number, param2:Number, param3:ByteArray) : void
      {
         this.scratchBytes1.position = 0;
         this.scratchBytes2.position = 0;
         this.scratchBytes1.writeDouble(param1);
         this.scratchBytes2.writeDouble(param2);
         var _loc4_:int = 0;
         while(_loc4_ < BYTE_LENGTH)
         {
            param3[_loc4_] = this.scratchBytes1[_loc4_] ^ this.scratchBytes2[_loc4_];
            _loc4_++;
         }
      }
   }
}
