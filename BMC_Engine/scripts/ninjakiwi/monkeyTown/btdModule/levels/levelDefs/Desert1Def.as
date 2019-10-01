package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Desert1Def extends LevelDef
   {
       
      
      public function Desert1Def()
      {
         super();
         id = "Desert1";
         name = "Desert";
         assetClassName = "assets.maps.Desert1";
         terrainClassName = "assets.maps.Desert1Terrain";
         swfName = "desert.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(657,-100)).ini_endPoint(new Vector2(657,2)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(657,2)).ini_endPoint(new Vector2(639,17)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(639,17)).ini_endPoint(new Vector2(622,18)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(622,18)).ini_endPoint(new Vector2(596,24)).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(596,24)).ini_endPoint(new Vector2(577,36)).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(577,36)).ini_endPoint(new Vector2(567,57)).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(567,57)).ini_endPoint(new Vector2(559,75)).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(559,75)).ini_endPoint(new Vector2(545,82)).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(545,82)).ini_endPoint(new Vector2(525,86)).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(525,86)).ini_endPoint(new Vector2(505,91)).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(505,91)).ini_endPoint(new Vector2(490,99)).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(490,99)).ini_endPoint(new Vector2(483,114)).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(483,114)).ini_endPoint(new Vector2(479,129)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(479,129)).ini_endPoint(new Vector2(468,144)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(468,144)).ini_endPoint(new Vector2(451,148)).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(451,148)).ini_endPoint(new Vector2(427,152)).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(427,152)).ini_endPoint(new Vector2(409,163)).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(409,163)).ini_endPoint(new Vector2(398,181)).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(398,181)).ini_endPoint(new Vector2(381,207)).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(381,207)).ini_endPoint(new Vector2(351,215)).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(351,215)).ini_endPoint(new Vector2(328,225)).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(328,225)).ini_endPoint(new Vector2(316,238)).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(316,238)).ini_endPoint(new Vector2(307,260)).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(307,260)).ini_endPoint(new Vector2(292,280)).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(292,280)).ini_endPoint(new Vector2(271,284)).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(271,284)).ini_endPoint(new Vector2(251,286)).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(251,286)).ini_endPoint(new Vector2(235,297)).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(235,297)).ini_endPoint(new Vector2(227,314)).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(227,314)).ini_endPoint(new Vector2(223,331)).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(223,331)).ini_endPoint(new Vector2(210,339)).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(210,339)).ini_endPoint(new Vector2(182,346)).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(182,346)).ini_endPoint(new Vector2(162,348)).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(162,348)).ini_endPoint(new Vector2(149,359)).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(149,359)).ini_endPoint(new Vector2(142,379)).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(142,379)).ini_endPoint(new Vector2(132,397)).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(132,397)).ini_endPoint(new Vector2(114,406)).ini_nextTileIndices(Vector.<int>([36])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(114,406)).ini_endPoint(new Vector2(91,405)).ini_nextTileIndices(Vector.<int>([37])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(91,405)).ini_endPoint(new Vector2(71,405)).ini_nextTileIndices(Vector.<int>([38])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(71,405)).ini_endPoint(new Vector2(52,413)).ini_nextTileIndices(Vector.<int>([39])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(52,413)).ini_endPoint(new Vector2(36,428)).ini_nextTileIndices(Vector.<int>([40])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(36,428)).ini_endPoint(new Vector2(30,444)).ini_nextTileIndices(Vector.<int>([41])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(30,444)).ini_endPoint(new Vector2(29,467)).ini_nextTileIndices(Vector.<int>([42])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(29,467)).ini_endPoint(new Vector2(39,483)).ini_nextTileIndices(Vector.<int>([43])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(39,483)).ini_endPoint(new Vector2(56,493)).ini_nextTileIndices(Vector.<int>([44])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(56,493)).ini_endPoint(new Vector2(79,494)).ini_nextTileIndices(Vector.<int>([45])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(79,494)).ini_endPoint(new Vector2(104,481)).ini_nextTileIndices(Vector.<int>([46])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(104,481)).ini_endPoint(new Vector2(117,478)).ini_nextTileIndices(Vector.<int>([47])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(117,478)).ini_endPoint(new Vector2(138,485)).ini_nextTileIndices(Vector.<int>([48])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(138,485)).ini_endPoint(new Vector2(159,493)).ini_nextTileIndices(Vector.<int>([49])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(159,493)).ini_endPoint(new Vector2(185,490)).ini_nextTileIndices(Vector.<int>([50])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(185,490)).ini_endPoint(new Vector2(205,479)).ini_nextTileIndices(Vector.<int>([51])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(205,479)).ini_endPoint(new Vector2(228,481)).ini_nextTileIndices(Vector.<int>([52])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(228,481)).ini_endPoint(new Vector2(248,492)).ini_nextTileIndices(Vector.<int>([53])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(248,492)).ini_endPoint(new Vector2(273,487)).ini_nextTileIndices(Vector.<int>([54])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(273,487)).ini_endPoint(new Vector2(296,476)).ini_nextTileIndices(Vector.<int>([55])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(296,476)).ini_endPoint(new Vector2(317,479)).ini_nextTileIndices(Vector.<int>([56])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(317,479)).ini_endPoint(new Vector2(338,488)).ini_nextTileIndices(Vector.<int>([57])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(338,488)).ini_endPoint(new Vector2(361,490)).ini_nextTileIndices(Vector.<int>([58])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(361,490)).ini_endPoint(new Vector2(382,479)).ini_nextTileIndices(Vector.<int>([59])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(382,479)).ini_endPoint(new Vector2(402,478)).ini_nextTileIndices(Vector.<int>([60])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(402,478)).ini_endPoint(new Vector2(423,485)).ini_nextTileIndices(Vector.<int>([61])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(423,485)).ini_endPoint(new Vector2(447,489)).ini_nextTileIndices(Vector.<int>([62])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(447,489)).ini_endPoint(new Vector2(468,482)).ini_nextTileIndices(Vector.<int>([63])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(468,482)).ini_endPoint(new Vector2(490,474)).ini_nextTileIndices(Vector.<int>([64])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(490,474)).ini_endPoint(new Vector2(509,479)).ini_nextTileIndices(Vector.<int>([65])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(509,479)).ini_endPoint(new Vector2(525,486)).ini_nextTileIndices(Vector.<int>([66])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(525,486)).ini_endPoint(new Vector2(547,485)).ini_nextTileIndices(Vector.<int>([67])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(547,485)).ini_endPoint(new Vector2(577,474)).ini_nextTileIndices(Vector.<int>([68])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(577,474)).ini_endPoint(new Vector2(598,475)).ini_nextTileIndices(Vector.<int>([69])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(598,475)).ini_endPoint(new Vector2(620,487)).ini_nextTileIndices(Vector.<int>([70])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(620,487)).ini_endPoint(new Vector2(656,489)).ini_nextTileIndices(Vector.<int>([71])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(656,489)).ini_endPoint(new Vector2(676,473)).ini_nextTileIndices(Vector.<int>([72])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(676,473)).ini_endPoint(new Vector2(678,444)).ini_nextTileIndices(Vector.<int>([73])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(678,444)).ini_endPoint(new Vector2(668,421)).ini_nextTileIndices(Vector.<int>([74])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(668,421)).ini_endPoint(new Vector2(651,407)).ini_nextTileIndices(Vector.<int>([75])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(651,407)).ini_endPoint(new Vector2(622,403)).ini_nextTileIndices(Vector.<int>([76])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(622,403)).ini_endPoint(new Vector2(598,406)).ini_nextTileIndices(Vector.<int>([77])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(598,406)).ini_endPoint(new Vector2(580,404)).ini_nextTileIndices(Vector.<int>([78])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(580,404)).ini_endPoint(new Vector2(568,392)).ini_nextTileIndices(Vector.<int>([79])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(568,392)).ini_endPoint(new Vector2(563,373)).ini_nextTileIndices(Vector.<int>([80])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(563,373)).ini_endPoint(new Vector2(557,357)).ini_nextTileIndices(Vector.<int>([81])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(557,357)).ini_endPoint(new Vector2(536,348)).ini_nextTileIndices(Vector.<int>([82])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(536,348)).ini_endPoint(new Vector2(507,346)).ini_nextTileIndices(Vector.<int>([83])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(507,346)).ini_endPoint(new Vector2(484,337)).ini_nextTileIndices(Vector.<int>([84])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(484,337)).ini_endPoint(new Vector2(477,316)).ini_nextTileIndices(Vector.<int>([85])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(477,316)).ini_endPoint(new Vector2(473,301)).ini_nextTileIndices(Vector.<int>([86])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(473,301)).ini_endPoint(new Vector2(455,290)).ini_nextTileIndices(Vector.<int>([87])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(455,290)).ini_endPoint(new Vector2(430,281)).ini_nextTileIndices(Vector.<int>([88])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(430,281)).ini_endPoint(new Vector2(409,274)).ini_nextTileIndices(Vector.<int>([89])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(409,274)).ini_endPoint(new Vector2(394,257)).ini_nextTileIndices(Vector.<int>([90])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(394,257)).ini_endPoint(new Vector2(378,235)).ini_nextTileIndices(Vector.<int>([91])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(378,235)).ini_endPoint(new Vector2(356,223)).ini_nextTileIndices(Vector.<int>([92])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(356,223)).ini_endPoint(new Vector2(331,215)).ini_nextTileIndices(Vector.<int>([93])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(331,215)).ini_endPoint(new Vector2(312,201)).ini_nextTileIndices(Vector.<int>([94])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(312,201)).ini_endPoint(new Vector2(301,178)).ini_nextTileIndices(Vector.<int>([95])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(301,178)).ini_endPoint(new Vector2(292,166)).ini_nextTileIndices(Vector.<int>([96])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(292,166)).ini_endPoint(new Vector2(270,158)).ini_nextTileIndices(Vector.<int>([97])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(270,158)).ini_endPoint(new Vector2(250,152)).ini_nextTileIndices(Vector.<int>([98])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(250,152)).ini_endPoint(new Vector2(227,139)).ini_nextTileIndices(Vector.<int>([99])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(227,139)).ini_endPoint(new Vector2(222,125)).ini_nextTileIndices(Vector.<int>([100])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(222,125)).ini_endPoint(new Vector2(219,107)).ini_nextTileIndices(Vector.<int>([101])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(219,107)).ini_endPoint(new Vector2(200,95)).ini_nextTileIndices(Vector.<int>([102])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(200,95)).ini_endPoint(new Vector2(177,92)).ini_nextTileIndices(Vector.<int>([103])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(177,92)).ini_endPoint(new Vector2(154,84)).ini_nextTileIndices(Vector.<int>([104])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(154,84)).ini_endPoint(new Vector2(137,64)).ini_nextTileIndices(Vector.<int>([105])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(137,64)).ini_endPoint(new Vector2(137,43)).ini_nextTileIndices(Vector.<int>([106])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(137,43)).ini_endPoint(new Vector2(122,32)).ini_nextTileIndices(Vector.<int>([107])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(122,32)).ini_endPoint(new Vector2(95,29)).ini_nextTileIndices(Vector.<int>([108])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(95,29)).ini_endPoint(new Vector2(79,25)).ini_nextTileIndices(Vector.<int>([109])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(79,25)).ini_endPoint(new Vector2(52,-2)).ini_nextTileIndices(Vector.<int>([110])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(52,-2)).ini_endPoint(new Vector2(28,-45)).ini_nextTileIndices(Vector.<int>([111])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(28,-45)).ini_endPoint(new Vector2(24,-74)).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}