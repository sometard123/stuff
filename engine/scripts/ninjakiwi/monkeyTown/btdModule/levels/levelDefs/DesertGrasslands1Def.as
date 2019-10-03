package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertGrasslands1Def extends LevelDef
   {
       
      
      public function DesertGrasslands1Def()
      {
         super();
         id = "DesertGrasslands1";
         name = "DesertGrasslands1";
         assetClassName = "assets.maps.DesertGrasslands1";
         terrainClassName = "assets.maps.DesertGrasslands1Terrain";
         swfName = "desert_grasslands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(221,600)).ini_endPoint(new Vector2(221,443)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(221,443)).ini_endPoint(new Vector2(294,463)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(294,463)).ini_endPoint(new Vector2(363,439)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(363,439)).ini_endPoint(new Vector2(436,463)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(436,463)).ini_endPoint(new Vector2(501,439)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(501,439)).ini_endPoint(new Vector2(501,347)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(501,347)).ini_endPoint(new Vector2(434,381)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(434,381)).ini_endPoint(new Vector2(360,342)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(360,342)).ini_endPoint(new Vector2(290,381)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(290,381)).ini_endPoint(new Vector2(219,336)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(219,336)).ini_endPoint(new Vector2(220,234)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(220,234)).ini_endPoint(new Vector2(290,291)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(290,291)).ini_endPoint(new Vector2(360,233)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(360,233)).ini_endPoint(new Vector2(433,291)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(433,291)).ini_endPoint(new Vector2(502,228)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(502,228)).ini_endPoint(new Vector2(501,77)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(501,77)).ini_endPoint(new Vector2(433,190)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(433,190)).ini_endPoint(new Vector2(363,69)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(363,69)).ini_endPoint(new Vector2(293,190)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(293,190)).ini_endPoint(new Vector2(222,61)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(222,61)).ini_endPoint(new Vector2(221,-55)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
