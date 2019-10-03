package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertBadlands4Def extends LevelDef
   {
       
      
      public function DesertBadlands4Def()
      {
         super();
         id = "DesertBadlands4";
         name = "DesertBadlands4";
         assetClassName = "assets.maps.DesertBadlands4";
         terrainClassName = "assets.maps.DesertBadlands4Terrain";
         swfName = "desert_badlands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(900,413)).ini_endPoint(new Vector2(755,413)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(755,413)).ini_endPoint(new Vector2(648,282)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(127.074805808848,707.488517392773)).ini_baseStart(new Vector2(648,282)).ini_baseEnd(new Vector2(538,175)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(674.239831093777,-1.5434358722251)).ini_baseStart(new Vector2(538,175)).ini_baseEnd(new Vector2(480,108)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(357.303659085003,177.195790982178)).ini_baseStart(new Vector2(480,108)).ini_baseEnd(new Vector2(371,37)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(346.865882187629,284.036909884278)).ini_baseStart(new Vector2(371,37)).ini_baseEnd(new Vector2(280,45)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(318.497644469618,182.624116676107)).ini_baseStart(new Vector2(280,45)).ini_baseEnd(new Vector2(199,261)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(356.962954349951,157.395563824047)).ini_baseStart(new Vector2(199,261)).ini_baseEnd(new Vector2(247,311)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(-113.533212984906,814.619616539305)).ini_baseStart(new Vector2(247,311)).ini_baseEnd(new Vector2(470,607)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
