package ninjakiwi.monkeyTown.town.tile
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainSpecialPropertyDefinition;
   import ninjakiwi.monkeyTown.town.tileProps.TileEdgeSetVariantsDefinition;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class TileDefinitions
   {
      
      private static var instance:TileDefinitions;
       
      
      public const GRASS:String = "GrassTerrain";
      
      public const FOREST:String = "ForestTerrain";
      
      public const HEAVY_FOREST:String = "HeavyForestTerrain";
      
      public const HILLS:String = "HillsTerrain";
      
      public const MOUNTAINS:String = "MountainTerrain";
      
      public const VOLCANO:String = "VolcanoTerrain";
      
      public const SNOW:String = "SnowTerrain";
      
      public const LAKE:String = "LakeTerrain";
      
      public const DESERT:String = "DesertTerrain";
      
      public const DESERT_BADLANDS:String = "DesertBadlandsTerrain";
      
      public const DESERT_HIGHLANDS:String = "DesertHighlandsTerrain";
      
      public const DESERT_ARID_GRASSLANDS:String = "DesertAridGrasslandsTerrain";
      
      public const DESERT_TYPES:Array = [this.DESERT,this.DESERT_BADLANDS,this.DESERT_HIGHLANDS,this.DESERT_ARID_GRASSLANDS];
      
      public const RIVER:String = "RiverTerrain";
      
      public const JUNGLE:String = "JungleTerrain";
      
      public const WATTLE_TREES:String = "WattleTrees";
      
      public const TRANQUIL_GLADE:String = "TranquilGlade";
      
      public const GLACIER:String = "Glacier";
      
      public const SHIPWRECK:String = "Shipwreck";
      
      public const PHASE_CRYSTAL:String = "PhaseCrystal";
      
      public const STICKY_SAP_PLANT:String = "StickySapPlant";
      
      public const CONSECRATED_GROUND:String = "ConsecratedGround";
      
      public const MOAB_GRAVEYARD:String = "MOABGraveyard";
      
      public const CAVES:String = "Caves";
      
      public const RUINS:String = "RuinsTerrain";
      
      public const DRY_AS_A_BONE:String = "DryAsABone";
      
      public const SANDSTORM:String = "Sandstorm";
      
      public const ZZZZOMG:String = "ZZZZOMG";
      
      public const GRASS_NAME:String = "Grass";
      
      public const FOREST_NAME:String = "Forest";
      
      public const HEAVY_FOREST_NAME:String = "Heavy Forest";
      
      public const HILLS_NAME:String = "Hills";
      
      public const MOUNTAINS_NAME:String = "Mountain";
      
      public const VOLCANO_NAME:String = "Volcano";
      
      public const SNOW_NAME:String = "Snow";
      
      public const LAKE_NAME:String = "Lake";
      
      public const DESERT_NAME:String = "Desert";
      
      public const DESERT_HIGHLANDS_NAME:String = "High Desert";
      
      public const DESERT_BADLANDS_NAME:String = "Badlands";
      
      public const DESERT_ARID_GRASSLANDS_NAME:String = "Arid Grasslands";
      
      public const RIVER_NAME:String = "River";
      
      public const JUNGLE_NAME:String = "Jungle";
      
      public const WATTLE_TREES_NAME:String = "Wattle Trees";
      
      public const TRANQUIL_GLADE_NAME:String = "Tranquil Glade";
      
      public const GLACIER_NAME:String = "Glacier";
      
      public const SHIPWRECK_NAME:String = "Shipwreck";
      
      public const PHASE_CRYSTAL_NAME:String = "Phase Crystal";
      
      public const STICKY_SAP_PLANT_NAME:String = "Sticky Sap Plant";
      
      public const CONSECRATED_GROUND_NAME:String = "Consecrated Ground";
      
      public const MOAB_GRAVEYARD_NAME:String = "MOAB Graveyard";
      
      public const CAVES_NAME:String = "Caves";
      
      public const RUINS_NAME:String = "Ruins";
      
      public const DRY_AS_A_BONE_NAME:String = "Dry As A Bone";
      
      public const SANDSTORM_NAME:String = "Sandstorm";
      
      public const ZZZZOMG_NAME:String = "ZZZZOMG";
      
      public const TERRAIN_NAMES_BY_ID:Object = {
         this.GRASS.valueOf():this.GRASS_NAME,
         this.FOREST.valueOf():this.FOREST_NAME,
         this.HEAVY_FOREST.valueOf():this.HEAVY_FOREST_NAME,
         this.HILLS.valueOf():this.HILLS_NAME,
         this.MOUNTAINS.valueOf():this.MOUNTAINS_NAME,
         this.VOLCANO.valueOf():this.VOLCANO_NAME,
         this.SNOW.valueOf():this.SNOW_NAME,
         this.LAKE.valueOf():this.LAKE_NAME,
         this.DESERT.valueOf():this.DESERT_NAME,
         this.DESERT_HIGHLANDS.valueOf():this.DESERT_HIGHLANDS_NAME,
         this.DESERT_BADLANDS.valueOf():this.DESERT_BADLANDS_NAME,
         this.DESERT_ARID_GRASSLANDS.valueOf():this.DESERT_ARID_GRASSLANDS_NAME,
         this.DESERT.valueOf():this.DESERT_NAME,
         this.DESERT.valueOf():this.DESERT_NAME,
         this.RIVER.valueOf():this.RIVER_NAME,
         this.JUNGLE.valueOf():this.JUNGLE_NAME,
         this.WATTLE_TREES.valueOf():this.WATTLE_TREES_NAME,
         this.TRANQUIL_GLADE.valueOf():this.TRANQUIL_GLADE_NAME,
         this.GLACIER.valueOf():this.GLACIER_NAME,
         this.SHIPWRECK.valueOf():this.SHIPWRECK_NAME,
         this.PHASE_CRYSTAL.valueOf():this.PHASE_CRYSTAL_NAME,
         this.STICKY_SAP_PLANT.valueOf():this.STICKY_SAP_PLANT_NAME,
         this.CONSECRATED_GROUND.valueOf():this.CONSECRATED_GROUND_NAME,
         this.MOAB_GRAVEYARD.valueOf():this.MOAB_GRAVEYARD_NAME,
         this.CAVES.valueOf():this.CAVES_NAME,
         this.RUINS.valueOf():this.RUINS_NAME,
         this.DRY_AS_A_BONE.valueOf():this.DRY_AS_A_BONE_NAME,
         this.SANDSTORM.valueOf():this.SANDSTORM_NAME,
         this.ZZZZOMG.valueOf():this.ZZZZOMG_NAME,
         "WaterEdge":"Water\'s Edge"
      };
      
      public const SKY:String = "sky";
      
      public const HORIZON:String = "horizon";
      
      public const CLIFF_TOP:String = "cliffTop";
      
      public const CLIFF_BOTTOM:String = "cliffBottom";
      
      public const GRASS_GROUND:String = "GrassGround";
      
      public const WATER_GROUND:String = "WaterGround";
      
      public const DESERT_GROUND:String = "DesertGround";
      
      public const DESERT_GRASS_GROUND:String = "DesertGrassGround";
      
      public const SNOW_GROUND:String = "SnowGround";
      
      public const GRASS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.GRASS);
      
      public const FOREST_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.FOREST);
      
      public const HEAVY_FOREST_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.HEAVY_FOREST);
      
      public const HILLS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.HILLS);
      
      public const MOUNTAINS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.MOUNTAINS);
      
      public const VOLCANO_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.VOLCANO);
      
      public const SNOW_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.SNOW);
      
      public const LAKE_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.LAKE);
      
      public const DESERT_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.DESERT);
      
      public const DESERT_BADLANDS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.DESERT_BADLANDS);
      
      public const DESERT_HIGHLANDS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.DESERT_HIGHLANDS);
      
      public const DESERT_ARID_GRASSLANDS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.DESERT_ARID_GRASSLANDS);
      
      public const RIVER_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.RIVER);
      
      public const JUNGLE_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.JUNGLE);
      
      public const RUINS_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.RUINS);
      
      public const SKY_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.SKY);
      
      public const HORIZON_DEFINITION:TerrainDefinition = new TerrainDefinition().Id(this.HORIZON);
      
      public const terrainDefinitions:Array = [this.GRASS_DEFINITION,this.FOREST_DEFINITION,this.HEAVY_FOREST_DEFINITION,this.JUNGLE_DEFINITION,this.HILLS_DEFINITION,this.MOUNTAINS_DEFINITION,this.VOLCANO_DEFINITION,this.SNOW_DEFINITION,this.LAKE_DEFINITION,this.DESERT_DEFINITION,this.RIVER_DEFINITION,this.RUINS_DEFINITION,this.DESERT_BADLANDS_DEFINITION,this.DESERT_HIGHLANDS_DEFINITION,this.DESERT_ARID_GRASSLANDS_DEFINITION];
      
      public const WATTLE_TREES_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.WATTLE_TREES).GraphicClass("assets.tiles.WattleTreesClip");
      
      public const TRANQUIL_GLADE_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.TRANQUIL_GLADE).GraphicClass("assets.tiles.TranquilGladeClip");
      
      public const GLACIER_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.GLACIER).GraphicClass("assets.tiles.GlacierClip");
      
      public const SHIPWRECK_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.SHIPWRECK).GraphicClass("assets.tiles.ShipwreckClip");
      
      public const PHASE_CRYSTAL_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.PHASE_CRYSTAL).GraphicClass("assets.tiles.PhaseCrystalClip");
      
      public const STICKY_SAP_PLANT_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.STICKY_SAP_PLANT).GraphicClass("assets.tiles.JungleSappyPlantClip");
      
      public const CONSECRATED_GROUND_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.CONSECRATED_GROUND).GraphicClass("assets.tiles.ConsecratedGroundClip");
      
      public const MOAB_GRAVEYARD_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.MOAB_GRAVEYARD).GraphicClass("assets.tiles.MoabGraveyardClip");
      
      public const CAVES_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.CAVES).GraphicClass("assets.tiles.Caves2TileClip");
      
      public const DRY_AS_A_BONE_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.DRY_AS_A_BONE).GraphicClass("assets.tiles.DryAsABoneMissionClip");
      
      public const SANDSTORM_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.SANDSTORM).GraphicClass("assets.tiles.SandstormMissionClip");
      
      public const ZZZOMG_DEFINITION:TerrainSpecialPropertyDefinition = new TerrainSpecialPropertyDefinition().Id(this.ZZZZOMG).GraphicClass("assets.tiles.ZZZZOMGMissionClip");
      
      public const terrainSpecialPropertyDefinitions:Array = [this.WATTLE_TREES_DEFINITION,this.TRANQUIL_GLADE_DEFINITION,this.GLACIER_DEFINITION,this.SHIPWRECK_DEFINITION,this.PHASE_CRYSTAL_DEFINITION,this.STICKY_SAP_PLANT_DEFINITION,this.MOAB_GRAVEYARD_DEFINITION,this.CAVES_DEFINITION,this.CONSECRATED_GROUND_DEFINITION,this.DRY_AS_A_BONE_DEFINITION,this.SANDSTORM_DEFINITION,this.ZZZOMG_DEFINITION];
      
      public const terrainHeirarchy:Array = [this.LAKE_DEFINITION,this.RIVER_DEFINITION,this.DESERT_DEFINITION,this.GRASS_DEFINITION,this.JUNGLE_DEFINITION,this.FOREST_DEFINITION,this.HEAVY_FOREST_DEFINITION,this.HILLS_DEFINITION,this.MOUNTAINS_DEFINITION,this.VOLCANO_DEFINITION,this.SNOW_DEFINITION];
      
      public const GRASS_EDGE_VARIANTS:TileEdgeSetVariantsDefinition = new TileEdgeSetVariantsDefinition().CornerLT(["assets.tiles.GrassGroundCornerLTClip","assets.tiles.GrassGroundCornerLTClip2"]).CornerRT(["assets.tiles.GrassGroundCornerRTClip","assets.tiles.GrassGroundCornerRTClip2"]).CornerLB(["assets.tiles.GrassGroundCornerLBClip","assets.tiles.GrassGroundCornerLBClip2"]).CornerRB(["assets.tiles.GrassGroundCornerRBClip","assets.tiles.GrassGroundCornerRBClip2"]).EdgeTop(["assets.tiles.GrassGroundEdgeTopClip"]).EdgeRight(["assets.tiles.GrassGroundEdgeRightClip"]).EdgeBottom(["assets.tiles.GrassGroundEdgeBottomClip"]).EdgeLeft(["assets.tiles.GrassGroundEdgeLeftClip"]).EdgeTopHalfLeft(["assets.tiles.GrassGroundEdgeTopHalfLeftClip"]).EdgeRightHalfTop(["assets.tiles.GrassGroundEdgeRightHalfTopClip"]).EdgeTopHalfRight(["assets.tiles.GrassGroundEdgeTopHalfRightClip"]).EdgeRightHalfBottom(["assets.tiles.GrassGroundEdgeRightHalfBottomClip"]).EdgeBottomHalfRight(["assets.tiles.GrassGroundEdgeBottomHalfRightClip"]).EdgeBottomHalfLeft(["assets.tiles.GrassGroundEdgeBottomHalfLeftClip"]).EdgeLeftHalfBottom(["assets.tiles.GrassGroundEdgeLeftHalfBottomClip"]).EdgeLeftHalfTop(["assets.tiles.GrassGroundEdgeLeftHalfTopClip"]);
      
      public const DESERT_GRASS_EDGE_VARIANTS:TileEdgeSetVariantsDefinition = new TileEdgeSetVariantsDefinition().CornerLT(["assets.tiles.DesertGrassGroundCornerLTClip"]).CornerRT(["assets.tiles.DesertGrassGroundCornerRTClip"]).CornerLB(["assets.tiles.DesertGrassGroundCornerLBClip"]).CornerRB(["assets.tiles.DesertGrassGroundCornerRBClip"]).EdgeTop(["assets.tiles.DesertGrassGroundEdgeTopClip"]).EdgeRight(["assets.tiles.DesertGrassGroundEdgeRightClip"]).EdgeBottom(["assets.tiles.DesertGrassGroundEdgeBottomClip"]).EdgeLeft(["assets.tiles.DesertGrassGroundEdgeLeftClip"]).EdgeTopHalfLeft(["assets.tiles.DesertGrassGroundEdgeTopHalfLeftClip"]).EdgeRightHalfTop(["assets.tiles.DesertGrassGroundEdgeRightHalfTopClip"]).EdgeTopHalfRight(["assets.tiles.DesertGrassGroundEdgeTopHalfRightClip"]).EdgeRightHalfBottom(["assets.tiles.DesertGrassGroundEdgeRightHalfBottomClip"]).EdgeBottomHalfRight(["assets.tiles.DesertGrassGroundEdgeBottomHalfRightClip"]).EdgeBottomHalfLeft(["assets.tiles.DesertGrassGroundEdgeBottomHalfLeftClip"]).EdgeLeftHalfBottom(["assets.tiles.DesertGrassGroundEdgeLeftHalfBottomClip"]).EdgeLeftHalfTop(["assets.tiles.DesertGrassGroundEdgeLeftHalfTopClip"]);
      
      public const WATER_EDGE_VARIANTS:TileEdgeSetVariantsDefinition = new TileEdgeSetVariantsDefinition().CornerLT(["assets.tiles.LakeGroundCornerLTClip"]).CornerRT(["assets.tiles.LakeGroundCornerRTClip"]).CornerLB(["assets.tiles.LakeGroundCornerLBClip"]).CornerRB(["assets.tiles.LakeGroundCornerRBClip"]).EdgeTop(["assets.tiles.LakeGroundEdgeTopClip"]).EdgeRight(["assets.tiles.LakeGroundEdgeRightClip"]).EdgeBottom(["assets.tiles.LakeGroundEdgeBottomClip"]).EdgeLeft(["assets.tiles.LakeGroundEdgeLeftClip"]);
      
      public const DESERT_EDGE_VARIANTS:TileEdgeSetVariantsDefinition = new TileEdgeSetVariantsDefinition().CornerLT(["assets.tiles.DesertGroundCornerLTClip"]).CornerRT(["assets.tiles.DesertGroundCornerRTClip"]).CornerLB(["assets.tiles.DesertGroundCornerLBClip"]).CornerRB(["assets.tiles.DesertGroundCornerRBClip"]).EdgeTop(["assets.tiles.DesertGroundEdgeTopClip"]).EdgeRight(["assets.tiles.DesertGroundEdgeRightClip"]).EdgeBottom(["assets.tiles.DesertGroundEdgeBottomClip"]).EdgeLeft(["assets.tiles.DesertGroundEdgeLeftClip"]).EdgeTopHalfLeft(["assets.tiles.DesertGroundEdgeTopHalfLeftClip"]).EdgeRightHalfTop(["assets.tiles.DesertGroundEdgeRightHalfTopClip"]).EdgeTopHalfRight(["assets.tiles.DesertGroundEdgeTopHalfRightClip"]).EdgeRightHalfBottom(["assets.tiles.DesertGroundEdgeRightHalfBottomClip"]).EdgeBottomHalfRight(["assets.tiles.DesertGroundEdgeBottomHalfRightClip"]).EdgeBottomHalfLeft(["assets.tiles.DesertGroundEdgeBottomHalfLeftClip"]).EdgeLeftHalfBottom(["assets.tiles.DesertGroundEdgeLeftHalfBottomClip"]).EdgeLeftHalfTop(["assets.tiles.DesertGroundEdgeLeftHalfTopClip"]);
      
      public const SNOW_EDGE_VARIANTS:TileEdgeSetVariantsDefinition = new TileEdgeSetVariantsDefinition().CornerLT(["assets.tiles.SnowGroundCornerLTClip"]).CornerRT(["assets.tiles.SnowGroundCornerRTClip"]).CornerLB(["assets.tiles.SnowGroundCornerLBClip"]).CornerRB(["assets.tiles.SnowGroundCornerRBClip"]).EdgeTop(["assets.tiles.SnowGroundEdgeTopClip"]).EdgeRight(["assets.tiles.SnowGroundEdgeRightClip"]).EdgeBottom(["assets.tiles.SnowGroundEdgeBottomClip"]).EdgeLeft(["assets.tiles.SnowGroundEdgeLeftClip"]).EdgeTopHalfLeft(["assets.tiles.SnowGroundEdgeTopHalfLeftClip"]).EdgeRightHalfTop(["assets.tiles.SnowGroundEdgeRightHalfTopClip"]).EdgeTopHalfRight(["assets.tiles.SnowGroundEdgeTopHalfRightClip"]).EdgeRightHalfBottom(["assets.tiles.SnowGroundEdgeRightHalfBottomClip"]).EdgeBottomHalfRight(["assets.tiles.SnowGroundEdgeBottomHalfRightClip"]).EdgeBottomHalfLeft(["assets.tiles.SnowGroundEdgeBottomHalfLeftClip"]).EdgeLeftHalfBottom(["assets.tiles.SnowGroundEdgeLeftHalfBottomClip"]).EdgeLeftHalfTop(["assets.tiles.SnowGroundEdgeLeftHalfTopClip"]);
      
      public const GRASS_EDGE_SET_ID:String = "grass";
      
      public const WATER_EDGE_SET_ID:String = "water";
      
      public const DESERT_EDGE_SET_ID:String = "desert";
      
      public const SNOW_EDGE_SET_ID:String = "snow";
      
      public const EDGE_SETS_BY_ID:Object = {
         "grass":this.GRASS_EDGE_VARIANTS,
         "water":this.WATER_EDGE_VARIANTS,
         "desert":this.DESERT_EDGE_VARIANTS,
         "snow":this.SNOW_EDGE_VARIANTS
      };
      
      public const tileRoShamBoOrder:Array = [this.SNOW_EDGE_VARIANTS,this.WATER_EDGE_VARIANTS,this.DESERT_EDGE_VARIANTS,this.DESERT_GRASS_EDGE_VARIANTS,this.GRASS_EDGE_VARIANTS];
      
      public var terrainDefinitionsByID:Object;
      
      public var terrainSpecialPropertyDefinitionsByID:Object;
      
      public function TileDefinitions(param1:SingletonEnforcer#740)
      {
         this.terrainDefinitionsByID = {};
         this.terrainSpecialPropertyDefinitionsByID = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use TileDefinitions.getInstance() instead of new.");
         }
         this.initData();
      }
      
      public static function getInstance() : TileDefinitions
      {
         if(instance == null)
         {
            instance = new TileDefinitions(new SingletonEnforcer#740());
         }
         return instance;
      }
      
      public function setFirstWorldTileSet() : void
      {
         this.EDGE_SETS_BY_ID["grass"] = this.GRASS_EDGE_VARIANTS;
      }
      
      public function setSecondWorldTileSet() : void
      {
         this.EDGE_SETS_BY_ID["grass"] = this.DESERT_GRASS_EDGE_VARIANTS;
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.tileRoShamBoOrder.length)
         {
            TileEdgeSetVariantsDefinition(this.tileRoShamBoOrder[_loc1_]).roShamBo = _loc1_;
            _loc1_++;
         }
      }
      
      public function initialiseTerrainDataFromObject(param1:Object) : void
      {
         var _loc2_:TerrainDefinition = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.terrainDefinitions.length)
         {
            _loc2_ = this.terrainDefinitions[_loc4_];
            this.terrainDefinitionsByID[_loc2_.id] = _loc2_;
            if(param1[_loc2_.id] != undefined)
            {
               _loc3_ = param1[_loc2_.id];
               _loc2_.Name(_loc3_.name).LevelModifier(_loc3_.levelModifier).GroundType(_loc3_.groundType).MinimumOnMap(_loc3_.minimumOnMap).MaximumOnMap(_loc3_.maximumOnMap);
               switch(_loc2_.groundType)
               {
                  case this.GRASS_GROUND:
                     _loc2_.edgeSetID = this.GRASS_EDGE_SET_ID;
                     break;
                  case this.WATER_GROUND:
                     _loc2_.edgeSetID = this.WATER_EDGE_SET_ID;
                     break;
                  case this.DESERT_GROUND:
                     _loc2_.edgeSetID = this.DESERT_EDGE_SET_ID;
                     break;
                  case this.SNOW_GROUND:
                     _loc2_.edgeSetID = this.SNOW_EDGE_SET_ID;
                     break;
                  case this.DESERT_GRASS_GROUND:
                     _loc2_.edgeSetID = this.SNOW_EDGE_SET_ID;
               }
            }
            _loc4_++;
         }
      }
      
      public function initialiseTerrainSpecialPropertiesDataFromObject(param1:Object) : void
      {
         var _loc2_:TerrainSpecialPropertyDefinition = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.terrainSpecialPropertyDefinitions.length)
         {
            _loc2_ = this.terrainSpecialPropertyDefinitions[_loc4_];
            this.terrainSpecialPropertyDefinitionsByID[_loc2_.id] = _loc2_;
            if(param1[_loc2_.id] != undefined)
            {
               _loc3_ = param1[_loc2_.id];
               _loc2_.Name(_loc3_.name).TerrainType(_loc3_.terrainType).Description(_loc3_.description).QuantityPerMap(_loc3_.quantityPerMap).LevelModifier(_loc3_.levelModifier);
            }
            _loc4_++;
         }
      }
      
      public function getTerrainNameByID(param1:String) : String
      {
         var _loc2_:String = this.TERRAIN_NAMES_BY_ID[param1];
         if(_loc2_ === null)
         {
            _loc2_ = param1;
            ErrorReporter.say("TileDefinitions::getTerrainNameByID() Warning - no terrain name found for this id " + param1);
         }
         return _loc2_;
      }
      
      public function getTerrainDefinitionByID(param1:String) : TerrainDefinition
      {
         if(param1 == "Volcano")
         {
            param1 = this.VOLCANO;
         }
         if(this.terrainDefinitionsByID[param1])
         {
            return this.terrainDefinitionsByID[param1];
         }
         return null;
      }
      
      public function isSpecialTerrain(param1:Tile) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(this.isCave(param1) || this.isVolcano(param1))
         {
            return false;
         }
         if(param1.terrainSpecialProperty != null)
         {
            return true;
         }
         return false;
      }
      
      public function isVolcano(param1:Tile) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.terrainDefinition.id == TileDefinitions.getInstance().VOLCANO_DEFINITION.id && param1.terrainSpecialProperty == null)
         {
            return true;
         }
         return false;
      }
      
      public function isCave(param1:Tile) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.terrainSpecialProperty != null && param1.terrainSpecialProperty.id == TileDefinitions.getInstance().CAVES_DEFINITION.id)
         {
            return true;
         }
         return false;
      }
   }
}

class SingletonEnforcer#740
{
    
   
   function SingletonEnforcer#740()
   {
      super();
   }
}
