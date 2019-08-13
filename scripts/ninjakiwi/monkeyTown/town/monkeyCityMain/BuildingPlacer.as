package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import com.lgrey.input.Key;
   import flash.ui.Keyboard;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.mouseManager.MouseManager;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.BuildingFactory;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class BuildingPlacer
   {
      
      public static var buildingWasPlacedSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static var buildingWasPlacedWithoutShiftSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static var buildingWasPlacedForTheFirstTimeSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static var placingBuildingWasCancelled:Signal = new Signal();
       
      
      private var _target:WorldView;
      
      public var placingBuilding:Boolean = false;
      
      public var buildingBeingPlaced:Building = null;
      
      private var _movingBuilding:Boolean = false;
      
      private var _originalTileOfMovingBuilding:Tile = null;
      
      private var _buildingFactory:BuildingFactory;
      
      private var _map:TownMap;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _mouseManager:MouseManager;
      
      public var beginFloatingBuildingSignal:Signal;
      
      public var endFloatingBuildingSignal:Signal;
      
      private var _disableAutoCancelByUI:Boolean = false;
      
      public function BuildingPlacer(param1:WorldView, param2:TownMap, param3:MouseManager)
      {
         this._buildingFactory = BuildingFactory.getInstance();
         this.beginFloatingBuildingSignal = new Signal();
         this.endFloatingBuildingSignal = new Signal();
         super();
         this._target = param1;
         this._map = param2;
         this._mouseManager = param3;
         Building.requestMoveSignal.add(this.beginMovingBuilding);
         TownUI.globalMouseDownSignal.add(this.cancelIfActive);
         WorldViewSignals.buildWorldStartSignal.add(this.cancel);
         WorldViewSignals.buildWorldEndSignal.add(this.cancel);
      }
      
      private function cancel(... rest) : void
      {
         this.cancelPlacingBuilding();
         placingBuildingWasCancelled.dispatch();
      }
      
      private function cancelIfActive(... rest) : void
      {
         if(this.placingBuilding && !this._disableAutoCancelByUI)
         {
            this.cancelPlacingBuilding();
            placingBuildingWasCancelled.dispatch();
         }
      }
      
      public function beginMovingBuilding(param1:Building) : void
      {
         if(this.placingBuilding)
         {
            return;
         }
         param1.clearLandBeneathFootprint();
         this.placingBuilding = true;
         this.buildingBeingPlaced = param1;
         this.buildingBeingPlaced.selectAnimationState(Building.FLOATING);
         this.buildingBeingPlaced.setPlayStateOfAllClips(false,1,true);
         this._originalTileOfMovingBuilding = this.buildingBeingPlaced.homeTile;
         this._movingBuilding = true;
         this.buildingBeingPlaced.floatOnMap(this._map);
         this.beginFloatingBuildingSignal.dispatch();
      }
      
      public function beginPlacingBuilding(param1:MonkeyTownBuildingDefinition) : void
      {
         this.placingBuilding = true;
         this.buildingBeingPlaced = this._buildingFactory.getBuilding(param1);
         this.buildingBeingPlaced.selectAnimationState(Building.FLOATING);
         this.buildingBeingPlaced.setPlayStateOfAllClips(false,-1,true);
         this.beginFloatingBuildingSignal.dispatch();
      }
      
      public function update(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         this.updateFloatingBuilding(param3);
      }
      
      public function placeBuildingOnTile(param1:MonkeyTownBuildingDefinition, param2:Tile) : void
      {
         this.beginPlacingBuilding(param1);
      }
      
      public function cancelPlacingBuilding() : void
      {
         if(this._movingBuilding)
         {
            this.buildingBeingPlaced.unfloatFromMap(this._map);
            this.buildingBeingPlaced.x = this._originalTileOfMovingBuilding.positionTilespace.x;
            this.buildingBeingPlaced.y = this._originalTileOfMovingBuilding.positionTilespace.y;
            this.buildingBeingPlaced.selectAnimationState(Building.DEFAULT_ANIMATION);
            this.buildingBeingPlaced.placeOnMap(this._map,false,false,true);
            this.buildingBeingPlaced.finishMoving();
            Tile.tileChangedSignal.dispatch(this._originalTileOfMovingBuilding);
         }
         else if(this.buildingBeingPlaced)
         {
            this.buildingBeingPlaced.unfloatFromMap(this._map);
            this.buildingBeingPlaced.die();
         }
         this.placingBuilding = false;
         this._movingBuilding = false;
         this._originalTileOfMovingBuilding = null;
         this.buildingBeingPlaced = null;
         this.endFloatingBuildingSignal.dispatch();
      }
      
      public function updateFloatingBuilding(param1:Boolean = true) : void
      {
         if(!this.buildingBeingPlaced)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         this.buildingBeingPlaced.unfloatFromMap(this._map);
         this.buildingBeingPlaced.floatOnMap(this._map);
      }
      
      public function placeBuilding(param1:int, param2:int) : void
      {
         var position:IntPoint2D = null;
         var x:int = param1;
         var y:int = param2;
         position = new IntPoint2D(x,y);
         var tile:Tile = this._map.tileAt(position.x,position.y);
         this.buildingBeingPlaced.selectAnimationState("");
         this.testForSpecialTerrain(this.buildingBeingPlaced,tile,function(param1:Boolean):void
         {
            if(param1 === false)
            {
               return;
            }
            buildingBeingPlaced.floatOnMap(_map);
            buildingBeingPlaced.unfloatFromMap(_map);
            if(!buildingBeingPlaced.canBePlacedOnMap(_map))
            {
               return;
            }
            if(_originalTileOfMovingBuilding)
            {
               _originalTileOfMovingBuilding.building = null;
            }
            buildingBeingPlaced.selectAnimationState(Building.DEFAULT_ANIMATION);
            buildingBeingPlaced.placeOnMap(_map,!_movingBuilding,false,_movingBuilding);
            if(!_movingBuilding)
            {
               buildingBeingPlaced.initialiseBuildClock();
            }
            _map.fenceBuilder.updateFenceAroundBlock(position.x,position.y,buildingBeingPlaced.definition.width,buildingBeingPlaced.definition.height);
            placingBuilding = false;
            if(_movingBuilding && _originalTileOfMovingBuilding !== null)
            {
               buildingBeingPlaced.finishMoving();
               if(_originalTileOfMovingBuilding !== buildingBeingPlaced.homeTile)
               {
                  if(buildingBeingPlaced.definition.nkCoinCost == 0)
                  {
                     ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney - Constants.COST_TO_MOVE_BUILDING;
                  }
                  Tile.tileChangedSignal.dispatch(_originalTileOfMovingBuilding);
                  Tile.tileChangedSignal.dispatch(buildingBeingPlaced.homeTile);
               }
            }
            else
            {
               Tile.tileChangedSignal.dispatch(buildingBeingPlaced.homeTile);
            }
            buildingWasPlacedSignal.dispatch(buildingBeingPlaced);
            if(!_movingBuilding)
            {
               buildingWasPlacedForTheFirstTimeSignal.dispatch(buildingBeingPlaced);
            }
            if(!_movingBuilding && Key.isDown(Keyboard.SHIFT) && _buildingFactory.isAvailableToBuild(buildingBeingPlaced.definition))
            {
               if(buildingBeingPlaced.definition.nkCoinCost > 0)
               {
                  if(MonkeySystem.getInstance().city.buildingManager.getBuildingCount(buildingBeingPlaced.definition.id) < PremiumBuildingManager.getInstance().buildingsBoughtINumbers[buildingBeingPlaced.definition.id].value)
                  {
                     beginPlacingBuilding(buildingBeingPlaced.definition);
                  }
                  else
                  {
                     buildingBeingPlaced.setPlayStateOfAllClips(true,-1,false);
                     buildingBeingPlaced.setHover(false,_map);
                     buildingBeingPlaced = null;
                     buildingWasPlacedWithoutShiftSignal.dispatch(buildingBeingPlaced);
                  }
               }
               else
               {
                  beginPlacingBuilding(buildingBeingPlaced.definition);
               }
            }
            else
            {
               buildingBeingPlaced.setPlayStateOfAllClips(true,-1,false);
               buildingBeingPlaced.setHover(false,_map);
               buildingBeingPlaced = null;
               buildingWasPlacedWithoutShiftSignal.dispatch(buildingBeingPlaced);
            }
            _movingBuilding = false;
            _originalTileOfMovingBuilding = null;
            endFloatingBuildingSignal.dispatch();
         });
      }
      
      private function testForSpecialTerrain(param1:Building, param2:Tile, param3:Function) : void
      {
         var specialProperty:String = null;
         var buildings:Array = null;
         var building:Building = param1;
         var tile:Tile = param2;
         var callback:Function = param3;
         this._disableAutoCancelByUI = true;
         var buildingData:BuildingData = BuildingData.getInstance();
         if(tile.terrainSpecialProperty !== null)
         {
            specialProperty = tile.terrainSpecialProperty.id;
            if(building.definition.requiresTerrainProperty !== specialProperty)
            {
               buildings = buildingData.getBuildingsRequiringSpecialTerrain(specialProperty);
               if(buildings !== null)
               {
                  WorldViewSignals.requestGenericConfirmation.dispatch("Warning - rare special tile","This is a special terrain tile that is a requirement for the " + buildings[0].name + " building. You will not be able to build the " + buildings[0].name + " building without this tile. Are you sure you want to build here?",function(param1:Boolean):void
                  {
                     _disableAutoCancelByUI = false;
                     callback(param1);
                  });
                  return;
               }
            }
         }
         callback(true);
      }
      
      public function get movingBuilding() : Boolean
      {
         return this._movingBuilding;
      }
   }
}
