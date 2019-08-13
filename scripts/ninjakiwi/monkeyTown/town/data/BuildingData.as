package ninjakiwi.monkeyTown.town.data
{
   import assets.bloonIcons.BloonContainmentUnitIconClip;
   import assets.icons.AC130ConstructionHangerIconClip;
   import assets.icons.AceAirportIconClip;
   import assets.icons.AdvancedMonkeyIntelligenceCommsIconClip;
   import assets.icons.AdvancedRocketLabIconClip;
   import assets.icons.AeronauticsLabIconClip;
   import assets.icons.AltarOfSunIconClip;
   import assets.icons.AntiMOABResearchLabIconClip;
   import assets.icons.AntiMaterialsGunLabIconClip;
   import assets.icons.AntiMatterWeaponFacilityIconClip;
   import assets.icons.ApprenticeSchoolofWizardryClipIconClip;
   import assets.icons.ArchivesOfAncientKnowledgeIconClip;
   import assets.icons.ArmouredStealthSiloIconClip;
   import assets.icons.ArmyMonkeyTrainingIcon;
   import assets.icons.BananaFarmBuildingIcon;
   import assets.icons.BananaResearchHQIconClip;
   import assets.icons.BananeriaIcon;
   import assets.icons.BankBuildingIconClip;
   import assets.icons.BarberShopIcon;
   import assets.icons.BiomechEnhancementsIconClip;
   import assets.icons.BlademillIconClip;
   import assets.icons.BlimpConstructionHangerIconClip;
   import assets.icons.BloonInflationFactoryIconClip;
   import assets.icons.BloonKilnIconClip;
   import assets.icons.BloonResearchLabIconClip;
   import assets.icons.BloontoniumGeneratorIconClip;
   import assets.icons.BloontoniumStorageTanksIconClip;
   import assets.icons.BombRangeBuildingIconClip;
   import assets.icons.BoomerangHutIconClip;
   import assets.icons.BridgeIcon;
   import assets.icons.CamoModificationDenIconClip;
   import assets.icons.CentreOfCamoCountermeasuresIconClip;
   import assets.icons.CowboyMonkeyIcon;
   import assets.icons.CryoLabIconClip;
   import assets.icons.CrystalFusionlIconClip;
   import assets.icons.DartlingGunCacheIconClip;
   import assets.icons.DinerIcon;
   import assets.icons.EiffelTowerIcon;
   import assets.icons.EnergyConcentrationCellsIconClip;
   import assets.icons.EngineerSchoolIconClip;
   import assets.icons.EngineerWorkshopIconClip;
   import assets.icons.ExperimentalMaterialsLabIconClip;
   import assets.icons.FerrisWheelIcon;
   import assets.icons.FieryPitIconClip;
   import assets.icons.FishingWharfMonkeyIcon;
   import assets.icons.FlowerBedRowsIcon;
   import assets.icons.FlowerBedSquareIcon;
   import assets.icons.FlowerCarpetIcon;
   import assets.icons.GargantuanVesselAssemblyYardIconClip;
   import assets.icons.GlueFactoryBuildingIconClip;
   import assets.icons.GlueGunnerRangeIconClip;
   import assets.icons.GoldenGateBridgeIcon;
   import assets.icons.GuerillaTacticsTrainingCampIconClip;
   import assets.icons.GunTrainingHallIconClip;
   import assets.icons.HeavyArtilleryFactoryIconClip;
   import assets.icons.HighItensityExplosivesWorkshopIconClip;
   import assets.icons.HighPerformanceUnitIconClip;
   import assets.icons.HouseOfIceIconClip;
   import assets.icons.LeadPropulsionLabIconClip;
   import assets.icons.LumberJackChopIcon;
   import assets.icons.MadScientistLabIcon;
   import assets.icons.MicroAgricultureBuildingIconClip;
   import assets.icons.MonkeyAcadamyIconClip;
   import assets.icons.MonkeyDartHallBuildingIconClip;
   import assets.icons.MonkeyStreetBandIcon;
   import assets.icons.MonkeyTownHallIconClip;
   import assets.icons.MonkeyVillageIconClip;
   import assets.icons.MortarRangeIconClip;
   import assets.icons.MunicipleParkIcon;
   import assets.icons.NavalBaseIconClip;
   import assets.icons.NessieIcon;
   import assets.icons.NewYorkSkylineIcon;
   import assets.icons.NinjaAbodeIconClip;
   import assets.icons.NinjaDojoIconClip;
   import assets.icons.OrdnanceandMunitionsIconClip;
   import assets.icons.OversizeAirshipSupportBayIconClip;
   import assets.icons.OversizeProjectilesWorkshopIconClip;
   import assets.icons.PineappleJuiceBarIcon;
   import assets.icons.PineappleStandBuildingIconClip;
   import assets.icons.PirateSchoolIconClip;
   import assets.icons.PizzaParlourIcon;
   import assets.icons.PoliceMonkeyIcon;
   import assets.icons.PortBuildingIconClip;
   import assets.icons.RadioCommsSupportIconClip;
   import assets.icons.RedTreeIcon;
   import assets.icons.RollerCoasterIcon;
   import assets.icons.RoseBushesIcon;
   import assets.icons.RubberRepairNanoTekIconClip;
   import assets.icons.ShipsFoundryIconClip;
   import assets.icons.SoccerMonkeyIcon;
   import assets.icons.SpikeDispersalUnitIconClip;
   import assets.icons.SpikeFactoryIconClip;
   import assets.icons.SpikeFactoryWarehouseIconClip;
   import assets.icons.SpikeShackIconClip;
   import assets.icons.StatueofLibertyIcon;
   import assets.icons.SuperBombResearchCentreIconClip;
   import assets.icons.SuperEnhancementsIconClip;
   import assets.icons.SuperMonkeyFanClubHouseIconClip;
   import assets.icons.SuperMonkeyVillaIconClip;
   import assets.icons.SuperiorAdhesiveFactoryIconClip;
   import assets.icons.SydneyOperHouseIcon;
   import assets.icons.TackShooterIconClip;
   import assets.icons.TattooShopIcon;
   import assets.icons.TempleComplexIconClip;
   import assets.icons.ThermitePlantIconClip;
   import assets.icons.WaterMillBuildingIconClip;
   import assets.icons.WindMillBuildingIconClip;
   import assets.icons.WindspireIconClip;
   import assets.icons.WizardBuildingIconClip;
   import assets.icons.ZeroPointEnergyGeneratorIconClip;
   import assets.tiles.SnipersRecluseIconClip;
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.buildings.SpecialBuilding;
   import ninjakiwi.monkeyTown.town.buildings.UpgradeBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BananaFarmBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BankBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloonResearchLab;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloontoniumGenerator;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloontoniumStorageTank;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BridgeBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.PortBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.PremiumBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.WaterMillBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.WharfBuilding;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.WindMillBuilding;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.Signal;
   
   public class BuildingData
   {
      
      private static var instance:BuildingData;
       
      
      public var remoteDataLoadedSignal:Signal;
      
      public var LGMath:LGMathUtil;
      
      private var _buildingDefinitionsByID:Array;
      
      private var _requiredSpecialBuildingsByUpgrade:Object;
      
      public const premiumBuildingDefinitionsByNKStoreItemID:Object = {};
      
      public var buildingsRequiringSpecialTerrainProperty:Object;
      
      public const TOWN_HALL_CATEGORY:String = "townHallCategory";
      
      public const BASE_BUILDING:String = "baseBuilding";
      
      public const UPGRADE_BUILDING:String = "upgradeBuilding";
      
      public const RESOURCE_BUILDING:String = "resourceBuilding";
      
      public const SPECIAL_BUILDING:String = "specialBuilding";
      
      public const PVP_BUILDING:String = "pvpBuilding";
      
      public const PREMIUM_BUILDING:String = "premiumBuilding";
      
      private const tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      public const MONKEY_TOWN_HALL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyTownHall").IconGraphicClass(MonkeyTownHallIconClip).GraphicsClasses(["MonkeyTownHallClip","MonkeyTownHallTier1Clip","MonkeyTownHallTier2Clip","MonkeyTownHallTier3Clip","MonkeyTownHallTier4Clip"]).Buildable(false).CustomClass(UpgradeBuilding);
      
      public const MONKEY_DART_HALL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyDartHall").IconGraphicClass(MonkeyDartHallBuildingIconClip).GraphicsClasses(["MonkeyDartHallClip","MonkeyDartHallUpgrade1Clip","MonkeyDartHallUpgrade2Clip"]);
      
      public const SPIKE_FACTORY_WAREHOUSE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SpikeFactoryWarehouse").IconGraphicClass(SpikeFactoryWarehouseIconClip).GraphicsClasses(["SpikeFactoryWarehouseClip","SpikeFactoryWarehouseUpgrade1Clip","SpikeFactoryWarehouseUpgrade2Clip"]).AnimationDelays([20]);
      
      public const BOOMERANG_HUT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BoomerangHut").IconGraphicClass(BoomerangHutIconClip).GraphicsClasses(["BoomerangHutClip","BoomerangHutUpgrade1Clip","BoomerangHutUpgrade2Clip"]).AnimationDelays([15]);
      
      public const SNIPERS_RECLUSE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SnipersRecluse").IconGraphicClass(SnipersRecluseIconClip).GraphicsClasses(["SnipersRecluseClip","SnipersRecluseUpgrade1Clip","SnipersRecluseUpgrade2Clip"]);
      
      public const NINJA_ABODE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("NinjaAbode").IconGraphicClass(NinjaAbodeIconClip).GraphicsClasses(["NinjaAbodeClip","NinjaAbodeUpgrade1Clip","NinjaAbodeUpgrade2Clip"]);
      
      public const BOMB_RANGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BombRange").GraphicsClasses(["BombRangeClip","BombRangeUpgrade1Clip","BombRangeUpgrade2Clip"]).IconGraphicClass(BombRangeBuildingIconClip).AnimationDelays([20]);
      
      public const HOUSE_OF_ICE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("HouseOfIce").IconGraphicClass(HouseOfIceIconClip).GraphicsClasses(["HouseOfIceClip","HouseOfIceUpgrade1Clip","HouseOfIceUpgrade2Clip"]);
      
      public const TACK_SHOOTER_STORAGE_FACILITY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("TackShooterStorageFacility").IconGraphicClass(TackShooterIconClip).GraphicsClasses(["TackShooterFacilityClip","TackShooterStorageFacilityUpgrade1Clip","TackShooterStorageFacilityUpgrade2Clip"]).AnimationDelays([20]);
      
      public const GLUE_GUN_RANGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("GlueGunRange").GraphicsClasses(["GlueGunnerRangeClip","GlueGunnerRangeUpgrade1Clip","GlueGunnerRangeUpgrade2Clip"]).IconGraphicClass(GlueGunnerRangeIconClip);
      
      public const PORT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Port").GraphicsClasses(["BuccaneerPortUpClip","BuccaneerPortUpUpgrade1Clip","BuccaneerPortUpUpgrade2Clip","BuccaneerPortRightClip","BuccaneerPortRightUpgrade1Clip","BuccaneerPortRightUpgrade2Clip","BuccaneerPortDownClip","BuccaneerPortDownUpgrade1Clip","BuccaneerPortDownUpgrade2Clip","BuccaneerPortLeftClip","BuccaneerPortLeftUpgrade1Clip","BuccaneerPortLeftUpgrade2Clip","BuccaneerPortCentreClip","BuccaneerPortCentreUpgrade1Clip","BuccaneerPortCentreUpgrade2Clip"]).IconGraphicClass(PortBuildingIconClip).CustomClass(PortBuilding).States(4);
      
      public const ACE_AIRPORT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AceAirport").GraphicsClasses(["AceAirportClip","AceAirportRunwayClip","AceAirportUpgrade1Clip","AceAirportRunwayUpgrade1Clip","AceAirportUpgrade2Clip","AceAirportRunwayUpgrade2Clip"]).GroundGraphicsClasses(["AceAirportGroundTileClip","AceAirportGroundTileClip","AceAirportGroundTileClip","AceAirportGroundTileClip","AceAirportGroundTileClip","AceAirportGroundTileClip"]).IconGraphicClass(AceAirportIconClip);
      
      public const SUPER_MONKEY_VILLA:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SuperMonkeyVilla").IconGraphicClass(SuperMonkeyVillaIconClip).GraphicsClasses(["SuperMonkeyVillaBuildingClip","EmptyTile","EmptyTile","EmptyTile","SuperMonkeyVillaBuildingUpgrade1Clip","EmptyTile","EmptyTile","EmptyTile","SuperMonkeyVillaBuildingUpgrade2Clip","EmptyTile","EmptyTile","EmptyTile"]).GroundGraphicsClasses(["SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip","SuperMonkeyGrassTileClip"]).AnimationDelays([60,60,60,60]);
      
      public const WIZARDS_TOWER:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("WizardsTower").GraphicsClasses(["WizardsTowerClip","WizardsTowerUpgrade1Clip","WizardsTowerUpgrade2Clip"]).IconGraphicClass(WizardBuildingIconClip);
      
      public const MORTAR_RANGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MortarRange").GraphicsClasses(["MortarRangeClip","MortarRangeUpgrade1Clip","MortarRangeUpgrade2Clip"]).IconGraphicClass(MortarRangeIconClip).AnimationDelays([20]);
      
      public const DARTLING_GUN_CACHE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("DartlingGunCache").GraphicsClasses(["DartlingGunCacheClip","DartlingGunCacheUpgrade1Clip","DartlingGunCacheUpgrade2Clip"]).IconGraphicClass(DartlingGunCacheIconClip);
      
      public const BLOON_INFLATION_AND_DEPLOYMENT_FACTORY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloonInflationAndDeploymentFactory").GraphicsClasses(["BloonInflationFactoryClip"]).IconGraphicClass(BloonInflationFactoryIconClip);
      
      public const BLOONTONIUM_STORAGE_TANK:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloontoniumStorageTank").GraphicsClasses(["BloontoniumStorageTanksClip"]).IconGraphicClass(BloontoniumStorageTanksIconClip).CustomClass(BloontoniumStorageTank);
      
      public const BLOONTONIUM_GENERATOR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloontoniumGenerator").IconGraphicClass(BloontoniumGeneratorIconClip).GraphicsClasses(["BloontoniumGeneratorClip"]).CustomClass(BloontoniumGenerator);
      
      public const ANTI_MOAB_RESEARCH_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AntiMOABResearchLab").GraphicsClasses(["AntiMOABResearchLabClip"]).IconGraphicClass(AntiMOABResearchLabIconClip);
      
      public const CENTER_OF_CAMO_COUNTERMEASURES:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("CentreOfCamoCountermeasures").GraphicsClasses(["CentreOfCamoCountermeasuresClip"]).IconGraphicClass(CentreOfCamoCountermeasuresIconClip);
      
      public const PINEAPPLE_STAND:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("PineappleStand").GraphicsClasses(["PineappleStandClip","PineappleStandClip","PineappleStandClip"]).IconGraphicClass(PineappleStandBuildingIconClip);
      
      public const SPIKE_SHACK:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SpikeShack").GraphicsClasses(["SpikeShackClip","SpikeShackClip","SpikeShackClip"]).IconGraphicClass(SpikeShackIconClip);
      
      public const MONKEY_VILLAGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyVillage").GraphicsClasses(["MonkeyVillageClip","MonkeyVillageUpgrade1Clip","MonkeyVillageUpgrade2Clip"]).IconGraphicClass(MonkeyVillageIconClip);
      
      public const ENGINEER_WORKSHOP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("EngineerWorkshop").GraphicsClasses(["EngineerWorkshopClip","EngineerWorkshopUpgrade1Clip","EngineerWorkshopUpgrade2Clip"]).IconGraphicClass(EngineerWorkshopIconClip);
      
      public const baseBuildingDefinitions:Array = [this.MONKEY_TOWN_HALL,this.MONKEY_DART_HALL,this.BOOMERANG_HUT,this.SPIKE_FACTORY_WAREHOUSE,this.SNIPERS_RECLUSE,this.NINJA_ABODE,this.BOMB_RANGE,this.HOUSE_OF_ICE,this.TACK_SHOOTER_STORAGE_FACILITY,this.GLUE_GUN_RANGE,this.PORT,this.ACE_AIRPORT,this.SUPER_MONKEY_VILLA,this.WIZARDS_TOWER,this.MORTAR_RANGE,this.DARTLING_GUN_CACHE,this.ENGINEER_WORKSHOP,this.SPIKE_SHACK,this.MONKEY_VILLAGE,this.PINEAPPLE_STAND];
      
      public const MONKEY_BANK:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyBank").IconGraphicClass(BankBuildingIconClip).GraphicsClasses(["MonkeyBankClip","MonkeyBankUpgrade1Clip","MonkeyBankUpgrade2Clip","MonkeyBankUpgrade3Clip","MonkeyBankUpgrade4Clip","MonkeyBankUpgrade5Clip","MonkeyBankUpgrade6Clip","MonkeyBankUpgrade7Clip"]).CustomClass(BankBuilding);
      
      public const WINDMILL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Windmill").IconGraphicClass(WindMillBuildingIconClip).GraphicsClasses(["WindmillClip","WindmillUpgrade1Clip"]).CustomClass(WindMillBuilding);
      
      public const WATERMILL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Watermill").IconGraphicClass(WaterMillBuildingIconClip).GraphicsClasses(["WatermillUpClip","WatermillUpUpgrade1Clip","WatermillRightToLeftClip","WatermillRightToLeftUpgrade1Clip","WatermillLeftToRightClip","WatermillLeftToRightUpgrade1Clip","WatermillLeftToBottomCornerClip","WatermillLeftToBottomCornerUpgrade1Clip","WatermillTopToRightCornerClip","WatermillTopToRightCornerUpgrade1Clip","WatermillTopToLeftCornerClip","WatermillTopToLeftCornerUpgrade1Clip","WatermillRightToBottomCornerClip","WatermillRightToBottomCornerUpgrade1Clip"]).States(7).CustomClass(WaterMillBuilding);
      
      public const BANANA_FARM:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BananaFarm").IconGraphicClass(BananaFarmBuildingIcon).GraphicsClasses(["BananaFarmV2Clip","EmptyTile","EmptyTile","EmptyTile","BananaFarmV2Upgrade1Clip","EmptyTile","EmptyTile","EmptyTile","BananaFarmV2Upgrade2Clip","EmptyTile","EmptyTile","EmptyTile","BananaFarmV2Upgrade3Clip","EmptyTile","EmptyTile","EmptyTile","BananaFarmV2Upgrade4Clip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(BananaFarmBuilding);
      
      public const resourceBuildingDefinitions:Array = [this.MONKEY_BANK,this.WINDMILL,this.WATERMILL,this.BANANA_FARM];
      
      public const MONKEY_ACADEMY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyAcademy").IconGraphicClass(MonkeyAcadamyIconClip).GraphicsClasses(["MonkeyAcadamyClip","MonkeyAcadamyTier1Clip","MonkeyAcadamyTier2Clip","MonkeyAcadamyTier3Clip","MonkeyAcadamyTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const GUN_TRAINING_HALL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("GunTrainingHall").IconGraphicClass(GunTrainingHallIconClip).GraphicsClasses(["GunTrainingHallClip","GunTrainingHallTier1Clip","GunTrainingHallTier2Clip","GunTrainingHallTier3Clip","GunTrainingHallTier3Clip"]).CustomClass(UpgradeBuilding);
      
      public const NINJA_DOJO:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("NinjaDojo").IconGraphicClass(NinjaDojoIconClip).GraphicsClasses(["NinjaDojoClip","NinjaDojoTier1Clip","NinjaDojoTier2Clip","NinjaDojoTier3Clip","NinjaDojoTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const ORDNANCE_AND_MUNITIONS_SUPPORT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("OrdnanceAndMunitionsSupport").IconGraphicClass(OrdnanceandMunitionsIconClip).GraphicsClasses(["OrdnanceandMunitionsClip","OrdnanceandMunitionsTier1Clip","OrdnanceandMunitionsTier2Clip","OrdnanceandMunitionsTier3Clip","OrdnanceandMunitionsTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const CRYO_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("CryoLab").IconGraphicClass(CryoLabIconClip).GraphicsClasses(["CryoLabClip","CryoLabTier1Clip","CryoLabTier2Clip","CryoLabTier3Clip","CryoLabTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const GLUE_FACTORY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("GlueFactory").IconGraphicClass(GlueFactoryBuildingIconClip).GraphicsClasses(["GlueFactoryClip","GlueFactoryTier1Clip","GlueFactoryTier2Clip","GlueFactoryTier3Clip","GlueFactoryTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const SHIPS_FOUNDRY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ShipsFoundry").IconGraphicClass(ShipsFoundryIconClip).GraphicsClasses(["ShipsFoundryClip","ShipsFoundryTier1Clip","ShipsFoundryTier2Clip","ShipsFoundryTier3Clip","ShipsFoundryTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const AERONAUTICS_LABORATORY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AeronauticsLaboratory").IconGraphicClass(AeronauticsLabIconClip).GraphicsClasses(["AeronauticsLabClip","AeronauticsLabTier1Clip","AeronauticsLabTier2Clip","AeronauticsLabTier3Clip","AeronauticsLabTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const SUPER_ENHANCEMENTS:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SuperEnhancements").IconGraphicClass(SuperEnhancementsIconClip).GraphicsClasses(["SuperEnhancementsClip","EmptyTile","EmptyTile","EmptyTile","SuperEnhancementsTier1Clip","EmptyTile","EmptyTile","EmptyTile","SuperEnhancementsTier2Clip","EmptyTile","EmptyTile","EmptyTile","SuperEnhancementsTier3Clip","EmptyTile","EmptyTile","EmptyTile","SuperEnhancementsTier4Clip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(UpgradeBuilding).AnimationDelays([15]);
      
      public const APPRENTICE_SCHOOL_OF_WIZARDRY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ApprenticeSchoolOfWizardry").IconGraphicClass(ApprenticeSchoolofWizardryClipIconClip).GraphicsClasses(["ApprenticeSchoolofWizardryClip","ApprenticeSchoolofWizardryTier1Clip","ApprenticeSchoolofWizardryTier2Clip","ApprenticeSchoolofWizardryTier3Clip","ApprenticeSchoolofWizardryTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MicroAgricultureDevelopmentBuilding").IconGraphicClass(MicroAgricultureBuildingIconClip).GraphicsClasses(["MicroAgricultureBuildingClip","MicroAgricultureBuildingTier1Clip","MicroAgricultureBuildingTier2Clip","MicroAgricultureBuildingTier3Clip","MicroAgricultureBuildingTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const SPIKE_PRODUCTION_BUILDING:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SpikeProductionBuilding").IconGraphicClass(SpikeFactoryIconClip).GraphicsClasses(["SpikeFactoryClip","SpikeFactoryTier1Clip","SpikeFactoryTier2Clip","SpikeFactoryTier3Clip","SpikeFactoryTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const ENGINEERING_SCHOOL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("EngineeringSchool").IconGraphicClass(EngineerSchoolIconClip).GraphicsClasses(["EngineerSchoolClip","EngineerSchoolTier1Clip","EngineerSchoolTier2Clip","EngineerSchoolTier3Clip","EngineerSchoolTier4Clip"]).CustomClass(UpgradeBuilding);
      
      public const upgradeBuildingDefinitions:Array = [this.MONKEY_ACADEMY,this.SPIKE_PRODUCTION_BUILDING,this.GUN_TRAINING_HALL,this.NINJA_DOJO,this.ORDNANCE_AND_MUNITIONS_SUPPORT,this.CRYO_LAB,this.GLUE_FACTORY,this.SHIPS_FOUNDRY,this.AERONAUTICS_LABORATORY,this.APPRENTICE_SCHOOL_OF_WIZARDRY,this.MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING,this.SUPER_ENHANCEMENTS,this.ENGINEERING_SCHOOL];
      
      public const OVERSIZE_PROJECTILE_WORKSHOP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("OversizeProjectileWorkshop").IconGraphicClass(OversizeProjectilesWorkshopIconClip).GraphicsClasses(["OversizeProjectilesWorkshopClip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const ANTI_MATERIALS_GUN_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AntiMaterialsGunLab").IconGraphicClass(AntiMaterialsGunLabIconClip).GraphicsClasses(["AntiMaterialsGunLabClip"]).CustomClass(SpecialBuilding);
      
      public const ARCHIVES_OF_ANCIENT_KNOWLEDGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ArchivesOfAncientKnowledge").IconGraphicClass(ArchivesOfAncientKnowledgeIconClip).GraphicsClasses(["ArchivesOfAncientKnowledgeClip"]).AnimationDelays([20]).CustomClass(SpecialBuilding);
      
      public const EXPERIMENTAL_MATERIALS_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ExperimentalMaterialsLab").IconGraphicClass(ExperimentalMaterialsLabIconClip).GraphicsClasses(["ExperimentalMaterialsLabClip"]).CustomClass(SpecialBuilding);
      
      public const THERMITE_PLANT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ThermitePlant").IconGraphicClass(ThermitePlantIconClip).GraphicsClasses(["ThermitePlantClip"]).CustomClass(SpecialBuilding);
      
      public const NAVAL_BASE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("NavalBase").IconGraphicClass(NavalBaseIconClip).GraphicsClasses(["NavalBaseClip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const AC130_CONSTRUCTION_HANGAR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AC130ConstructionHangar").IconGraphicClass(AC130ConstructionHangerIconClip).GraphicsClasses(["AC130ConstructionHangerClip"]).CustomClass(SpecialBuilding);
      
      public const ALTAR_OF_SUN:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AltarOfSun").IconGraphicClass(AltarOfSunIconClip).GraphicsClasses(["AltarOfSunClip"]).CustomClass(SpecialBuilding);
      
      public const TEMPLE_COMPLEX:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("TempleComplex").IconGraphicClass(TempleComplexIconClip).GraphicsClasses(["TempleComplexClip","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const WIND_SPIRE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("WindSpire").IconGraphicClass(WindspireIconClip).GraphicsClasses(["WindspireClip"]).CustomClass(SpecialBuilding);
      
      public const BANANA_RESEARCH_HQ:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BananaResearchHQ").IconGraphicClass(BananaResearchHQIconClip).GraphicsClasses(["BananaResearchHQClip"]).CustomClass(SpecialBuilding);
      
      public const SUPER_BOMB_RESEARCH_CENTRE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SuperBombResearchCentre").IconGraphicClass(SuperBombResearchCentreIconClip).GraphicsClasses(["SuperBombResearchCentreClip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const HIGH_INTENSITY_EXPLOSIVES_WORKSHOP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("HighIntensityExplosivesWorkshop").IconGraphicClass(HighItensityExplosivesWorkshopIconClip).GraphicsClasses(["HighItensityExplosivesWorkshopClip"]).CustomClass(SpecialBuilding);
      
      public const CRYSTAL_FUSION_ARRAY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("CrystalFusionArray").IconGraphicClass(CrystalFusionlIconClip).GraphicsClasses(["CrystalFusionArrayClip","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const ENERGY_CONCENTRATION_CELLS:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("EnergyConcentrationCells").IconGraphicClass(EnergyConcentrationCellsIconClip).GraphicsClasses(["EnergyConcentrationCellsClip"]).CustomClass(SpecialBuilding);
      
      public const SUPER_MONKEY_FAN_CLUB_HOUSE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SuperMonkeyFanClubhouse").IconGraphicClass(SuperMonkeyFanClubHouseIconClip).GraphicsClasses(["SuperMonkeyFanClubHouseClip"]).CustomClass(SpecialBuilding);
      
      public const RADIO_COMMS_SUPPORT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("RadioCommsSupport").IconGraphicClass(RadioCommsSupportIconClip).GraphicsClasses(["RadioCommsSupportClip"]).CustomClass(SpecialBuilding);
      
      public const GUERILLA_TACTICS_TRAINING_CAMP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("GuerillaTacticsTrainingCamp").IconGraphicClass(GuerillaTacticsTrainingCampIconClip).GraphicsClasses(["GuerillaTacticsTrainingCampClip"]).CustomClass(SpecialBuilding);
      
      public const ZERO_POINT_ENERGY_GENERATOR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ZeroPointEnergyGenerator").IconGraphicClass(ZeroPointEnergyGeneratorIconClip).GraphicsClasses(["ZeroPointEnergyGeneratorClip"]).CustomClass(SpecialBuilding);
      
      public const BLADE_MILL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Blademill").IconGraphicClass(BlademillIconClip).GraphicsClasses(["BladeMillClip"]).CustomClass(SpecialBuilding);
      
      public const SUPERIOR_ADHESIVE_FACTORY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SuperiorAdhesiveFactory").IconGraphicClass(SuperiorAdhesiveFactoryIconClip).GraphicsClasses(["SuperiorAdhesiveFactoryClip"]).CustomClass(SpecialBuilding);
      
      public const PIRATE_SCHOOL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("PirateSchool").IconGraphicClass(PirateSchoolIconClip).GraphicsClasses(["PirateSchoolClip"]).CustomClass(SpecialBuilding);
      
      public const BIOMECH_ENHANCEMENTS:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BiomechEnhancements").IconGraphicClass(BiomechEnhancementsIconClip).GraphicsClasses(["BiomechEnhancementsClip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const ANTIMATTER_WEAPON_FACILITY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AntimatterWeaponFacility").IconGraphicClass(AntiMatterWeaponFacilityIconClip).GraphicsClasses(["AntiMatterWeaponFacilityClip","EmptyTile","EmptyTile","EmptyTile"]).CustomClass(SpecialBuilding);
      
      public const FIREY_PIT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FieryPit").IconGraphicClass(FieryPitIconClip).GraphicsClasses(["FieryPitClip"]).CustomClass(SpecialBuilding);
      
      public const HEAVY_ARTILLERY_FACTORY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("HeavyArtilleryFactory").IconGraphicClass(HeavyArtilleryFactoryIconClip).GraphicsClasses(["HeavyArtilleryFactoryClip"]).CustomClass(SpecialBuilding);
      
      public const SPIKE_DISPERSAL_UNIT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SpikeDispersalUnit").IconGraphicClass(SpikeDispersalUnitIconClip).GraphicsClasses(["SpikeDispersalUnitClip"]).CustomClass(SpecialBuilding);
      
      public const ADVANCED_ROCKET_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AdvancedRocketLab").IconGraphicClass(AdvancedRocketLabIconClip).GraphicsClasses(["AdvancedRocketLabClip"]).CustomClass(SpecialBuilding);
      
      public const ADVANCED_MONKEY_INTELLIGENCE_COMMS:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("AdvancedMonkeyIntelligenceComms").IconGraphicClass(AdvancedMonkeyIntelligenceCommsIconClip).GraphicsClasses(["AdvancedMonkeyIntelligenceCommsClip"]).CustomClass(SpecialBuilding);
      
      public const BLOON_RESEARCH_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloonResearchLab").IconGraphicClass(BloonResearchLabIconClip).GraphicsClasses(["BloonResearchLabClip","BloonResearchFastBloonsClip","BloonResearchLabThermalClip","BloonResearchLabHeavyArmourClip","BloonResearchLabRubberRepairClip","BloonResearchLabCamoModClip","BloonResearchLabMultiLayerClip","BloonResearchLabCeramicClip","BloonResearchLabMOABClip","BloonResearchLabBFBClip","BloonResearchLabZOMGClip","BloonResearchLabDDTClip"]).CustomClass(BloonResearchLab);
      
      public const BLOON_CONTAINMENT_UNIT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloonContainmentUnit").IconGraphicClass(BloonContainmentUnitIconClip).GraphicsClasses(["BloonContainmentUnitClip"]).CustomClass(SpecialBuilding);
      
      public const HIGH_PERFORMANCE_UNIT:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("HighPerformanceUnit").IconGraphicClass(HighPerformanceUnitIconClip).GraphicsClasses(["HighPerformanceUnitClip"]).CustomClass(SpecialBuilding);
      
      public const specialBuildingDefinitions:Array = [this.CENTER_OF_CAMO_COUNTERMEASURES,this.ANTI_MOAB_RESEARCH_LAB,this.OVERSIZE_PROJECTILE_WORKSHOP,this.ANTI_MATERIALS_GUN_LAB,this.ARCHIVES_OF_ANCIENT_KNOWLEDGE,this.EXPERIMENTAL_MATERIALS_LAB,this.THERMITE_PLANT,this.NAVAL_BASE,this.AC130_CONSTRUCTION_HANGAR,this.ALTAR_OF_SUN,this.TEMPLE_COMPLEX,this.WIND_SPIRE,this.BANANA_RESEARCH_HQ,this.SUPER_BOMB_RESEARCH_CENTRE,this.HIGH_INTENSITY_EXPLOSIVES_WORKSHOP,this.CRYSTAL_FUSION_ARRAY,this.ENERGY_CONCENTRATION_CELLS,this.SUPER_MONKEY_FAN_CLUB_HOUSE,this.RADIO_COMMS_SUPPORT,this.GUERILLA_TACTICS_TRAINING_CAMP,this.ZERO_POINT_ENERGY_GENERATOR,this.BLADE_MILL,this.SUPERIOR_ADHESIVE_FACTORY,this.PIRATE_SCHOOL,this.BIOMECH_ENHANCEMENTS,this.ANTIMATTER_WEAPON_FACILITY,this.FIREY_PIT,this.HEAVY_ARTILLERY_FACTORY,this.SPIKE_DISPERSAL_UNIT,this.ADVANCED_ROCKET_LAB,this.ADVANCED_MONKEY_INTELLIGENCE_COMMS,this.BLOON_CONTAINMENT_UNIT,this.HIGH_PERFORMANCE_UNIT];
      
      public const RUBBER_REPAIR_NANO_TEK:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("RubberRepairNanoTek").GraphicsClasses(["RubberRepairNanoTekClip"]).IconGraphicClass(RubberRepairNanoTekIconClip);
      
      public const LEAD_PROPULSION_LAB:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("LeadPropulsionLab").GraphicsClasses(["LeadPropulsionLabClip"]).IconGraphicClass(LeadPropulsionLabIconClip);
      
      public const BLOON_KILN:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BloonKiln").GraphicsClasses(["BloonKilnClip"]).IconGraphicClass(BloonKilnIconClip);
      
      public const BLIMP_CONSTRUCTION_HANGAR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BlimpConstructionHangar").GraphicsClasses(["BlimpConstructionHangarClip"]).IconGraphicClass(BlimpConstructionHangerIconClip);
      
      public const OVERSIZE_AIRSHIP_SUPPORT_BAY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("OversizeAirshipSupportBay").GraphicsClasses(["OversizeAirshipSupportBayClip","EmptyTile","EmptyTile","EmptyTile"]).IconGraphicClass(OversizeAirshipSupportBayIconClip);
      
      public const GARGANTUAN_VESSEL_ASSEMBLY_YARD:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("GargantuanVesselAssemblyYard").GraphicsClasses(["GargantuanVesselAssemblyYardClip","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile"]).IconGraphicClass(GargantuanVesselAssemblyYardIconClip);
      
      public const CAMO_MODIFICATION_DEN:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("CamoModificationDen").GraphicsClasses(["CamoModificationDenClip"]).IconGraphicClass(CamoModificationDenIconClip);
      
      public const ARMOURED_STEALTH_SILO_CLIP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ArmouredStealthSilo").GraphicsClasses(["ArmouredStealthSiloClip","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile","EmptyTile"]).IconGraphicClass(ArmouredStealthSiloIconClip);
      
      public const pvpBuildingDefinitions:Array = [this.BLOON_INFLATION_AND_DEPLOYMENT_FACTORY,this.BLOONTONIUM_GENERATOR,this.BLOONTONIUM_STORAGE_TANK,this.BLOON_RESEARCH_LAB,this.RUBBER_REPAIR_NANO_TEK,this.LEAD_PROPULSION_LAB,this.BLOON_KILN,this.BLIMP_CONSTRUCTION_HANGAR,this.OVERSIZE_AIRSHIP_SUPPORT_BAY,this.GARGANTUAN_VESSEL_ASSEMBLY_YARD,this.CAMO_MODIFICATION_DEN,this.ARMOURED_STEALTH_SILO_CLIP];
      
      public const PINEAPPLE_JUICE_BAR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("PineappleJuiceBar").IconGraphicClass(PineappleJuiceBarIcon).GraphicsClasses(["PineappleJuiceBar"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const RED_TREE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("RedTree").IconGraphicClass(RedTreeIcon).GraphicsClasses(["RedTree"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const BARBER_SHOP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BarberShop").IconGraphicClass(BarberShopIcon).GraphicsClasses(["BarberShop"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const TATTOO_PARLOUR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("TattooParlour").IconGraphicClass(TattooShopIcon).GraphicsClasses(["TattooParlour"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const BANANERIA:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Bananeria").IconGraphicClass(BananeriaIcon).GraphicsClasses(["Bananeria"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const PIZZA_PARLOUR:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("PizzaParlour").IconGraphicClass(PizzaParlourIcon).GraphicsClasses(["PizzaParlour"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const DINER_BUILDING:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("DinerBuilding").IconGraphicClass(DinerIcon).GraphicsClasses(["DinerBuilding"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const FLOWER_CARPET:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FlowerCarpet").IconGraphicClass(FlowerCarpetIcon).GraphicsClasses(["FlowerCarpet"]).CustomClass(PremiumBuilding);
      
      public const FLOWER_BED_ROWS:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FlowerBedRows").IconGraphicClass(FlowerBedRowsIcon).GraphicsClasses(["FlowerBedRows"]).CustomClass(PremiumBuilding);
      
      public const FLOWER_BED_SQUARE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FlowerBedSquare").IconGraphicClass(FlowerBedSquareIcon).GraphicsClasses(["FlowerBedSquare"]).CustomClass(PremiumBuilding);
      
      public const MUNICIPLE_PARK:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MuniciplePark").IconGraphicClass(MunicipleParkIcon).GraphicsClasses(["MuniciplePark01","MuniciplePark02","MuniciplePark03","MuniciplePark04"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["EmptyTile","EmptyTile","EmptyTile","MunicipleParkGround"]);
      
      public const EIFFEL_TOWER:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("EiffelTower").IconGraphicClass(EiffelTowerIcon).GraphicsClasses(["EiffelTower"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const MONKEY_OF_LIBERTY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyOfLiberty").IconGraphicClass(StatueofLibertyIcon).GraphicsClasses(["MonkeyOfLiberty"]).CustomClass(PremiumBuilding);
      
      public const SYDNEY_OPERA_HOUSE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SydneyOperaHouse").IconGraphicClass(SydneyOperHouseIcon).GraphicsClasses(["SydneyOperaHouse"]).CustomClass(PremiumBuilding);
      
      public const NEW_YORK_SKYLINE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("NewYorkSkyline").IconGraphicClass(NewYorkSkylineIcon).GraphicsClasses(["NewYorkSkyline"]).CustomClass(PremiumBuilding);
      
      public const ROLLERCOASTER:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("RollerCoaster").IconGraphicClass(RollerCoasterIcon).GraphicsClasses(["Rollercoaster"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const FERRIS_WHEEL:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FerrisWheel").IconGraphicClass(FerrisWheelIcon).GraphicsClasses(["FerrisWheel"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const ROSE_BUSHES:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("RoseBushes").IconGraphicClass(RoseBushesIcon).GraphicsClasses(["RoseBushes"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const FISHING_WHARF:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("FishingWharf").IconGraphicClass(FishingWharfMonkeyIcon).GraphicsClasses(["FishingWharfDown","FishingWharfLeft","FishingWharfUp","FishingWharfRight"]).States(4).CustomClass(WharfBuilding);
      
      public const MONKEY_STREET_BAND:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MonkeyStreetBand").IconGraphicClass(MonkeyStreetBandIcon).GraphicsClasses(["MonkeyStreetBand"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumStoneBase"]);
      
      public const COWBOY_MONKEY_RIDE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("CowboyMonkeyRide").IconGraphicClass(CowboyMonkeyIcon).GraphicsClasses(["CowboyMonkeyRide"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["premiumSandBase"]);
      
      public const SOCCER_MONKEY_ZIG_ZAG:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("SoccerMonkeyZigZag").IconGraphicClass(SoccerMonkeyIcon).GraphicsClasses(["SoccerMonkeyZigZag"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumGrassBase"]);
      
      public const LOCH_NESS_MONSTER:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("LochNess").IconGraphicClass(NessieIcon).GraphicsClasses(["LochNess"]).CustomClass(PremiumBuilding);
      
      public const POLICE_MONKEY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("PoliceMonkey").IconGraphicClass(PoliceMonkeyIcon).GraphicsClasses(["PoliceMonkey"]).CustomClass(PremiumBuilding);
      
      public const ARMY_MONKEY_TRAINING:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("ArmyMonkeyTraining").IconGraphicClass(ArmyMonkeyTrainingIcon).GraphicsClasses(["armyMonkeyTraining"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumDirtBase"]);
      
      public const BRIDGE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("Bridge").IconGraphicClass(BridgeIcon).GraphicsClasses(["BridgeTopVertical","BridgeLeftCornerBottom","BridgeHorizontal","BridgeLeftCornerTop","BridgeRightCornerTop","BridgeRightCornerBottom"]).States(6).CustomClass(BridgeBuilding);
      
      public const BRIDGE_GOLDEN_GATE:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("BridgeGoldenGate").IconGraphicClass(GoldenGateBridgeIcon).GraphicsClasses(["BridgeGoldenGateVertical","BridgeGoldenGateLeftCornerBottom","BridgeGoldenGateRight","BridgeGoldenGateLeftCornerTop","BridgeGoldenGateRightCornerTop","BridgeGoldenGateRightCornerBottom"]).States(6).CustomClass(BridgeBuilding);
      
      public const MAD_SCIENTIST_MONKEY:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("MadScientistLab").IconGraphicClass(MadScientistLabIcon).GraphicsClasses(["MadScientistsLab"]).CustomClass(PremiumBuilding).GroundGraphicsClasses(["PremiumStoneBase"]);
      
      public const LUMBER_JACK_CHOP:MonkeyTownBuildingDefinition = new MonkeyTownBuildingDefinition().Id("LumberJackChop").IconGraphicClass(LumberJackChopIcon).GraphicsClasses(["LumberJackChop"]).CustomClass(PremiumBuilding);
      
      public const premiumBuildingDefinitions:Array = [this.ROLLERCOASTER,this.FERRIS_WHEEL,this.EIFFEL_TOWER,this.BANANERIA,this.PINEAPPLE_JUICE_BAR,this.DINER_BUILDING,this.PIZZA_PARLOUR,this.TATTOO_PARLOUR,this.BARBER_SHOP,this.NEW_YORK_SKYLINE,this.SYDNEY_OPERA_HOUSE,this.MONKEY_OF_LIBERTY,this.BRIDGE,this.BRIDGE_GOLDEN_GATE,this.LOCH_NESS_MONSTER,this.FISHING_WHARF,this.RED_TREE,this.FLOWER_CARPET,this.FLOWER_BED_ROWS,this.FLOWER_BED_SQUARE,this.ROSE_BUSHES,this.MUNICIPLE_PARK,this.MONKEY_STREET_BAND,this.COWBOY_MONKEY_RIDE,this.LUMBER_JACK_CHOP,this.SOCCER_MONKEY_ZIG_ZAG,this.POLICE_MONKEY,this.ARMY_MONKEY_TRAINING,this.MAD_SCIENTIST_MONKEY];
      
      private const _defaultDisallowedTerrains:Array = [this.tileDefinitions.LAKE,this.tileDefinitions.RIVER];
      
      public function BuildingData(param1:SingletonEnforcer#327)
      {
         this.remoteDataLoadedSignal = new Signal();
         this.LGMath = LGMathUtil.getInstance();
         this._buildingDefinitionsByID = [];
         this._requiredSpecialBuildingsByUpgrade = {};
         this.buildingsRequiringSpecialTerrainProperty = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use BuildingData.getInstance() instead of new.");
         }
      }
      
      private static function configureChristmas() : void
      {
         BuildingData.getInstance().MONKEY_TOWN_HALL.GraphicsClasses(["MonkeyTownHallTier1ClipXmas","MonkeyTownHallTier1ClipXmas","MonkeyTownHallTier2ClipXmas","MonkeyTownHallTier3ClipXmas","MonkeyTownHallTier4ClipXmas"]);
      }
      
      public static function getInstance() : BuildingData
      {
         if(instance == null)
         {
            instance = new BuildingData(new SingletonEnforcer#327());
            if(Constants.IS_CHRISTMAS)
            {
               configureChristmas();
            }
         }
         return instance;
      }
      
      public function initialiseFromDataObjects(param1:Object, param2:Object, param3:Object, param4:Object, param5:Object) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MonkeyTownBuildingDefinition = null;
         var _loc9_:Object = null;
         var _loc11_:MonkeyTownBuildingDefinition = null;
         var _loc12_:MonkeyTownBuildingDefinition = null;
         var _loc13_:String = null;
         _loc6_ = 0;
         while(_loc6_ < this.baseBuildingDefinitions.length)
         {
            _loc8_ = this.baseBuildingDefinitions[_loc6_];
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param1[_loc8_.id] != undefined)
            {
               this.initBuildingDefinitionFromObject(_loc8_,param1[_loc8_.id]);
            }
            _loc8_.buildingCategory = this.BASE_BUILDING;
            _loc6_++;
         }
         this.baseBuildingDefinitions.sort(this.sortByPrice);
         _loc6_ = 0;
         while(_loc6_ < this.resourceBuildingDefinitions.length)
         {
            _loc8_ = this.resourceBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.RESOURCE_BUILDING;
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param1[_loc8_.id] != undefined)
            {
               this.initBuildingDefinitionFromObject(_loc8_,param1[_loc8_.id]);
            }
            _loc6_++;
         }
         this.resourceBuildingDefinitions.sort(this.sortByPrice);
         _loc6_ = 0;
         while(_loc6_ < this.upgradeBuildingDefinitions.length)
         {
            _loc8_ = this.upgradeBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.UPGRADE_BUILDING;
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param2[_loc8_.id] != undefined)
            {
               this.initBuildingDefinitionFromObject(_loc8_,param2[_loc8_.id]);
            }
            _loc6_++;
         }
         this.upgradeBuildingDefinitions.sort(this.sortByPrice);
         _loc6_ = 0;
         while(_loc6_ < this.specialBuildingDefinitions.length)
         {
            _loc8_ = this.specialBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.SPECIAL_BUILDING;
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param3[_loc8_.id] != undefined)
            {
               _loc9_ = param3[_loc8_.id];
               this.initBuildingDefinitionFromObject(_loc8_,_loc9_);
               if(_loc9_.enablesUpgrades)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc9_.enablesUpgrades.length)
                  {
                     _loc13_ = _loc9_.enablesUpgrades[_loc7_];
                     this._requiredSpecialBuildingsByUpgrade[_loc13_] = _loc8_;
                     _loc7_++;
                  }
               }
            }
            _loc6_++;
         }
         this.specialBuildingDefinitions.sort(this.sortByPrice);
         _loc6_ = 0;
         while(_loc6_ < this.pvpBuildingDefinitions.length)
         {
            _loc8_ = this.pvpBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.PVP_BUILDING;
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param4[_loc8_.id] != undefined)
            {
               _loc9_ = param4[_loc8_.id];
               this.initBuildingDefinitionFromObject(_loc8_,_loc9_);
            }
            _loc6_++;
         }
         this.pvpBuildingDefinitions.sort(this.sortByPrice);
         _loc6_ = 0;
         while(_loc6_ < this.pvpBuildingDefinitions.length)
         {
            _loc8_ = this.pvpBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.PVP_BUILDING;
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < this.premiumBuildingDefinitions.length)
         {
            _loc8_ = this.premiumBuildingDefinitions[_loc6_];
            _loc8_.buildingCategory = this.PREMIUM_BUILDING;
            this._buildingDefinitionsByID[_loc8_.id] = _loc8_;
            if(param5[_loc8_.id] != undefined)
            {
               _loc9_ = param5[_loc8_.id];
               this.initBuildingDefinitionFromObject(_loc8_,_loc9_);
            }
            _loc6_++;
         }
         var _loc10_:Array = this.baseBuildingDefinitions.concat(this.upgradeBuildingDefinitions).concat(this.specialBuildingDefinitions).concat(this.pvpBuildingDefinitions).concat(this.premiumBuildingDefinitions);
         _loc6_ = 0;
         while(_loc6_ < _loc10_.length)
         {
            _loc11_ = _loc10_[_loc6_];
            if(_loc11_.requiresTerrainProperty !== "" && _loc11_.requiresTerrainProperty !== null)
            {
               if(typeof this.buildingsRequiringSpecialTerrainProperty[_loc11_.requiresTerrainProperty] === "undefined")
               {
                  this.buildingsRequiringSpecialTerrainProperty[_loc11_.requiresTerrainProperty] = [];
               }
               this.buildingsRequiringSpecialTerrainProperty[_loc11_.requiresTerrainProperty].push(_loc11_);
            }
            _loc6_++;
         }
         for each(_loc12_ in this.premiumBuildingDefinitions)
         {
            this.premiumBuildingDefinitionsByNKStoreItemID[_loc12_.nkItemID] = _loc12_;
         }
      }
      
      private function sortByPrice(param1:MonkeyTownBuildingDefinition, param2:MonkeyTownBuildingDefinition) : int
      {
         if(param1.monkeyMoneyCost > param2.monkeyMoneyCost)
         {
            return 1;
         }
         if(param1.monkeyMoneyCost < param2.monkeyMoneyCost)
         {
            return -1;
         }
         return 0;
      }
      
      private function sortByNKCoinCost(param1:MonkeyTownBuildingDefinition, param2:MonkeyTownBuildingDefinition) : int
      {
         if(param1.nkCoinCost > param2.nkCoinCost)
         {
            return 1;
         }
         if(param1.nkCoinCost < param2.nkCoinCost)
         {
            return -1;
         }
         return 0;
      }
      
      public function getBuildingsRequiringSpecialTerrain(param1:String) : Array
      {
         return this.buildingsRequiringSpecialTerrainProperty[param1] || null;
      }
      
      public function getRequiredSpecialBuildingForUpgrade(param1:String) : MonkeyTownBuildingDefinition
      {
         return this._requiredSpecialBuildingsByUpgrade[param1] || null;
      }
      
      private function initBuildingDefinitionFromObject(param1:MonkeyTownBuildingDefinition, param2:Object) : void
      {
         var _loc5_:Array = null;
         var _loc3_:Array = param2.requiresTerrain.split(";");
         var _loc4_:Array = param2.disallowTerrain.split(";");
         if(param2.enablesUpgrades != undefined)
         {
            _loc5_ = param2.enablesUpgrades.split(";");
         }
         else
         {
            _loc5_ = null;
         }
         var _loc6_:Array = param2.footprint.split("x");
         var _loc7_:Array = !!param2.upgrades?param2.upgrades.split(";"):null;
         var _loc8_:IntPoint2D = new IntPoint2D();
         if(_loc6_.length == 2)
         {
            _loc8_.x = this.LGMath.stringToNumber("" + _loc6_[0]);
            _loc8_.y = this.LGMath.stringToNumber("" + _loc6_[1]);
         }
         if(_loc3_.length == 1 && _loc3_[0] == "")
         {
            _loc3_ = null;
         }
         if(_loc4_.length == 1 && _loc4_[0] == "")
         {
            if(_loc3_ !== null)
            {
               _loc4_ = this.getValidatedDefaultDisallowedTerrainTypes(_loc3_);
            }
            else
            {
               _loc4_ = this._defaultDisallowedTerrains;
            }
         }
         if(param2.customClass == "")
         {
            param2.customClass = null;
         }
         if(_loc8_.x < 1)
         {
            _loc8_.x = 1;
         }
         if(_loc8_.y < 1)
         {
            _loc8_.y = 1;
         }
         param2.width = _loc8_.x;
         param2.height = _loc8_.y;
         param2.requiresTerrain = _loc3_;
         param2.disallowTerrain = _loc4_;
         param2.upgrades = _loc7_;
         param2.enablesUpgrades = _loc5_;
         var _loc9_:DefinitionPopulator = new DefinitionPopulator();
         _loc9_.populateDefinitionFromObject(param1,param2);
         if(param1.graphicsClasses == null)
         {
            param1.graphicsClasses = ["BuildingPlaceholder"];
         }
      }
      
      public function getValidatedDefaultDisallowedTerrainTypes(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc4_:Array = [];
         var _loc5_:Boolean = true;
         _loc2_ = 0;
         while(_loc2_ < this._defaultDisallowedTerrains.length)
         {
            _loc5_ = true;
            _loc6_ = this._defaultDisallowedTerrains[_loc2_];
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(param1[_loc3_] === _loc6_)
               {
                  _loc5_ = false;
                  break;
               }
               _loc3_++;
            }
            if(_loc5_)
            {
               _loc4_.push(_loc6_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function getBuildingDefinitionByID(param1:String) : MonkeyTownBuildingDefinition
      {
         if(this._buildingDefinitionsByID[param1] != undefined)
         {
            return this._buildingDefinitionsByID[param1];
         }
         return null;
      }
      
      public function getPremiumBuildingDefinitionByNKStoreID(param1:*) : MonkeyTownBuildingDefinition
      {
         if(param1 is String)
         {
            param1 = parseInt(param1);
         }
         if(this.premiumBuildingDefinitionsByNKStoreItemID[param1] != undefined)
         {
            return this.premiumBuildingDefinitionsByNKStoreItemID[param1];
         }
         return null;
      }
   }
}

class SingletonEnforcer#327
{
    
   
   function SingletonEnforcer#327()
   {
      super();
   }
}
