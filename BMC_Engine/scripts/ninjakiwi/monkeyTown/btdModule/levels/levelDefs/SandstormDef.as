package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class SandstormDef extends LevelDef
   {
       
      
      public function SandstormDef()
      {
         super();
         id = "Sandstorm";
         name = "Sandstorm";
         assetClassName = "assets.maps.Sandstorm";
         terrainClassName = "assets.maps.SandstormTerrain";
         swfName = "sandstorm.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,62)).ini_endPoint(new Vector2(-2,62)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-2,62)).ini_endPoint(new Vector2(548,62)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(548,132.514184397163)).ini_baseStart(new Vector2(548,62)).ini_baseEnd(new Vector2(546,203)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(546,203)).ini_endPoint(new Vector2(146,204)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(146.182540497962,277.016199184904)).ini_baseStart(new Vector2(146,204)).ini_baseEnd(new Vector2(144,350)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(144,350)).ini_endPoint(new Vector2(540,350)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(540,427.262987012987)).ini_baseStart(new Vector2(540,350)).ini_baseEnd(new Vector2(531,504)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(531,504)).ini_endPoint(new Vector2(-30,502)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
