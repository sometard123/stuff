package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Grass4Def extends LevelDef
   {
       
      
      public function Grass4Def()
      {
         super();
         id = "Grass4";
         name = "Grass4";
         assetClassName = "assets.maps.Grass4";
         terrainClassName = "assets.maps.Grass4Terrain";
         swfName = "grass.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(900,79)).ini_endPoint(new Vector2(790,79)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(790,79)).ini_endPoint(new Vector2(566,182)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(566,182)).ini_endPoint(new Vector2(557,169)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(459.787610619469,236.300884955752)).ini_baseStart(new Vector2(557,169)).ini_baseEnd(new Vector2(349,195)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(349,195)).ini_endPoint(new Vector2(340,180)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(238.234870317003,241.059077809798)).ini_baseStart(new Vector2(340,180)).ini_baseEnd(new Vector2(299,343)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(299,343)).ini_endPoint(new Vector2(298,368)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(417.254191711484,372.770167668459)).ini_baseStart(new Vector2(298,368)).ini_baseEnd(new Vector2(429,254)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(429,254)).ini_endPoint(new Vector2(445,235)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(352.553223140496,157.150082644628)).ini_baseStart(new Vector2(445,235)).ini_baseEnd(new Vector2(274,249)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(274,249)).ini_endPoint(new Vector2(254,253)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(277.274647887324,369.37323943662)).ini_baseStart(new Vector2(254,253)).ini_baseEnd(new Vector2(392,339)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(392,339)).ini_endPoint(new Vector2(419,351)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(464.765870704718,248.026790914386)).ini_baseStart(new Vector2(419,351)).ini_baseEnd(new Vector2(576,230)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(576,230)).ini_endPoint(new Vector2(801,124)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
