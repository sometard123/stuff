package ninjakiwi.monkeyTown.town.city
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.BankManager;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.BloontoniumStorageTankManager;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.PowerSourceManager;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.SpecialBuildingManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.bananaFarm.BananaFarmStatsManager;
   import ninjakiwi.monkeyTown.town.ui.bloontoniumGenerator.BloontoniumStatsManager;
   import ninjakiwi.monkeyTown.town.ui.clock.BuildClockManager;
   import ninjakiwi.monkeyTown.town.ui.clock.DamageClockManager;
   import ninjakiwi.monkeyTown.town.ui.clock.UpgradeBuildingWarmupClockManager;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import org.osflash.signals.Signal;
   
   public class City
   {
      
      public static const cityInfoChanged:Signal = new Signal();
      
      public static const cityInfoLoaded:Signal = new Signal();
       
      
      private var _xp:INumber;
      
      private var _xpDebt:INumber;
      
      public var name:String = "Unnamed City";
      
      public var upgradeTree:UpgradeTree;
      
      public var buildingManager:BuildingManager;
      
      public var specialBuildingManager:SpecialBuildingManager;
      
      public var bananaFarmStatsManager:BananaFarmStatsManager;
      
      public var bloontoniumStatsManager:BloontoniumStatsManager;
      
      public var buildClockManager:BuildClockManager;
      
      public var damageClockManager:DamageClockManager;
      
      public var upgradeBuildingWarmupClockManager:UpgradeBuildingWarmupClockManager;
      
      public var cityIndex:int = -1;
      
      public var contestedTerritoryData:Object;
      
      public var bankManager:BankManager;
      
      public var powerSourceManager:PowerSourceManager;
      
      public var bloontoniumStorageTankManager:BloontoniumStorageTankManager;
      
      private var _upgradeData:UpgradeData;
      
      protected var _cityCommonDataManager:CityCommonDataManager;
      
      public function City(param1:DisplayObjectContainer, param2:int)
      {
         this._xp = DancingShadows.getOne();
         this._xpDebt = DancingShadows.getOne();
         this.upgradeTree = new UpgradeTree();
         this.buildingManager = new BuildingManager();
         this.specialBuildingManager = new SpecialBuildingManager();
         this.bananaFarmStatsManager = new BananaFarmStatsManager();
         this.bloontoniumStatsManager = new BloontoniumStatsManager();
         this.bankManager = new BankManager();
         this.powerSourceManager = new PowerSourceManager();
         this.bloontoniumStorageTankManager = new BloontoniumStorageTankManager();
         this._upgradeData = UpgradeData.getInstance();
         this._cityCommonDataManager = CityCommonDataManager.getInstance();
         super();
         this.buildClockManager = new BuildClockManager(WorldView.overlayContainerFlash);
         this.damageClockManager = new DamageClockManager(WorldView.overlayContainerFlash);
         this.upgradeBuildingWarmupClockManager = new UpgradeBuildingWarmupClockManager(WorldView.overlayContainerFlash);
         this.upgradeTree.initialiseWithDefaults();
         this.cityIndex = param2;
      }
      
      public function tick() : void
      {
         this.bloontoniumStatsManager.tick();
         this.buildClockManager.process();
         this.damageClockManager.process();
         this.upgradeBuildingWarmupClockManager.process();
         this.bananaFarmStatsManager.tick();
         this.upgradeTree.tick();
      }
      
      public function clear() : void
      {
         this._xpDebt.value = 0;
         this._xp.value = 0;
         this.contestedTerritoryData = null;
         this.buildingManager.clear();
         this.specialBuildingManager.clear();
         this.bankManager.clear();
         this.bloontoniumStorageTankManager.clear();
         this.bloontoniumStatsManager.clear();
         this.bananaFarmStatsManager.clear();
         this.powerSourceManager.clear();
         this.buildClockManager.clear();
         this.damageClockManager.clear();
         this.upgradeBuildingWarmupClockManager.clear();
         this.upgradeTree.clear();
      }
      
      public function clearUpgradeTree() : void
      {
         this.upgradeTree.clear();
      }
      
      public function getCityInfoSaveDefinition() : CityInfoSaveDefinition
      {
         var _loc1_:CityInfoSaveDefinition = new CityInfoSaveDefinition();
         _loc1_.cityIndex = this.cityIndex;
         _loc1_.name = this.name;
         _loc1_.xp = this._xp.value;
         _loc1_.xpDebt = this._xpDebt.value;
         _loc1_.cityLevel = ResourceStore.getInstance().townLevel;
         _loc1_.honour = ResourceStore.getInstance().honour;
         return _loc1_;
      }
      
      public function getSaveData() : CitySaveDefinition
      {
         var _loc1_:CitySaveDefinition = new CitySaveDefinition();
         _loc1_.xp = this._xp.value;
         _loc1_.xpDebt = this._xpDebt.value;
         _loc1_.upgradeTree = this.upgradeTree.getSaveData();
         return _loc1_;
      }
      
      public function populateFromSaveData(param1:CityInfoSaveDefinition, param2:Object) : void
      {
         this.clear();
         this._xpDebt.value = param1.xpDebt;
         this._xp.value = param1.xp;
         ResourceStore.getInstance().xpDebt = this._xpDebt.value;
         ResourceStore.getInstance().setXPNoAward(this._xp.value);
         ResourceStore.getInstance().setHonour(param1.honour,true,false,false);
         if(param2 !== null)
         {
            this.upgradeTree.populateFromSaveData(param2);
         }
         else
         {
            this.upgradeTree.initialiseWithDefaults();
         }
         cityInfoLoaded.dispatch();
      }
      
      public function get xp() : Number
      {
         return int(this._xp.value);
      }
      
      public function set xp(param1:Number) : void
      {
         this._xp.value = param1;
      }
      
      public function get xpDebt() : Number
      {
         return int(this._xpDebt.value);
      }
      
      public function set xpDebt(param1:Number) : void
      {
         this._xpDebt.value = param1;
      }
   }
}
