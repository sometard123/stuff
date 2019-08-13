package ninjakiwi.monkeyTown.town.buildings
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.TerrainTowerRestrictionsData;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.PopulationData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   import ninjakiwi.monkeyTown.town.management.Manager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import org.osflash.signals.Signal;
   
   public class BuildingManager extends Manager
   {
       
      
      public var buildingWasRegisteredSignal:Signal;
      
      public var buildingWasDeregisteredSignal:Signal;
      
      private var _powerUsed:int;
      
      private var _buildingCounts:Object;
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function BuildingManager()
      {
         this.buildingWasRegisteredSignal = new Signal();
         this.buildingWasDeregisteredSignal = new Signal();
         this._buildingCounts = {};
         super();
         validType = Building;
         MonkeyCityMain.globalResetSignal.add(this.reset);
      }
      
      private function reset() : void
      {
         this.initBuildingCounts();
      }
      
      private function initBuildingCounts() : void
      {
         var _loc1_:MonkeyTownBuildingDefinition = null;
         var _loc2_:Array = this._buildingData.baseBuildingDefinitions.concat(this._buildingData.specialBuildingDefinitions).concat(this._buildingData.resourceBuildingDefinitions).concat(this._buildingData.pvpBuildingDefinitions).concat(this._buildingData.upgradeBuildingDefinitions);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_];
            this._buildingCounts[_loc1_.id] = 0;
            _loc3_++;
         }
      }
      
      public function getBaseBuildingCount() : Object
      {
         var _loc1_:MonkeyTownBuildingDefinition = null;
         var _loc2_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < this._buildingData.baseBuildingDefinitions.length)
         {
            _loc1_ = this._buildingData.baseBuildingDefinitions[_loc3_];
            _loc2_[_loc1_.id] = this.getCompletedBuildingCount(_loc1_.id).complete;
            _loc3_++;
         }
         var _loc4_:MonkeyTownBuildingDefinition = this._buildingData.MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING;
         var _loc5_:* = this._buildingCounts[_loc4_.id] > 0;
         var _loc6_:String = this._buildingData.BANANA_FARM.id;
         if(_loc5_)
         {
            _loc2_[_loc6_] = this.getCompletedBuildingCount(_loc6_).complete;
         }
         else
         {
            _loc2_[_loc6_] = 0;
         }
         return _loc2_;
      }
      
      public function getBuiltAndUnbuiltBaseBuildings() : Object
      {
         var _loc5_:* = null;
         var _loc6_:MonkeyTownBuildingDefinition = null;
         var _loc1_:Object = this.getBaseBuildingCount();
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Object = this.getAvailableTowersDescription();
         for(_loc5_ in _loc1_)
         {
            _loc6_ = this._buildingData.getBuildingDefinitionByID(_loc5_);
            if(_loc1_[_loc5_] > 0)
            {
               _loc2_.push({
                  "id":_loc5_,
                  "definition":_loc6_,
                  "count":_loc1_[_loc5_],
                  "damagedCount":(_loc4_[_loc6_.populationType] != null?_loc4_[_loc6_.populationType].damagedCount:0)
               });
            }
            else
            {
               _loc3_.push({
                  "id":_loc5_,
                  "definition":_loc6_,
                  "count":0,
                  "damagedCount":0
               });
            }
         }
         return {
            "available":_loc2_,
            "unavailable":_loc3_
         };
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc2_:Boolean = false;
         if(validType != null)
         {
            if(!(param1 is validType))
            {
               return false;
            }
         }
         var _loc3_:Building = param1;
         var _loc4_:String = _loc3_.definition.id;
         _items.push(_loc3_);
         if(!this._buildingCounts[_loc4_])
         {
            this._buildingCounts[_loc4_] = 0;
         }
         this._buildingCounts[_loc4_]++;
         var _loc5_:int = this._powerUsed;
         this._powerUsed = this._powerUsed + _loc3_.definition.powerUsed;
         this.buildingWasRegisteredSignal.dispatch(param1);
         GameSignals.POWER_USED_CHANGED_DIFF.dispatch(this._powerUsed - _loc5_);
         return true;
      }
      
      override public function deregister(param1:*) : Boolean
      {
         if(validType != null)
         {
            if(!(param1 is validType))
            {
               return false;
            }
         }
         if(!removeItemFromArray(_items,param1))
         {
            return false;
         }
         this._buildingCounts[Building(param1).definition.id]--;
         var _loc2_:int = this._powerUsed;
         this._powerUsed = this._powerUsed - param1.definition.powerUsed;
         this.buildingWasDeregisteredSignal.dispatch(param1);
         GameSignals.POWER_USED_CHANGED_DIFF.dispatch(this._powerUsed - _loc2_);
         return true;
      }
      
      public function getBuildingCount(param1:String) : int
      {
         if(this._buildingCounts[param1] == undefined)
         {
            return 0;
         }
         return this._buildingCounts[param1];
      }
      
      public function getCompletedBuildingCount(param1:String) : Object
      {
         var _loc4_:Building = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _items.length)
         {
            _loc4_ = _items[_loc5_];
            if(_loc4_.definition.id === param1)
            {
               if(_loc4_.buildComplete)
               {
                  _loc2_++;
               }
               else
               {
                  _loc3_++;
               }
            }
            _loc5_++;
         }
         return {
            "complete":_loc2_,
            "incomplete":_loc3_
         };
      }
      
      public function getCompletedBuilding(param1:String) : Vector.<Building>
      {
         var _loc3_:Building = null;
         var _loc2_:Vector.<Building> = new Vector.<Building>();
         var _loc4_:int = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_];
            if(_loc3_.definition.id === param1)
            {
               if(_loc3_.buildComplete)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getAvailableTowersDescription(param1:String = null) : Object
      {
         var _loc3_:Building = null;
         var _loc4_:String = null;
         var _loc5_:PopulationDefinition = null;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc2_:Object = {};
         var _loc6_:int = this._system.city.cityIndex;
         var _loc7_:int = 0;
         while(_loc7_ < _items.length)
         {
            _loc3_ = _items[_loc7_];
            if(!(_loc3_.definition.populationType == "" || _loc3_.definition.populationType == null || !_loc3_.buildComplete))
            {
               _loc4_ = _loc3_.definition.populationType;
               _loc5_ = PopulationData.getInstance().getDefinitionByID(_loc4_);
               if(_loc2_[_loc4_] == undefined)
               {
                  _loc2_[_loc4_] = {
                     "count":0,
                     "damagedCount":0
                  };
               }
               if(_loc3_.isDamaged)
               {
                  _loc2_[_loc4_].damagedCount = _loc2_[_loc4_].damagedCount + _loc5_.populationCount;
               }
               else
               {
                  _loc2_[_loc4_].count = _loc2_[_loc4_].count + _loc5_.populationCount;
               }
               _loc2_[_loc4_].allowed = TerrainTowerRestrictionsData.isTowerAllowedForTerrain(param1,_loc4_);
               _loc8_ = TerrainTowerRestrictionsData.getCostModifierForTerrainAndTower(param1,_loc3_.definition.populationType);
               if(_loc8_ !== 1)
               {
                  _loc2_[_loc3_.definition.populationType].costModifier = _loc8_;
               }
            }
            _loc7_++;
         }
         if(_loc2_.hasOwnProperty(Constants.TOWER_FARM) && _loc2_[Constants.TOWER_FARM].count > 0)
         {
            _loc9_ = this.hasCompletedBuilding(this._buildingData.MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING.id);
            if(!_loc9_)
            {
               _loc2_[Constants.TOWER_FARM].count = 0;
               delete _loc2_[Constants.TOWER_FARM];
            }
         }
         return _loc2_;
      }
      
      public function getAvailableFarmCount() : int
      {
         var _loc1_:* = this.getBuildingCount(this._buildingData.MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING.id) > 0;
         if(_loc1_)
         {
            return this.getBuildingCount(this._buildingData.BANANA_FARM.id);
         }
         return 0;
      }
      
      public function hasCompletedBuilding(param1:String) : Boolean
      {
         var _loc2_:Building = null;
         var _loc3_:int = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_.definition.id === param1 && _loc2_.buildComplete)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function hasBuiltBuilding(param1:String) : Boolean
      {
         var _loc2_:Building = null;
         var _loc3_:int = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_.definition.id === param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getDamageableBuildings() : Array
      {
         var _loc2_:Building = null;
         var _loc1_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_.definition.buildingCategory === this._buildingData.BASE_BUILDING && _loc2_.buildComplete && !_loc2_.isDamaged && _loc2_.definition.id !== "MonkeyTownHall")
            {
               _loc1_.push(_loc2_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getDamagedBuildingsOfType(param1:String) : Array
      {
         var _loc3_:Building = null;
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_];
            if(_loc3_.definition.id == param1)
            {
               if(_loc3_.isDamaged)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getCompletedBaseBuildingCount() : int
      {
         var _loc1_:Building = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items[_loc3_];
            if(_loc1_.definition.buildingCategory === this._buildingData.BASE_BUILDING && _loc1_.definition.id !== "MonkeyTownHall" && _loc1_.buildComplete)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function clear() : void
      {
         var _loc2_:Building = null;
         var _loc1_:int = 0;
         while(_loc1_ < _items.length)
         {
            _loc2_ = _items[_loc1_];
            _loc2_.tidy();
            _loc1_++;
         }
         super.clear();
         this._powerUsed = 0;
         this._buildingCounts = {};
         this.initBuildingCounts();
      }
      
      public function getBuildingsOfType(param1:String) : Array
      {
         var _loc3_:Building = null;
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_];
            if(_loc3_.definition.id == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get powerUsed() : int
      {
         return this._powerUsed;
      }
      
      public function get buildingCounts() : Object
      {
         return this._buildingCounts;
      }
   }
}
