package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Forest2Def extends LevelDef
   {
       
      
      public function Forest2Def()
      {
         super();
         id = "Forest2";
         name = "Forest2";
         assetClassName = "assets.maps.Forest2";
         terrainClassName = "assets.maps.Forest2Terrain";
         swfName = "forest.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(227,-100)).ini_endPoint(new Vector2(227,-25)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(227,-25)).ini_endPoint(new Vector2(261,36)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(261,36)).ini_endPoint(new Vector2(343,35)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(343,35)).ini_endPoint(new Vector2(389,106)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(389,106)).ini_endPoint(new Vector2(472,107)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(472,107)).ini_endPoint(new Vector2(517,37)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(517,37)).ini_endPoint(new Vector2(604,36)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(604,36)).ini_endPoint(new Vector2(645,107)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(645,107)).ini_endPoint(new Vector2(604,183)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(604,183)).ini_endPoint(new Vector2(645,258)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(645,258)).ini_endPoint(new Vector2(603,334)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(603,334)).ini_endPoint(new Vector2(518,335)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(518,335)).ini_endPoint(new Vector2(471,407)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(471,407)).ini_endPoint(new Vector2(387,410)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(387,410)).ini_endPoint(new Vector2(344,483)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(344,483)).ini_endPoint(new Vector2(257,483)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(257,483)).ini_endPoint(new Vector2(217,409)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(217,409)).ini_endPoint(new Vector2(262,335)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(262,335)).ini_endPoint(new Vector2(344,334)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(344,334)).ini_endPoint(new Vector2(388,256)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(388,256)).ini_endPoint(new Vector2(346,185)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(346,185)).ini_endPoint(new Vector2(257,185)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(257,185)).ini_endPoint(new Vector2(213,258)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(213,258)).ini_endPoint(new Vector2(130,261)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(130,261)).ini_endPoint(new Vector2(88,336)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(88,336)).ini_endPoint(new Vector2(127,410)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(127,410)).ini_endPoint(new Vector2(84,487)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(84,487)).ini_endPoint(new Vector2(157,603)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}