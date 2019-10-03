package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   
   public class WindMillBuilding extends UpgradeableBuilding implements IPowerSource
   {
       
      
      public var configData:ConfigData;
      
      public function WindMillBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         this.configData = ConfigData.getInstance();
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
      }
      
      override public function die() : void
      {
         _city.powerSourceManager.deregister(this);
         super.die();
      }
      
      override public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         _city.powerSourceManager.register(this);
         super.onBuildComplete(param1,param2);
      }
      
      override public function finaliseUpgrade(param1:Number = 0, param2:int = 2) : void
      {
         var _loc3_:int = this.power;
         super.finaliseUpgrade(param1);
         var _loc4_:int = upgradeableValue - _loc3_;
         _city.powerSourceManager.addPowerFromUpgrade(_loc4_);
      }
      
      public function get power() : int
      {
         return upgradeableValue;
      }
   }
}
