package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Hills6Def extends LevelDef
   {
       
      
      public function Hills6Def()
      {
         super();
         id = "Hills6";
         name = "Hills6";
         assetClassName = "assets.maps.Hills6";
         terrainClassName = "assets.maps.Hills6Terrain";
         swfName = "hills.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(110,-100)).ini_endPoint(new Vector2(110,-25)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(110,-25)).ini_endPoint(new Vector2(107,17)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(418.33445945946,39.2381756756757)).ini_baseStart(new Vector2(107,17)).ini_baseEnd(new Vector2(120,131)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-200.172886679666,229.478895914817)).ini_baseStart(new Vector2(120,131)).ini_baseEnd(new Vector2(130,286)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(1603.09044142721,538.173032752912)).ini_baseStart(new Vector2(130,286)).ini_baseEnd(new Vector2(112,437)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(157.529780819204,440.08927337878)).ini_baseStart(new Vector2(112,437)).ini_baseEnd(new Vector2(142,483)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(163.811827405232,422.731193003204)).ini_baseStart(new Vector2(142,483)).ini_baseEnd(new Vector2(179,485)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(171.235930532294,453.168695728354)).ini_baseStart(new Vector2(179,485)).ini_baseEnd(new Vector2(204,453)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(3402.53073860842,436.531396393072)).ini_baseStart(new Vector2(204,453)).ini_baseEnd(new Vector2(209,257)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-3044.60738831011,74.0912618199311)).ini_baseStart(new Vector2(209,257)).ini_baseEnd(new Vector2(214,104)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(279.972180593208,104.605517769219)).ini_baseStart(new Vector2(214,104)).ini_baseEnd(new Vector2(273,39)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(293.921514295216,235.863342752621)).ini_baseStart(new Vector2(273,39)).ini_baseEnd(new Vector2(350,46)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(340.66305335987,77.6118361242891)).ini_baseStart(new Vector2(350,46)).ini_baseEnd(new Vector2(373,84)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(711.147101252029,150.800960552467)).ini_baseStart(new Vector2(373,84)).ini_baseEnd(new Vector2(367,170)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-1049.09277241231,249)).ini_baseStart(new Vector2(367,170)).ini_baseEnd(new Vector2(367,328)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-54.6422981851561,304.477712332445)).ini_baseStart(new Vector2(367,328)).ini_baseEnd(new Vector2(354,411)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(404.22866391631,424.093290172389)).ini_baseStart(new Vector2(354,411)).ini_baseEnd(new Vector2(382,471)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(435.657026922517,357.77346503853)).ini_baseStart(new Vector2(382,471)).ini_baseEnd(new Vector2(452,482)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(525.179850388236,1038.25614749708)).ini_baseStart(new Vector2(452,482)).ini_baseEnd(new Vector2(555,478)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(557.734709007914,426.620729498454)).ini_baseStart(new Vector2(555,478)).ini_baseEnd(new Vector2(609,431)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(3719.77565819644,696.733946169727)).ini_baseStart(new Vector2(609,431)).ini_baseEnd(new Vector2(620,324)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(252.797230976172,279.845534569319)).ini_baseStart(new Vector2(620,324)).ini_baseEnd(new Vector2(621,245)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(1083.19117417091,201.259702826504)).ini_baseStart(new Vector2(621,245)).ini_baseEnd(new Vector2(622,148)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(513.087253725019,135.422438187262)).ini_baseStart(new Vector2(622,148)).ini_baseEnd(new Vector2(615,95)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(742.931882597838,44.2573911948378)).ini_baseStart(new Vector2(615,95)).ini_baseEnd(new Vector2(624,-25)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(624,-25)).ini_endPoint(new Vector2(633,-78)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}