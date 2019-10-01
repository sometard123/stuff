package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Volcano1Def extends LevelDef
   {
       
      
      public function Volcano1Def()
      {
         super();
         id = "Volcano1";
         name = "Volcano1";
         assetClassName = "assets.maps.Volcano1";
         terrainClassName = "assets.maps.Volcano1Terrain";
         swfName = "volcano.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(295,600)).ini_endPoint(new Vector2(295,367)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(295,367)).ini_endPoint(new Vector2(271,354)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(351.981308411215,204.496046010065)).ini_baseStart(new Vector2(271,354)).ini_baseEnd(new Vector2(402,367)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(402,367)).ini_endPoint(new Vector2(407,604)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
