package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Snow4Def extends LevelDef
   {
       
      
      public function Snow4Def()
      {
         super();
         id = "Snow4";
         name = "Snow4";
         assetClassName = "assets.maps.Snow4";
         terrainClassName = "assets.maps.Snow4Terrain";
         swfName = "snow.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(228,600)).ini_endPoint(new Vector2(228,452)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(1).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(228,452)).ini_endPoint(new Vector2(230,436)).ini_nextTileIndices(Vector.<int>([2,10])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(230,436)).ini_endPoint(new Vector2(282,386)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(233.179956896552,335.227155172414)).ini_baseStart(new Vector2(282,386)).ini_baseEnd(new Vector2(288,291)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(288,291)).ini_endPoint(new Vector2(178,193)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(229.316285211268,135.400088028169)).ini_baseStart(new Vector2(178,193)).ini_baseEnd(new Vector2(283,80)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(283,80)).ini_endPoint(new Vector2(526,280)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(482.081889333197,333.360504460166)).ini_baseStart(new Vector2(526,280)).ini_baseEnd(new Vector2(517,393)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(517,393)).ini_endPoint(new Vector2(474,437)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(474,437)).ini_endPoint(new Vector2(475,593)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(230,436)).ini_endPoint(new Vector2(175,389)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(217.597401129944,339.15197740113)).ini_baseStart(new Vector2(175,389)).ini_baseEnd(new Vector2(165,300)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(165,300)).ini_endPoint(new Vector2(172,289)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(172,289)).ini_endPoint(new Vector2(431,76)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(477.957097650153,133.098067095726)).ini_baseStart(new Vector2(431,76)).ini_baseEnd(new Vector2(546,162)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(546,162)).ini_endPoint(new Vector2(544,175)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(544,175)).ini_endPoint(new Vector2(420,280)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(464.286608260325,332.300375469337)).ini_baseStart(new Vector2(420,280)).ini_baseEnd(new Vector2(423,387)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(423,387)).ini_endPoint(new Vector2(472,436)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(472,436)).ini_endPoint(new Vector2(476,592)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
