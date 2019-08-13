package ninjakiwi.monkeyTown.town.buildings
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BananaFarmBuilding;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileFactory;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import ninjakiwi.monkeyTown.utils.SoftProcess;
   
   public class BuildingFactory
   {
      
      private static var instance:BuildingFactory;
       
      
      private var _buildingData:BuildingData;
      
      private var _tileFacfory:TileFactory;
      
      private var _config:ConfigData;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _upgradeData:UpgradeData;
      
      private var _resourceStore:ResourceStore;
      
      public function BuildingFactory(param1:SingletonEnforcer#956)
      {
         this._buildingData = BuildingData.getInstance();
         this._tileFacfory = TileFactory.getInstance();
         this._config = ConfigData.getInstance();
         this._upgradeData = UpgradeData.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use BuildingData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : BuildingFactory
      {
         if(instance == null)
         {
            instance = new BuildingFactory(new SingletonEnforcer#956());
         }
         return instance;
      }
      
      private function init() : void
      {
      }
      
      public function getBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null) : Building
      {
         var _loc5_:BitClipCustom = null;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:Boolean = false;
         var _loc16_:int = 0;
         var _loc17_:UpgradeDefinition = null;
         var _loc18_:UpgradeStateDefinition = null;
         var _loc3_:Class = Building;
         if(param2 === null)
         {
            param2 = this._system.city;
         }
         if(param1 === null)
         {
            return null;
         }
         if(param1.customClass != null)
         {
            _loc3_ = param1.customClass;
         }
         var _loc4_:Building = new _loc3_(param1,param2);
         var _loc7_:int = param1.graphicsClasses.length / (param1.height * param1.width);
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         var _loc8_:int = param2.upgradeTree.getBuildingUpgradeIndex(param1.upgrades);
         var _loc9_:int = param2.upgradeTree.getHighestTierLevelForUpgrades(param1.upgrades);
         var _loc10_:int = 0;
         while(_loc10_ < _loc7_)
         {
            _loc11_ = 0;
            while(_loc11_ < param1.height)
            {
               _loc12_ = 0;
               while(_loc12_ < param1.width)
               {
                  if(param1.graphicsClasses[_loc6_] == undefined)
                  {
                     _loc13_ = "MissingTile";
                  }
                  else
                  {
                     _loc13_ = param1.graphicsClasses[_loc6_];
                  }
                  if(_loc13_ == "")
                  {
                     _loc13_ = "BuildingPlaceholder";
                  }
                  _loc14_ = -1;
                  if(param1.animationDelays && param1.animationDelays[_loc6_ % param1.animationDelays.length])
                  {
                     _loc14_ = param1.animationDelays[_loc6_ % param1.animationDelays.length];
                  }
                  _loc15_ = true;
                  if(_loc4_.definition.buildingCategory === this._buildingData.BASE_BUILDING)
                  {
                     if(_loc8_ != _loc10_)
                     {
                        _loc15_ = false;
                     }
                     else
                     {
                        _loc15_ = true;
                     }
                  }
                  if(_loc4_.definition.buildingCategory === this._buildingData.UPGRADE_BUILDING)
                  {
                     if(_loc9_ != _loc10_)
                     {
                        _loc15_ = false;
                     }
                     else
                     {
                        _loc15_ = true;
                     }
                  }
                  if(_loc4_.definition === this._buildingData.PORT)
                  {
                     _loc15_ = true;
                  }
                  if(_loc15_)
                  {
                     _loc4_.addClipByClassName("assets.tiles." + _loc13_,false,_loc14_);
                  }
                  else
                  {
                     _loc4_.addClipByClassName("assets.tiles.WarningTile",false,_loc14_);
                  }
                  if(param1.groundGraphicsClasses != null)
                  {
                     if(param1.groundGraphicsClasses[_loc6_] == undefined)
                     {
                        _loc13_ = "MissingTile";
                     }
                     else
                     {
                        _loc13_ = param1.groundGraphicsClasses[_loc6_];
                     }
                     _loc4_.addGroundClipByClassName("assets.tiles." + _loc13_,false);
                  }
                  _loc6_++;
                  _loc12_++;
               }
               _loc11_++;
            }
            _loc10_++;
         }
         if(param1.buildingCategory == this._buildingData.UPGRADE_BUILDING)
         {
            _loc16_ = 0;
            while(_loc16_ < param1.upgrades.length)
            {
               _loc17_ = this._upgradeData.getUpgradeDefinitionByID(param1.upgrades[_loc16_]);
               _loc18_ = this._system.city.upgradeTree.getUpgradeStateDefinition(_loc17_.id);
               if(_loc18_.path1.unlockedTo == 0)
               {
                  _loc18_.path1.unlockedTo = 1;
               }
               if(_loc18_.path2.unlockedTo == 0)
               {
                  _loc18_.path2.unlockedTo = 1;
               }
               _loc16_++;
            }
         }
         return _loc4_;
      }
      
      public function getBuildingFromBuildingSaveDefinition(param1:BuildingSaveDefinition, param2:City, param3:int) : Building
      {
         var _loc4_:Building = this.getBuilding(this._buildingData.getBuildingDefinitionByID(param1.id),param2);
         _loc4_.buildOrderForType = param3;
         _loc4_.populateFromSaveDefinition(param1);
         return _loc4_;
      }
      
      public function addTestBuildings(param1:TownMap) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IntPoint2D = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc3_ = 0;
            while(_loc3_ < this._system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               _loc4_ = new IntPoint2D(_loc3_,_loc2_);
               this.getBuilding(this._buildingData.WINDMILL).setPosition(_loc4_.x,_loc4_.y).placeOnMap(param1,false).skipBuildClock();
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function addInitialVillage(param1:TownMap) : void
      {
         var _loc4_:int = 0;
         var _loc2_:IntPoint2D = new IntPoint2D(this._system.VILLAGE_POSITION_X,this._system.VILLAGE_POSITION_Y);
         this.getBuilding(this._buildingData.WINDMILL).setPosition(_loc2_.x,_loc2_.y).placeOnMap(param1,false).skipBuildClock();
         this.getBuilding(this._buildingData.MONKEY_DART_HALL).setPosition(_loc2_.x + 1,_loc2_.y).placeOnMap(param1,false).skipBuildClock();
         this.getBuilding(this._buildingData.MONKEY_DART_HALL).setPosition(_loc2_.x + 2,_loc2_.y).placeOnMap(param1,false).skipBuildClock();
         this.getBuilding(this._buildingData.MONKEY_TOWN_HALL).setPosition(_loc2_.x,_loc2_.y + 1).placeOnMap(param1,false).skipBuildClock();
         var _loc3_:BananaFarmBuilding = BananaFarmBuilding(this.getBuilding(this._buildingData.BANANA_FARM));
         _loc3_.setPosition(_loc2_.x + 1,_loc2_.y + 1).placeOnMap(param1,false).skipBuildClock();
         _loc3_.monkeyMoney = this._config.firstBananaFarmStartingMoney;
         _loc3_.statsView.update(this._system.getSecureTime());
         this.getBuilding(this._buildingData.MONKEY_BANK).setPosition(_loc2_.x,_loc2_.y + 2).placeOnMap(param1,false).skipBuildClock();
      }
      
      public function claimLandAroundVillage(param1:TownMap, param2:IntPoint2D) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            param1.claimTerritory(param2.x - 2 + _loc3_,param2.y - 2);
            param1.claimTerritory(param2.x - 2 + _loc3_,param2.y + 2);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            param1.claimTerritory(param2.x - 2,param2.y - 1 + _loc3_);
            param1.claimTerritory(param2.x + 2,param2.y - 1 + _loc3_);
            _loc3_++;
         }
      }
      
      public function getPossibleBuildingCount(param1:MonkeyTownBuildingDefinition) : int
      {
         var _loc2_:int = this._resourceStore.townLevel;
         var _loc3_:int = param1.levelsPerBuild;
         var _loc4_:int = param1.numberAllowedAtMonkeyTownLevel1;
         var _loc5_:int = param1.minimumMonkeyTownLevel;
         if(_loc3_ == 0)
         {
            return _loc4_ + 1;
         }
         if(_loc2_ <= 1)
         {
            return _loc4_;
         }
         if(_loc2_ < _loc5_)
         {
            return _loc4_;
         }
         if(_loc2_ == _loc5_)
         {
            return _loc4_ + 1;
         }
         var _loc6_:int = _loc2_ - _loc5_;
         if(_loc5_ == 1 && _loc3_ > 1 && _loc4_ > 0)
         {
            _loc6_ = _loc6_ + 1;
         }
         var _loc7_:int = _loc6_ / _loc3_;
         if(_loc5_ != 1)
         {
            _loc7_ = _loc7_ + 1;
         }
         return _loc4_ + _loc7_;
      }
      
      public function levelNeededToBuild(param1:MonkeyTownBuildingDefinition) : int
      {
         var _loc2_:int = this._system.city.buildingManager.getBuildingCount(param1.id);
         var _loc3_:int = param1.levelsPerBuild;
         var _loc4_:int = param1.numberAllowedAtMonkeyTownLevel1;
         var _loc5_:int = param1.minimumMonkeyTownLevel;
         if(_loc2_ + 1 <= _loc4_)
         {
            return 1;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(_loc3_ == 1)
         {
            _loc7_ = _loc5_ + (_loc2_ + 1 - _loc4_) * _loc3_;
         }
         else
         {
            if(_loc4_ > 0)
            {
               _loc6_ = _loc3_;
            }
            if(_loc6_ > 0 && _loc5_ == 1)
            {
               _loc5_ = 0;
            }
            if(_loc5_ == 1 && _loc4_ == 0)
            {
               _loc4_--;
            }
            _loc7_ = _loc5_ + (_loc2_ + 1 - _loc4_ - 1) * _loc3_ + _loc6_;
         }
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         return _loc7_;
      }
      
      public function isAvailableToBuild(param1:MonkeyTownBuildingDefinition) : Boolean
      {
         var _loc2_:BuildingAvailabilityReport = new BuildingAvailabilityReport(param1,false);
         return _loc2_.available;
      }
      
      public function getAvailableBuildings(param1:Array) : Object
      {
         var _loc3_:MonkeyTownBuildingDefinition = null;
         var _loc2_:Boolean = false;
         param1 = this._buildingData.resourceBuildingDefinitions;
         var _loc4_:Object = {
            "available":[],
            "unavailable":[]
         };
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_];
            _loc2_ = this.isAvailableToBuild(_loc3_);
            if(_loc2_)
            {
               _loc4_.hasAvailableBuildings = true;
               _loc4_.available[_loc3_.id] = _loc3_;
            }
            else
            {
               _loc4_.available[_loc3_.id] = _loc3_;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function makeAllBuildings() : void
      {
         var allBuildings:Array = null;
         var index:int = 0;
         var softProcess:SoftProcess = new SoftProcess();
         allBuildings = this._buildingData.baseBuildingDefinitions.concat(this._buildingData.upgradeBuildingDefinitions).concat(this._buildingData.specialBuildingDefinitions);
         index = 0;
         softProcess.run(function():Boolean
         {
            getBuilding(allBuildings[index],null);
            index++;
            if(index == allBuildings.length)
            {
               return false;
            }
            return true;
         },this,16,function():void
         {
         },this);
      }
   }
}

class SingletonEnforcer#956
{
    
   
   function SingletonEnforcer#956()
   {
      super();
   }
}
