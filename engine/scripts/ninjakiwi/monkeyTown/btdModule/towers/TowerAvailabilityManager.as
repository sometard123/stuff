package ninjakiwi.monkeyTown.btdModule.towers
{
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import org.osflash.signals.Signal;
   
   public class TowerAvailabilityManager
   {
      
      public static const instance:TowerAvailabilityManager = new TowerAvailabilityManager();
       
      
      private var _towersAvailable:Object;
      
      private var _towerAvailabilityChangeSignals:Object;
      
      public function TowerAvailabilityManager()
      {
         this._towersAvailable = {};
         this._towerAvailabilityChangeSignals = {};
         super();
         TowerPlace.towerPlacedSignal.add(this.onTowerPlacedSignal);
         Level.towerSoldSignal.add(this.onTowerSoldSignal);
      }
      
      public function setup(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:ByteArray = null;
         this._towersAvailable = {};
         for(_loc2_ in param1)
         {
            if(param1[_loc2_].count != null)
            {
               _loc3_ = new ByteArray();
               _loc3_.writeObject(param1[_loc2_]);
               _loc3_.position = 0;
               this._towersAvailable[_loc2_] = _loc3_.readObject();
               if(this._towersAvailable[_loc2_].freeCount == null)
               {
                  this._towersAvailable[_loc2_].freeCount = 0;
               }
               else
               {
                  this._towersAvailable[_loc2_].freeCount = param1[_loc2_].freeCount;
               }
            }
         }
      }
      
      private function onTowerPlacedSignal(param1:Tower) : void
      {
         this.decrementTower(param1.rootID);
      }
      
      private function onTowerSoldSignal(param1:Tower) : void
      {
         if(!param1.isFree)
         {
            this.incrementTower(param1.rootID);
         }
         else
         {
            this.addFreeTower(param1.rootID);
         }
      }
      
      public function getAvailabilityChangeSignal(param1:String) : Signal
      {
         var _loc2_:Signal = this._towerAvailabilityChangeSignals[param1];
         if(_loc2_ === null)
         {
            _loc2_ = this._towerAvailabilityChangeSignals[param1] = new Signal(String,int,int);
         }
         return _loc2_;
      }
      
      private function dispatchTowerAvailabilityChangedSignal(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:Signal = this.getAvailabilityChangeSignal(param1);
         if(_loc4_ !== null)
         {
            _loc4_.dispatch(param1,param2,param3);
         }
      }
      
      public function isTowerAvailable(param1:String) : Boolean
      {
         if(this._towersAvailable[param1] !== undefined)
         {
            if(this._towersAvailable[param1].count > 0 || this._towersAvailable[param1].freeCount > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getNumberOfAvailableTowers(param1:String) : int
      {
         if(this._towersAvailable[param1] !== undefined)
         {
            return int(this._towersAvailable[param1].count) + int(this._towersAvailable[param1].freeCount);
         }
         return 0;
      }
      
      public function getNumberOfFreeTowers(param1:String) : int
      {
         if(this._towersAvailable[param1] !== undefined && this._towersAvailable[param1].freeCount != null)
         {
            return int(this._towersAvailable[param1].freeCount);
         }
         return 0;
      }
      
      public function getNumberOfDamagedTowers(param1:String) : int
      {
         if(this._towersAvailable[param1] !== undefined && this._towersAvailable[param1].damagedCount != null)
         {
            return int(this._towersAvailable[param1].damagedCount);
         }
         return 0;
      }
      
      public function incrementTower(param1:String) : void
      {
         if(this._towersAvailable[param1] !== undefined)
         {
            this._towersAvailable[param1].count++;
            this.dispatchTowerAvailabilityChangedSignal(param1,this._towersAvailable[param1].count,this._towersAvailable[param1].freeCount);
         }
      }
      
      public function decrementTower(param1:String) : void
      {
         if(this._towersAvailable[param1] !== undefined)
         {
            if(this._towersAvailable[param1].freeCount > 0)
            {
               this._towersAvailable[param1].freeCount--;
            }
            else
            {
               this._towersAvailable[param1].count--;
            }
            this.dispatchTowerAvailabilityChangedSignal(param1,this._towersAvailable[param1].count,this._towersAvailable[param1].freeCount);
         }
      }
      
      public function addFreeTower(param1:String) : void
      {
         if(this._towersAvailable[param1] !== undefined)
         {
            this._towersAvailable[param1].freeCount++;
            this.dispatchTowerAvailabilityChangedSignal(param1,this._towersAvailable[param1].count,this._towersAvailable[param1].freeCount);
         }
      }
   }
}
