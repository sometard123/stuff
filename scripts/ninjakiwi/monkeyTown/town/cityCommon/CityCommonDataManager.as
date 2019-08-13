package ninjakiwi.monkeyTown.town.cityCommon
{
   import flash.utils.getTimer;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.persistence.Persistence;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import org.osflash.signals.Signal;
   
   public class CityCommonDataManager
   {
      
      public static const onDataSynced:Signal = new Signal();
      
      private static var instance:CityCommonDataManager;
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var slots:Vector.<CityCommonDataSlot>;
      
      private var _currentCitySlot:CityCommonDataSlot = null;
      
      private var _map:TownMap;
      
      private var _timestampOfDataPopulation:int;
      
      private var _slotIndex:Array;
      
      private var _nextAvailableCityIndex:int = 0;
      
      public function CityCommonDataManager(param1:SingletonEnforcer#964)
      {
         this.slots = new Vector.<CityCommonDataSlot>();
         this._slotIndex = [];
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use CityManager.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : CityCommonDataManager
      {
         if(instance == null)
         {
            instance = new CityCommonDataManager(new SingletonEnforcer#964());
         }
         return instance;
      }
      
      public function setMap(param1:TownMap) : void
      {
         this._map = param1;
      }
      
      public function resetCity() : void
      {
         this.slots = new Vector.<CityCommonDataSlot>();
         this._nextAvailableCityIndex = 0;
      }
      
      private function getNewSecureVar(param1:INumber) : void
      {
         if(param1 != null)
         {
            DancingShadows.returnOne(param1);
         }
         param1 = DancingShadows.getOne();
      }
      
      public function createNewCityCommonSlot(param1:String = "New City") : CityCommonDataSlot
      {
         var _loc2_:CityCommonDataSlot = new CityCommonDataSlot();
         _loc2_.bucketID = this.getNextAvailableCityIndex();
         _loc2_.name = param1;
         this.slots.push(_loc2_);
         this._currentCitySlot = _loc2_;
         this.buildSlotIndex();
         return _loc2_;
      }
      
      public function buildSlotIndex() : void
      {
         this._slotIndex.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.slots.length)
         {
            this._slotIndex[this.slots[_loc1_].bucketID] = this.slots[_loc1_];
            _loc1_++;
         }
      }
      
      public function populateFromData(param1:Object) : void
      {
         var _loc3_:CityCommonDataSlot = null;
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new CityCommonDataSlot();
            _loc4_ = param1[_loc2_];
            _loc3_.name = _loc4_.name;
            _loc3_.bucketID = _loc4_.index;
            _loc3_.cityLevel = _loc4_.level;
            _loc3_.incomingAttacks = _loc4_.attacks;
            this.slots.push(_loc3_);
            _loc2_++;
         }
         this._nextAvailableCityIndex = this.slots.length;
         this.buildSlotIndex();
         this._timestampOfDataPopulation = getTimer();
      }
      
      public function getCitySlotClone(param1:int) : CityCommonDataSlot
      {
         if(param1 < 0 || this.slots.length <= param1)
         {
            return null;
         }
         return this.slots[param1].clone();
      }
      
      private function getNextAvailableCityIndex() : int
      {
         return this._nextAvailableCityIndex++;
      }
      
      public function get numberOfCities() : int
      {
         return this.slots.length;
      }
      
      public function get timestampOfDataPopulation() : int
      {
         return this._timestampOfDataPopulation;
      }
      
      public function isCityNameAvailable(param1:String) : Boolean
      {
         var _loc2_:CityCommonDataSlot = null;
         var _loc3_:String = null;
         param1 = param1.toLowerCase();
         var _loc4_:int = 0;
         while(_loc4_ < this.slots.length)
         {
            _loc2_ = this.slots[_loc4_];
            _loc3_ = _loc2_.name.toLowerCase();
            if(_loc3_ === param1)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      private function syncPvPDataCurrentCity(... rest) : void
      {
         this._currentCitySlot = this.slots[this._system.city.cityIndex];
         if(this._currentCitySlot == null)
         {
            return;
         }
         this._currentCitySlot.incomingAttacks = PvPMain.instance.incomingRaids;
      }
      
      public function onCityLoadBeginSignal(param1:CityCommonDataSlot) : void
      {
         this._currentCitySlot = param1;
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.syncPvPDataCurrentCity);
      }
      
      private function onPvPDataUpdatedSignal(... rest) : void
      {
         this.syncPvPDataCurrentCity();
      }
      
      private function onBuildWorldEndSignal(... rest) : void
      {
         this.syncPvPDataCurrentCity();
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onLevelUpdated);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onLevelUpdated);
         this.onLevelUpdated();
         onDataSynced.dispatch();
      }
      
      private function onLevelUpdated(... rest) : void
      {
         this._currentCitySlot.cityLevel = ResourceStore.getInstance().townLevel;
      }
      
      private function init() : void
      {
         Persistence.cityLoadBeginSignal.add(this.onCityLoadBeginSignal);
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEndSignal);
      }
   }
}

class SingletonEnforcer#964
{
    
   
   function SingletonEnforcer#964()
   {
      super();
   }
}
