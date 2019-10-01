package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Jungle5Def extends LevelDef
   {
       
      
      public function Jungle5Def()
      {
         super();
         id = "Jungle5";
         name = "Jungle5";
         assetClassName = "assets.maps.Jungle5";
         terrainClassName = "assets.maps.Jungle5Terrain";
         swfName = "jungle.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(182,600)).ini_endPoint(new Vector2(182,574)).ini_nextTileIndices(Vector.<int>([1,25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(182,574)).ini_endPoint(new Vector2(143,548)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(143,548)).ini_endPoint(new Vector2(145,461)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(145,461)).ini_endPoint(new Vector2(61,460)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(61,460)).ini_endPoint(new Vector2(63,380)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(63,380)).ini_endPoint(new Vector2(143,378)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(143,378)).ini_endPoint(new Vector2(145,306)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(145,306)).ini_endPoint(new Vector2(62,304)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(62,304)).ini_endPoint(new Vector2(64,203)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(64,203)).ini_endPoint(new Vector2(145,201)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(145,201)).ini_endPoint(new Vector2(147,126)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(147,126)).ini_endPoint(new Vector2(59,124)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(59,124)).ini_endPoint(new Vector2(61,51)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(61,51)).ini_endPoint(new Vector2(310,47)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(310,47)).ini_endPoint(new Vector2(399,126)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(399,126)).ini_endPoint(new Vector2(482,126)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(482,126)).ini_endPoint(new Vector2(481,199)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(481,199)).ini_endPoint(new Vector2(396,200)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(396,200)).ini_endPoint(new Vector2(398,303)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(398,303)).ini_endPoint(new Vector2(483,305)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(483,305)).ini_endPoint(new Vector2(481,378)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(481,378)).ini_endPoint(new Vector2(395,379)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(395,379)).ini_endPoint(new Vector2(397,458)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(397,458)).ini_endPoint(new Vector2(484,459)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(484,459)).ini_endPoint(new Vector2(482,607)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(182,574)).ini_endPoint(new Vector2(226,550)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(226,550)).ini_endPoint(new Vector2(228,461)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(228,461)).ini_endPoint(new Vector2(310,457)).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(310,457)).ini_endPoint(new Vector2(311,380)).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(311,380)).ini_endPoint(new Vector2(226,376)).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(226,376)).ini_endPoint(new Vector2(227,305)).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(227,305)).ini_endPoint(new Vector2(309,302)).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(309,302)).ini_endPoint(new Vector2(309,205)).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(309,205)).ini_endPoint(new Vector2(226,201)).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(226,201)).ini_endPoint(new Vector2(226,127)).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(226,127)).ini_endPoint(new Vector2(306,125)).ini_nextTileIndices(Vector.<int>([36])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(306,125)).ini_endPoint(new Vector2(400,45)).ini_nextTileIndices(Vector.<int>([37])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(400,45)).ini_endPoint(new Vector2(642,47)).ini_nextTileIndices(Vector.<int>([38])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(642,47)).ini_endPoint(new Vector2(642,126)).ini_nextTileIndices(Vector.<int>([39])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(642,126)).ini_endPoint(new Vector2(562,126)).ini_nextTileIndices(Vector.<int>([40])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(562,126)).ini_endPoint(new Vector2(562,199)).ini_nextTileIndices(Vector.<int>([41])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(562,199)).ini_endPoint(new Vector2(645,201)).ini_nextTileIndices(Vector.<int>([42])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(645,201)).ini_endPoint(new Vector2(644,304)).ini_nextTileIndices(Vector.<int>([43])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(644,304)).ini_endPoint(new Vector2(560,306)).ini_nextTileIndices(Vector.<int>([44])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(560,306)).ini_endPoint(new Vector2(562,377)).ini_nextTileIndices(Vector.<int>([45])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(562,377)).ini_endPoint(new Vector2(644,380)).ini_nextTileIndices(Vector.<int>([46])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(644,380)).ini_endPoint(new Vector2(644,456)).ini_nextTileIndices(Vector.<int>([47])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(644,456)).ini_endPoint(new Vector2(560,457)).ini_nextTileIndices(Vector.<int>([48])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(560,457)).ini_endPoint(new Vector2(562,614)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
