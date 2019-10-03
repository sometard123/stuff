package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Desert5Def extends LevelDef
   {
       
      
      public function Desert5Def()
      {
         super();
         id = "Desert5";
         name = "Desert5";
         assetClassName = "assets.maps.Desert5";
         terrainClassName = "assets.maps.Desert5Terrain";
         swfName = "desert.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(653,-100)).ini_endPoint(new Vector2(653,-29)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(653,-29)).ini_endPoint(new Vector2(82,477)).ini_nextTileIndices(Vector.<int>([2,4])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(82,477)).ini_endPoint(new Vector2(87,185)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(87,185)).ini_endPoint(new Vector2(796,181)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(82,477)).ini_endPoint(new Vector2(424,483)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(424,483)).ini_endPoint(new Vector2(419,-62)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
