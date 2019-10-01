package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class StickySapDef extends LevelDef
   {
       
      
      public function StickySapDef()
      {
         super();
         id = "StickySap";
         name = "StickySap";
         assetClassName = "assets.maps.StickySap";
         terrainClassName = "assets.maps.StickySapTerrain";
         swfName = "stickysap.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(333,600)).ini_endPoint(new Vector2(333,548)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(333,548)).ini_endPoint(new Vector2(334,276)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(334,276)).ini_endPoint(new Vector2(332,233)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(332,233)).ini_endPoint(new Vector2(319,211)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(319,211)).ini_endPoint(new Vector2(299,197)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(299,197)).ini_endPoint(new Vector2(233,148)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(233,148)).ini_endPoint(new Vector2(199,127)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(181.729257641921,154.962154294032)).ini_baseStart(new Vector2(199,127)).ini_baseEnd(new Vector2(153,139)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(153,139)).ini_endPoint(new Vector2(148,154)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(465.681818181818,259.893939393939)).ini_baseStart(new Vector2(148,154)).ini_baseEnd(new Vector2(131,271)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(347.194996927521,263.825798689489)).ini_baseStart(new Vector2(131,271)).ini_baseEnd(new Vector2(156,365)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(156,365)).ini_endPoint(new Vector2(172,379)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(172,379)).ini_endPoint(new Vector2(199,376)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(199,376)).ini_endPoint(new Vector2(235,350)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(235,350)).ini_endPoint(new Vector2(486,175)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(486,175)).ini_endPoint(new Vector2(520,152)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(520,152)).ini_endPoint(new Vector2(534,151)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(534,151)).ini_endPoint(new Vector2(554,158)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(554,158)).ini_endPoint(new Vector2(569,173)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(569,173)).ini_endPoint(new Vector2(577,190)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(475.548387096774,237.741935483871)).ini_baseStart(new Vector2(577,190)).ini_baseEnd(new Vector2(587,250)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(587,250)).ini_endPoint(new Vector2(588,275)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(397.302618328298,282.627895266868)).ini_baseStart(new Vector2(588,275)).ini_baseEnd(new Vector2(553,393)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(553,393)).ini_endPoint(new Vector2(536,399)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(536,399)).ini_endPoint(new Vector2(513,393)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(513,393)).ini_endPoint(new Vector2(488,375)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(488,375)).ini_endPoint(new Vector2(391,307)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(3).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(404.017482517483,288.430944055944)).ini_baseStart(new Vector2(391,307)).ini_baseEnd(new Vector2(382,283)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(382,283)).ini_endPoint(new Vector2(384,233)).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(3).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(384,233)).ini_endPoint(new Vector2(389,-114)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}