package ninjakiwi.monkeyTown.town.data.definitions
{
   public class UpgradePathTierDefinition
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var cost:int;
      
      public var bloonstoneCost:int;
      
      public var time:int;
      
      public var xpGiven:int;
      
      public var minimumMonkeyTownLevel:int;
      
      public var requiresUpgrade:Array;
      
      public var requiresBuilding:Array;
      
      public var requiresTerrain:Array;
      
      public var requiresTerrainProperty:Array;
      
      public var iconClassName:String = "BlankUpgradeIcon";
      
      public var description:String;
      
      public function UpgradePathTierDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : UpgradePathTierDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : UpgradePathTierDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Cost(param1:int) : UpgradePathTierDefinition
      {
         this.cost = param1;
         return this;
      }
      
      public function BloonstoneCost(param1:int) : UpgradePathTierDefinition
      {
         this.bloonstoneCost = param1;
         return this;
      }
      
      public function Time(param1:int) : UpgradePathTierDefinition
      {
         this.time = param1;
         return this;
      }
      
      public function XpGiven(param1:int) : UpgradePathTierDefinition
      {
         this.xpGiven = param1;
         return this;
      }
      
      public function MinimumMonkeyTownLevel(param1:int) : UpgradePathTierDefinition
      {
         this.minimumMonkeyTownLevel = param1;
         return this;
      }
      
      public function RequiresUpgrade(param1:Array) : UpgradePathTierDefinition
      {
         this.requiresUpgrade = param1;
         return this;
      }
      
      public function RequiresBuilding(param1:Array) : UpgradePathTierDefinition
      {
         this.requiresBuilding = param1;
         return this;
      }
      
      public function RequiresTerrain(param1:Array) : UpgradePathTierDefinition
      {
         this.requiresTerrain = param1;
         return this;
      }
      
      public function RequiresTerrainProperty(param1:Array) : UpgradePathTierDefinition
      {
         this.requiresTerrainProperty = param1;
         return this;
      }
      
      public function IconClassName(param1:String) : UpgradePathTierDefinition
      {
         this.iconClassName = param1;
         return this;
      }
      
      public function Description(param1:String) : UpgradePathTierDefinition
      {
         this.description = param1;
         return this;
      }
   }
}
