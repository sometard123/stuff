package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Forest4Def extends LevelDef
   {
       
      
      public function Forest4Def()
      {
         super();
         id = "Forest4";
         name = "Forest4";
         assetClassName = "assets.maps.Forest4";
         terrainClassName = "assets.maps.Forest4Terrain";
         swfName = "forest.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(116,600)).ini_endPoint(new Vector2(116,550)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(-10),new StraightTile().ini_startPoint(new Vector2(116,550)).ini_endPoint(new Vector2(116,137)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-10),new ArcTile().ini_baseCentre(new Vector2(175.152542372881,137)).ini_baseStart(new Vector2(116,137)).ini_baseEnd(new Vector2(234,131)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-10),new StraightTile().ini_startPoint(new Vector2(234,131)).ini_endPoint(new Vector2(234,379)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-10),new ArcTile().ini_baseCentre(new Vector2(295.004098360656,379)).ini_baseStart(new Vector2(234,379)).ini_baseEnd(new Vector2(356,380)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-10),new StraightTile().ini_startPoint(new Vector2(356,380)).ini_endPoint(new Vector2(357,140)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-10),new ArcTile().ini_baseCentre(new Vector2(415.5,140.24375)).ini_baseStart(new Vector2(357,140)).ini_baseEnd(new Vector2(474,140)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-10),new StraightTile().ini_startPoint(new Vector2(474,140)).ini_endPoint(new Vector2(475,375)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-10),new ArcTile().ini_baseCentre(new Vector2(538.130064829822,374.731361426256)).ini_baseStart(new Vector2(475,375)).ini_baseEnd(new Vector2(601,369)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-10),new StraightTile().ini_startPoint(new Vector2(601,369)).ini_endPoint(new Vector2(606,-91)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-10)]);
      }
   }
}
