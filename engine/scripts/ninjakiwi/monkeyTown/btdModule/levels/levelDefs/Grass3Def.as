package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Grass3Def extends LevelDef
   {
       
      
      public function Grass3Def()
      {
         super();
         id = "Grass3";
         name = "Grass3";
         assetClassName = "assets.maps.Grass3";
         terrainClassName = "assets.maps.Grass3Terrain";
         swfName = "grass.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(110,-100)).ini_endPoint(new Vector2(110,-14)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(110,-14)).ini_endPoint(new Vector2(112,270)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(112,270)).ini_endPoint(new Vector2(427,273)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(427,273)).ini_endPoint(new Vector2(428,441)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(428,441)).ini_endPoint(new Vector2(581,440)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(581,440)).ini_endPoint(new Vector2(579,93)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(579,93)).ini_endPoint(new Vector2(272,94)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(272,94)).ini_endPoint(new Vector2(273,193)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(273,193)).ini_endPoint(new Vector2(274,342)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(1).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(274,342)).ini_endPoint(new Vector2(273,596)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
