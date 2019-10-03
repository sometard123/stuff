package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class BuildingUpgradeDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["name","id","building","cost","requiredMTL","tier1","tier2","timeToUpgrade","xpGiven"];
       
      
      public var name:String;
      
      public var id:String;
      
      public var building:String;
      
      public var cost:int;
      
      public var requiredMTL:int;
      
      public var tier1:int;
      
      public var tier2:int;
      
      public var timeToUpgrade:int;
      
      public var xpGiven:int;
      
      public function BuildingUpgradeDefinition()
      {
         super();
      }
      
      public function Name(param1:String) : BuildingUpgradeDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Id(param1:String) : BuildingUpgradeDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Building(param1:String) : BuildingUpgradeDefinition
      {
         this.building = param1;
         return this;
      }
      
      public function Cost(param1:int) : BuildingUpgradeDefinition
      {
         this.cost = param1;
         return this;
      }
      
      public function RequiredMTL(param1:int) : BuildingUpgradeDefinition
      {
         this.requiredMTL = param1;
         return this;
      }
      
      public function Tier1(param1:int) : BuildingUpgradeDefinition
      {
         this.tier1 = param1;
         return this;
      }
      
      public function Tier2(param1:int) : BuildingUpgradeDefinition
      {
         this.tier2 = param1;
         return this;
      }
      
      public function TimeToUpgrade(param1:int) : BuildingUpgradeDefinition
      {
         this.timeToUpgrade = param1;
         return this;
      }
      
      public function XpGiven(param1:int) : BuildingUpgradeDefinition
      {
         this.xpGiven = param1;
         return this;
      }
   }
}
