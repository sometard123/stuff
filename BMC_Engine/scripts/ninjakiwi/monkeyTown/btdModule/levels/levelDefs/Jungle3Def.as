package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Jungle3Def extends LevelDef
   {
       
      
      public function Jungle3Def()
      {
         super();
         id = "Jungle3";
         name = "Jungle3";
         assetClassName = "assets.maps.Jungle3";
         terrainClassName = "assets.maps.Jungle3Terrain";
         swfName = "jungle.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(355,-100)).ini_endPoint(new Vector2(355,116)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(410.25,116)).ini_baseStart(new Vector2(355,116)).ini_baseEnd(new Vector2(405,171)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(304.949868073879,1219.14423922603)).ini_baseStart(new Vector2(405,171)).ini_baseEnd(new Vector2(508,186)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(488.430972351966,285.569638246663)).ini_baseStart(new Vector2(508,186)).ini_baseEnd(new Vector2(581,244)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(512.825859164315,274.61471470881)).ini_baseStart(new Vector2(581,244)).ini_baseEnd(new Vector2(563,330)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(482.182929591177,240.78917493277)).ini_baseStart(new Vector2(563,330)).ini_baseEnd(new Vector2(383,309)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-7207.23376892087,5529.01225377495)).ini_baseStart(new Vector2(383,309)).ini_baseEnd(new Vector2(309,203)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(220.134776535413,265.97000381546)).ini_baseStart(new Vector2(309,203)).ini_baseEnd(new Vector2(152,181)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(226.071113158428,273.373132895149)).ini_baseStart(new Vector2(152,181)).ini_baseEnd(new Vector2(118,225)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(177.72139473598,251.731574051728)).ini_baseStart(new Vector2(118,225)).ini_baseEnd(new Vector2(150,311)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(306.62572629326,-23.8662774300358)).ini_baseStart(new Vector2(150,311)).ini_baseEnd(new Vector2(270,344)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(241.212409794927,633.140577312467)).ini_baseStart(new Vector2(270,344)).ini_baseEnd(new Vector2(302,349)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(288.941908987743,410.037680656599)).ini_baseStart(new Vector2(302,349)).ini_baseEnd(new Vector2(350,423)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(350,423)).ini_endPoint(new Vector2(352,652)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
