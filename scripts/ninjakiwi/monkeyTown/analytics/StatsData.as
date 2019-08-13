package ninjakiwi.monkeyTown.analytics
{
   import mx.utils.DescribeTypeCache;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.persistence.Persistence;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.mynk.save.TrafficGate;
   
   public class StatsData
   {
      
      private static var instance:StatsData;
       
      
      private var _allStatsData:Object = null;
      
      private var _globalDataIsInitialised:Boolean = false;
      
      private var _cityDataIsInitialised:Boolean = false;
      
      private var _active:Boolean = false;
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      public var totalCashPillaged:INumber;
      
      public var totalMvMRevengeAttacks:INumber;
      
      public var totalMvMDefensiveWins:INumber;
      
      public var totalMvMAttackWins:INumber;
      
      public var globalMvMAttackWinChain:INumber;
      
      public var globalMvMDefensiveWinChain:INumber;
      
      public var tilesCaptured:INumber;
      
      public var waterTilesCaptured:INumber;
      
      public var highGroundTilesCaptured:INumber;
      
      public var treasureChestsCaptured:INumber;
      
      public var contestedTerritoriesParticipated:INumber;
      
      public var contestedTerritoriesWon:INumber;
      
      public var moabsDestroyed:INumber;
      
      public var ddtsDestroyed:INumber;
      
      public var bfbsDestroyed:INumber;
      
      public var zomgsDestroyed:INumber;
      
      public var leadBloonsPopped:INumber;
      
      public var ceramicBloonsPopped:INumber;
      
      public var camoBloonsPopped:INumber;
      
      public var totalBloonsPopped:INumber;
      
      public const specialTerrainsCaptured_DEFAULT:Object = {
         "WattleTrees":false,
         "TranquilGlade":false,
         "Glacier":false,
         "Shipwreck":false,
         "StickySapPlant":false,
         "PhaseCrystal":false,
         "ConsecratedGround":false,
         "MOABGraveyard":false
      };
      
      public var specialTerrainsCaptured:Object;
      
      public var buildingsBuilt_DEFAULT:Object;
      
      public var buildingsBuilt:Object;
      
      public var totalAttackSent:INumber;
      
      public var totalAttackReceived:INumber;
      
      public var quickMatchLaunched:INumber;
      
      public var quickMatchDefended:INumber;
      
      public var quickMatchDefensiveWinChain:INumber;
      
      public var quickMatchDefensiveLoseChain:INumber;
      
      public var quickMatchOffensiveWinChain:INumber;
      
      public var quickMatchOffensiveLoseChain:INumber;
      
      public var hasPurchasedStarterPack:INumber;
      
      private var _trafficGate:TrafficGate;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const CURRENT_DATA_FORMAT_VERSION:int = 2;
      
      private const GLOBAL_COUNTERS:Array = [this.contestedTerritoriesParticipated,this.contestedTerritoriesWon,this.globalMvMAttackWinChain,this.globalMvMDefensiveWinChain,this.moabsDestroyed,this.ddtsDestroyed,this.bfbsDestroyed,this.zomgsDestroyed,this.leadBloonsPopped,this.ceramicBloonsPopped,this.camoBloonsPopped,this.totalBloonsPopped,this.hasPurchasedStarterPack];
      
      public function StatsData(param1:SingletonEnforcer#394)
      {
         this.totalCashPillaged = DancingShadows.getOne();
         this.totalMvMRevengeAttacks = DancingShadows.getOne();
         this.totalMvMDefensiveWins = DancingShadows.getOne();
         this.totalMvMAttackWins = DancingShadows.getOne();
         this.globalMvMAttackWinChain = DancingShadows.getOne();
         this.globalMvMDefensiveWinChain = DancingShadows.getOne();
         this.tilesCaptured = DancingShadows.getOne();
         this.waterTilesCaptured = DancingShadows.getOne();
         this.highGroundTilesCaptured = DancingShadows.getOne();
         this.treasureChestsCaptured = DancingShadows.getOne();
         this.contestedTerritoriesParticipated = DancingShadows.getOne();
         this.contestedTerritoriesWon = DancingShadows.getOne();
         this.moabsDestroyed = DancingShadows.getOne();
         this.ddtsDestroyed = DancingShadows.getOne();
         this.bfbsDestroyed = DancingShadows.getOne();
         this.zomgsDestroyed = DancingShadows.getOne();
         this.leadBloonsPopped = DancingShadows.getOne();
         this.ceramicBloonsPopped = DancingShadows.getOne();
         this.camoBloonsPopped = DancingShadows.getOne();
         this.totalBloonsPopped = DancingShadows.getOne();
         this.specialTerrainsCaptured = this.cloneObject(this.specialTerrainsCaptured_DEFAULT);
         this.buildingsBuilt_DEFAULT = {
            "" + this._buildingData.MONKEY_DART_HALL.id:2,
            "" + this._buildingData.BANANA_FARM.id:1,
            "" + this._buildingData.MONKEY_BANK.id:1,
            "" + this._buildingData.WINDMILL.id:1,
            "" + this._buildingData.MONKEY_TOWN_HALL.id:1
         };
         this.buildingsBuilt = this.cloneObject(this.buildingsBuilt_DEFAULT);
         this.totalAttackSent = DancingShadows.getOne();
         this.totalAttackReceived = DancingShadows.getOne();
         this.quickMatchLaunched = DancingShadows.getOne();
         this.quickMatchDefended = DancingShadows.getOne();
         this.quickMatchDefensiveWinChain = DancingShadows.getOne();
         this.quickMatchDefensiveLoseChain = DancingShadows.getOne();
         this.quickMatchOffensiveWinChain = DancingShadows.getOne();
         this.quickMatchOffensiveLoseChain = DancingShadows.getOne();
         this.hasPurchasedStarterPack = DancingShadows.getOne();
         this._trafficGate = new TrafficGate();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use StatsData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : StatsData
      {
         if(instance == null)
         {
            instance = new StatsData(new SingletonEnforcer#394());
         }
         return instance;
      }
      
      private function get dataIsInitialised() : Boolean
      {
         var _loc1_:Boolean = MonkeySystem.getInstance().map.worldIsReady;
         if(_loc1_)
         {
         }
         return this._globalDataIsInitialised && this._cityDataIsInitialised && _loc1_;
      }
      
      private function set dataIsInitialised(param1:Boolean) : void
      {
         this._globalDataIsInitialised = param1;
         this._cityDataIsInitialised = param1;
      }
      
      private function reset() : void
      {
         var _loc1_:* = null;
         this.resetShadows();
         for(_loc1_ in this.specialTerrainsCaptured)
         {
            if(this.specialTerrainsCaptured[_loc1_] is Boolean)
            {
               this.specialTerrainsCaptured[_loc1_] = false;
            }
         }
         this.dataIsInitialised = false;
      }
      
      public function init() : void
      {
         Persistence.cityLoadBeginSignal.add(this.onCityLoadBegin);
         WorldViewSignals.buildWorldEndSignal.add(this.activate);
         WorldViewSignals.generateNewWorldCompleteSignal.add(this.onCreatedNewCity);
         MonkeyCityMain.globalResetSignal.add(this.reset);
      }
      
      private function onCityLoadBegin(... rest) : void
      {
         this._cityDataIsInitialised = false;
         this.deactivate();
      }
      
      private function onCreatedNewCity(... rest) : void
      {
         if(this._allStatsData !== null)
         {
            this._allStatsData.cityStats = {"v":this.CURRENT_DATA_FORMAT_VERSION};
         }
         this.validateAllStatsData();
         this.dataIsInitialised = true;
      }
      
      public function activate(... rest) : void
      {
         StatsDataManager.getInstance().activate();
         this._active = true;
      }
      
      public function deactivate(... rest) : void
      {
         StatsDataManager.getInstance().deactivate();
         this._active = false;
      }
      
      public function save() : void
      {
         if(!this.dataIsInitialised)
         {
            return;
         }
         if(!this._active)
         {
            return;
         }
         this._trafficGate.callFunction(this.savePostGate);
      }
      
      public function savePostGate() : void
      {
         var _loc1_:Object = null;
         if(!this.dataIsInitialised)
         {
            return;
         }
         _loc1_ = this.getSaveData();
         var _loc2_:Object = _loc1_.globalStats;
         var _loc3_:Object = _loc1_.cityStats;
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.STATS_KEY,_loc2_);
         CityDataPersistence.getInstance().saveValue(CityDataPersistence.CITY_STATS_KEY,_loc3_);
      }
      
      public function resetShadows() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc1_:XMLList = DescribeTypeCache.describeType(this).typeDescription.variable;
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = _loc3_.attribute("name");
            _loc2_ = this[_loc4_];
            if(_loc2_ !== null && _loc2_ is INumber)
            {
               _loc2_.value = 0;
            }
         }
         this.dataIsInitialised = false;
      }
      
      public function isGlobalCounter(param1:*) : Boolean
      {
         var _loc2_:int = this.GLOBAL_COUNTERS.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.GLOBAL_COUNTERS[_loc3_] === param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function validateAllStatsData() : void
      {
         if(this._allStatsData === null)
         {
            this._allStatsData = {
               "globalStats":{},
               "cityStats":{"v":this.CURRENT_DATA_FORMAT_VERSION}
            };
         }
         else
         {
            if(!this._allStatsData.hasOwnProperty("globalStats") || !this._allStatsData.globalStats)
            {
               this._allStatsData.globalStats = {};
            }
            if(!this._allStatsData.hasOwnProperty("cityStats"))
            {
               this._allStatsData.cityStats = {"v":this.CURRENT_DATA_FORMAT_VERSION};
            }
         }
      }
      
      public function getSaveData() : Object
      {
         var _loc2_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc1_:XMLList = DescribeTypeCache.describeType(this).typeDescription.variable;
         var _loc3_:Object = {};
         var _loc4_:Object = {"v":this.CURRENT_DATA_FORMAT_VERSION};
         for each(_loc5_ in _loc1_)
         {
            _loc6_ = _loc5_.attribute("name");
            _loc2_ = this[_loc6_];
            if(_loc2_ !== null && _loc2_ is INumber)
            {
               if(this.isGlobalCounter(_loc2_))
               {
                  _loc3_[_loc6_] = _loc2_.value;
               }
               else
               {
                  _loc4_[_loc6_] = _loc2_.value;
               }
            }
         }
         _loc4_.specialTerrainsCaptured = this.specialTerrainsCaptured;
         _loc4_.buildingsBuilt = this.buildingsBuilt;
         this.validateAllStatsData();
         this._allStatsData.cityStats = _loc4_;
         this._allStatsData.globalStats = _loc3_;
         return this.cloneObject(this._allStatsData);
      }
      
      private function getValueByField(param1:*) : *
      {
         if(param1 is INumber)
         {
            return param1.value;
         }
         return param1;
      }
      
      public function logData(param1:Boolean = true) : void
      {
         var _loc5_:* = undefined;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Object = {"v":this.CURRENT_DATA_FORMAT_VERSION};
         var _loc4_:XMLList = DescribeTypeCache.describeType(this).typeDescription.variable;
         var _loc6_:Boolean = false;
         for each(_loc7_ in _loc4_)
         {
            _loc10_ = _loc7_.attribute("name");
            _loc5_ = this.getValueByField(this[_loc10_]);
            if(_loc5_ !== null)
            {
               _loc6_ = false;
               _loc11_ = 0;
               while(_loc11_ < this.GLOBAL_COUNTERS.length)
               {
                  if(this.GLOBAL_COUNTERS[_loc11_] === _loc5_)
                  {
                     _loc6_ = true;
                  }
                  _loc11_++;
               }
               if(_loc6_)
               {
                  _loc2_[_loc10_] = _loc5_;
               }
               else
               {
                  _loc3_[_loc10_] = _loc5_;
               }
            }
         }
         t.DoNotTrace = true;
         _loc8_ = t.obj(_loc2_);
         _loc9_ = t.obj(_loc3_);
         t.DoNotTrace = false;
         if(param1)
         {
            ErrorReporter.externalLog("Global Stats:");
            ErrorReporter.externalLog(_loc8_);
            ErrorReporter.externalLog("City Stats:");
            ErrorReporter.externalLog(_loc9_);
         }
      }
      
      private function updateDataFormat(param1:Object) : Object
      {
         var _loc5_:* = undefined;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Object = {"v":this.CURRENT_DATA_FORMAT_VERSION};
         var _loc4_:XMLList = DescribeTypeCache.describeType(this).typeDescription.variable;
         var _loc6_:Boolean = false;
         for each(_loc7_ in _loc4_)
         {
            _loc8_ = _loc7_.attribute("name");
            _loc5_ = this[_loc8_];
            if(_loc5_ !== null && param1.hasOwnProperty(_loc8_))
            {
               _loc6_ = false;
               _loc9_ = 0;
               while(_loc9_ < this.GLOBAL_COUNTERS.length)
               {
                  if(this.GLOBAL_COUNTERS[_loc9_] === _loc5_)
                  {
                     _loc6_ = true;
                  }
                  _loc9_++;
               }
               if(_loc6_)
               {
                  _loc2_[_loc8_] = param1[_loc8_];
               }
               else
               {
                  _loc3_[_loc8_] = param1[_loc8_];
               }
            }
         }
         this._allStatsData = {
            "globalStats":_loc2_,
            "cityStats":_loc3_
         };
         return _loc3_;
      }
      
      public function setGlobalSaveData(param1:Object) : void
      {
         this.validateAllStatsData();
         this._allStatsData.globalStats = this.cloneObject(param1);
         this._globalDataIsInitialised = true;
      }
      
      public function setCitySaveData(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         if(param1 == null)
         {
            return;
         }
         if(!param1.hasOwnProperty("v") || param1.v !== 2)
         {
            param1 = this.updateDataFormat(param1);
         }
         else
         {
            this.validateAllStatsData();
            this._allStatsData.cityStats = this.cloneObject(param1);
         }
         var _loc2_:Object = this._allStatsData.globalStats;
         var _loc3_:XMLList = DescribeTypeCache.describeType(this).typeDescription.variable;
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = _loc5_.attribute("name");
            _loc4_ = this[_loc6_];
            if(_loc4_ !== null && _loc4_ is INumber)
            {
               if(param1.hasOwnProperty(_loc6_))
               {
                  this[_loc6_].value = param1[_loc6_];
               }
               else if(_loc2_.hasOwnProperty(_loc6_))
               {
                  this[_loc6_].value = _loc2_[_loc6_];
               }
               else
               {
                  this[_loc6_].value = 0;
               }
            }
         }
         if(param1.hasOwnProperty("specialTerrainsCaptured"))
         {
            this.specialTerrainsCaptured = param1.specialTerrainsCaptured;
         }
         else
         {
            this.specialTerrainsCaptured = this.cloneObject(this.specialTerrainsCaptured_DEFAULT);
         }
         if(param1.hasOwnProperty("buildingsBuilt"))
         {
            this.buildingsBuilt = param1.buildingsBuilt;
         }
         else
         {
            this.buildingsBuilt = this.cloneObject(this.buildingsBuilt_DEFAULT);
         }
         GameSignals.CITY_IS_FINALLY_READY.remove(this.setExtendedStats);
         GameSignals.CITY_IS_FINALLY_READY.add(this.setExtendedStats);
         this._cityDataIsInitialised = true;
      }
      
      public function setExtendedStats() : void
      {
         var totalMvMDefensiveWinsForCityString:String = null;
         var totalMvMDefensiveWinsForCity:int = 0;
         if(null == this._allStatsData || false == this._allStatsData.hasOwnProperty("cityStats"))
         {
            return;
         }
         var cityStats:Object = this._allStatsData.cityStats;
         if(cityStats.hasOwnProperty("totalMvMDefensiveWins"))
         {
            totalMvMDefensiveWinsForCityString = "totalMvMDefensiveWinsCity" + MonkeySystem.getInstance().city.cityIndex.toString();
            totalMvMDefensiveWinsForCity = cityStats.totalMvMDefensiveWins;
            KeyValueStore.getInstance().get(totalMvMDefensiveWinsForCityString,function(param1:int):void
            {
               if(param1 != totalMvMDefensiveWinsForCity)
               {
                  KeyValueStore.getInstance().set(totalMvMDefensiveWinsForCityString,totalMvMDefensiveWinsForCity);
               }
            });
         }
      }
      
      public function hasBuiltBuilding(param1:String) : Boolean
      {
         return this.buildingsBuilt.hasOwnProperty(param1);
      }
      
      private function cloneObject(param1:Object) : Object
      {
         return JSON.parse(JSON.stringify(param1));
      }
   }
}

class SingletonEnforcer#394
{
    
   
   function SingletonEnforcer#394()
   {
      super();
   }
}
