package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Volcano3Def extends LevelDef
   {
       
      
      public function Volcano3Def()
      {
         super();
         id = "Volcano3";
         name = "Volcano3";
         assetClassName = "assets.maps.Volcano3";
         terrainClassName = "assets.maps.Volcano3Terrain";
         swfName = "volcano.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(38,-100)).ini_endPoint(new Vector2(38,-14)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(38,-14)).ini_endPoint(new Vector2(48,71)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(48,71)).ini_endPoint(new Vector2(92,94)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(92,94)).ini_endPoint(new Vector2(120,145)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(120,145)).ini_endPoint(new Vector2(54,184)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(54,184)).ini_endPoint(new Vector2(86,260)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(86,260)).ini_endPoint(new Vector2(193,239)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(193,239)).ini_endPoint(new Vector2(216,164)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(216,164)).ini_endPoint(new Vector2(222,82)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(222,82)).ini_endPoint(new Vector2(326,84)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(326,84)).ini_endPoint(new Vector2(375,155)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(375,155)).ini_endPoint(new Vector2(437,199)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(437,199)).ini_endPoint(new Vector2(493,149)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(493,149)).ini_endPoint(new Vector2(494,89)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(494,89)).ini_endPoint(new Vector2(522,42)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(522,42)).ini_endPoint(new Vector2(578,75)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(578,75)).ini_endPoint(new Vector2(632,264)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(632,264)).ini_endPoint(new Vector2(558,373)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(558,373)).ini_endPoint(new Vector2(508,352)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(508,352)).ini_endPoint(new Vector2(494,305)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(494,305)).ini_endPoint(new Vector2(402,351)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(402,351)).ini_endPoint(new Vector2(411,458)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(411,458)).ini_endPoint(new Vector2(321,507)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(321,507)).ini_endPoint(new Vector2(283,433)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(283,433)).ini_endPoint(new Vector2(197,388)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(197,388)).ini_endPoint(new Vector2(123,418)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(123,418)).ini_endPoint(new Vector2(92,491)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(92,491)).ini_endPoint(new Vector2(-41,574)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
