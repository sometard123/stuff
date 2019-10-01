package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class DesertBadlands1Def extends LevelDef
   {
       
      
      public function DesertBadlands1Def()
      {
         super();
         id = "DesertBadlands1";
         name = "DesertBadlands1";
         assetClassName = "assets.maps.DesertBadlands1";
         terrainClassName = "assets.maps.DesertBadlands1Terrain";
         swfName = "desert_badlands.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(900,218)).ini_endPoint(new Vector2(787,218)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(-2),new StraightTile().ini_startPoint(new Vector2(787,218)).ini_endPoint(new Vector2(546,150)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(503.141518275539,301.895501405811)).ini_baseStart(new Vector2(546,150)).ini_baseEnd(new Vector2(464,149)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(441.422847979455,60.8086080821816)).ini_baseStart(new Vector2(464,149)).ini_baseEnd(new Vector2(380,128)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(520.933942323416,-26.1697929139226)).ini_baseStart(new Vector2(380,128)).ini_baseEnd(new Vector2(356,102)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(251.031776860221,183.570568391475)).ini_baseStart(new Vector2(356,102)).ini_baseEnd(new Vector2(276,53)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(231.186092520605,287.352974926174)).ini_baseStart(new Vector2(276,53)).ini_baseEnd(new Vector2(169,57)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(188.9703929495,130.975373590771)).ini_baseStart(new Vector2(169,57)).ini_baseEnd(new Vector2(123,92)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(648.482032100977,402.455305792271)).ini_baseStart(new Vector2(123,92)).ini_baseEnd(new Vector2(72,202)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(303.040671087914,282.337852343102)).ini_baseStart(new Vector2(72,202)).ini_baseEnd(new Vector2(60,310)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(123.070480522262,302.82151033739)).ini_baseStart(new Vector2(60,310)).ini_baseEnd(new Vector2(140,364)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(95.9082837856772,204.66502252638)).ini_baseStart(new Vector2(140,364)).ini_baseEnd(new Vector2(195,337)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(513.622719369798,762.51418020845)).ini_baseStart(new Vector2(195,337)).ini_baseEnd(new Vector2(274,288)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(322.613521053256,384.267186810582)).ini_baseStart(new Vector2(274,288)).ini_baseEnd(new Vector2(375,290)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(332.002291104475,367.372504095991)).ini_baseStart(new Vector2(375,290)).ini_baseEnd(new Vector2(378,443)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(439.506067614581,544.125686219688)).ini_baseStart(new Vector2(378,443)).ini_baseEnd(new Vector2(323,565)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(-2),new ArcTile().ini_baseCentre(new Vector2(69.088955307086,610.493071114034)).ini_baseStart(new Vector2(323,565)).ini_baseEnd(new Vector2(324,650)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-2)]);
      }
   }
}
