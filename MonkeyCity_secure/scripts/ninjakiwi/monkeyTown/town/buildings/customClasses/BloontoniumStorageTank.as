package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   
   public class BloontoniumStorageTank extends Building
   {
       
      
      public var teir:int = 1;
      
      public function BloontoniumStorageTank(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         this.init();
      }
      
      public function init() : void
      {
      }
      
      public function get capacity() : int
      {
         if(UpgradeData.getInstance().getBuildingUpgradeByBuildingID(definition.id))
         {
            return UpgradeData.getInstance().getBuildingUpgradeByBuildingID(definition.id).tier1;
         }
         return 1000;
      }
      
      override public function die() : void
      {
         _city.bloontoniumStorageTankManager.deregister(this);
         super.die();
      }
      
      override public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         super.onBuildComplete(param1,param2);
         _city.bloontoniumStorageTankManager.register(this);
      }
   }
}
