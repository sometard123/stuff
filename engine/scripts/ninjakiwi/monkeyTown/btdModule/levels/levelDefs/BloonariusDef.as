package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class BloonariusDef extends LevelDef
   {
       
      
      public function BloonariusDef()
      {
         super();
         id = "Swamp";
         name = "Swamp";
         assetClassName = "assets.maps.Bloonarius";
         terrainClassName = "assets.maps.BloonariusTerrain";
         swfName = "bloonarius.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,238)).ini_endPoint(new Vector2(215,238)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(215,238)).ini_endPoint(new Vector2(307,234)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(2).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(307,234)).ini_endPoint(new Vector2(340,229)).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(349.892857142857,294.292857142857)).ini_baseStart(new Vector2(340,229)).ini_baseEnd(new Vector2(386,239)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(371.110819694275,261.800622106156)).ini_baseStart(new Vector2(386,239)).ini_baseEnd(new Vector2(393,278)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(328.849924441136,230.524886661704)).ini_baseStart(new Vector2(393,278)).ini_baseEnd(new Vector2(348,308)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(249.539364756886,-90.3404060925456)).ini_baseStart(new Vector2(348,308)).ini_baseEnd(new Vector2(278,319)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(269.967702244625,203.473976179546)).ini_baseStart(new Vector2(278,319)).ini_baseEnd(new Vector2(193,290)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(230.700001207974,247.618181296557)).ini_baseStart(new Vector2(193,290)).ini_baseEnd(new Vector2(174,246)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(606.626750950151,258.346887158074)).ini_baseStart(new Vector2(174,246)).ini_baseEnd(new Vector2(176,215)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(224.854965833837,219.917740680156)).ini_baseStart(new Vector2(176,215)).ini_baseEnd(new Vector2(201,177)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(278.406979380036,316.263778074848)).ini_baseStart(new Vector2(201,177)).ini_baseEnd(new Vector2(260,158)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(260,158)).ini_endPoint(new Vector2(336,154)).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(0),new StraightTile().ini_startPoint(new Vector2(336,154)).ini_endPoint(new Vector2(399,156)).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(393.746540880503,321.483962264151)).ini_baseStart(new Vector2(399,156)).ini_baseEnd(new Vector2(486,184)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(452.142446729579,234.457409625773)).ini_baseStart(new Vector2(486,184)).ini_baseEnd(new Vector2(512,224)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(342.458011100706,253.619821222535)).ini_baseStart(new Vector2(512,224)).ini_baseEnd(new Vector2(504,313)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(382.611026043785,268.379409252992)).ini_baseStart(new Vector2(504,313)).ini_baseEnd(new Vector2(460,372)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(318.341920301852,182.325771850733)).ini_baseStart(new Vector2(460,372)).ini_baseEnd(new Vector2(362,415)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(287.730909913014,19.1854490436751)).ini_baseStart(new Vector2(362,415)).ini_baseEnd(new Vector2(101,376)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(140.067985854863,301.346982799662)).ini_baseStart(new Vector2(101,376)).ini_baseEnd(new Vector2(68,345)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(244.635118519983,238.008583832702)).ini_baseStart(new Vector2(68,345)).ini_baseEnd(new Vector2(39,219)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(639.369837295318,274.497234446095)).ini_baseStart(new Vector2(39,219)).ini_baseEnd(new Vector2(48,157)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(163.32087647916,179.912707422097)).ini_baseStart(new Vector2(48,157)).ini_baseEnd(new Vector2(90,88)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(253.452509978308,292.898842573353)).ini_baseStart(new Vector2(90,88)).ini_baseEnd(new Vector2(243,31)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(269.435843502521,693.37839811957)).ini_baseStart(new Vector2(243,31)).ini_baseEnd(new Vector2(437,52)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(255.816311401972,745.509318385442)).ini_baseStart(new Vector2(437,52)).ini_baseEnd(new Vector2(559,96)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(484.71195568385,255.147008373339)).ini_baseStart(new Vector2(559,96)).ini_baseEnd(new Vector2(642,177)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(478.229136777504,258.367932796169)).ini_baseStart(new Vector2(642,177)).ini_baseEnd(new Vector2(659,286)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(64.4274371074915,195.115502783331)).ini_baseStart(new Vector2(659,286)).ini_baseEnd(new Vector2(639,373)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(553.262604473973,346.456175110354)).ini_baseStart(new Vector2(639,373)).ini_baseEnd(new Vector2(610,416)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(513.827651940548,298.120198316037)).ini_baseStart(new Vector2(610,416)).ini_baseEnd(new Vector2(557,444)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(347.855351149801,-262.701888336351)).ini_baseStart(new Vector2(557,444)).ini_baseEnd(new Vector2(444,468)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([33])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(396.888082019161,109.948170351293)).ini_baseStart(new Vector2(444,468)).ini_baseEnd(new Vector2(389,471)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([34])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(387.631654550617,533.631654550617)).ini_baseStart(new Vector2(389,471)).ini_baseEnd(new Vector2(325,535)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([35])).ini_transitionType(0).ini_layer(0),new ArcTile().ini_baseCentre(new Vector2(-1757.61757536373,580.5)).ini_baseStart(new Vector2(325,535)).ini_baseEnd(new Vector2(325,626)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(0)]);
      }
   }
}