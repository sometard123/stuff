package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertHighlands1Def extends LevelDef
   {
       
      
      public function DesertHighlands1Def()
      {
         super();
         id = "DesertHighlands1";
         name = "DesertHighlands1";
         assetClassName = "assets.maps.DesertHighlands1";
         terrainClassName = "assets.maps.DesertHighlands1Terrain";
         swfName = "desert_highlands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(212,600)).ini_endPoint(new Vector2(212,323)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(212,323)).ini_endPoint(new Vector2(110,322)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(110.4858938824,272.438823995248)).ini_baseStart(new Vector2(110,322)).ini_baseEnd(new Vector2(114,223)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(114,223)).ini_endPoint(new Vector2(199,221)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(199,221)).ini_endPoint(new Vector2(201,92)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(251.724936621341,92.7864331259123)).ini_baseStart(new Vector2(201,92)).ini_baseEnd(new Vector2(302,86)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(302,86)).ini_endPoint(new Vector2(306,217)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(306,217)).ini_endPoint(new Vector2(564,220)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(563.463953043256,266.100038279954)).ini_baseStart(new Vector2(564,220)).ini_baseEnd(new Vector2(553,311)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(553,311)).ini_endPoint(new Vector2(304,318)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(304,318)).ini_endPoint(new Vector2(308,605)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
