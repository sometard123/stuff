package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertHighlands2Def extends LevelDef
   {
       
      
      public function DesertHighlands2Def()
      {
         super();
         id = "DesertHighlands2";
         name = "DesertHighlands2";
         assetClassName = "assets.maps.DesertHighlands2";
         terrainClassName = "assets.maps.DesertHighlands2Terrain";
         swfName = "desert_highlands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(89,600)).ini_endPoint(new Vector2(89,552)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(89,552)).ini_endPoint(new Vector2(292,348)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(292,348)).ini_endPoint(new Vector2(178,347)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(178,347)).ini_endPoint(new Vector2(181,250)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(181,250)).ini_endPoint(new Vector2(420,254)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(420,254)).ini_endPoint(new Vector2(426,422)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(426,422)).ini_endPoint(new Vector2(533,423)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(533,423)).ini_endPoint(new Vector2(532,-42)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
