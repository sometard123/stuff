package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Snow2Def extends LevelDef
   {
       
      
      public function Snow2Def()
      {
         super();
         id = "Snow2";
         name = "Snow2";
         assetClassName = "assets.maps.Snow2";
         terrainClassName = "assets.maps.Snow2Terrain";
         swfName = "snow.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(65,-100)).ini_endPoint(new Vector2(65,45)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(65,45)).ini_endPoint(new Vector2(65,183)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(65,183)).ini_endPoint(new Vector2(138,181)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(138,181)).ini_endPoint(new Vector2(253,181)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(1).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(253,181)).ini_endPoint(new Vector2(454,184)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(454,184)).ini_endPoint(new Vector2(579,185)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(1).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(579,185)).ini_endPoint(new Vector2(666,185)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(666,185)).ini_endPoint(new Vector2(669,334)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(669,334)).ini_endPoint(new Vector2(433,333)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(433,333)).ini_endPoint(new Vector2(272,336)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(272,336)).ini_endPoint(new Vector2(64,338)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(64,338)).ini_endPoint(new Vector2(66,468)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(66,468)).ini_endPoint(new Vector2(200,471)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(200,471)).ini_endPoint(new Vector2(201,40)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(201,40)).ini_endPoint(new Vector2(356,37)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(356,37)).ini_endPoint(new Vector2(359,285)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(359,285)).ini_endPoint(new Vector2(360,380)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(1).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(360,380)).ini_endPoint(new Vector2(361,479)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(361,479)).ini_endPoint(new Vector2(514,480)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(1),new StraightTile().ini_startPoint(new Vector2(514,480)).ini_endPoint(new Vector2(515,-103)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(1)]);
      }
   }
}
