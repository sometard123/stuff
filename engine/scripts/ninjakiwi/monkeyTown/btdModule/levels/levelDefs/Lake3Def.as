package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Lake3Def extends LevelDef
   {
       
      
      public function Lake3Def()
      {
         super();
         id = "Lake3";
         name = "Lake3";
         assetClassName = "assets.maps.Lake3";
         terrainClassName = "assets.maps.Lake3Terrain";
         swfName = "lake.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(317,-100)).ini_endPoint(new Vector2(317,-37)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(235.982456140351,-37)).ini_baseStart(new Vector2(317,-37)).ini_baseEnd(new Vector2(203,37)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(163.511709245742,125.596601277372)).ini_baseStart(new Vector2(203,37)).ini_baseEnd(new Vector2(104,49)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(134.9232688058,88.8008613923369)).ini_baseStart(new Vector2(104,49)).ini_baseEnd(new Vector2(97,122)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(150.915986268598,74.800368806122)).ini_baseStart(new Vector2(97,122)).ini_baseEnd(new Vector2(159,146)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(114.577226685507,-245.25181892196)).ini_baseStart(new Vector2(159,146)).ini_baseEnd(new Vector2(278,113)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(409.211033130702,400.63794866731)).ini_baseStart(new Vector2(278,113)).ini_baseEnd(new Vector2(449,87)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(432.80620142473,214.648194107757)).ini_baseStart(new Vector2(449,87)).ini_baseEnd(new Vector2(557,181)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-344.927451247215,425.361878763919)).ini_baseStart(new Vector2(557,181)).ini_baseEnd(new Vector2(576,267)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(404.365608433753,296.514099804629)).ini_baseStart(new Vector2(576,267)).ini_baseEnd(new Vector2(532,415)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(466.421520244208,354.122010047927)).ini_baseStart(new Vector2(532,415)).ini_baseEnd(new Vector2(445,441)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(652.847851840548,-401.956213093477)).ini_baseStart(new Vector2(445,441)).ini_baseEnd(new Vector2(284,384)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(227.828977660373,503.691530758128)).ini_baseStart(new Vector2(284,384)).ini_baseEnd(new Vector2(128,417)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(298.676579174996,565.215620955061)).ini_baseStart(new Vector2(128,417)).ini_baseEnd(new Vector2(93,659)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
