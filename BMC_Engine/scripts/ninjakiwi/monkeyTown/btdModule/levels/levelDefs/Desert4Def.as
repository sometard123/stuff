package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Desert4Def extends LevelDef
   {
       
      
      public function Desert4Def()
      {
         super();
         id = "Desert4";
         name = "Desert4";
         assetClassName = "assets.maps.Desert4";
         terrainClassName = "assets.maps.Desert4Terrain";
         swfName = "desert.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,70)).ini_endPoint(new Vector2(-26,70)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-26,70)).ini_endPoint(new Vector2(120,194)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(194.746435452794,105.992100192678)).ini_baseStart(new Vector2(120,194)).ini_baseEnd(new Vector2(278,186)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(278,186)).ini_endPoint(new Vector2(408,56)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(452.2,100.2)).ini_baseStart(new Vector2(408,56)).ini_baseEnd(new Vector2(492,52)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(457.033806343907,94.3459933222037)).ini_baseStart(new Vector2(492,52)).ini_baseEnd(new Vector2(489,139)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(489,139)).ini_endPoint(new Vector2(229,394)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(268.55652601796,434.332144175175)).ini_baseStart(new Vector2(229,394)).ini_baseEnd(new Vector2(316,465)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(316,465)).ini_endPoint(new Vector2(454,331)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(525.768509156275,404.910852713178)).ini_baseStart(new Vector2(454,331)).ini_baseEnd(new Vector2(592,326)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(592,326)).ini_endPoint(new Vector2(784,485)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
