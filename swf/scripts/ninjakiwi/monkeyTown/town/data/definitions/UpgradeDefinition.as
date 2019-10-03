package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class UpgradeDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["name","id","building","path1","path2","btdTowerID"];
       
      
      public var name:String;
      
      public var id:String;
      
      public var building:String;
      
      public var path1:UpgradePathDefinition;
      
      public var path2:UpgradePathDefinition;
      
      public var btdTowerID:String;
      
      public function UpgradeDefinition()
      {
         super();
      }
      
      public function Name(param1:String) : UpgradeDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Id(param1:String) : UpgradeDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Building(param1:String) : UpgradeDefinition
      {
         this.building = param1;
         return this;
      }
      
      public function Path1(param1:UpgradePathDefinition) : UpgradeDefinition
      {
         this.path1 = param1;
         return this;
      }
      
      public function Path2(param1:UpgradePathDefinition) : UpgradeDefinition
      {
         this.path2 = param1;
         return this;
      }
      
      public function BtdTowerID(param1:String) : UpgradeDefinition
      {
         this.btdTowerID = param1;
         return this;
      }
   }
}
