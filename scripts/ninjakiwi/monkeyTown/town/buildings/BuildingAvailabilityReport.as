package ninjakiwi.monkeyTown.town.buildings
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.tests.EngineerAvailabilityTest;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   
   public class BuildingAvailabilityReport
   {
       
      
      public var available:Boolean = false;
      
      public var hasEnoughCash:Boolean = false;
      
      public var hasRequiredCityLevel:Boolean = false;
      
      public var isUniqueBuilding:Boolean = false;
      
      public var isPremiumBuilding:Boolean = false;
      
      public var alreadyBuilt:Boolean = false;
      
      public var hasPowerRequired:Boolean = false;
      
      public var hasRequiredBuilding:Boolean = false;
      
      public var currentBuildingCount:int = 0;
      
      public var possibleBuildingCount:int = 0;
      
      public var message:String = "";
      
      public var notMetMessage:String = "";
      
      public function BuildingAvailabilityReport(param1:MonkeyTownBuildingDefinition, param2:Boolean = true)
      {
         super();
         this.processBuildingDefinition(param1,param2);
      }
      
      private function processBuildingDefinition(param1:MonkeyTownBuildingDefinition, param2:Boolean = true) : void
      {
         var _loc13_:* = null;
         var _loc3_:ResourceStore = ResourceStore.getInstance();
         var _loc4_:MonkeySystem = MonkeySystem.getInstance();
         var _loc5_:BuildingFactory = BuildingFactory.getInstance();
         var _loc6_:BuildingData = BuildingData.getInstance();
         var _loc7_:BuildingManager = _loc4_.city.buildingManager;
         if(param1.monkeyMoneyCost < 0)
         {
            this.available = false;
         }
         var _loc8_:int = _loc3_.spendableMonkeyMoney;
         this.hasEnoughCash = _loc8_ >= param1.monkeyMoneyCost;
         var _loc9_:int = _loc5_.levelNeededToBuild(param1);
         this.hasRequiredCityLevel = _loc3_.townLevel >= _loc9_;
         this.isUniqueBuilding = param1.buildingCategory == _loc6_.UPGRADE_BUILDING || param1.buildingCategory == _loc6_.SPECIAL_BUILDING;
         var _loc10_:int = _loc7_.getBuildingCount(param1.id);
         this.alreadyBuilt = _loc10_ > 0;
         if(param1.levelsPerBuild <= 0)
         {
            this.isUniqueBuilding = true;
            if(_loc10_ > 0)
            {
               this.alreadyBuilt = true;
            }
         }
         var _loc11_:Boolean = true;
         if(this.isUniqueBuilding && this.alreadyBuilt)
         {
            _loc11_ = false;
         }
         if(param1.nkCoinCost > 0)
         {
            this.isUniqueBuilding = false;
            this.alreadyBuilt = false;
            _loc11_ = true;
            this.isPremiumBuilding = true;
         }
         this.currentBuildingCount = _loc10_;
         if(this.isPremiumBuilding)
         {
            this.possibleBuildingCount = PremiumBuildingManager.getInstance().buildingsBoughtINumbers[param1.id].value;
         }
         else if(this.isUniqueBuilding)
         {
            this.possibleBuildingCount = 1;
         }
         else
         {
            this.possibleBuildingCount = _loc5_.getPossibleBuildingCount(param1);
         }
         this.hasPowerRequired = _loc3_.availablePower >= param1.powerUsed || param1.powerUsed === 0;
         this.hasRequiredBuilding = param1.requiresBuilding === "" || _loc7_.hasCompletedBuilding(param1.requiresBuilding);
         this.available = this.hasEnoughCash && this.hasRequiredCityLevel && _loc11_ && this.hasPowerRequired && this.hasRequiredBuilding;
         var _loc12_:Boolean = true;
         if(param1.id == _loc6_.ENGINEER_WORKSHOP.id || param1.id == _loc6_.ENGINEERING_SCHOOL.id || param1.id == _loc6_.BLOON_CONTAINMENT_UNIT.id || param1.id == _loc6_.HIGH_PERFORMANCE_UNIT.id)
         {
            EngineerAvailabilityTest.test();
            _loc12_ = EngineerAvailabilityTest.isAvailable;
            this.available = this.available && _loc12_;
         }
         if(param2)
         {
            if(_loc11_)
            {
               if(param1.width !== 1 || param1.height !== 1)
               {
                  this.message = this.message + ("<br/><span class=\"green\">Requires " + param1.width + "x" + param1.height + " Tiles</span>");
               }
               _loc13_ = "";
               this.notMetMessage = "";
               if(!this.hasEnoughCash)
               {
                  _loc13_ = "<br/><span class=\"red\">Requires $" + param1.monkeyMoneyCost + "</span>";
                  this.message = this.message + _loc13_;
                  this.notMetMessage = this.notMetMessage + _loc13_;
               }
               if(!this.hasRequiredCityLevel)
               {
                  if(_loc9_ > Constants.MAX_CITY_LEVEL)
                  {
                     _loc13_ = "<br/><span class=\"red\">Maximum built</span>";
                  }
                  else
                  {
                     _loc13_ = "<br/><span class=\"red\">Requires town level " + _loc9_ + "</span>";
                  }
                  this.message = this.message + _loc13_;
                  this.notMetMessage = this.notMetMessage + _loc13_;
               }
               if(!this.hasPowerRequired)
               {
                  _loc13_ = "<br/><span class=\"red\">Requires " + param1.powerUsed + " power</span>";
                  this.message = this.message + _loc13_;
                  this.notMetMessage = this.notMetMessage + _loc13_;
               }
               if(!this.hasRequiredBuilding)
               {
                  _loc13_ = "<br/><span class=\"red\">Requires " + _loc6_.getBuildingDefinitionByID(param1.requiresBuilding).name + "</span>";
                  this.message = this.message + _loc13_;
                  this.notMetMessage = this.notMetMessage + _loc13_;
               }
               if(!_loc12_)
               {
                  _loc13_ = "<br/><span class=\"red\">Requires a " + "level 5 second city to unlock</span>";
                  if(EngineerAvailabilityTest.hasUnlockCity)
                  {
                     this.message = this.message + _loc13_;
                     this.notMetMessage = this.notMetMessage + _loc13_;
                  }
                  else
                  {
                     this.message = _loc13_;
                     this.notMetMessage = _loc13_;
                  }
               }
            }
            else
            {
               _loc13_ = "<br/><span class=\"green\">Already built</span>";
               this.message = this.message + _loc13_;
               this.notMetMessage = this.notMetMessage + _loc13_;
            }
         }
      }
   }
}
