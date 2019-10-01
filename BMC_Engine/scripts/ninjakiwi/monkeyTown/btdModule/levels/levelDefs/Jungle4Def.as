package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Jungle4Def extends LevelDef
   {
       
      
      public function Jungle4Def()
      {
         super();
         id = "Jungle4";
         name = "Jungle4";
         assetClassName = "assets.maps.Jungle4";
         terrainClassName = "assets.maps.Jungle4Terrain";
         swfName = "jungle.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(900,76)).ini_endPoint(new Vector2(732,76)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(732,76)).ini_endPoint(new Vector2(234,79)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(234,79)).ini_endPoint(new Vector2(539,388)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(493.163654582543,433.242994667716)).ini_baseStart(new Vector2(539,388)).ini_baseEnd(new Vector2(445,476)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(445,476)).ini_endPoint(new Vector2(134,176)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(134,176)).ini_endPoint(new Vector2(132,617)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
