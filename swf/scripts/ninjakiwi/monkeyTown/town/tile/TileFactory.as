package ninjakiwi.monkeyTown.town.tile
{
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.display.tileSystem.TileDefinition;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   
   public class TileFactory
   {
      
      private static var instance:TileFactory;
       
      
      public var tileDefinitions:TileDefinitions;
      
      public var buildingData:BuildingData;
      
      private var _tileData:Array;
      
      private var LGMath:LGMathUtil;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const DEFAULT_SET:String = "DefaultSet";
      
      private const SECOND_SET:String = "SecondSet";
      
      public function TileFactory(param1:SingletonEnforcer#326)
      {
         this.tileDefinitions = TileDefinitions.getInstance();
         this.buildingData = BuildingData.getInstance();
         this._tileData = [];
         this.LGMath = LGMathUtil.getInstance();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use TileFactory.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : TileFactory
      {
         if(instance == null)
         {
            instance = new TileFactory(new SingletonEnforcer#326());
         }
         return instance;
      }
      
      private function init() : void
      {
         this._tileData[this.tileDefinitions.GRASS + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["GrassTileClip"]);
         this._tileData[this.tileDefinitions.GRASS + this.SECOND_SET] = new TileDefinition().GroundVariants(["DesertGrassGroundTileClip"]);
         this._tileData[this.tileDefinitions.GRASS] = this._tileData[this.tileDefinitions.GRASS + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.FOREST + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["ForestGroundTileClip"]).PropVariants(["ForestPropsTileClip1","ForestPropsTileClip2","ForestPropsTileClip3","ForestPropsTileClip4","ForestPropsTileClip5","ForestPropsTileClip6"]);
         this._tileData[this.tileDefinitions.FOREST + this.SECOND_SET] = new TileDefinition().GroundVariants(["DesertGrassGroundTileClip"]).PropVariants(["ForestPropsTileClip1","ForestPropsTileClip2","ForestPropsTileClip3","ForestPropsTileClip4","ForestPropsTileClip5","ForestPropsTileClip6","DesertForestPropsTileClip1","DesertForestPropsTileClip2","DesertForestPropsTileClip3","DesertForestPropsTileClip4","DesertForestPropsTileClip5","DesertForestPropsTileClip6"]);
         this._tileData[this.tileDefinitions.FOREST] = this._tileData[this.tileDefinitions.FOREST + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.HEAVY_FOREST + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["HeavyForestGroundTileClip"]).PropVariants(["HeavyForestPropsTileClip1","HeavyForestPropsTileClip2","HeavyForestPropsTileClip3"]);
         this._tileData[this.tileDefinitions.HEAVY_FOREST + this.SECOND_SET] = new TileDefinition().GroundVariants(["DesertGrassGroundTileClip"]).PropVariants(["DesertHeavyForestPropsTileClip1","DesertHeavyForestPropsTileClip2","DesertHeavyForestPropsTileClip3"]);
         this._tileData[this.tileDefinitions.HEAVY_FOREST] = this._tileData[this.tileDefinitions.HEAVY_FOREST + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.HILLS + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["HillsGroundTileClip"]).PropVariants(["HillsPropTileClip1","HillsPropTileClip2","HillsPropTileClip3"]);
         this._tileData[this.tileDefinitions.HILLS + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["HillsGroundTileClip"]).PropVariants(["HillsPropTileClip1","HillsPropTileClip2","HillsPropTileClip3"]);
         this._tileData[this.tileDefinitions.HILLS + this.SECOND_SET] = new TileDefinition().GroundVariants(["DesertGrassGroundTileClip"]).PropVariants(["DesertHillsPropTileClip1","DesertHillsPropTileClip2","DesertHillsPropTileClip3"]);
         this._tileData[this.tileDefinitions.HILLS] = this._tileData[this.tileDefinitions.HILLS + "DefaultSet"];
         this._tileData[this.tileDefinitions.MOUNTAINS] = new TileDefinition().GroundVariants(["GrassTileClip"]).PropVariants(["MountainTileClip2","MountainTileClip3","MountainTileClip4","MountainTileClip5","MountainTileClip6"]);
         this._tileData[this.tileDefinitions.SNOW] = new TileDefinition().GroundVariants(["SnowGroundClip"]).PropVariants(["SnowPropsClip1","SnowPropsClip2","SnowPropsClip3","SnowPropsClip4","SnowPropsClip5","SnowPropsClip6","SnowPropsClip7"]);
         this._tileData[this.tileDefinitions.LAKE] = new TileDefinition().GroundVariants(["LakeTileClip"]);
         this._tileData[this.tileDefinitions.DESERT + this.DEFAULT_SET] = new TileDefinition().GroundVariants(["DesertGroundClip1"]).PropVariants(["DesertPropsClip1","DesertPropsClip2","DesertPropsClip3","DesertPropsClip4","DesertGroundStonesClip"]);
         this._tileData[this.tileDefinitions.DESERT + this.SECOND_SET] = new TileDefinition().GroundVariants(["DesertGroundClip1"]).PropVariants(["DesertPropsClip1b","DesertPropsClip1","DesertPropsClip2","DesertPropsClip3","DesertPropsClip4","DesertGroundStonesClip","DesertPropsClip7","DesertPropsClip8","DesertPropsClip9","DesertPropsClip10"]);
         this._tileData[this.tileDefinitions.DESERT] = this._tileData[this.tileDefinitions.DESERT + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.DESERT_BADLANDS] = new TileDefinition().GroundVariants(["DesertGroundClip1"]).PropVariants(["BadlandsClip1","BadlandsClip2","BadlandsClip3","BadlandsClip4"]);
         this._tileData[this.tileDefinitions.DESERT_HIGHLANDS] = new TileDefinition().GroundVariants(["DesertGroundClip1"]).PropVariants(["DesertHighlandsClip1","DesertHighlandsClip2","DesertHighlandsClip3","DesertHighlandsClip4"]);
         this._tileData[this.tileDefinitions.DESERT_ARID_GRASSLANDS] = new TileDefinition().GroundVariants(["DesertGroundClip1"]).PropVariants(["AridGrasslandClip1","AridGrasslandClip2","AridGrasslandClip3","AridGrasslandClip4"]);
         this._tileData[this.tileDefinitions.VOLCANO] = new TileDefinition().GroundVariants(["VolcanoGroundTileClip2"]).PropVariants(["VolcanoPropsTileClip","VolcanoPropsTileClip2"]);
         this._tileData[this.tileDefinitions.JUNGLE] = new TileDefinition().GroundVariants(["GrassTileClip"]).PropVariants(["JungleProps1Clip","JungleProps2Clip","JungleProps3Clip"]);
         this._tileData[this.tileDefinitions.RUINS] = new TileDefinition().GroundVariants(["RuinsGroundTileClip"]).PropVariants(["RuinsPropsTileClip","RuinsPropsTileClip2","RuinsPropsTileClip","RuinsPropsTileClip4"]);
         this._tileData[this.tileDefinitions.SKY] = new TileDefinition().GroundVariants(["SkyTopTileClip"]).PropVariants([]);
         this._tileData[this.tileDefinitions.HORIZON] = new TileDefinition().GroundVariants(["HorizonTileClip","HorizonTileClip2","HorizonTileClip3"]).PropVariants([]);
      }
      
      public function setFirstWorldTileSet() : void
      {
         this._tileData[this.tileDefinitions.DESERT] = this._tileData[this.tileDefinitions.DESERT + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.GRASS] = this._tileData[this.tileDefinitions.GRASS + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.HILLS] = this._tileData[this.tileDefinitions.HILLS + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.FOREST] = this._tileData[this.tileDefinitions.FOREST + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.HEAVY_FOREST] = this._tileData[this.tileDefinitions.HEAVY_FOREST + this.DEFAULT_SET];
         this._tileData[this.tileDefinitions.MOUNTAINS].GroundVariants(["GrassTileClip"]);
         this._tileData[this.tileDefinitions.VOLCANO].GroundVariants(["VolcanoGroundTileClip2"]);
         this._tileData[this.tileDefinitions.JUNGLE].GroundVariants(["GrassTileClip"]);
         this.tileDefinitions.setFirstWorldTileSet();
      }
      
      public function setSecondWorldTileSet() : void
      {
         this._tileData[this.tileDefinitions.DESERT] = this._tileData[this.tileDefinitions.DESERT + this.SECOND_SET];
         this._tileData[this.tileDefinitions.GRASS] = this._tileData[this.tileDefinitions.GRASS + this.SECOND_SET];
         this._tileData[this.tileDefinitions.HILLS] = this._tileData[this.tileDefinitions.HILLS + this.SECOND_SET];
         this._tileData[this.tileDefinitions.FOREST] = this._tileData[this.tileDefinitions.FOREST + this.SECOND_SET];
         this._tileData[this.tileDefinitions.HEAVY_FOREST] = this._tileData[this.tileDefinitions.HEAVY_FOREST + this.SECOND_SET];
         this._tileData[this.tileDefinitions.MOUNTAINS].GroundVariants(["DesertGrassGroundTileClip"]);
         this._tileData[this.tileDefinitions.VOLCANO].GroundVariants(["DesertGrassGroundTileClip"]);
         this._tileData[this.tileDefinitions.JUNGLE].GroundVariants(["DesertGrassGroundTileClip"]);
         this.tileDefinitions.setSecondWorldTileSet();
      }
      
      public function makeRandomTileOfType(param1:String, param2:Boolean = false) : Tile
      {
         var _loc8_:String = null;
         if(this._tileData[param1])
         {
         }
         var _loc3_:Tile = new Tile();
         var _loc4_:String = param1;
         _loc3_.type = param1;
         _loc3_.terrainDefinition = this.tileDefinitions.getTerrainDefinitionByID(param1);
         var _loc5_:Array = TileDefinition(this._tileData[_loc4_]).groundVariants;
         var _loc6_:String = "assets.tiles." + _loc5_[this._system.RND.nextInteger(_loc5_.length)];
         _loc3_.addLayerFromClipClass(Tile.GROUND_LAYER,_loc6_,param2);
         var _loc7_:Array = TileDefinition(this._tileData[_loc4_]).propVariants;
         if(_loc7_.length > 0)
         {
            _loc8_ = "assets.tiles." + _loc7_[this._system.RND.nextInteger(_loc7_.length)];
            _loc3_.addLayerFromClipClass(Tile.PROPS_LAYER,_loc8_,param2);
         }
         return _loc3_;
      }
   }
}

class SingletonEnforcer#326
{
    
   
   function SingletonEnforcer#326()
   {
      super();
   }
}
