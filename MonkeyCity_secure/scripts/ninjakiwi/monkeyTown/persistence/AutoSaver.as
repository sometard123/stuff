package ninjakiwi.monkeyTown.persistence
{
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.net.kloud.CityDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.city.CityInfoSaveDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.BuildingPlacer;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMainSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestManager;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemStoreSaveDefinition;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import org.osflash.signals.Signal;
   
   public class AutoSaver
   {
      
      private static var instance:AutoSaver;
       
      
      private var _persistence:Persistence;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _monkeyCityMainSignals:MonkeyCityMainSignals;
      
      private var _resourceStore:ResourceStore;
      
      private var _keyValueStore:KeyValueStore;
      
      private var _state:Boolean = false;
      
      private var _registeredSignals:Vector.<RegisteredSignal>;
      
      public function AutoSaver(param1:SingletonEnforcer#939)
      {
         this._persistence = Persistence.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         this._keyValueStore = KeyValueStore.getInstance();
         this._registeredSignals = new Vector.<RegisteredSignal>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use AutoSaver.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : AutoSaver
      {
         if(instance == null)
         {
            instance = new AutoSaver(new SingletonEnforcer#939());
         }
         return instance;
      }
      
      public function init(param1:MonkeyCityMainSignals) : void
      {
         this._monkeyCityMainSignals = param1;
         MonkeyCityMain.globalResetSignal.add(this.reset);
         this.registerSignal(Tile.tileChangedSignal,this.onTileChanged);
         this.registerSignal(BuildingPlacer.buildingWasPlacedForTheFirstTimeSignal,this.onBuildingWasPlacedSignal);
         this.registerSignal(Building.buildingWasCompletedForFirstTimeSignal,this.onBuildingWasCompletedSignal);
         this.registerSignal(Building.buildingWasDemolishedSignal,this.onBuildingWasDemolished);
         this.registerSignal(GameSignals.BUILDING_UPGRADE_COMPLETE,this.onBuildingUpgradeComplete);
         this.registerSignal(UpgradeSignals.upgradePurchased,this.onUpgradesChanged);
         this.registerSignal(UpgradeSignals.pathWarmupComplete,this.onUpgradesChanged);
         this.registerSignal(UpgradeSignals.bloonResearchLabUpgradePurchased,this.onUpgradesChanged);
         this.registerSignal(UpgradeSignals.bloonResearchLabUpgradeComplete,this.onUpgradesChanged);
         this.registerSignal(this._monkeyCityMainSignals.btdGameWonSignal,this.onBTDGameWonSignal);
         this.registerSignal(this._resourceStore.globalResourcesChangedSignal,this.onGlobalResourcesChanged);
         this.registerSignal(this._resourceStore.cityResourcesChangedSignal,this.onCityResourcesChanged);
         this.registerSignal(this._keyValueStore.dataHasChangedSignal,this.onKeyValueStoreDataChanged);
         this.registerSignal(SpecialItemStore.specialItemsStateChanged,this.onSpecialItemsStateChanged);
         this.registerSignal(City.cityInfoChanged,this.onCityInfoChanged);
         this.registerSignal(QuestManager.questsStateChanged,this.onQuestsStateChanged);
         this.registerSignal(FirstTimeTriggerManager.tutorialStateChanged,this.onTutorialStateChanged);
         this.on();
      }
      
      private function reset() : void
      {
      }
      
      private function registerSignal(param1:Signal, param2:Function) : void
      {
         this._registeredSignals.push(new RegisteredSignal(param1,param2));
      }
      
      private function addListeners() : void
      {
         var _loc1_:RegisteredSignal = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._registeredSignals.length)
         {
            _loc1_ = this._registeredSignals[_loc2_];
            _loc1_.activate();
            _loc2_++;
         }
      }
      
      private function removeListeners() : void
      {
         var _loc1_:RegisteredSignal = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._registeredSignals.length)
         {
            _loc1_ = this._registeredSignals[_loc2_];
            _loc1_.deactivate();
            _loc2_++;
         }
      }
      
      public function on() : void
      {
         if(this._state === false)
         {
            this.addListeners();
         }
         this._state = true;
      }
      
      public function off() : void
      {
         if(this._state === true)
         {
            this.removeListeners();
         }
         this._state = false;
      }
      
      private function onGlobalResourcesChanged(... rest) : void
      {
         this.saveGlobalResources();
      }
      
      private function onCityResourcesChanged(... rest) : void
      {
         this.saveCityResources();
      }
      
      private function onKeyValueStoreDataChanged(... rest) : void
      {
         this.saveKeyValueStore();
      }
      
      private function onCityInfoChanged(... rest) : void
      {
         this.saveCityInfo(this._system.city.getCityInfoSaveDefinition());
      }
      
      private function onBTDGameWonSignal() : void
      {
      }
      
      private function onBuildingWasDemolished(param1:Building, param2:Boolean) : void
      {
         this.saveTile(param1.homeTile);
      }
      
      private function onBuildingWasCompletedSignal(param1:Building) : void
      {
         this.saveTile(param1.homeTile);
      }
      
      private function onBuildingWasPlacedSignal(param1:Building) : void
      {
         this.saveTile(param1.homeTile);
      }
      
      private function onTileChanged(param1:Tile) : void
      {
         this.saveTile(param1);
      }
      
      private function onBuildingUpgradeComplete(param1:UpgradeableBuilding) : void
      {
         this.saveTile(param1.homeTile);
      }
      
      private function onUpgradesChanged(... rest) : void
      {
         this.saveUpgrades(this._system.city.upgradeTree.getSaveData());
      }
      
      private function onTutorialStateChanged() : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.TUTORIAL_KEY,FirstTimeTriggerManager.getInstance().getSaveData());
      }
      
      private function onQuestsStateChanged() : void
      {
         this.saveQuests(QuestManager.getInstance().getSaveData());
      }
      
      private function onSpecialItemsStateChanged() : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.SPECIAL_ITEMS_KEY,SpecialItemStore.getInstance().getSaveDefinition());
      }
      
      private function saveTile(param1:Tile) : void
      {
         if(!this._system.map.worldIsReady)
         {
            return;
         }
         this._persistence.saveTile(param1);
      }
      
      private function saveGlobalResources() : void
      {
         this._persistence.saveGlobalResources();
      }
      
      private function saveCityResources() : void
      {
         this._persistence.saveCityResources();
      }
      
      private function saveKeyValueStore() : void
      {
         Kloud.saveKeyValueStore(this._keyValueStore.getSaveData(),function(param1:Object):void
         {
         });
      }
      
      private function saveUpgrades(param1:Object) : void
      {
         CityDataPersistence.getInstance().saveValue(CityDataPersistence.UPGRADE_TREE_KEY,param1);
      }
      
      private function saveTutorial(param1:Object) : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.TUTORIAL_KEY,param1);
      }
      
      private function saveQuests(param1:Object) : void
      {
         CityDataPersistence.getInstance().saveValue(CityDataPersistence.CITY_QUESTS_KEY,param1);
      }
      
      private function saveCityInfo(param1:CityInfoSaveDefinition) : void
      {
         var cityInfo:CityInfoSaveDefinition = param1;
         Kloud.saveCityInfo(cityInfo,function():void
         {
         });
      }
      
      private function saveSpecialItemsStore(param1:SpecialItemStoreSaveDefinition) : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.SPECIAL_ITEMS_KEY,param1);
      }
   }
}

class SingletonEnforcer#939
{
    
   
   function SingletonEnforcer#939()
   {
      super();
   }
}

import org.osflash.signals.Signal;

class RegisteredSignal
{
    
   
   private var _signal:Signal;
   
   private var _callbackFunction:Function;
   
   private var _active:Boolean = false;
   
   function RegisteredSignal(param1:Signal, param2:Function)
   {
      super();
      this._signal = param1;
      this._callbackFunction = param2;
   }
   
   public function activate() : void
   {
      if(this._active)
      {
         return;
      }
      this._signal.add(this._callbackFunction);
      this._active = true;
   }
   
   public function deactivate() : void
   {
      if(!this._active)
      {
         return;
      }
      this._signal.remove(this._callbackFunction);
      this._active = false;
   }
}
