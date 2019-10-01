package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Snow5Def extends LevelDef
   {
       
      
      public function Snow5Def()
      {
         super();
         id = "Snow5";
         name = "Snow5";
         assetClassName = "assets.maps.Snow5";
         terrainClassName = "assets.maps.Snow5Terrain";
         swfName = "snow.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(360,600)).ini_endPoint(new Vector2(360,358)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(360,358)).ini_endPoint(new Vector2(359,52)).ini_nextTileIndices(Vector.<int>([2,8])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(359,52)).ini_endPoint(new Vector2(346,52)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(346,246.816384180791)).ini_baseStart(new Vector2(346,52)).ini_baseEnd(new Vector2(152,229)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(152,229)).ini_endPoint(new Vector2(327,228)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(327,228)).ini_endPoint(new Vector2(391,229)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(1).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(391,229)).ini_endPoint(new Vector2(474,230)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(474,230)).ini_endPoint(new Vector2(780,231)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(2),new StraightTile().ini_startPoint(new Vector2(359,52)).ini_endPoint(new Vector2(372,53)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(2),new ArcTile().ini_baseCentre(new Vector2(353.978827361564,287.275244299674)).ini_baseStart(new Vector2(372,53)).ini_baseEnd(new Vector2(566,186)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(-104.485596160649,506.267979398358)).ini_baseStart(new Vector2(566,186)).ini_baseEnd(new Vector2(600,270)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(1).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(-78.4925036279319,497.550504570641)).ini_baseStart(new Vector2(600,270)).ini_baseEnd(new Vector2(631,404)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(631,404)).ini_endPoint(new Vector2(396,402)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(396,402)).ini_endPoint(new Vector2(328,404)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(1).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(328,404)).ini_endPoint(new Vector2(-94,408)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
