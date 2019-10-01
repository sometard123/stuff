package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class TranquilGladeDef extends LevelDef
   {
       
      
      public function TranquilGladeDef()
      {
         super();
         id = "TranquilGlade";
         name = "TranquilGlade";
         assetClassName = "assets.maps.TranquilGlade";
         terrainClassName = "assets.maps.TranquilGladeTerrain";
         swfName = "tranquilglade.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(315,-100)).ini_endPoint(new Vector2(315,96)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(276.96,96)).ini_baseStart(new Vector2(315,96)).ini_baseEnd(new Vector2(240,105)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(137.658227848101,129.920886075949)).ini_baseStart(new Vector2(240,105)).ini_baseEnd(new Vector2(219,63)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(183.063443525284,92.5654512827116)).ini_baseStart(new Vector2(219,63)).ini_baseEnd(new Vector2(180,139)).ini_reflex(true).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(176.710171582727,188.866007534522)).ini_baseStart(new Vector2(180,139)).ini_baseEnd(new Vector2(225,176)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(194.718347113393,184.068033931085)).ini_baseStart(new Vector2(225,176)).ini_baseEnd(new Vector2(204,214)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(165.251967846907,89.0432926319509)).ini_baseStart(new Vector2(204,214)).ini_baseEnd(new Vector2(138,217)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(124.986101081727,278.104418769222)).ini_baseStart(new Vector2(138,217)).ini_baseEnd(new Vector2(74,242)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(109.170383934772,266.904949445338)).ini_baseStart(new Vector2(74,242)).ini_baseEnd(new Vector2(109,310)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(109.211785100062,256.433391116842)).ini_baseStart(new Vector2(109,310)).ini_baseEnd(new Vector2(143,298)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(226.626513906784,400.878196025433)).ini_baseStart(new Vector2(143,298)).ini_baseEnd(new Vector2(200,271)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(205.376017647338,297.223015009834)).ini_baseStart(new Vector2(200,271)).ini_baseEnd(new Vector2(232,300)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(164.190268259534,292.927181037902)).ini_baseStart(new Vector2(232,300)).ini_baseEnd(new Vector2(181,359)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(195.399109791456,415.59755843551)).ini_baseStart(new Vector2(181,359)).ini_baseEnd(new Vector2(137,416)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(180.851238815701,415.697811127313)).ini_baseStart(new Vector2(137,416)).ini_baseEnd(new Vector2(218,439)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-16.5913125159408,291.848630805798)).ini_baseStart(new Vector2(218,439)).ini_baseEnd(new Vector2(240,396)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(323.674757001105,429.96389543826)).ini_baseStart(new Vector2(240,396)).ini_baseEnd(new Vector2(262,364)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(285.502714145014,389.137198000622)).ini_baseStart(new Vector2(262,364)).ini_baseEnd(new Vector2(317,403)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(394.211618860823,436.982908535264)).ini_baseStart(new Vector2(317,403)).ini_baseEnd(new Vector2(315,466)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(355.195316048796,451.2755040357)).ini_baseStart(new Vector2(315,466)).ini_baseEnd(new Vector2(386,481)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(349.324680275421,445.610726249634)).ini_baseStart(new Vector2(386,481)).ini_baseEnd(new Vector2(395,423)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(434.849097055747,403.273438034901)).ini_baseStart(new Vector2(395,423)).ini_baseEnd(new Vector2(414,364)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(430.228218442926,394.569090341465)).ini_baseStart(new Vector2(414,364)).ini_baseEnd(new Vector2(464,387)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(590.598736675957,358.626096378828)).ini_baseStart(new Vector2(464,387)).ini_baseEnd(new Vector2(485,434)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(527.664895034104,403.546797740809)).ini_baseStart(new Vector2(485,434)).ini_baseEnd(new Vector2(561,444)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(532.751922298475,409.720065922629)).ini_baseStart(new Vector2(561,444)).ini_baseEnd(new Vector2(548,368)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(1599.56634667805,-2509.1769244748)).ini_baseStart(new Vector2(548,368)).ini_baseEnd(new Vector2(500,350)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(514.486687210858,312.330602504791)).ini_baseStart(new Vector2(500,350)).ini_baseEnd(new Vector2(516,272)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(514.609475665916,309.058223913506)).ini_baseStart(new Vector2(516,272)).ini_baseEnd(new Vector2(547,291)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(589.105144662753,267.525723313764)).ini_baseStart(new Vector2(547,291)).ini_baseEnd(new Vector2(637,273)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(585.057568774638,267.063094286825)).ini_baseStart(new Vector2(637,273)).ini_baseEnd(new Vector2(567,218)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(538.072897169539,139.40397241023)).ini_baseStart(new Vector2(567,218)).ini_baseEnd(new Vector2(500,214)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(516.039654440844,182.573589241933)).ini_baseStart(new Vector2(500,214)).ini_baseEnd(new Vector2(509,148)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(485.919444087656,34.6453366007528)).ini_baseStart(new Vector2(509,148)).ini_baseEnd(new Vector2(564,120)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(535.258656059867,88.5810672197817)).ini_baseStart(new Vector2(564,120)).ini_baseEnd(new Vector2(535,46)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(537.87284225382,518.939583106971)).ini_baseStart(new Vector2(535,46)).ini_baseEnd(new Vector2(507,47)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([36])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(508.616638954028,71.712849815575)).ini_baseStart(new Vector2(507,47)).ini_baseEnd(new Vector2(484,69)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([37])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(402.798079244312,60.0512309922652)).ini_baseStart(new Vector2(484,69)).ini_baseEnd(new Vector2(445,130)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([38])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(425.863168127988,98.2811159258705)).ini_baseStart(new Vector2(445,130)).ini_baseEnd(new Vector2(390,89)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([39])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(390,89)).ini_endPoint(new Vector2(392,-82)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}