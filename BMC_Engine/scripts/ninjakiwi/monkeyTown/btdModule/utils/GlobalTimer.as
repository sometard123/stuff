package ninjakiwi.monkeyTown.btdModule.utils
{
   import flash.utils.getTimer;
   
   public class GlobalTimer
   {
      
      private static var instance:GlobalTimer;
       
      
      private var _timerList:Vector.<GlobalTimerObject>;
      
      private var _i:int;
      
      private const TERM:int = 10000;
      
      private var _timeLastUpdated:Number = 0;
      
      private var _currentTime:Number = 0;
      
      private var _expired:Vector.<GlobalTimerObject>;
      
      public function GlobalTimer(param1:SingletonEnforcer#950)
      {
         this._timerList = new Vector.<GlobalTimerObject>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use GlobalTimer.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : GlobalTimer
      {
         if(instance == null)
         {
            instance = new GlobalTimer(new SingletonEnforcer#950());
         }
         return instance;
      }
      
      public function reset() : void
      {
         this._timerList = new Vector.<GlobalTimerObject>();
         this._timeLastUpdated = getTimer();
      }
      
      public function registerTimer(param1:String, param2:int, param3:Function = null) : void
      {
         var _loc4_:GlobalTimerObject = this.getTimerObject(param1);
         if(_loc4_ != null)
         {
            _loc4_.resetTime(param2);
         }
         else
         {
            _loc4_ = new GlobalTimerObject(param1,param2,param3);
            this._timerList.push(_loc4_);
         }
      }
      
      public function deleteTimer(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GlobalTimerObject = this.getTimerObject(param1);
         if(_loc2_ != null)
         {
            _loc3_ = this._timerList.indexOf(_loc2_);
            if(_loc3_ != -1)
            {
               this._timerList.splice(_loc3_,1);
            }
         }
      }
      
      private function getTimerObject(param1:String) : GlobalTimerObject
      {
         this._i = 0;
         while(this._i < this._timerList.length)
         {
            if(param1 == this._timerList[this._i].id)
            {
               return this._timerList[this._i];
            }
            this._i++;
         }
         return null;
      }
      
      public function update() : void
      {
         var _loc1_:GlobalTimerObject = null;
         var _loc2_:int = 0;
         this._currentTime = getTimer();
         if(this._currentTime - this._timeLastUpdated < this.TERM)
         {
            return;
         }
         this._timeLastUpdated = this._currentTime;
         this._expired = new Vector.<GlobalTimerObject>();
         for each(_loc1_ in this._timerList)
         {
            _loc1_.decreaseTime(this.TERM * 0.001);
            if(_loc1_.timeLeft <= 0)
            {
               this._expired.push(_loc1_);
            }
         }
         _loc2_ = 0;
         while(_loc2_ < this._expired.length)
         {
            this.deleteTimer(this._expired[_loc2_].id);
            if(this._expired[_loc2_].callback != null)
            {
               this._expired[_loc2_].callback();
            }
            _loc2_++;
         }
      }
   }
}

class SingletonEnforcer#950
{
    
   
   function SingletonEnforcer#950()
   {
      super();
   }
}
