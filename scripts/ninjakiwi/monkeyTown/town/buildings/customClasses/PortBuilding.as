package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.PortBuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class PortBuilding extends Building
   {
       
      
      private var _orienatedWaterBuildingComponent:OrientatedWaterEdgeBuildingComponent;
      
      private var howManyOrientations:int = 5;
      
      private var howManyStates:int = 3;
      
      public function PortBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         this._orienatedWaterBuildingComponent = new OrientatedWaterEdgeBuildingComponent(this,true,true);
      }
      
      override public function floatOnMap(param1:TownMap) : Building
      {
         if(this._orienatedWaterBuildingComponent != null)
         {
            if(this._orienatedWaterBuildingComponent.orientToLakeDirection(param1))
            {
               this.syncCurrentStateToOrientation();
            }
         }
         super.floatOnMap(param1);
         return this;
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         if(this._orienatedWaterBuildingComponent != null)
         {
            if(this._orienatedWaterBuildingComponent.waterEdgeDirection == -1)
            {
               if(this._orienatedWaterBuildingComponent.orientToLakeDirection(param1))
               {
                  this.syncCurrentStateToOrientation();
               }
            }
            else
            {
               this.syncCurrentStateToOrientation();
            }
         }
         if(param1 !== null)
         {
            super.placeOnMap(param1,param2,param3,param4);
         }
         return this;
      }
      
      private function syncCurrentStateToOrientation() : void
      {
         var _loc1_:int = _city.upgradeTree.getBuildingUpgradeIndex(definition.upgrades);
         if(this._orienatedWaterBuildingComponent.waterEdgeDirection >= this.howManyOrientations)
         {
            this._orienatedWaterBuildingComponent.waterEdgeDirection = this.howManyOrientations - 1;
         }
         else if(this._orienatedWaterBuildingComponent.waterEdgeDirection < 0)
         {
            this._orienatedWaterBuildingComponent.waterEdgeDirection = 0;
         }
         currentState = this._orienatedWaterBuildingComponent.waterEdgeDirection * this.howManyStates + _loc1_;
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:PortBuildingSaveDefinition = new PortBuildingSaveDefinition();
         populateSaveDefinition(_loc1_);
         _loc1_.orientation = this._orienatedWaterBuildingComponent.waterEdgeDirection;
         return _loc1_;
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         super.populateFromSaveDefinition(param1);
         var _loc2_:PortBuildingSaveDefinition = PortBuildingSaveDefinition(param1);
         this._orienatedWaterBuildingComponent.waterEdgeDirection = _loc2_.orientation;
         this.syncCurrentStateToOrientation();
      }
   }
}
