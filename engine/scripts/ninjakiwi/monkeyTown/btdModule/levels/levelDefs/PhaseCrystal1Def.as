package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class PhaseCrystal1Def extends LevelDef
   {
       
      
      public function PhaseCrystal1Def()
      {
         super();
         id = "PhaseCrystal1";
         name = "PhaseCrystal1";
         assetClassName = "assets.maps.PhaseCrystal1";
         terrainClassName = "assets.maps.PhaseCrystal1Terrain";
         swfName = "PhaseCrystal.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(209,-100)).ini_endPoint(new Vector2(209,-66)).ini_nextTileIndices(Vector.<int>([1,4,8,12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(209,-66)).ini_endPoint(new Vector2(212,269)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(357.574696958774,267.696345997384)).ini_baseStart(new Vector2(212,269)).ini_baseEnd(new Vector2(502,286)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(502,286)).ini_endPoint(new Vector2(496,-47)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(209,-66)).ini_endPoint(new Vector2(-62,130)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-62,130)).ini_endPoint(new Vector2(365,125)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(366.677705686222,268.276065603316)).ini_baseStart(new Vector2(365,125)).ini_baseEnd(new Vector2(354,411)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(354,411)).ini_endPoint(new Vector2(-58,412)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(209,-66)).ini_endPoint(new Vector2(758,129)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(758,129)).ini_endPoint(new Vector2(365,125)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(363.532805429864,269.151866515837)).ini_baseStart(new Vector2(365,125)).ini_baseEnd(new Vector2(373,413)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(373,413)).ini_endPoint(new Vector2(770,414)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(209,-66)).ini_endPoint(new Vector2(503,584)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(503,584)).ini_endPoint(new Vector2(501,265)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(357.74537037037,265.898148148148)).ini_baseStart(new Vector2(501,265)).ini_baseEnd(new Vector2(215,278)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(215,278)).ini_endPoint(new Vector2(215,582)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
