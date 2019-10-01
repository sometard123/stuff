package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertBadlands3Def extends LevelDef
   {
       
      
      public function DesertBadlands3Def()
      {
         super();
         id = "DesertBadlands3";
         name = "DesertBadlands3";
         assetClassName = "assets.maps.DesertBadlands3";
         terrainClassName = "assets.maps.DesertBadlands3Terrain";
         swfName = "desert_badlands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,103)).ini_endPoint(new Vector2(-17,103)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-17,103)).ini_endPoint(new Vector2(33,144)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(215.189448441247,-78.1822541966427)).ini_baseStart(new Vector2(33,144)).ini_baseEnd(new Vector2(107,188)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(47.1702614150962,335.201181944966)).ini_baseStart(new Vector2(107,188)).ini_baseEnd(new Vector2(180,248)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(99.3960164646748,300.91557981393)).ini_baseStart(new Vector2(180,248)).ini_baseEnd(new Vector2(174,362)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(117.349379786455,315.615475676482)).ini_baseStart(new Vector2(174,362)).ini_baseEnd(new Vector2(55,354)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(156.973446585543,291.22147270395)).ini_baseStart(new Vector2(55,354)).ini_baseEnd(new Vector2(76,203)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(172.140854227741,307.746532408333)).ini_baseStart(new Vector2(76,203)).ini_baseEnd(new Vector2(228,177)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(134.254806401243,396.42439010717)).ini_baseStart(new Vector2(228,177)).ini_baseEnd(new Vector2(296,221)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(612.916433990826,-122.718851304444)).ini_baseStart(new Vector2(296,221)).ini_baseEnd(new Vector2(475,324)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(532.648752168671,137.272547710765)).ini_baseStart(new Vector2(475,324)).ini_baseEnd(new Vector2(607,318)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(574.003458547378,237.794474941201)).ini_baseStart(new Vector2(607,318)).ini_baseEnd(new Vector2(653,202)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(570.615218652511,239.329735419463)).ini_baseStart(new Vector2(653,202)).ini_baseEnd(new Vector2(566,149)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(569.507095801752,217.641392686924)).ini_baseStart(new Vector2(566,149)).ini_baseEnd(new Vector2(512,180)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(615.490833596513,247.74014671742)).ini_baseStart(new Vector2(512,180)).ini_baseEnd(new Vector2(532,339)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(532,339)).ini_endPoint(new Vector2(588,406)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(588,406)).ini_endPoint(new Vector2(785,602)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
