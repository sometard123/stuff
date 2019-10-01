package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Mountain6Def extends LevelDef
   {
       
      
      public function Mountain6Def()
      {
         super();
         id = "Mountain6";
         name = "Mountain6";
         assetClassName = "assets.maps.Mountain6";
         terrainClassName = "assets.maps.Mountain6Terrain";
         swfName = "mountain.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(226,600)).ini_endPoint(new Vector2(226,547)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(226,547)).ini_endPoint(new Vector2(261,491)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(347.627272727273,545.142045454546)).ini_baseStart(new Vector2(261,491)).ini_baseEnd(new Vector2(346,443)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(363.815662025142,1561.26870190633)).ini_baseStart(new Vector2(346,443)).ini_baseEnd(new Vector2(433,445)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(441.169363788202,313.189746723152)).ini_baseStart(new Vector2(433,445)).ini_baseEnd(new Vector2(550,388)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(410.794654941661,292.310151223976)).ini_baseStart(new Vector2(550,388)).ini_baseEnd(new Vector2(562,217)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(442.459683417239,276.538896033975)).ini_baseStart(new Vector2(562,217)).ini_baseEnd(new Vector2(441,143)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(521.237525277326,7483.51673088303)).ini_baseStart(new Vector2(441,143)).ini_baseEnd(new Vector2(266,147)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(269.895647020522,258.976009454807)).ini_baseStart(new Vector2(266,147)).ini_baseEnd(new Vector2(272,371)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(427.12626052352,8629.05504669185)).ini_baseStart(new Vector2(272,371)).ini_baseEnd(new Vector2(514,370)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(515.578712618154,219.912361378545)).ini_baseStart(new Vector2(514,370)).ini_baseEnd(new Vector2(523,70)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(399.883026261386,2557.00195926719)).ini_baseStart(new Vector2(523,70)).ini_baseEnd(new Vector2(258,71)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(269.726889041389,276.472563570031)).ini_baseStart(new Vector2(258,71)).ini_baseEnd(new Vector2(67,241)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(67,241)).ini_endPoint(new Vector2(33,630)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
