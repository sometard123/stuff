package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Grass2Def extends LevelDef
   {
       
      
      public function Grass2Def()
      {
         super();
         id = "Grass2";
         name = "Grass2";
         assetClassName = "assets.maps.Grass2";
         terrainClassName = "assets.maps.Grass2Terrain";
         swfName = "grass.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,96)).ini_endPoint(new Vector2(-6,96)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-6,96)).ini_endPoint(new Vector2(84,320)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(84,320)).ini_endPoint(new Vector2(121,387)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(218.467349494588,333.174747294033)).ini_baseStart(new Vector2(121,387)).ini_baseEnd(new Vector2(300,409)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(163.016076903174,281.605140136073)).ini_baseStart(new Vector2(300,409)).ini_baseEnd(new Vector2(342,336)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(342,336)).ini_endPoint(new Vector2(366,198)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(511.379246064623,223.283347141674)).ini_baseStart(new Vector2(366,198)).ini_baseEnd(new Vector2(492,77)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(501.948925692431,152.099007768387)).ini_baseStart(new Vector2(492,77)).ini_baseEnd(new Vector2(533,83)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(462.465021899405,239.963876722553)).ini_baseStart(new Vector2(533,83)).ini_baseEnd(new Vector2(633,263)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-358.237679344111,129.102112112438)).ini_baseStart(new Vector2(633,263)).ini_baseEnd(new Vector2(621,333)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(490.51473164523,305.830221733502)).ini_baseStart(new Vector2(621,333)).ini_baseEnd(new Vector2(485,439)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(489.236173434867,336.704854322747)).ini_baseStart(new Vector2(485,439)).ini_baseEnd(new Vector2(427,418)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(427,418)).ini_endPoint(new Vector2(396,387)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(396,387)).ini_endPoint(new Vector2(376,356)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(376,356)).ini_endPoint(new Vector2(217,-53)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
