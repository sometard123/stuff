package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.WatermillSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class WaterMillBuilding extends UpgradeableBuilding implements IPowerSource
   {
      
      public static const NUMBER_OF_STATES:int = 2;
       
      
      public var configData:ConfigData;
      
      private var _riverBuildingComponent:OrientatedRiverBuildingComponent;
      
      public function WaterMillBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         this.configData = ConfigData.getInstance();
         super(param1,param2);
         this._riverBuildingComponent = new OrientatedRiverBuildingComponent(this);
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
      
      override public function floatOnMap(param1:TownMap) : Building
      {
         this._riverBuildingComponent.orientToRiverDirection(param1);
         this.syncCurrentStateToOrientation();
         super.floatOnMap(param1);
         return this;
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         this._riverBuildingComponent.orientToRiverDirection(param1);
         this.syncCurrentStateToOrientation();
         super.placeOnMap(param1,param2,param3,param4);
         return this;
      }
      
      override public function finaliseUpgrade(param1:Number = 0, param2:int = 2) : void
      {
         var _loc3_:int = this.power;
         super.finaliseUpgrade(param1);
         var _loc4_:int = this.power - _loc3_;
         _city.powerSourceManager.addPowerFromUpgrade(_loc4_);
      }
      
      public function get power() : int
      {
         return upgradeableValue;
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:WatermillSaveDefinition = new WatermillSaveDefinition();
         populateSaveDefinition(_loc1_);
         _loc1_.orientation = this._riverBuildingComponent.riverDirection;
         return _loc1_;
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         var _loc2_:WatermillSaveDefinition = null;
         super.populateFromSaveDefinition(param1);
         if(param1 is WatermillSaveDefinition)
         {
            _loc2_ = WatermillSaveDefinition(param1);
            this._riverBuildingComponent.riverDirection = _loc2_.orientation;
         }
         else
         {
            this._riverBuildingComponent.riverDirection = currentState;
         }
         this.syncCurrentStateToOrientation();
      }
      
      public function syncCurrentStateToOrientation() : void
      {
         currentState = this._riverBuildingComponent.riverDirection * NUMBER_OF_STATES + (tier - 1);
      }
   }
}
