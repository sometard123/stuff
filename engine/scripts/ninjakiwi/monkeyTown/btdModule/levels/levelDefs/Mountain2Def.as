package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Mountain2Def extends LevelDef
   {
       
      
      public function Mountain2Def()
      {
         super();
         id = "Mountain2";
         name = "Mountain2";
         assetClassName = "assets.maps.Mountain2";
         terrainClassName = "assets.maps.Mountain2Terrain";
         swfName = "mountain.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,429)).ini_endPoint(new Vector2(-38,429)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(-38,429)).ini_endPoint(new Vector2(-10,391)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(222.02967032967,561.969230769231)).ini_baseStart(new Vector2(-10,391)).ini_baseEnd(new Vector2(67,319)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(226.267767541303,568.611360738584)).ini_baseStart(new Vector2(67,319)).ini_baseEnd(new Vector2(188,275)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(201.000838134706,374.749580932647)).ini_baseStart(new Vector2(188,275)).ini_baseEnd(new Vector2(273,445)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(199,372.797339909176)).ini_baseStart(new Vector2(273,445)).ini_baseEnd(new Vector2(125,445)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(186.491367362717,385.002158159321)).ini_baseStart(new Vector2(125,445)).ini_baseEnd(new Vector2(104,361)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(371.897431711067,438.948962806393)).ini_baseStart(new Vector2(104,361)).ini_baseEnd(new Vector2(125,309)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(125,309)).ini_endPoint(new Vector2(258,85)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(345.131045663334,136.734058362605)).ini_baseStart(new Vector2(258,85)).ini_baseEnd(new Vector2(443,163)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(345.271137866024,136.771656124271)).ini_baseStart(new Vector2(443,163)).ini_baseEnd(new Vector2(435,90)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(435,90)).ini_endPoint(new Vector2(576,322)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(490.079787234043,374.21875)).ini_baseStart(new Vector2(576,322)).ini_baseEnd(new Vector2(482,274)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(491.910368212994,396.924612440454)).ini_baseStart(new Vector2(482,274)).ini_baseEnd(new Vector2(528,279)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(431.072779295089,595.714368381902)).ini_baseStart(new Vector2(528,279)).ini_baseEnd(new Vector2(729,451)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(949.212600519349,344.034522597524)).ini_baseStart(new Vector2(729,451)).ini_baseEnd(new Vector2(825,555)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
