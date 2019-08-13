package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class BloonResearchLabUpgrade extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","tier","description","cashCost","bloonstoneCost","time","xpGiven","requiresMTL","requiresBuilding","requiresUpgrade","iconClassName"];
       
      
      public var id:String;
      
      public var name:String;
      
      public var tier:int;
      
      public var description:String;
      
      public var cashCost:int;
      
      public var bloonstoneCost:int;
      
      public var time:int;
      
      public var xpGiven:int;
      
      public var requiresMTL:int;
      
      public var requiresBuilding:String;
      
      public var requiresUpgrade:String = null;
      
      public var iconClassName:String;
      
      public function BloonResearchLabUpgrade()
      {
         super();
      }
      
      public function Id(param1:String) : BloonResearchLabUpgrade
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : BloonResearchLabUpgrade
      {
         this.name = param1;
         return this;
      }
      
      public function Tier(param1:int) : BloonResearchLabUpgrade
      {
         this.tier = param1;
         return this;
      }
      
      public function Description(param1:String) : BloonResearchLabUpgrade
      {
         this.description = param1;
         return this;
      }
      
      public function CashCost(param1:int) : BloonResearchLabUpgrade
      {
         this.cashCost = param1;
         return this;
      }
      
      public function BloonstoneCost(param1:int) : BloonResearchLabUpgrade
      {
         this.bloonstoneCost = param1;
         return this;
      }
      
      public function Time(param1:int) : BloonResearchLabUpgrade
      {
         this.time = param1;
         return this;
      }
      
      public function XpGiven(param1:int) : BloonResearchLabUpgrade
      {
         this.xpGiven = param1;
         return this;
      }
      
      public function RequiresMTL(param1:int) : BloonResearchLabUpgrade
      {
         this.requiresMTL = param1;
         return this;
      }
      
      public function RequiresBuilding(param1:String) : BloonResearchLabUpgrade
      {
         this.requiresBuilding = param1;
         return this;
      }
      
      public function RequiresUpgrade(param1:String) : BloonResearchLabUpgrade
      {
         this.requiresUpgrade = param1;
         return this;
      }
      
      public function IconClassName(param1:String) : BloonResearchLabUpgrade
      {
         this.iconClassName = param1;
         return this;
      }
   }
}
