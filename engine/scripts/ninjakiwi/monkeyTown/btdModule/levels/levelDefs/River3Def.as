package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class River3Def extends LevelDef
   {
       
      
      public function River3Def()
      {
         super();
         id = "River3";
         name = "River3";
         assetClassName = "assets.maps.River3";
         terrainClassName = "assets.maps.River3Terrain";
         swfName = "river.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(460,-100)).ini_endPoint(new Vector2(460,-55)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(460,-55)).ini_endPoint(new Vector2(538,10)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(538,10)).ini_endPoint(new Vector2(564,36)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(564,36)).ini_endPoint(new Vector2(577,61)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(577,61)).ini_endPoint(new Vector2(579,87)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(579,87)).ini_endPoint(new Vector2(569,109)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(569,109)).ini_endPoint(new Vector2(540,125)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(540,125)).ini_endPoint(new Vector2(478,132)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(478,132)).ini_endPoint(new Vector2(392,131)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(392,131)).ini_endPoint(new Vector2(303,121)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(303,121)).ini_endPoint(new Vector2(261,114)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(261,114)).ini_endPoint(new Vector2(225,115)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(225,115)).ini_endPoint(new Vector2(183,127)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(183,127)).ini_endPoint(new Vector2(152,149)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(152,149)).ini_endPoint(new Vector2(135,178)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(135,178)).ini_endPoint(new Vector2(136,196)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(136,196)).ini_endPoint(new Vector2(165,216)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(165,216)).ini_endPoint(new Vector2(213,228)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(213,228)).ini_endPoint(new Vector2(283,236)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(283,236)).ini_endPoint(new Vector2(358,238)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(358,238)).ini_endPoint(new Vector2(431,241)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(431,241)).ini_endPoint(new Vector2(493,248)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(493,248)).ini_endPoint(new Vector2(544,266)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(544,266)).ini_endPoint(new Vector2(585,287)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(585,287)).ini_endPoint(new Vector2(604,313)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(604,313)).ini_endPoint(new Vector2(611,342)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(611,342)).ini_endPoint(new Vector2(603,367)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(603,367)).ini_endPoint(new Vector2(570,387)).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(570,387)).ini_endPoint(new Vector2(528,395)).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(528,395)).ini_endPoint(new Vector2(465,393)).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(465,393)).ini_endPoint(new Vector2(368,385)).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(368,385)).ini_endPoint(new Vector2(262,369)).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(262,369)).ini_endPoint(new Vector2(204,365)).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(204,365)).ini_endPoint(new Vector2(156,378)).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(156,378)).ini_endPoint(new Vector2(126,397)).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(126,397)).ini_endPoint(new Vector2(113,424)).ini_nextTileIndices(Vector.<int>([36])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(113,424)).ini_endPoint(new Vector2(112,460)).ini_nextTileIndices(Vector.<int>([37])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(112,460)).ini_endPoint(new Vector2(137,490)).ini_nextTileIndices(Vector.<int>([38])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(137,490)).ini_endPoint(new Vector2(194,527)).ini_nextTileIndices(Vector.<int>([39])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(194,527)).ini_endPoint(new Vector2(313,586)).ini_nextTileIndices(Vector.<int>([40])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(313,586)).ini_endPoint(new Vector2(361,610)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}