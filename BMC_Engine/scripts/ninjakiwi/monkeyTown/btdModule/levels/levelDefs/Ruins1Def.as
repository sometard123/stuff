package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Ruins1Def extends LevelDef
   {
       
      
      public function Ruins1Def()
      {
         super();
         id = "Ruins1";
         name = "Ruins1";
         assetClassName = "assets.maps.Ruins1";
         terrainClassName = "assets.maps.Ruins1Terrain";
         swfName = "ruins.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(351,-73)).ini_endPoint(new Vector2(351,-39)).ini_nextTileIndices(Vector.<int>([1,3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(351,-39)).ini_endPoint(new Vector2(351,328)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(351,328)).ini_endPoint(new Vector2(351,695)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(351,-39)).ini_endPoint(new Vector2(-37,262)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-37,262)).ini_endPoint(new Vector2(395,259)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(395,262)).ini_endPoint(new Vector2(827,259)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
