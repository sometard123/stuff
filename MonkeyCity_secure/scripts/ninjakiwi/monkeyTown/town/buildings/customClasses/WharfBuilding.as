package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BridgeSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class WharfBuilding extends PremiumBuilding
   {
      
      private static const WHARF_UP:int = 0;
      
      private static const WHARF_RIGHT:int = 1;
      
      private static const WHARF_DOWN:int = 2;
      
      private static const WHARF_LEFT:int = 3;
       
      
      private var _waterEdgeBuildingComponent:OrientatedWaterEdgeBuildingComponent;
      
      private var howManyOrientations:int = 4;
      
      public function WharfBuilding(param1:MonkeyTownBuildingDefinition, param2:int, param3:City = null)
      {
         super(param1,param2,param3);
         this._waterEdgeBuildingComponent = new OrientatedWaterEdgeBuildingComponent(this,true,false);
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:BridgeSaveDefinition = new BridgeSaveDefinition();
         populateSaveDefinition(_loc1_);
         _loc1_.orientation = this._waterEdgeBuildingComponent.waterEdgeDirection;
         return _loc1_;
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         var _loc2_:BridgeSaveDefinition = null;
         super.populateFromSaveDefinition(param1);
         if(param1.hasOwnProperty("orientation"))
         {
            _loc2_ = BridgeSaveDefinition(param1);
            this._waterEdgeBuildingComponent.waterEdgeDirection = _loc2_.orientation;
         }
         this.syncCurrentStateToOrientation();
      }
      
      override public function floatOnMap(param1:TownMap) : Building
      {
         if(this._waterEdgeBuildingComponent.orientToLakeDirection(param1))
         {
            this.syncCurrentStateToOrientation();
         }
         else
         {
            this.setToDefaultOrientation();
         }
         super.floatOnMap(param1);
         return this;
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         this._waterEdgeBuildingComponent.orientToLakeDirection(param1);
         this.syncCurrentStateToOrientation();
         super.placeOnMap(param1,param2,param3,param4);
         return this;
      }
      
      private function syncCurrentStateToOrientation() : void
      {
         if(this._waterEdgeBuildingComponent.waterEdgeDirection >= this.howManyOrientations)
         {
            this._waterEdgeBuildingComponent.waterEdgeDirection = WHARF_UP;
         }
         else if(this._waterEdgeBuildingComponent.waterEdgeDirection == OrientatedWaterEdgeBuildingComponent.LAND_EDGE_NORTH)
         {
            this._waterEdgeBuildingComponent.waterEdgeDirection = WHARF_UP;
         }
         currentState = this._waterEdgeBuildingComponent.waterEdgeDirection;
      }
      
      public function setToDefaultOrientation() : void
      {
         currentState = WHARF_UP;
      }
   }
}
