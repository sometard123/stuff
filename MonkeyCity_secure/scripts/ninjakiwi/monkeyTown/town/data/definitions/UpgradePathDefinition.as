package ninjakiwi.monkeyTown.town.data.definitions
{
   public class UpgradePathDefinition
   {
       
      
      public var tier1:UpgradePathTierDefinition;
      
      public var tier2:UpgradePathTierDefinition;
      
      public var tier3:UpgradePathTierDefinition;
      
      public var tier4:UpgradePathTierDefinition;
      
      public function UpgradePathDefinition()
      {
         super();
      }
      
      public function Tier1(param1:UpgradePathTierDefinition) : UpgradePathDefinition
      {
         this.tier1 = param1;
         return this;
      }
      
      public function Tier2(param1:UpgradePathTierDefinition) : UpgradePathDefinition
      {
         this.tier2 = param1;
         return this;
      }
      
      public function Tier3(param1:UpgradePathTierDefinition) : UpgradePathDefinition
      {
         this.tier3 = param1;
         return this;
      }
      
      public function Tier4(param1:UpgradePathTierDefinition) : UpgradePathDefinition
      {
         this.tier4 = param1;
         return this;
      }
   }
}
