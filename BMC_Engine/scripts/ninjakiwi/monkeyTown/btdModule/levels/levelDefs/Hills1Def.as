package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Hills1Def extends LevelDef
   {
       
      
      public function Hills1Def()
      {
         super();
         id = "Hills1";
         name = "Hills1";
         assetClassName = "assets.maps.Hills1";
         terrainClassName = "assets.maps.Hills1Terrain";
         swfName = "hills.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(254,600)).ini_endPoint(new Vector2(254,566)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(254,566)).ini_endPoint(new Vector2(250,516)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(250,516)).ini_endPoint(new Vector2(255,483)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(255,483)).ini_endPoint(new Vector2(276,453)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(276,453)).ini_endPoint(new Vector2(304,428)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(304,428)).ini_endPoint(new Vector2(343,411)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(343,411)).ini_endPoint(new Vector2(381,403)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(381,403)).ini_endPoint(new Vector2(419,398)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(419,398)).ini_endPoint(new Vector2(467,397)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(467,397)).ini_endPoint(new Vector2(513,404)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(513,404)).ini_endPoint(new Vector2(555,410)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(555,410)).ini_endPoint(new Vector2(585,408)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(585,408)).ini_endPoint(new Vector2(627,391)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(627,391)).ini_endPoint(new Vector2(652,365)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(652,365)).ini_endPoint(new Vector2(672,333)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(672,333)).ini_endPoint(new Vector2(677,296)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(677,296)).ini_endPoint(new Vector2(669,264)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(669,264)).ini_endPoint(new Vector2(648,235)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(648,235)).ini_endPoint(new Vector2(622,219)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(622,219)).ini_endPoint(new Vector2(594,211)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(594,211)).ini_endPoint(new Vector2(568,214)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(568,214)).ini_endPoint(new Vector2(538,232)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(538,232)).ini_endPoint(new Vector2(508,258)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(508,258)).ini_endPoint(new Vector2(481,283)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(481,283)).ini_endPoint(new Vector2(458,312)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(458,312)).ini_endPoint(new Vector2(438,328)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(438,328)).ini_endPoint(new Vector2(419,341)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(419,341)).ini_endPoint(new Vector2(395,346)).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(395,346)).ini_endPoint(new Vector2(369,341)).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(369,341)).ini_endPoint(new Vector2(343,321)).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(343,321)).ini_endPoint(new Vector2(331,302)).ini_nextTileIndices(Vector.<int>([31,39])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(331,302)).ini_endPoint(new Vector2(327,274)).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(327,274)).ini_endPoint(new Vector2(324,215)).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(324,215)).ini_endPoint(new Vector2(323,144)).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(323,144)).ini_endPoint(new Vector2(327,94)).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(327,94)).ini_endPoint(new Vector2(340,55)).ini_nextTileIndices(Vector.<int>([36])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(340,55)).ini_endPoint(new Vector2(357,25)).ini_nextTileIndices(Vector.<int>([37])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(357,25)).ini_endPoint(new Vector2(409,-37)).ini_nextTileIndices(Vector.<int>([38])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(409,-37)).ini_endPoint(new Vector2(430,-63)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(331,302)).ini_endPoint(new Vector2(299,280)).ini_nextTileIndices(Vector.<int>([40])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(299,280)).ini_endPoint(new Vector2(259,267)).ini_nextTileIndices(Vector.<int>([41])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(259,267)).ini_endPoint(new Vector2(204,251)).ini_nextTileIndices(Vector.<int>([42])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(204,251)).ini_endPoint(new Vector2(147,241)).ini_nextTileIndices(Vector.<int>([43])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(147,241)).ini_endPoint(new Vector2(98,234)).ini_nextTileIndices(Vector.<int>([44])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(98,234)).ini_endPoint(new Vector2(69,234)).ini_nextTileIndices(Vector.<int>([45])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(69,234)).ini_endPoint(new Vector2(31,237)).ini_nextTileIndices(Vector.<int>([46])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(31,237)).ini_endPoint(new Vector2(4,244)).ini_nextTileIndices(Vector.<int>([47])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(4,244)).ini_endPoint(new Vector2(-85,270)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
