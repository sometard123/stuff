package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Desert3Def extends LevelDef
   {
       
      
      public function Desert3Def()
      {
         super();
         id = "Desert3";
         name = "Desert3";
         assetClassName = "assets.maps.Desert3";
         terrainClassName = "assets.maps.Desert3Terrain";
         swfName = "desert.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,203)).ini_endPoint(new Vector2(104,203)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(104,203)).ini_endPoint(new Vector2(107,388)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(107,388)).ini_endPoint(new Vector2(216,391)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(216,391)).ini_endPoint(new Vector2(219,480)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(219,480)).ini_endPoint(new Vector2(267,482)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(267,482)).ini_endPoint(new Vector2(267,340)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(267,340)).ini_endPoint(new Vector2(158,338)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(158,338)).ini_endPoint(new Vector2(155,151)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(155,151)).ini_endPoint(new Vector2(33,149)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(33,149)).ini_endPoint(new Vector2(36,50)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(36,50)).ini_endPoint(new Vector2(292,49)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(292,49)).ini_endPoint(new Vector2(295,190)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(295,190)).ini_endPoint(new Vector2(413,194)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(413,194)).ini_endPoint(new Vector2(415,332)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(415,332)).ini_endPoint(new Vector2(514,335)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(514,335)).ini_endPoint(new Vector2(511,467)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(511,467)).ini_endPoint(new Vector2(677,469)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(677,469)).ini_endPoint(new Vector2(675,249)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(675,249)).ini_endPoint(new Vector2(583,250)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(583,250)).ini_endPoint(new Vector2(582,106)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(582,106)).ini_endPoint(new Vector2(473,106)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(473,106)).ini_endPoint(new Vector2(476,50)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(476,50)).ini_endPoint(new Vector2(631,50)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(631,50)).ini_endPoint(new Vector2(633,198)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(633,198)).ini_endPoint(new Vector2(865,201)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}