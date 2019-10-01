package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   
   public class PvPTimerManager
   {
      
      private static var instance:PvPTimerManager;
       
      
      private var _timerList:Vector.<PvPTimerObject>;
      
      private const TERM:int = 5000;
      
      private var _timeLastUpdated:Number = 0;
      
      private var _currentTime:Number = 0;
      
      private var _expired:Vector.<PvPTimerObject>;
      
      public function PvPTimerManager(param1:SingletonEnforcer#1187)
      {
         this._timerList = new Vector.<PvPTimerObject>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use PvPTimeManager.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      public static function getInstance() : PvPTimerManager
      {
         if(instance == null)
         {
            instance = new PvPTimerManager(new SingletonEnforcer#1187());
         }
         return instance;
      }
      
      private function onReset() : void
      {
         this._timerList = new Vector.<PvPTimerObject>();
      }
      
      public function registerTimer(param1:String, param2:int, param3:Function = null) : void
      {
         var _loc4_:PvPTimerObject = this.getTimer(param1);
         if(_loc4_ != null)
         {
            _loc4_.resetTime(param2);
         }
         else
         {
            _loc4_ = new PvPTimerObject(param1,param2,param3);
            this._timerList.push(_loc4_);
         }
      }
      
      public function deleteTimer(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PvPTimerObject = this.getTimer(param1);
         if(_loc2_ != null)
         {
            _loc3_ = this._timerList.indexOf(_loc2_);
            if(_loc3_ != -1)
            {
               this._timerList.splice(_loc3_,1);
            }
         }
      }
      
      public function getTimer(param1:String) : PvPTimerObject
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._timerList.length)
         {
            if(param1 == this._timerList[_loc2_].id)
            {
               return this._timerList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function update() : void
      {
         var _loc1_:PvPTimerObject = null;
         var _loc2_:int = 0;
         this._currentTime = MonkeySystem.getInstance().getSecureTime();
         if(this._currentTime - this._timeLastUpdated < this.TERM)
         {
            return;
         }
         this._timeLastUpdated = this._currentTime;
         this._expired = new Vector.<PvPTimerObject>();
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

class SingletonEnforcer#1187
{
    
   
   function SingletonEnforcer#1187()
   {
      super();
   }
}
