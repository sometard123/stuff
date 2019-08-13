package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.tileProps.RiverTileSet;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class OrientatedRiverBuildingComponent
   {
       
      
      private const _riverTileSet:RiverTileSet = RiverTileSet.getInstance();
      
      private const _tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      private var _building:Building;
      
      public var riverDirection:int;
      
      public function OrientatedRiverBuildingComponent(param1:Building)
      {
         super();
         this._building = param1;
      }
      
      public function orientToRiverDirection(param1:TownMap) : Boolean
      {
         var _loc2_:Tile = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         if(param1 === null)
         {
            return false;
         }
         _loc2_ = param1.tileAt(this._building.x,this._building.y);
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.features is Vector || _loc2_.features.riverDirection == undefined)
         {
            return false;
         }
         if(_loc2_.terrainDefinition.id != this._tileDefinitions.RIVER)
         {
            return false;
         }
         this.riverDirection = this._riverTileSet.orientationIDs[_loc2_.features.riverDirection];
         return true;
      }
   }
}
