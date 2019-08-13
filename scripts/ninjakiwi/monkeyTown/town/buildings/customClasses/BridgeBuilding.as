package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BridgeSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.tileProps.RiverTileSet;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class BridgeBuilding extends PremiumBuilding
   {
      
      private static const BRIDGE_TOP_VERTICAL:int = 0;
      
      private static const BRIDGE_LEFT_CORNER_BOTTOM:int = 1;
      
      private static const BRIDGE_HORIZONTAL:int = 2;
      
      private static const BRIDGE_LEFT_CORNER_TOP:int = 3;
      
      private static const BRIDGE_RIGHT_CORNER_TOP:int = 4;
      
      private static const BRIDGE_RIGHT_CORNER_BOTTOM:int = 5;
       
      
      private var _riverBuildingComponent:OrientatedRiverBuildingComponent;
      
      public function BridgeBuilding(param1:MonkeyTownBuildingDefinition, param2:int, param3:City = null)
      {
         super(param1,param2,param3);
         this._riverBuildingComponent = new OrientatedRiverBuildingComponent(this);
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:BridgeSaveDefinition = new BridgeSaveDefinition();
         populateSaveDefinition(_loc1_);
         _loc1_.orientation = this._riverBuildingComponent.riverDirection;
         return _loc1_;
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         var _loc2_:BridgeSaveDefinition = null;
         super.populateFromSaveDefinition(param1);
         if(param1.hasOwnProperty("orientation"))
         {
            _loc2_ = BridgeSaveDefinition(param1);
            this._riverBuildingComponent.riverDirection = _loc2_.orientation;
         }
         this.syncCurrentStateToOrientation();
      }
      
      override public function floatOnMap(param1:TownMap) : Building
      {
         if(this._riverBuildingComponent.orientToRiverDirection(param1))
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
         this._riverBuildingComponent.orientToRiverDirection(param1);
         this.syncCurrentStateToOrientation();
         super.placeOnMap(param1,param2,param3,param4);
         return this;
      }
      
      public function syncCurrentStateToOrientation() : void
      {
         var _loc1_:RiverTileSet = RiverTileSet.getInstance();
         if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.leftToRight] || this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.rightToLeft])
         {
            currentState = BRIDGE_TOP_VERTICAL;
         }
         else if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.topToRight])
         {
            currentState = BRIDGE_LEFT_CORNER_BOTTOM;
         }
         else if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.topToBottom])
         {
            currentState = BRIDGE_HORIZONTAL;
         }
         else if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.topToLeft])
         {
            currentState = BRIDGE_LEFT_CORNER_TOP;
         }
         else if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.leftToBottom])
         {
            currentState = BRIDGE_RIGHT_CORNER_TOP;
         }
         else if(this._riverBuildingComponent.riverDirection == _loc1_.orientationIDs[_loc1_.rightToBottom])
         {
            currentState = BRIDGE_RIGHT_CORNER_BOTTOM;
         }
      }
      
      public function setToDefaultOrientation() : void
      {
         currentState = BRIDGE_RIGHT_CORNER_BOTTOM;
      }
   }
}
