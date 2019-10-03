package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Hills3Def extends LevelDef
   {
       
      
      public function Hills3Def()
      {
         super();
         id = "Hills3";
         name = "Hills3";
         assetClassName = "assets.maps.Hills3";
         terrainClassName = "assets.maps.Hills3Terrain";
         swfName = "hills.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(236,-100)).ini_endPoint(new Vector2(236,-25)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(236,-25)).ini_endPoint(new Vector2(175,11)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(320.321326238232,257.23891390367)).ini_baseStart(new Vector2(175,11)).ini_baseEnd(new Vector2(38,212)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(274.808755211035,249.946020696954)).ini_baseStart(new Vector2(38,212)).ini_baseEnd(new Vector2(91,404)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(216.479220701685,298.83322898985)).ini_baseStart(new Vector2(91,404)).ini_baseEnd(new Vector2(203,462)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(228.318430094192,155.518892750295)).ini_baseStart(new Vector2(203,462)).ini_baseEnd(new Vector2(365,431)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(284.060045256668,267.865874683763)).ini_baseStart(new Vector2(365,431)).ini_baseEnd(new Vector2(466,260)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(2),new ArcTile().ini_baseCentre(new Vector2(248.650868277967,269.396732208503)).ini_baseStart(new Vector2(466,260)).ini_baseEnd(new Vector2(425,142)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(2),new ArcTile().ini_baseCentre(new Vector2(297.835315911084,233.865296114925)).ini_baseStart(new Vector2(425,142)).ini_baseEnd(new Vector2(296,77)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(2),new ArcTile().ini_baseCentre(new Vector2(297.357603289112,193.034978320043)).ini_baseStart(new Vector2(296,77)).ini_baseEnd(new Vector2(208,119)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(318.582825018656,210.620598040625)).ini_baseStart(new Vector2(208,119)).ini_baseEnd(new Vector2(175,208)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(262.464138728711,209.596349358272)).ini_baseStart(new Vector2(175,208)).ini_baseEnd(new Vector2(228,290)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(284.622653404614,157.901296516093)).ini_baseStart(new Vector2(228,290)).ini_baseEnd(new Vector2(298,301)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(298,301)).ini_endPoint(new Vector2(373,301)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(373,301)).ini_endPoint(new Vector2(543,297)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(1).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(543,297)).ini_endPoint(new Vector2(759,294)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
