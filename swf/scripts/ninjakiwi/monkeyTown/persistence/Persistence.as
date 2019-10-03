package ninjakiwi.monkeyTown.persistence
{
   import ninjakiwi.monkeyTown.analytics.StatsData;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.town.data.definitions.CityResourcesSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.ResourceStoreSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestManager;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemStoreSaveDefinition;
   import ninjakiwi.net.WebAction;
   import org.osflash.signals.Signal;
   
   public class Persistence
   {
      
      public static const cityLoadBeginSignal:Signal = new Signal(CityCommonDataSlot);
      
      public static const cityLoadEndSignal:Signal = new Signal(CityCommonDataSlot);
      
      public static const pvpStartupDataLoadedSignal:Signal = new Signal(Object);
      
      private static var instance:Persistence;
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _mapCrypt:LGCryptObject;
      
      private var _townCrypt:LGCryptObject;
      
      private var _nextAvailableBucket:int = 0;
      
      private var _resourceStore:ResourceStore;
      
      private var _nextAvailableCityIndex:int = -1;
      
      private var _coreHasBeenLoaded:Boolean = false;
      
      public function Persistence(param1:SingletonEnforcer#813)
      {
         this._mapCrypt = new LGCryptObject();
         this._townCrypt = new LGCryptObject();
         this._resourceStore = ResourceStore.getInstance();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use Persistence.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : Persistence
      {
         if(instance == null)
         {
            instance = new Persistence(new SingletonEnforcer#813());
         }
         return instance;
      }
      
      public function init() : void
      {
         this._mapCrypt.setData({});
         this._townCrypt.setData({});
         MonkeyCityMain.globalResetSignal.remove(this.onGlobalReset);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalReset);
      }
      
      private function onGlobalReset() : void
      {
         this._coreHasBeenLoaded = false;
      }
      
      public function shakeHandsWithServer(param1:Function) : void
      {
         this._coreHasBeenLoaded = false;
         Kloud.shakeHandsWithServer(param1);
      }
      
      public function loadCityList(param1:Function) : void
      {
         var callback:Function = param1;
         CityCommonDataManager.getInstance().resetCity();
         Kloud.loadCityList(function(param1:Object):void
         {
            if(param1.success === true)
            {
               CityCommonDataManager.getInstance().populateFromData(param1.cityList);
            }
            callback(param1);
         });
      }
      
      public function loadCoreData(param1:Function) : void
      {
         var callback:Function = param1;
         if(this._coreHasBeenLoaded)
         {
            callback();
            return;
         }
         Kloud.loadCoreDataBeginSignal.dispatch();
         Kloud.loadCoreData(function(param1:Object):void
         {
            var _loc2_:Object = null;
            var _loc10_:ResourceStoreSaveDefinition = null;
            _coreHasBeenLoaded = true;
            _loc2_ = param1[CoreDataPersistence.CORE_KEY];
            var _loc3_:Object = !!_loc2_.hasOwnProperty(CoreDataPersistence.RESOURCES_KEY)?_loc2_[CoreDataPersistence.RESOURCES_KEY]:null;
            if(_loc3_)
            {
               if(_loc3_ is CityResourcesSaveDefinition)
               {
                  _loc10_ = new ResourceStoreSaveDefinition();
                  _loc10_.bloontonium = _loc3_.bloontonium;
                  _loc10_.maxCashPillage = _loc3_.maxCashPillage;
                  _loc10_.monkeyMoney = _loc3_.monkeyMoney;
               }
               else
               {
                  _loc10_ = ResourceStoreSaveDefinition(_loc3_);
               }
               ResourceStore.getInstance().populateGlobalResourcesFromSaveDefinition(_loc10_);
            }
            else
            {
               ResourceStore.getInstance().populateGlobalResourcesFromSaveDefinition(null);
            }
            var _loc4_:SpecialItemStoreSaveDefinition = !!_loc2_.hasOwnProperty(CoreDataPersistence.SPECIAL_ITEMS_KEY)?_loc2_[CoreDataPersistence.SPECIAL_ITEMS_KEY]:null;
            SpecialItemStore.getInstance().populateFromSaveDefinition(_loc4_);
            var _loc5_:Object = !!_loc2_.hasOwnProperty(CoreDataPersistence.STATS_KEY)?_loc2_[CoreDataPersistence.STATS_KEY]:null;
            if(_loc5_ !== null)
            {
               StatsData.getInstance().setGlobalSaveData(_loc5_);
            }
            var _loc6_:Object = !!_loc2_.hasOwnProperty(CoreDataPersistence.TUTORIAL_KEY)?_loc2_[CoreDataPersistence.TUTORIAL_KEY]:null;
            FirstTimeTriggerManager.getInstance().setSaveData(_loc6_);
            var _loc7_:Object = !!_loc2_.hasOwnProperty(CoreDataPersistence.PREFERENCES_KEY)?_loc2_[CoreDataPersistence.PREFERENCES_KEY]:null;
            if(_loc7_ !== null)
            {
               Preferences.populateFromData(_loc7_);
            }
            var _loc8_:Object = !!param1.hasOwnProperty(CoreDataPersistence.CRATES_KEY)?param1[CoreDataPersistence.CRATES_KEY]:null;
            if(_loc8_)
            {
               CrateManager.getInstance().setData(_loc8_);
            }
            var _loc9_:Object = !!param1.hasOwnProperty(CoreDataPersistence.MONKEY_KNOWLEDGE_KEY)?param1[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY]:null;
            if(_loc9_)
            {
               MonkeyKnowledge.getInstance().populateFromSaveData(_loc9_);
            }
            pvpStartupDataLoadedSignal.dispatch(null);
            callback();
         });
      }
      
      public function loadCity(param1:CityCommonDataSlot, param2:Function) : void
      {
         var slot:CityCommonDataSlot = param1;
         var callback:Function = param2;
         cityLoadBeginSignal.dispatch(slot);
         Kloud.loadCity(slot.bucketID,function(param1:Object):void
         {
            var contentObject:Object = null;
            var questData:Object = null;
            var response:Object = param1;
            if(response.success)
            {
               contentObject = response.content;
               if(contentObject[CityDataPersistence.CITY_RESOURCES_KEY])
               {
                  ResourceStore.getInstance().populateCityResourcesFromSaveDefinition(CityResourcesSaveDefinition(contentObject.cityResources));
               }
               else
               {
                  ResourceStore.getInstance().populateCityResourcesFromSaveDefinition(null);
               }
               if(contentObject[CityDataPersistence.CITY_STATS_KEY])
               {
                  StatsData.getInstance().setCitySaveData(contentObject[CityDataPersistence.CITY_STATS_KEY]);
               }
               if(contentObject[CityDataPersistence.CITY_QUESTS_KEY])
               {
                  questData = Squeeze.derialiseAndDecompress(contentObject[CityDataPersistence.CITY_QUESTS_KEY]);
                  QuestManager.getInstance().populateFromSaveData(questData);
               }
               CityLoadHandler.regenerateCity(response,function():void
               {
                  cityLoadEndSignal.dispatch(slot);
               });
            }
            if(callback !== null)
            {
               callback();
            }
         });
      }
      
      function saveTile(param1:Tile) : void
      {
         var _loc2_:Array = [param1];
         CityDataPersistence.getInstance().saveValue(CityDataPersistence.TILES_KEY,_loc2_);
      }
      
      function saveGlobalResources() : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.RESOURCES_KEY,this._resourceStore.getGlobalResourcesSaveDefinition());
      }
      
      function saveCityResources() : void
      {
         CityDataPersistence.getInstance().saveValue(CityDataPersistence.CITY_RESOURCES_KEY,this._resourceStore.getCityResourcesSaveDefinition());
      }
      
      public function deleteSaveData() : void
      {
         Kloud.deleteAllDataForUser();
      }
      
      public function loadCityData(param1:CityCommonDataSlot, param2:Function) : void
      {
      }
      
      public function saveCityByDefinition(param1:CityCommonDataSlot, param2:City, param3:TownMapSaveDefinition, param4:Function) : void
      {
      }
      
      public function invalidateSession() : void
      {
         WebAction.invalidateSession();
      }
      
      public function get nextAvailableCityIndex() : int
      {
         return this._nextAvailableCityIndex;
      }
   }
}

class SingletonEnforcer#813
{
    
   
   function SingletonEnforcer#813()
   {
      super();
   }
}
