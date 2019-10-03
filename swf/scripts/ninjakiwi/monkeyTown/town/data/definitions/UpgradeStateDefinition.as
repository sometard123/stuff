package ninjakiwi.monkeyTown.town.data.definitions
{
   public class UpgradeStateDefinition
   {
       
      
      public var id:String;
      
      public var path1:UpgradePathStateDefinition;
      
      public var path2:UpgradePathStateDefinition;
      
      public function UpgradeStateDefinition()
      {
         this.path1 = new UpgradePathStateDefinition();
         this.path2 = new UpgradePathStateDefinition();
         super();
         this.path1.pathNumber = 1;
         this.path2.pathNumber = 2;
      }
      
      public function Id(param1:String) : UpgradeStateDefinition
      {
         this.id = param1;
         this.path1.upgradeID = this.id;
         this.path2.upgradeID = this.id;
         return this;
      }
      
      public function Path1(param1:UpgradePathStateDefinition) : UpgradeStateDefinition
      {
         this.path1 = param1;
         return this;
      }
      
      public function Path2(param1:UpgradePathStateDefinition) : UpgradeStateDefinition
      {
         this.path2 = param1;
         return this;
      }
      
      public function getDescription() : Object
      {
         var _loc1_:Object = {
            "path1":this.path1.aquiredTo,
            "path2":this.path2.aquiredTo
         };
         return _loc1_;
      }
   }
}
