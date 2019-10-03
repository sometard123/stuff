package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Mountain4Def extends LevelDef
   {
       
      
      public function Mountain4Def()
      {
         super();
         id = "Mountain4";
         name = "Mountain4";
         assetClassName = "assets.maps.Mountain4";
         terrainClassName = "assets.maps.Mountain4Terrain";
         swfName = "mountain.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(900,231)).ini_endPoint(new Vector2(717,231)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(717,231)).ini_endPoint(new Vector2(669,264)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(552.692826587693,94.8259295820994)).ini_baseStart(new Vector2(669,264)).ini_baseEnd(new Vector2(416,248)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(416,248)).ini_endPoint(new Vector2(402,263)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(325.003735699276,191.136819985991)).ini_baseStart(new Vector2(402,263)).ini_baseEnd(new Vector2(263,106)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(235.851720860523,68.7229209988699)).ini_baseStart(new Vector2(263,106)).ini_baseEnd(new Vector2(199,41)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(548.614796652823,304.009247908014)).ini_baseStart(new Vector2(199,41)).ini_baseEnd(new Vector2(159,105)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(337.395825112618,196.121844679906)).ini_baseStart(new Vector2(159,105)).ini_baseEnd(new Vector2(194,336)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(316.884888401394,216.129623768315)).ini_baseStart(new Vector2(194,336)).ini_baseEnd(new Vector2(393,370)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(407.401365091045,399.11305545336)).ini_baseStart(new Vector2(393,370)).ini_baseEnd(new Vector2(428,374)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(286.899495052223,546.024254078606)).ini_baseStart(new Vector2(428,374)).ini_baseEnd(new Vector2(505,590)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
