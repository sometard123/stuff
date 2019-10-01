package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class GlacierDef extends LevelDef
   {
       
      
      public function GlacierDef()
      {
         super();
         id = "Glacier";
         name = "Glacier";
         assetClassName = "assets.maps.Glacier";
         terrainClassName = "assets.maps.GlacierTerrain";
         swfName = "glacier.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-2,-100)).ini_endPoint(new Vector2(-2,-58)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(131.406504065041,-58)).ini_baseStart(new Vector2(-2,-58)).ini_baseEnd(new Vector2(121,75)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(254.599021150149,-1632.45811484006)).ini_baseStart(new Vector2(121,75)).ini_baseEnd(new Vector2(190,79)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(190,79)).ini_endPoint(new Vector2(485,81)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(484.562489505793,145.532797895562)).ini_baseStart(new Vector2(485,81)).ini_baseEnd(new Vector2(549,142)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(488.97500734352,145.290880825649)).ini_baseStart(new Vector2(549,142)).ini_baseEnd(new Vector2(482,205)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(482,205)).ini_endPoint(new Vector2(212,206)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(212.251652107862,273.946069122674)).ini_baseStart(new Vector2(212,206)).ini_baseEnd(new Vector2(147,255)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(187.02005715587,266.619978110518)).ini_baseStart(new Vector2(147,255)).ini_baseEnd(new Vector2(165,302)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(233.871258906459,191.343309582776)).ini_baseStart(new Vector2(165,302)).ini_baseEnd(new Vector2(213,320)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(213,320)).ini_endPoint(new Vector2(486,321)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(485.698932557011,403.191411935953)).ini_baseStart(new Vector2(486,321)).ini_baseEnd(new Vector2(555,359)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(513.140792787645,385.692481623828)).ini_baseStart(new Vector2(555,359)).ini_baseEnd(new Vector2(547,422)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(491.838634690894,362.84999474281)).ini_baseStart(new Vector2(547,422)).ini_baseEnd(new Vector2(481,443)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(481,443)).ini_endPoint(new Vector2(183,444)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(184.117157490397,776.912932138284)).ini_baseStart(new Vector2(183,444)).ini_baseEnd(new Vector2(60,468)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(112.466204348952,598.582180186129)).ini_baseStart(new Vector2(60,468)).ini_baseEnd(new Vector2(-28,590)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
