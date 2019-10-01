package ninjakiwi.monkeyTown.utils
{
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class SoftProcess
   {
       
      
      private var _processFunction:Function;
      
      private var _completeFunction:Function;
      
      private var _maxTimePerChunk:int;
      
      private var _paused:Boolean = false;
      
      private var _thisArg;
      
      private var _completeThisArg;
      
      private var _timeRunBegan:Number;
      
      private var _index:int = 0;
      
      public function SoftProcess()
      {
         super();
      }
      
      public function run(param1:Function, param2:*, param3:int = 1000, param4:Function = null, param5:* = null) : void
      {
         this._index = 0;
         this._timeRunBegan = getTimer();
         this._processFunction = param1;
         this._maxTimePerChunk = param3;
         this._completeFunction = param4;
         this._completeThisArg = param5;
         this._thisArg = param2;
         this.nextProcessChunk();
      }
      
      private function nextProcessChunk() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Boolean = true;
         var _loc2_:int = getTimer();
         var _loc3_:int = 0;
         while(true)
         {
            if(_loc1_)
            {
               if(this._paused)
               {
                  break;
               }
               _loc3_ = getTimer() - _loc2_;
               if(_loc3_ <= this._maxTimePerChunk)
               {
                  _loc1_ = this._processFunction.call(this._thisArg);
                  this._index++;
                  continue;
               }
            }
            if(_loc1_)
            {
               this.yield(this.nextProcessChunk);
            }
            else
            {
               _loc4_ = getTimer() - this._timeRunBegan;
               if(this._completeFunction !== null)
               {
                  if(this._completeThisArg != null)
                  {
                     this._completeFunction.call(this._completeThisArg);
                  }
                  else
                  {
                     this._completeFunction();
                  }
               }
            }
            return;
         }
      }
      
      public function set paused(param1:Boolean) : void
      {
         this._paused = param1;
         if(this._paused == false)
         {
            this.nextProcessChunk();
         }
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      private function yield(param1:Function) : void
      {
         setTimeout(param1,0);
      }
   }
}
