package ninjakiwi.monkeyTown.town.data.definitions
{
   import assets.icons.BlankBuildingIconClip;
   import ninjakiwi.data.NKDefinition;
   
   public class MonkeyTownBuildingDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","gameDescription","monkeyMoneyCost","nkCoinCost","bloonstoneCost","timeToBuild","minimumMonkeyTownLevel","levelsPerBuild","numberAllowedAtMonkeyTownLevel1","graphicsClasses","groundGraphicsClasses","powerUsed","xpGivenForBuilding","requiresTerrain","disallowTerrain","requiresTerrainProperty","requiresBuilding","buildingClass","width","height","customClass","iconGraphicClass","upgrades","states","buildingCategory","animationDelays","populationType","buildable","minimumCityIndex","nkItemID"];
       
      
      public var id:String = "";
      
      public var name:String = "";
      
      public var gameDescription:String = "";
      
      public var monkeyMoneyCost:int;
      
      public var nkCoinCost:int;
      
      public var bloonstoneCost:int;
      
      public var timeToBuild:Number = 0;
      
      public var minimumMonkeyTownLevel:int = 1;
      
      public var levelsPerBuild:int = 0;
      
      public var numberAllowedAtMonkeyTownLevel1:int = 1;
      
      public var graphicsClasses:Array = null;
      
      public var groundGraphicsClasses:Array = null;
      
      public var powerUsed:int;
      
      public var xpGivenForBuilding:int;
      
      public var requiresTerrain:Array;
      
      public var disallowTerrain:Array;
      
      public var requiresTerrainProperty:String;
      
      public var requiresBuilding:String = "";
      
      public var buildingClass:Class;
      
      public var width:int;
      
      public var height:int;
      
      public var customClass:Class;
      
      public var iconGraphicClass:Class;
      
      public var upgrades:Array = null;
      
      public var states:int = 1;
      
      public var buildingCategory:String;
      
      public var animationDelays:Array = null;
      
      public var populationType:String = "";
      
      public var buildable:Boolean = true;
      
      public var minimumCityIndex:int = 0;
      
      public var nkItemID:int;
      
      public function MonkeyTownBuildingDefinition()
      {
         this.requiresTerrain = [];
         this.disallowTerrain = [];
         this.iconGraphicClass = BlankBuildingIconClip;
         super();
      }
      
      public function Id(param1:String) : MonkeyTownBuildingDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : MonkeyTownBuildingDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function GameDescription(param1:String) : MonkeyTownBuildingDefinition
      {
         this.gameDescription = param1;
         return this;
      }
      
      public function MonkeyMoneyCost(param1:int) : MonkeyTownBuildingDefinition
      {
         this.monkeyMoneyCost = param1;
         return this;
      }
      
      public function NkCoinCost(param1:int) : MonkeyTownBuildingDefinition
      {
         this.nkCoinCost = param1;
         return this;
      }
      
      public function BloonstoneCost(param1:int) : MonkeyTownBuildingDefinition
      {
         this.bloonstoneCost = param1;
         return this;
      }
      
      public function TimeToBuild(param1:Number) : MonkeyTownBuildingDefinition
      {
         this.timeToBuild = param1;
         return this;
      }
      
      public function MinimumMonkeyTownLevel(param1:int) : MonkeyTownBuildingDefinition
      {
         this.minimumMonkeyTownLevel = param1;
         return this;
      }
      
      public function LevelsPerBuild(param1:int) : MonkeyTownBuildingDefinition
      {
         this.levelsPerBuild = param1;
         return this;
      }
      
      public function NumberAllowedAtMonkeyTownLevel1(param1:int) : MonkeyTownBuildingDefinition
      {
         this.numberAllowedAtMonkeyTownLevel1 = param1;
         return this;
      }
      
      public function GraphicsClasses(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.graphicsClasses = param1;
         return this;
      }
      
      public function GroundGraphicsClasses(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.groundGraphicsClasses = param1;
         return this;
      }
      
      public function PowerUsed(param1:int) : MonkeyTownBuildingDefinition
      {
         this.powerUsed = param1;
         return this;
      }
      
      public function XpGivenForBuilding(param1:int) : MonkeyTownBuildingDefinition
      {
         this.xpGivenForBuilding = param1;
         return this;
      }
      
      public function RequiresTerrain(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.requiresTerrain = param1;
         return this;
      }
      
      public function DisallowTerrain(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.disallowTerrain = param1;
         return this;
      }
      
      public function RequiresTerrainProperty(param1:String) : MonkeyTownBuildingDefinition
      {
         this.requiresTerrainProperty = param1;
         return this;
      }
      
      public function RequiresBuilding(param1:String) : MonkeyTownBuildingDefinition
      {
         this.requiresBuilding = param1;
         return this;
      }
      
      public function BuildingClass(param1:Class) : MonkeyTownBuildingDefinition
      {
         this.buildingClass = param1;
         return this;
      }
      
      public function Width(param1:int) : MonkeyTownBuildingDefinition
      {
         this.width = param1;
         return this;
      }
      
      public function Height(param1:int) : MonkeyTownBuildingDefinition
      {
         this.height = param1;
         return this;
      }
      
      public function CustomClass(param1:Class) : MonkeyTownBuildingDefinition
      {
         this.customClass = param1;
         return this;
      }
      
      public function IconGraphicClass(param1:Class) : MonkeyTownBuildingDefinition
      {
         this.iconGraphicClass = param1;
         return this;
      }
      
      public function Upgrades(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.upgrades = param1;
         return this;
      }
      
      public function States(param1:int) : MonkeyTownBuildingDefinition
      {
         this.states = param1;
         return this;
      }
      
      public function BuildingCategory(param1:String) : MonkeyTownBuildingDefinition
      {
         this.buildingCategory = param1;
         return this;
      }
      
      public function AnimationDelays(param1:Array) : MonkeyTownBuildingDefinition
      {
         this.animationDelays = param1;
         return this;
      }
      
      public function PopulationType(param1:String) : MonkeyTownBuildingDefinition
      {
         this.populationType = param1;
         return this;
      }
      
      public function Buildable(param1:Boolean) : MonkeyTownBuildingDefinition
      {
         this.buildable = param1;
         return this;
      }
      
      public function MinimumCityIndex(param1:int) : MonkeyTownBuildingDefinition
      {
         this.minimumCityIndex = param1;
         return this;
      }
      
      public function NkItemID(param1:int) : MonkeyTownBuildingDefinition
      {
         this.nkItemID = param1;
         return this;
      }
   }
}
