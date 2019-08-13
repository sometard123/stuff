package ninjakiwi.monkeyTown.town.ui
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.utils.CSSUtil;
   
   public class UpgradeAvailabilityReport
   {
       
      
      private var _resourceStore:ResourceStore;
      
      public var available:Boolean = true;
      
      public var canAfford:Boolean = false;
      
      public var canAffordBloonstones:Boolean = false;
      
      public var warmingUp:Boolean = false;
      
      public var message:String = "";
      
      public var unlocked:Boolean = false;
      
      public var hasAquired:Boolean = false;
      
      public var aquiredTo:int = 0;
      
      public var hasRequiredCityLevel:Boolean = false;
      
      public var hasRequiredUpgradeBuilding:Boolean = false;
      
      public var passedRequiredTierBuildingTest:Boolean = false;
      
      public var passedRequiredSpecialBuildingTest:Boolean = false;
      
      public function UpgradeAvailabilityReport(param1:UpgradePathTierDefinition, param2:UpgradePathStateDefinition, param3:UpgradePathStateDefinition, param4:UpgradeDefinition, param5:int, param6:MonkeyTownBuildingDefinition)
      {
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         this._resourceStore = ResourceStore.getInstance();
         super();
         var _loc7_:MonkeySystem = MonkeySystem.getInstance();
         var _loc8_:BuildingData = BuildingData.getInstance();
         this.unlocked = param2.unlockedTo >= param5;
         this.hasAquired = param2.aquiredTo >= param5;
         this.aquiredTo = param2.aquiredTo;
         this.warmingUp = param2.isWarmingUp && param5 == this.aquiredTo + 1;
         this.hasRequiredUpgradeBuilding = _loc7_.city.buildingManager.hasCompletedBuilding(param4.building);
         this.passedRequiredTierBuildingTest = true;
         var _loc9_:Array = [];
         if(param1.requiresBuilding.length > 0)
         {
            _loc11_ = 0;
            while(_loc11_ < param1.requiresBuilding.length)
            {
               _loc10_ = param1.requiresBuilding[_loc11_];
               if(!_loc7_.city.buildingManager.hasCompletedBuilding(_loc10_))
               {
                  _loc9_.push(_loc8_.getBuildingDefinitionByID(_loc10_).name);
                  this.passedRequiredTierBuildingTest = false;
               }
               _loc11_++;
            }
         }
         this.passedRequiredSpecialBuildingTest = true;
         if(param6 !== null)
         {
            if(!_loc7_.city.buildingManager.hasCompletedBuilding(param6.id))
            {
               this.passedRequiredSpecialBuildingTest = false;
            }
         }
         this.canAfford = this._resourceStore.spendableMonkeyMoney >= param1.cost;
         this.canAffordBloonstones = this._resourceStore.bloonstones >= param1.bloonstoneCost;
         this.hasRequiredCityLevel = this._resourceStore.townLevel >= param1.minimumMonkeyTownLevel;
         this.available = this.unlocked && this.canAfford && this.canAffordBloonstones && this.hasRequiredCityLevel && this.hasRequiredUpgradeBuilding && this.passedRequiredTierBuildingTest && this.passedRequiredSpecialBuildingTest;
         this.message = "<span class = \'title\'>" + param1.name + "</span><br/>";
         this.message = this.message + (param1.description + "<br/>");
         if(param3.isWarmingUp)
         {
            this.message = this.message + CSSUtil.wrapInRed("Only one path can upgrade at a time.");
            this.available = false;
            return;
         }
         if(this.unlocked && !this.hasAquired && !this.warmingUp)
         {
            if(this.canAfford)
            {
               this.message = this.message + CSSUtil.wrapInGreen("Costs $" + param1.cost + "<br/>");
            }
            else
            {
               this.message = this.message + CSSUtil.wrapInRed("Costs $" + param1.cost + " ( Can\'t afford )<br/>");
            }
            if(param1.bloonstoneCost > 0)
            {
               if(this._resourceStore.bloonstones >= param1.bloonstoneCost)
               {
                  this.message = this.message + CSSUtil.wrapInGreen("Costs " + param1.bloonstoneCost + " Bloonstones<br/>");
               }
               else
               {
                  this.message = this.message + CSSUtil.wrapInRed("Requires " + param1.bloonstoneCost + " Bloonstones ( Can\'t afford )<br/>");
               }
            }
            if(!this.hasRequiredCityLevel)
            {
               this.message = this.message + CSSUtil.wrapInRed("Requires City Level: " + param1.minimumMonkeyTownLevel + "<br/>");
            }
            if(!this.hasRequiredUpgradeBuilding)
            {
               this.message = this.message + CSSUtil.wrapInRed(_loc8_.getBuildingDefinitionByID(param4.building).name + "<br/>");
            }
            if(!this.passedRequiredTierBuildingTest)
            {
               _loc12_ = 0;
               while(_loc12_ < _loc9_.length)
               {
                  this.message = this.message + CSSUtil.wrapInRed("Requires - " + _loc9_[_loc12_] + "<br/>");
                  _loc12_++;
               }
            }
            this.message = this.message + ("Earns " + param1.xpGiven + " XP<br/>");
            if(this.available)
            {
               this.message = this.message + "<span class = \"\">CLICK TO BUY<br/></span>";
            }
         }
         else
         {
            this.message = this.message + ("Earns " + param1.xpGiven + " XP<br/>");
         }
         if(this.hasAquired)
         {
            this.message = this.message + "<span class = \"green\">Purchased<br/></span>";
         }
         else if(this.warmingUp)
         {
            this.message = this.message + "<span class = \"green\">Upgrading now...<br/></span>";
         }
      }
   }
}
