package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import ninjakiwi.monkeyTown.utils.CSSUtil;
   
   public class BloonResearchLabUpgradeAvailabilityReport
   {
       
      
      public var available:Boolean = true;
      
      public var isOwned:Boolean = false;
      
      public var isWarmingUp:Boolean = false;
      
      public var canAfford:Boolean = false;
      
      public var canAffordBloonstones:Boolean = false;
      
      public var hasMTL:Boolean = false;
      
      public var hasRequiredBuilding:Boolean = false;
      
      public var hasRequiredTier:Boolean = true;
      
      public var reportDescription:String = "";
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _upgrade:BloonResearchLabUpgrade;
      
      public function BloonResearchLabUpgradeAvailabilityReport(param1:BloonResearchLabUpgrade)
      {
         super();
         this.createReport(param1);
      }
      
      public function update() : void
      {
         this.createReport(this._upgrade);
      }
      
      private function createReport(param1:BloonResearchLabUpgrade) : void
      {
         var _loc8_:MonkeyTownBuildingDefinition = null;
         var _loc9_:String = null;
         this._upgrade = param1;
         var _loc2_:ResourceStore = ResourceStore.getInstance();
         var _loc3_:UpgradeTree = this._system.city.upgradeTree;
         var _loc4_:BuildingManager = this._system.city.buildingManager;
         var _loc5_:BuildingData = BuildingData.getInstance();
         var _loc6_:int = BloonResearchLabState.currentTier;
         var _loc7_:Boolean = _loc4_.hasCompletedBuilding(_loc5_.BLOON_RESEARCH_LAB.id);
         this.reportDescription = "";
         this.hasRequiredTier = param1.tier < _loc6_ + 2;
         this.isOwned = param1.tier < _loc6_ + 1;
         this.isWarmingUp = param1 === BloonResearchLabState.currentWarmingUpgrade;
         this.canAfford = _loc2_.spendableMonkeyMoney >= param1.cashCost;
         this.canAffordBloonstones = _loc2_.bloonstones >= param1.bloonstoneCost;
         if(_loc2_.townLevel < param1.requiresMTL)
         {
            this.hasMTL = false;
         }
         else
         {
            this.hasMTL = true;
         }
         if(param1.requiresBuilding !== "")
         {
            this.hasRequiredBuilding = _loc4_.hasCompletedBuilding(param1.requiresBuilding);
         }
         else
         {
            this.hasRequiredBuilding = true;
         }
         if(this.canAfford && this.canAffordBloonstones && this.hasRequiredTier && this.hasMTL && this.hasRequiredBuilding && this.hasRequiredTier && _loc7_)
         {
            this.available = true;
         }
         else
         {
            this.available = false;
         }
         if(!this.hasRequiredTier)
         {
            this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Locked<br/>");
         }
         else if(!this.isWarmingUp)
         {
            if(!this.canAfford)
            {
               this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Costs $" + param1.cashCost + " ( Can\'t afford )<br/>");
            }
            else
            {
               this.reportDescription = this.reportDescription + CSSUtil.wrapInGreen("Costs $" + param1.cashCost + "<br/>");
            }
            if(param1.bloonstoneCost > 0)
            {
               if(!this.canAffordBloonstones)
               {
                  this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Costs " + param1.bloonstoneCost + " Bloonstones ( Can\'t afford )<br/>");
               }
               else
               {
                  this.reportDescription = this.reportDescription + CSSUtil.wrapInGreen("Costs " + param1.bloonstoneCost + " Bloonstones <br/>");
               }
            }
            if(!_loc7_)
            {
               this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Requires Bloon Research Lab<br/>");
            }
            if(!this.hasMTL)
            {
               this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Requires city level: " + param1.requiresMTL + "<br/>");
            }
            if(!this.hasRequiredBuilding)
            {
               _loc8_ = _loc5_.getBuildingDefinitionByID(param1.requiresBuilding);
               _loc9_ = !!_loc8_?_loc8_.name:param1.requiresBuilding;
               this.reportDescription = this.reportDescription + CSSUtil.wrapInRed("Requires building: " + _loc9_ + "<br/>");
            }
            if(param1.requiresUpgrade !== null)
            {
               this.reportDescription = this.reportDescription + CSSUtil.wrapInGreen("Requires " + BloonResearchLabUpgrades.getUpgradeByID(param1.requiresUpgrade).name);
            }
         }
      }
   }
}
