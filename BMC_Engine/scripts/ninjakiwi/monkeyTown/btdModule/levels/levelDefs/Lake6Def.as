package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Lake6Def extends LevelDef
   {
       
      
      public function Lake6Def()
      {
         super();
         id = "Lake6";
         name = "Lake6";
         assetClassName = "assets.maps.Lake6";
         terrainClassName = "assets.maps.Lake6Terrain";
         swfName = "lake.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-2,-100)).ini_endPoint(new Vector2(-2,-20)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-2,-20)).ini_endPoint(new Vector2(75,147)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(75,147)).ini_endPoint(new Vector2(207,362)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(719.186353985717,47.5414012738854)).ini_baseStart(new Vector2(207,362)).ini_baseEnd(new Vector2(306,484)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(352,435.409103065162)).ini_baseStart(new Vector2(306,484)).ini_baseEnd(new Vector2(398,484)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(100.3804815023,169.617405453963)).ini_baseStart(new Vector2(398,484)).ini_baseEnd(new Vector2(473,390)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(473,390)).ini_endPoint(new Vector2(630,128)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(630,128)).ini_endPoint(new Vector2(695,-27)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(695,-27)).ini_endPoint(new Vector2(713,-58)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
