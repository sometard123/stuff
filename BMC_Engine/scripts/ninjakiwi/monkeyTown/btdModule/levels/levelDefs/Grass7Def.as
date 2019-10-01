package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Grass7Def extends LevelDef
   {
       
      
      public function Grass7Def()
      {
         super();
         id = "Grass7";
         name = "Grass7";
         assetClassName = "assets.maps.Grass7";
         terrainClassName = "assets.maps.Grass7Terrain";
         swfName = "grass.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(479,-100)).ini_endPoint(new Vector2(479,235)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(2).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(479,235)).ini_endPoint(new Vector2(501,240)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(487.265463917526,300.431958762887)).ini_baseStart(new Vector2(501,240)).ini_baseEnd(new Vector2(549,295)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(467.337356870469,302.185412543723)).ini_baseStart(new Vector2(549,295)).ini_baseEnd(new Vector2(503,376)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(431.574802085491,228.164027806546)).ini_baseStart(new Vector2(503,376)).ini_baseEnd(new Vector2(383,385)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(412.466076404974,289.861357302761)).ini_baseStart(new Vector2(383,385)).ini_baseEnd(new Vector2(327,341)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(495.070820476242,240.434793339054)).ini_baseStart(new Vector2(327,341)).ini_baseEnd(new Vector2(300,258)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(428.597573047988,246.420395520102)).ini_baseStart(new Vector2(300,258)).ini_baseEnd(new Vector2(442,118)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(424.497238547704,285.709292984464)).ini_baseStart(new Vector2(442,118)).ini_baseEnd(new Vector2(593,292)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(445.296050570017,286.485774221779)).ini_baseStart(new Vector2(593,292)).ini_baseEnd(new Vector2(436,434)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(447.950126896148,244.369607635058)).ini_baseStart(new Vector2(436,434)).ini_baseEnd(new Vector2(258,249)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(426.088886170331,244.902516582259)).ini_baseStart(new Vector2(258,249)).ini_baseEnd(new Vector2(435,77)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(420.024001246061,359.176608579208)).ini_baseStart(new Vector2(435,77)).ini_baseEnd(new Vector2(506,90)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(449.985918578772,265.370809158004)).ini_baseStart(new Vector2(506,90)).ini_baseEnd(new Vector2(632,293)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(424.989445284238,261.576419594082)).ini_baseStart(new Vector2(632,293)).ini_baseEnd(new Vector2(445,470)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(425.283641542913,264.640674355934)).ini_baseStart(new Vector2(445,470)).ini_baseEnd(new Vector2(226,318)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(28.6380361553503,370.84478553786)).ini_baseStart(new Vector2(226,318)).ini_baseEnd(new Vector2(208,273)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(157.301872357939,300.65662975571)).ini_baseStart(new Vector2(208,273)).ini_baseEnd(new Vector2(154,243)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(64.6572611244555,-1317.08490283489)).ini_baseStart(new Vector2(154,243)).ini_baseEnd(new Vector2(-67,240)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
