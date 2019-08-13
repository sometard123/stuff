package ninjakiwi.monkeyTown.town.buildings.saveDefinitions
{
   public class BloontoniumGeneratorSaveDefinition extends UpgradeableBuildingSaveDefinition
   {
      
      protected static const _structure:String = "{\"bloontonium\":{\"type\":\"Number\",\"defaultValue\":\"0\",\"definitionName\":\"BloontoniumGeneratorSaveDefinition\",\"packageName\":\"ninjakiwi.monkeyTown.town.buildings.saveDefinitions\"},\"statsTimeLastUpdated\":{\"type\":\"Number\",\"defaultValue\":\"-1\",\"definitionName\":\"BloontoniumGeneratorSaveDefinition\",\"packageName\":\"ninjakiwi.monkeyTown.town.buildings.saveDefinitions\"}}";
      
      protected static const _propertyNames:Array = ["bloontonium","statsTimeLastUpdated"];
       
      
      public var bloontonium:Number = 0;
      
      public var statsTimeLastUpdated:Number = -1;
      
      public function BloontoniumGeneratorSaveDefinition()
      {
         super();
      }
      
      public static function getStructureJson() : String
      {
         return _structure;
      }
      
      public function Bloontonium(param1:Number) : BloontoniumGeneratorSaveDefinition
      {
         this.bloontonium = param1;
         return this;
      }
      
      public function StatsTimeLastUpdated(param1:Number) : BloontoniumGeneratorSaveDefinition
      {
         this.statsTimeLastUpdated = param1;
         return this;
      }
   }
}
