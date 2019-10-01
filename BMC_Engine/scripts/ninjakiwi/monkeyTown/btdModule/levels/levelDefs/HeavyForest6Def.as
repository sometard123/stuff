package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class HeavyForest6Def extends LevelDef
   {
       
      
      public function HeavyForest6Def()
      {
         super();
         id = "HeavyForest6";
         name = "HeavyForest6";
         assetClassName = "assets.maps.HeavyForest6";
         terrainClassName = "assets.maps.HeavyForest6Terrain";
         swfName = "heavyforest.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(459,-100)).ini_endPoint(new Vector2(459,-79)).ini_nextTileIndices(Vector.<int>([1,12])).ini_transitionType(1).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(459,-79)).ini_endPoint(new Vector2(606,148)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(2).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(606,148)).ini_endPoint(new Vector2(586,159)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(567.076642335767,124.593895155939)).ini_baseStart(new Vector2(586,159)).ini_baseEnd(new Vector2(529,115)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(596.073659662977,131.900063111061)).ini_baseStart(new Vector2(529,115)).ini_baseEnd(new Vector2(620,67)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(592.197335166569,142.414571427511)).ini_baseStart(new Vector2(620,67)).ini_baseEnd(new Vector2(672,152)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(544.677435413127,136.706759466479)).ini_baseStart(new Vector2(672,152)).ini_baseEnd(new Vector2(572,262)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(550.327469194342,162.616151658468)).ini_baseStart(new Vector2(572,262)).ini_baseEnd(new Vector2(510,256)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(617.760912853301,6.46465984407428)).ini_baseStart(new Vector2(510,256)).ini_baseEnd(new Vector2(430,203)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(309.012975308259,329.640980227993)).ini_baseStart(new Vector2(430,203)).ini_baseEnd(new Vector2(183,208)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(401.251539831751,418.679346126533)).ini_baseStart(new Vector2(183,208)).ini_baseEnd(new Vector2(102,369)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(400.159521118773,418.498057917793)).ini_baseStart(new Vector2(102,369)).ini_baseEnd(new Vector2(174,619)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(459,-79)).ini_endPoint(new Vector2(602,415)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(2).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(602,415)).ini_endPoint(new Vector2(568,417)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(564.121951219512,351.073170731707)).ini_baseStart(new Vector2(568,417)).ini_baseEnd(new Vector2(526,405)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(542.783916660937,381.257684109193)).ini_baseStart(new Vector2(526,405)).ini_baseEnd(new Vector2(521,362)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(590.434756418218,423.382561552792)).ini_baseStart(new Vector2(521,362)).ini_baseEnd(new Vector2(575,332)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(584.653392725354,389.153590961549)).ini_baseStart(new Vector2(575,332)).ini_baseEnd(new Vector2(639,369)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(551.316919523153,401.515901668868)).ini_baseStart(new Vector2(639,369)).ini_baseEnd(new Vector2(615,470)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(524.672024834423,372.862269114943)).ini_baseStart(new Vector2(615,470)).ini_baseEnd(new Vector2(499,503)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(546.084608072622,264.316682509319)).ini_baseStart(new Vector2(499,503)).ini_baseEnd(new Vector2(395,455)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(464.25741496621,367.590476190414)).ini_baseStart(new Vector2(395,455)).ini_baseEnd(new Vector2(360,328)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(218.05395114226,274.097726771308)).ini_baseStart(new Vector2(360,328)).ini_baseEnd(new Vector2(341,185)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(283.864937563102,226.405187310693)).ini_baseStart(new Vector2(341,185)).ini_baseEnd(new Vector2(263,159)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(326.559337097283,364.331504560169)).ini_baseStart(new Vector2(263,159)).ini_baseEnd(new Vector2(137,263)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(427.256032351017,418.160283403499)).ini_baseStart(new Vector2(137,263)).ini_baseEnd(new Vector2(162,613)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-1)]);
      }
   }
}