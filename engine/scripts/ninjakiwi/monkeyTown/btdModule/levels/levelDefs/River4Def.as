package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class River4Def extends LevelDef
   {
       
      
      public function River4Def()
      {
         super();
         id = "River4";
         name = "River4";
         assetClassName = "assets.maps.River4";
         terrainClassName = "assets.maps.River4Terrain";
         swfName = "river.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,108)).ini_endPoint(new Vector2(-31,108)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-31,108)).ini_endPoint(new Vector2(122,199)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(48.9762949956102,321.776119402985)).ini_baseStart(new Vector2(122,199)).ini_baseEnd(new Vector2(190,299)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(119.103186401972,310.450233077833)).ini_baseStart(new Vector2(190,299)).ini_baseEnd(new Vector2(137,380)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(114.27653749104,291.693133947772)).ini_baseStart(new Vector2(137,380)).ini_baseEnd(new Vector2(32,331)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(120.973365650648,288.493785318484)).ini_baseStart(new Vector2(32,331)).ini_baseEnd(new Vector2(60,211)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(194.439471481062,381.865154483616)).ini_baseStart(new Vector2(60,211)).ini_baseEnd(new Vector2(179,165)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(187.928488458729,290.410900967859)).ini_baseStart(new Vector2(179,165)).ini_baseEnd(new Vector2(287,213)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(531.748386145341,21.7624506057141)).ini_baseStart(new Vector2(287,213)).ini_baseEnd(new Vector2(570,330)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(552.896449428371,192.176886596952)).ini_baseStart(new Vector2(570,330)).ini_baseEnd(new Vector2(644,297)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(591.076759428861,236.106886468892)).ini_baseStart(new Vector2(644,297)).ini_baseEnd(new Vector2(631,166)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(581.179361790797,253.487132226066)).ini_baseStart(new Vector2(631,166)).ini_baseEnd(new Vector2(528,168)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(575.088691962601,243.6962306542)).ini_baseStart(new Vector2(528,168)).ini_baseEnd(new Vector2(492,276)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(707.996289769736,192.023538709568)).ini_baseStart(new Vector2(492,276)).ini_baseEnd(new Vector2(562,372)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-82.096295484416,1166.00765714248)).ini_baseStart(new Vector2(562,372)).ini_baseEnd(new Vector2(755,579)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
