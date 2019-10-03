package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DryAsABoneDef extends LevelDef
   {
       
      
      public function DryAsABoneDef()
      {
         super();
         id = "DryAsABone";
         name = "DryAsABone";
         assetClassName = "assets.maps.DryAsABone";
         terrainClassName = "assets.maps.DryAsABoneTerrain";
         swfName = "dryasabone.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,259)).ini_endPoint(new Vector2(-7,259)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-7,178.622448979592)).ini_baseStart(new Vector2(-7,259)).ini_baseEnd(new Vector2(67,210)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(1138.93266551179,664.521917601868)).ini_baseStart(new Vector2(67,210)).ini_baseEnd(new Vector2(93,153)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(190.040923135016,200.458656493523)).ini_baseStart(new Vector2(93,153)).ini_baseEnd(new Vector2(179,93)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(185.47229147075,155.993260380148)).ini_baseStart(new Vector2(179,93)).ini_baseEnd(new Vector2(229,110)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(78.3106316487416,269.224907289619)).ini_baseStart(new Vector2(229,110)).ini_baseEnd(new Vector2(279,181)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-573.197623220656,555.633977468514)).ini_baseStart(new Vector2(279,181)).ini_baseEnd(new Vector2(304,244)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-4941.06943499175,2107.36785104792)).ini_baseStart(new Vector2(304,244)).ini_baseEnd(new Vector2(351,382)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(525.464513713189,325.119517457746)).ini_baseStart(new Vector2(351,382)).ini_baseEnd(new Vector2(384,442)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(442.594633434585,393.588077812179)).ini_baseStart(new Vector2(384,442)).ini_baseEnd(new Vector2(490,453)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(416.249235143916,360.570070218197)).ini_baseStart(new Vector2(490,453)).ini_baseEnd(new Vector2(525,407)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(880.172798137376,558.637076757556)).ini_baseStart(new Vector2(525,407)).ini_baseEnd(new Vector2(583,312)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(625.665151673652,347.409729134572)).ini_baseStart(new Vector2(583,312)).ini_baseEnd(new Vector2(615,293)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(662.740890529265,536.556678969491)).ini_baseStart(new Vector2(615,293)).ini_baseEnd(new Vector2(645,289)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(645,289)).ini_endPoint(new Vector2(834,290)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}
