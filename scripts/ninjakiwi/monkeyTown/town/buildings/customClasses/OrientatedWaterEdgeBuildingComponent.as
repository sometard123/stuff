package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class OrientatedWaterEdgeBuildingComponent
   {
      
      public static const LAND_EDGE_NORTH:int = 0;
      
      public static const LAND_EDGE_EAST:int = 1;
      
      public static const LAND_EDGE_SOUTH:int = 2;
      
      public static const LAND_EDGE_WEST:int = 3;
      
      public static const LAND_NO_EDGE:int = 4;
       
      
      private var _tileDefinitions:TileDefinitions;
      
      private var _building:Building;
      
      private var _lakeCompatible:Boolean;
      
      private var _riverCompatible:Boolean;
      
      public var waterEdgeDirection:int = 0;
      
      public function OrientatedWaterEdgeBuildingComponent(param1:Building, param2:Boolean = true, param3:Boolean = true)
      {
         this._tileDefinitions = TileDefinitions.getInstance();
         super();
         this._building = param1;
         this._lakeCompatible = param2;
         this._riverCompatible = param3;
      }
      
      public function orientToLakeDirection(param1:TownMap) : Boolean
      {
         var _loc2_:Tile = null;
         var _loc6_:EdgeHintHelper = null;
         if(param1 === null)
         {
            return false;
         }
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         _loc2_ = param1.tileAt(this._building.x,this._building.y,true);
         if(this.isTileOnBuildableTerrain(_loc2_))
         {
            this.waterEdgeDirection = LAND_EDGE_NORTH;
            return true;
         }
         if(!param1.hasAdjacentLand(this._building.x,this._building.y))
         {
            this.waterEdgeDirection = LAND_NO_EDGE;
            return true;
         }
         var _loc5_:Array = [new EdgeHintHelper(_loc2_.tileLeft,param1.mouseHint.x,3),new EdgeHintHelper(_loc2_.tileRight,1 - param1.mouseHint.x,1),new EdgeHintHelper(_loc2_.tileTop,param1.mouseHint.y,0),new EdgeHintHelper(_loc2_.tileBottom,1 - param1.mouseHint.y,2)];
         _loc5_.sortOn("distanceFromMouse",Array.NUMERIC);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc7_];
            if(this.isTileOnBuildableTerrain(_loc6_.borderingTile))
            {
               this.waterEdgeDirection = _loc6_.targetState;
               return true;
            }
            _loc7_++;
         }
         if(this.isTileOnBuildableTerrain(_loc2_.tileTop))
         {
            this.waterEdgeDirection = LAND_EDGE_NORTH;
            return true;
         }
         if(this.isTileOnBuildableTerrain(_loc2_.tileRight))
         {
            this.waterEdgeDirection = LAND_EDGE_EAST;
            return true;
         }
         if(this.isTileOnBuildableTerrain(_loc2_.tileBottom))
         {
            this.waterEdgeDirection = LAND_EDGE_SOUTH;
            return true;
         }
         if(this.isTileOnBuildableTerrain(_loc2_.tileLeft))
         {
            this.waterEdgeDirection = LAND_EDGE_WEST;
            return true;
         }
         return false;
      }
      
      private function isTileOnBuildableTerrain(param1:Tile) : Boolean
      {
         if(this._lakeCompatible && this._riverCompatible)
         {
            return param1.type != this._tileDefinitions.LAKE && param1.type != this._tileDefinitions.RIVER;
         }
         if(this._lakeCompatible)
         {
            return param1.type != this._tileDefinitions.LAKE;
         }
         if(this._riverCompatible)
         {
            return param1.type != this._tileDefinitions.RIVER;
         }
         return false;
      }
   }
}

import ninjakiwi.monkeyTown.display.tileSystem.Tile;

class EdgeHintHelper
{
    
   
   public var borderingTile:Tile;
   
   public var distanceFromMouse:Number;
   
   public var targetState:int;
   
   function EdgeHintHelper(param1:Tile, param2:Number, param3:int)
   {
      super();
      this.borderingTile = param1;
      this.distanceFromMouse = param2;
      this.targetState = param3;
   }
   
   public function describe() : String
   {
      return "[ distanceFromMouse: " + this.distanceFromMouse + " targetState: " + this.targetState + " borderingTile.type: " + this.borderingTile.type + " ]";
   }
}
