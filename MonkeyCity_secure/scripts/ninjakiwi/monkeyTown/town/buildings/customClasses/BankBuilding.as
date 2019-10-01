package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.BankTierData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   
   public class BankBuilding extends UpgradeableBuilding
   {
       
      
      public function BankBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
      }
      
      public function get capacity() : int
      {
         return this.upgradeableValue;
      }
      
      override public function die() : void
      {
         _city.bankManager.deregister(this);
         super.die();
      }
      
      override public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         super.onBuildComplete(param1,param2);
         _city.bankManager.register(this);
      }
      
      override public function finaliseUpgrade(param1:Number = 0, param2:int = 8) : void
      {
         super.finaliseUpgrade(param1,BankTierData.MAX_BANK_UPGRADE_TIERS);
         _city.bankManager.recalculateMaximumCapacity();
      }
      
      override public function canGetUpgrade() : Boolean
      {
         if(tier < BankTierData.MAX_BANK_UPGRADE_TIERS)
         {
            return tier < BankTierData.MAX_BANK_UPGRADE_TIERS && _resourceStore.spendableMonkeyMoney >= BankTierData.getCostForTier(tier + 1) && _resourceStore.townLevel >= BankTierData.getRequiredLevelForTier(tier + 1) && !isUpgrading;
         }
         return false;
      }
      
      override public function getTotalCashInvestedInBuildingForTier(param1:int) : int
      {
         var _loc2_:Number = definition.monkeyMoneyCost;
         var _loc3_:int = 1;
         while(_loc3_ <= param1)
         {
            _loc2_ = _loc2_ + BankTierData.getCostForTier(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function getTotalXPEarned() : int
      {
         var _loc1_:int = definition.xpGivenForBuilding;
         var _loc2_:int = 1;
         while(_loc2_ <= tier)
         {
            _loc1_ = _loc1_ + BankTierData.getXPForTier(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function getUpgradeCostForTier(param1:int) : int
      {
         return BankTierData.getCostForTier(param1);
      }
      
      override public function getXPAwardedForTier(param1:int) : int
      {
         return BankTierData.getXPForTier(param1);
      }
      
      override public function get upgradeableValue() : int
      {
         return BankTierData.getCapacityForTier(tier);
      }
      
      override public function get nextUpgradeableValue() : int
      {
         return BankTierData.getCapacityForTier(this.clampToTier(tier + 1));
      }
      
      override public function getUpgradeNameForTier(param1:int) : String
      {
         return BankTierData.getNameForTier(param1);
      }
      
      override public function get maximumTiers() : int
      {
         return BankTierData.MAX_BANK_UPGRADE_TIERS;
      }
      
      override public function getRequiredTownLevelForTier(param1:int) : int
      {
         return BankTierData.getRequiredLevelForTier(param1);
      }
      
      override public function isDemolishable() : Boolean
      {
         var _loc1_:BuildingManager = _system.city.buildingManager;
         if(_loc1_.getBuildingCount(definition.id) <= 1)
         {
            return false;
         }
         return true;
      }
      
      override public function getTimeToUpgrade() : Number
      {
         return BankTierData.getTimeForTier(this.clampToTier(tier + 1));
      }
      
      private function clampToTier(param1:int) : int
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         else if(param1 > BankTierData.MAX_BANK_UPGRADE_TIERS)
         {
            param1 = BankTierData.MAX_BANK_UPGRADE_TIERS;
         }
         return param1;
      }
   }
}
