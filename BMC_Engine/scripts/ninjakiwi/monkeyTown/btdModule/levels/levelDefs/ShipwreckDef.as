package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class ShipwreckDef extends LevelDef
   {
       
      
      public function ShipwreckDef()
      {
         super();
         id = "Shipwreck";
         name = "Shipwreck";
         assetClassName = "assets.maps.Shipwreck";
         terrainClassName = "assets.maps.ShipwreckTerrain";
         swfName = "shipwreck.swf";
         mainPath = Vector.<Tile>([new StraightTile().ini_startPoint(new Vector2(-100,52)).ini_endPoint(new Vector2(-56,52)).ini_nextTileIndices(Vector.<int>([1])).ini_transitionType(0).ini_layer(-1),new StraightTile().ini_startPoint(new Vector2(-56,52)).ini_endPoint(new Vector2(-13,44)).ini_nextTileIndices(Vector.<int>([2])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(17.9605707848291,210.413067968457)).ini_baseStart(new Vector2(-13,44)).ini_baseEnd(new Vector2(169,134)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([3])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(39.5603456234007,199.485424296738)).ini_baseStart(new Vector2(169,134)).ini_baseEnd(new Vector2(156,286)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([4])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(88.6784842156058,235.980164360933)).ini_baseStart(new Vector2(156,286)).ini_baseEnd(new Vector2(67,317)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([5])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(85.8098684646726,246.701152707753)).ini_baseStart(new Vector2(67,317)).ini_baseEnd(new Vector2(30,200)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([6])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(89.8265729821257,250.062291807556)).ini_baseStart(new Vector2(30,200)).ini_baseEnd(new Vector2(159,214)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([7])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(-126.228733506801,362.698745501855)).ini_baseStart(new Vector2(159,214)).ini_baseEnd(new Vector2(195,346)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([8])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(-809.592028027874,398.222683899087)).ini_baseStart(new Vector2(195,346)).ini_baseEnd(new Vector2(196,425)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([9])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(268.347279229648,426.926492962332)).ini_baseStart(new Vector2(196,425)).ini_baseEnd(new Vector2(282,498)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([10])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(222.68562919846,189.220495789176)).ini_baseStart(new Vector2(282,498)).ini_baseEnd(new Vector2(370,467)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([11])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(344.016607432373,418.005092945928)).ini_baseStart(new Vector2(370,467)).ini_baseEnd(new Vector2(393,392)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([12])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(334.65075246166,422.977388988821)).ini_baseStart(new Vector2(393,392)).ini_baseEnd(new Vector2(338,357)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([13])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(334.727839090072,421.458846566863)).ini_baseStart(new Vector2(338,357)).ini_baseEnd(new Vector2(275,397)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([14])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(329.231928185013,419.208243772256)).ini_baseStart(new Vector2(275,397)).ini_baseEnd(new Vector2(300,470)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([15])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(416.457188040399,267.65053237408)).ini_baseStart(new Vector2(300,470)).ini_baseEnd(new Vector2(409,501)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([16])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(410.88987210635,441.862340132938)).ini_baseStart(new Vector2(409,501)).ini_baseEnd(new Vector2(469,453)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([17])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(391.248353606084,438.097754504612)).ini_baseStart(new Vector2(469,453)).ini_baseEnd(new Vector2(470,430)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([18])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(588.601049511521,417.804671687374)).ini_baseStart(new Vector2(470,430)).ini_baseEnd(new Vector2(550,305)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([19])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(622.98174255311,518.276105496014)).ini_baseStart(new Vector2(550,305)).ini_baseEnd(new Vector2(615,293)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([20])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(617.462788772407,362.509566315306)).ini_baseStart(new Vector2(615,293)).ini_baseEnd(new Vector2(687,364)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([21])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(606.471419140793,362.273981550679)).ini_baseStart(new Vector2(687,364)).ini_baseEnd(new Vector2(595,442)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([22])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(604.650983081121,374.925957483028)).ini_baseStart(new Vector2(595,442)).ini_baseEnd(new Vector2(537,371)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([23])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(722.722760638934,381.777961068573)).ini_baseStart(new Vector2(537,371)).ini_baseEnd(new Vector2(569,277)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([24])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(-1442.53975758033,-1094.07240028487)).ini_baseStart(new Vector2(569,277)).ini_baseEnd(new Vector2(625,191)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([25])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(236.396156963165,-50.5354149782858)).ini_baseStart(new Vector2(625,191)).ini_baseEnd(new Vector2(651,143)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([26])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(573.46885753775,106.808772923412)).ini_baseStart(new Vector2(651,143)).ini_baseEnd(new Vector2(595,24)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([27])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(561.109902345659,154.341314025992)).ini_baseStart(new Vector2(595,24)).ini_baseEnd(new Vector2(465,60)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([28])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(508.953619089872,103.144796529114)).ini_baseStart(new Vector2(465,60)).ini_baseEnd(new Vector2(483,159)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([29])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(515.485975995607,89.0864055644168)).ini_baseStart(new Vector2(483,159)).ini_baseEnd(new Vector2(564,149)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([30])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(525.144893144816,101.014924310094)).ini_baseStart(new Vector2(564,149)).ini_baseEnd(new Vector2(576,66)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([31])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(516.499731940203,106.967318945506)).ini_baseStart(new Vector2(576,66)).ini_baseEnd(new Vector2(503,36)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([32])).ini_transitionType(0).ini_layer(-1),new ArcTile().ini_baseCentre(new Vector2(456.692831265738,-207.434138365439)).ini_baseStart(new Vector2(503,36)).ini_baseEnd(new Vector2(246,-77)).ini_reflex(false).ini_nextTileIndices(Vector.<int>([])).ini_transitionType(0).ini_layer(-1)]);
      }
   }
}
