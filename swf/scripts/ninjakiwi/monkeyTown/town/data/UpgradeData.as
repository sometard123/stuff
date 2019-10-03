package ninjakiwi.monkeyTown.town.data
{
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.bridges.UpgradesBridge;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.BuildingUpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   
   public class UpgradeData
   {
      
      public static var upgradeDefinitionsByBTDTower:Object = {};
      
      private static var instance:UpgradeData;
       
      
      public const DART_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("DartMonkeyUpgrades").BtdTowerID(Constants.TOWER_DART);
      
      public const BOOMERANG_THROWER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("BoomerangThrowerUpgrades").BtdTowerID(Constants.TOWER_BOOMERANG);
      
      public const SNIPER_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("SniperMonkeyUpgrades").BtdTowerID(Constants.TOWER_SNIPER);
      
      public const DARTLING_GUN_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("DartlingGunUpgrades").BtdTowerID(Constants.TOWER_DARTLING);
      
      public const NINJA_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("NinjaMonkeyUpgrades").BtdTowerID(Constants.TOWER_NINJA);
      
      public const BOMB_TOWER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("BombTowerUpgrades").BtdTowerID(Constants.TOWER_BOMB);
      
      public const MORTAR_TOWER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("MortarTowerUpgrades").BtdTowerID(Constants.TOWER_MORTAR);
      
      public const ICE_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("IceMonkeyUpgrades").BtdTowerID(Constants.TOWER_ICE);
      
      public const GLUE_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("GlueMonkeyUpgrades").BtdTowerID(Constants.TOWER_GLUE);
      
      public const BUCCANEER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("BuccaneerUpgrades").BtdTowerID(Constants.TOWER_BUCCANEER);
      
      public const AERO_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("AeroMonkeyUpgrades").BtdTowerID(Constants.TOWER_PLANE);
      
      public const SUPER_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("SuperMonkeyUpgrades").BtdTowerID(Constants.TOWER_SUPER);
      
      public const WIZARD_MONKEY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("WizardMonkeyUpgrades").BtdTowerID(Constants.TOWER_APPRENTICE);
      
      public const AGRICULTURAL_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("AgriculturalUpgrades").BtdTowerID(Constants.TOWER_FARM);
      
      public const TACK_SHOOTER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("TackShooterUpgrades").BtdTowerID(Constants.TOWER_TACK);
      
      public const SPIKE_FACTORY_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("SpikeFactoryUpgrades").BtdTowerID(Constants.TOWER_SPIKEFACTORY);
      
      public const TOWN_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("TownUpgrades").BtdTowerID(Constants.TOWER_VILLAGE);
      
      public const ENGINEER_UPGRADES:UpgradeDefinition = new UpgradeDefinition().Id("EngineerUpgrades").BtdTowerID(Constants.TOWER_ENGINEER);
      
      public const upgradeDefinitions:Array = [this.DART_MONKEY_UPGRADES,this.BOOMERANG_THROWER_UPGRADES,this.SNIPER_MONKEY_UPGRADES,this.DARTLING_GUN_UPGRADES,this.NINJA_MONKEY_UPGRADES,this.BOMB_TOWER_UPGRADES,this.MORTAR_TOWER_UPGRADES,this.ICE_MONKEY_UPGRADES,this.GLUE_MONKEY_UPGRADES,this.BUCCANEER_UPGRADES,this.AERO_MONKEY_UPGRADES,this.SUPER_MONKEY_UPGRADES,this.WIZARD_MONKEY_UPGRADES,this.AGRICULTURAL_UPGRADES,this.TACK_SHOOTER_UPGRADES,this.SPIKE_FACTORY_UPGRADES,this.TOWN_UPGRADES,this.ENGINEER_UPGRADES];
      
      public const BIGGER_WINDMILL:BuildingUpgradeDefinition = new BuildingUpgradeDefinition().Id("BiggerWindmill");
      
      public const BIGGER_WATERMILL:BuildingUpgradeDefinition = new BuildingUpgradeDefinition().Id("BiggerWatermill");
      
      public const BIGGER_BLOONTONIUM_GENERATOR:BuildingUpgradeDefinition = new BuildingUpgradeDefinition().Id("BiggerGenerator");
      
      public const BIGGER_BLOONTONIUM_TANK:BuildingUpgradeDefinition = new BuildingUpgradeDefinition().Id("BiggerTank");
      
      public const buildingUpgradeDefinitions:Array = [this.BIGGER_WINDMILL,this.BIGGER_WATERMILL,this.BIGGER_BLOONTONIUM_GENERATOR,this.BIGGER_BLOONTONIUM_TANK];
      
      private var _buildingUpgradesByBuildingID:Object;
      
      private var _upgradesByID:Object;
      
      private var _system:MonkeySystem;
      
      public function UpgradeData(param1:SingletonEnforcer#182)
      {
         this._buildingUpgradesByBuildingID = {};
         this._upgradesByID = {};
         this._system = MonkeySystem.getInstance();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use UpgradeData.getInstance() instead of new.");
         }
         this.initUpgradeDefinitionsByBTDTower();
         UpgradesBridge.REQUEST_UPGRADE_INFORMATION.add(onRequestUpgradeInformation);
      }
      
      public static function getUpgradeDefinitionsByBTDTowerID(param1:String) : UpgradeDefinition
      {
         var _loc2_:UpgradeDefinition = upgradeDefinitionsByBTDTower[param1];
         if(_loc2_ === null)
         {
         }
         return _loc2_;
      }
      
      private static function onRequestUpgradeInformation(param1:String, param2:int, param3:int, param4:Function) : void
      {
         var _loc5_:UpgradeDefinition = getUpgradeDefinitionsByBTDTowerID(param1);
         if(_loc5_ === null)
         {
            param4({
               "success":false,
               "message":"No upgrade for this tower"
            });
            return;
         }
         var _loc6_:BuildingData = BuildingData.getInstance();
         var _loc7_:LGMathUtil = LGMathUtil.getInstance();
         param2 = _loc7_.clamp(param2,0,1);
         param3 = _loc7_.clamp(param3,0,3);
         var _loc8_:String = "path" + (param2 + 1).toString();
         var _loc9_:String = "tier" + (param3 + 1).toString();
         var _loc10_:UpgradePathTierDefinition = _loc5_[_loc8_][_loc9_];
         var _loc11_:String = _loc10_.name;
         var _loc12_:MonkeyTownBuildingDefinition = _loc6_.getBuildingDefinitionByID(_loc5_.building);
         var _loc13_:String = _loc12_.name;
         param4({
            "success":true,
            "upgradeName":_loc11_,
            "buildingName":_loc13_
         });
      }
      
      public static function getInstance() : UpgradeData
      {
         if(instance == null)
         {
            instance = new UpgradeData(new SingletonEnforcer#182());
         }
         return instance;
      }
      
      public function initialiseFromDataObject(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UpgradeDefinition = null;
         _loc2_ = 0;
         while(_loc2_ < this.upgradeDefinitions.length)
         {
            _loc3_ = this.upgradeDefinitions[_loc2_];
            if(param1[_loc3_.id] != undefined)
            {
               this.initUpgradeDefinitionFromObject(_loc3_,param1[_loc3_.id]);
            }
            _loc2_++;
         }
         this.initialiseDescriptions();
      }
      
      public function initialiseBuildingUpgrades(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BuildingUpgradeDefinition = null;
         _loc2_ = 0;
         while(_loc2_ < this.buildingUpgradeDefinitions.length)
         {
            _loc3_ = this.buildingUpgradeDefinitions[_loc2_];
            if(param1[_loc3_.id] != undefined)
            {
               this.initBuildingUpgradeDefinitionFromObject(_loc3_,param1[_loc3_.id]);
            }
            _loc2_++;
         }
      }
      
      private function initUpgradeDefinitionsByBTDTower() : void
      {
         var _loc1_:UpgradeDefinition = null;
         var _loc3_:String = null;
         upgradeDefinitionsByBTDTower = {};
         var _loc2_:int = 0;
         while(_loc2_ < this.upgradeDefinitions.length)
         {
            _loc1_ = this.upgradeDefinitions[_loc2_];
            if(_loc1_.btdTowerID !== null)
            {
               _loc3_ = _loc1_.btdTowerID.toString();
               upgradeDefinitionsByBTDTower[_loc3_] = _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function initUpgradeDefinitionFromObject(param1:UpgradeDefinition, param2:Object) : void
      {
         param1.path1 = new UpgradePathDefinition();
         param1.path2 = new UpgradePathDefinition();
         param1.Building(param2.building);
         param1.Name(param2.name);
         param1.path1.tier1 = new UpgradePathTierDefinition().Id(param2.path1Tier1_id).Name(param2.path1Tier1_name).Cost(param2.path1Tier1_cost).BloonstoneCost(param2.path1Tier1_bloonstoneCost).Time(param2.path1Tier1_time).XpGiven(param2.path1Tier1_xpGiven).MinimumMonkeyTownLevel(param2.path1Tier1_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path1Tier1_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path1Tier1_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path1Tier1_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path1Tier1_requiresTerrainProperty)).IconClassName(param2.path1Tier1_iconClassName);
         param1.path1.tier2 = new UpgradePathTierDefinition().Id(param2.path1Tier2_id).Name(param2.path1Tier2_name).Cost(param2.path1Tier2_cost).BloonstoneCost(param2.path1Tier2_bloonstoneCost).Time(param2.path1Tier2_time).XpGiven(param2.path1Tier2_xpGiven).MinimumMonkeyTownLevel(param2.path1Tier2_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path1Tier2_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path1Tier2_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path1Tier2_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path1Tier2_requiresTerrainProperty)).IconClassName(param2.path1Tier2_iconClassName);
         param1.path1.tier3 = new UpgradePathTierDefinition().Id(param2.path1Tier3_id).Name(param2.path1Tier3_name).Cost(param2.path1Tier3_cost).BloonstoneCost(param2.path1Tier3_bloonstoneCost).Time(param2.path1Tier3_time).XpGiven(param2.path1Tier3_xpGiven).MinimumMonkeyTownLevel(param2.path1Tier3_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path1Tier3_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path1Tier3_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path1Tier3_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path1Tier3_requiresTerrainProperty)).IconClassName(param2.path1Tier3_iconClassName);
         param1.path1.tier4 = new UpgradePathTierDefinition().Id(param2.path1Tier4_id).Name(param2.path1Tier4_name).Cost(param2.path1Tier4_cost).BloonstoneCost(param2.path1Tier4_bloonstoneCost).Time(param2.path1Tier4_time).XpGiven(param2.path1Tier4_xpGiven).MinimumMonkeyTownLevel(param2.path1Tier4_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path1Tier4_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path1Tier4_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path1Tier4_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path1Tier4_requiresTerrainProperty)).IconClassName(param2.path1Tier4_iconClassName);
         param1.path2.tier1 = new UpgradePathTierDefinition().Id(param2.path2Tier1_id).Name(param2.path2Tier1_name).Cost(param2.path2Tier1_cost).BloonstoneCost(param2.path2Tier1_bloonstoneCost).Time(param2.path2Tier1_time).XpGiven(param2.path2Tier1_xpGiven).MinimumMonkeyTownLevel(param2.path2Tier1_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path2Tier1_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path2Tier1_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path2Tier1_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path2Tier1_requiresTerrainProperty)).IconClassName(param2.path2Tier1_iconClassName);
         param1.path2.tier2 = new UpgradePathTierDefinition().Id(param2.path2Tier2_id).Name(param2.path2Tier2_name).Cost(param2.path2Tier2_cost).BloonstoneCost(param2.path2Tier2_bloonstoneCost).Time(param2.path2Tier2_time).XpGiven(param2.path2Tier2_xpGiven).MinimumMonkeyTownLevel(param2.path2Tier2_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path2Tier2_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path2Tier2_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path2Tier2_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path2Tier2_requiresTerrainProperty)).IconClassName(param2.path2Tier2_iconClassName);
         param1.path2.tier3 = new UpgradePathTierDefinition().Id(param2.path2Tier3_id).Name(param2.path2Tier3_name).Cost(param2.path2Tier3_cost).BloonstoneCost(param2.path2Tier3_bloonstoneCost).Time(param2.path2Tier3_time).XpGiven(param2.path2Tier3_xpGiven).MinimumMonkeyTownLevel(param2.path2Tier3_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path2Tier3_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path2Tier3_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path2Tier3_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path2Tier3_requiresTerrainProperty)).IconClassName(param2.path2Tier3_iconClassName);
         param1.path2.tier4 = new UpgradePathTierDefinition().Id(param2.path2Tier4_id).Name(param2.path2Tier4_name).Cost(param2.path2Tier4_cost).BloonstoneCost(param2.path2Tier4_bloonstoneCost).Time(param2.path2Tier4_time).XpGiven(param2.path2Tier4_xpGiven).MinimumMonkeyTownLevel(param2.path2Tier4_minTownLevel).RequiresBuilding(this.splitAndValidate(param2.path2Tier4_requiresBuilding)).RequiresUpgrade(this.splitAndValidate(param2.path2Tier4_requiresUpgrade)).RequiresTerrain(this.splitAndValidate(param2.path2Tier4_requiresTerrain)).RequiresTerrainProperty(this.splitAndValidate(param2.path2Tier4_requiresTerrainProperty)).IconClassName(param2.path2Tier4_iconClassName);
         this._upgradesByID[param1.id] = param1;
      }
      
      private function initBuildingUpgradeDefinitionFromObject(param1:BuildingUpgradeDefinition, param2:Object) : void
      {
         param1.Name(param2.name).Cost(param2.cost).Building(param2.building).RequiredMTL(param2.requiredMTL).Tier1(param2.tier1).Tier2(param2.tier2).TimeToUpgrade(param2.timeToUpgrade).XpGiven(param2.timeToUpgrade);
         this._buildingUpgradesByBuildingID[param1.building] = param1;
      }
      
      private function splitAndValidate(param1:String) : Array
      {
         var _loc2_:Array = param1.split(";");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_.length == 1 && _loc2_[0] == "")
            {
               _loc2_.length = 0;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getUpgradeDefinitionByID(param1:String) : UpgradeDefinition
      {
         if(this._upgradesByID[param1])
         {
            return this._upgradesByID[param1];
         }
         return null;
      }
      
      public function getBuildingUpgradeByBuildingID(param1:String) : BuildingUpgradeDefinition
      {
         if(this._buildingUpgradesByBuildingID[param1])
         {
            return this._buildingUpgradesByBuildingID[param1];
         }
         return null;
      }
      
      public function getBuildingUpgradeTierValue(param1:String, param2:int) : int
      {
         var _loc3_:BuildingUpgradeDefinition = null;
         if(this._buildingUpgradesByBuildingID[param1])
         {
            if(param2 < 1)
            {
               param2 = 1;
            }
            else if(param2 > 2)
            {
               param2 = 2;
            }
            _loc3_ = this._buildingUpgradesByBuildingID[param1];
            if(param2 == 1)
            {
               return _loc3_.tier1;
            }
            return _loc3_.tier2;
         }
         return 0;
      }
      
      private function getDefinitionListByIDList(param1:Array) : void
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(this._upgradesByID[param1[_loc3_]])
            {
               _loc2_.push(this._upgradesByID[param1[_loc3_]]);
            }
            _loc3_++;
         }
      }
      
      public function isUpgradeAvailable(param1:String) : Boolean
      {
         return this._system.city.buildingManager.getBuildingCount(this.getUpgradeDefinitionByID(param1).building) > 0;
      }
      
      private function initialiseDescriptions() : void
      {
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path1.tier1.description = "Makes the Dart Monkey shoot further than normal.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path1.tier2.description = "Increase attack range even further and allows Dart Monkey to shoot Camo Bloons.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path1.tier3.description = "Converts the Dart Monkey into a Spike-o-pult, a powerful tower that hurls a large spiked ball instead of darts. Good range, but slower attack speed. Each ball can pop 18 bloons.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path1.tier4.description = "Hurls a giant unstoppable killer spiked ball that can pop lead bloons and excels at crushing ceramic bloons.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path2.tier1.description = "Can pop 1 extra bloon per shot.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path2.tier2.description = "Can pop 2 extra bloons per shot.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path2.tier3.description = "Throws 3 darts at a time instead of 1.";
         this.getUpgradeDefinitionByID("DartMonkeyUpgrades").path2.tier4.description = "Super Monkey Fan Club Ability: Converts up to 10 nearby dart monkeys into Super Monkeys for 10 seconds";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path1.tier1.description = "Generates larger piles of spikes per shot.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path1.tier2.description = "Cuts through lead like a hot spike through... lead.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path1.tier3.description = "Modified to produce heavy but viciously sharp spiked balls instead of regular spikes. Do extra damage to ceramic bloons.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path1.tier4.description = "Rigged with heavy explosives, the spiked balls are set to go off when they lose all their spikes.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path2.tier1.description = "Increases the rate of spike production.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path2.tier2.description = "By adding sprockets, dongles and widgets, the rate of spike production increases even more.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path2.tier3.description = "Super-Hard-Rending-Engine-Driven-Razors are specially engineered to really hurt MOAB-class bloons.";
         this.getUpgradeDefinitionByID("SpikeFactoryUpgrades").path2.tier4.description = "Lays down a thick carpet of spikes over the whole track.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path1.tier1.description = "Shoots tacks faster.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path1.tier2.description = "Shoots tacks even faster!";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path1.tier3.description = "Sprays out 16 tacks per volley instead of the usual 8.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path1.tier4.description = "Upgrade to a fast firing burst tower that shoots a deadly ring of flame instead of tacks.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path2.tier1.description = "Tacks fly out further than normal.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path2.tier2.description = "Tacks go much further than normal.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path2.tier3.description = "Converts tower into a blade shooter that shoots out razor sharp blades that are harder for bloons to avoid.";
         this.getUpgradeDefinitionByID("TackShooterUpgrades").path2.tier4.description = "Blade Maelstrom Ability: covers the area in an unstoppable storm of blades.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path1.tier1.description = "Glue soaks through all layers of bloons.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path1.tier2.description = "Makes the glue become corrosive, popping bloons every few seconds while glued.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path1.tier3.description = "Glue contains an extreme solvent that melts bloons. While glued, bloons will pop twice every second.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path1.tier4.description = "Pops bloons once before glueing. Contains a super strong dissolving glue that pops bloons ten times every second!";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path2.tier1.description = "Makes glue effect last much longer.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path2.tier2.description = "Instead of glueing 1 bloon at a time, splatters 6 bloons at a time.";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path2.tier3.description = "Shoots glue more than 3x as fast!";
         this.getUpgradeDefinitionByID("GlueMonkeyUpgrades").path2.tier4.description = "Glue Strike Ability: glues all bloons on the screen.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path1.tier1.description = "This enhanced Ice Tower has a larger freeze area and freezes bloons for longer.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path1.tier2.description = "The tower freezes so fast the bloons pop once before freezing.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path1.tier3.description = "Super cold aura that slows all bloons that come near the tower. In addition the regular freeze effect of this tower has much larger area.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path1.tier4.description = "Bloons are frozen so cold that they freeze other bloons that come in contact with them, spreading the freeze like a virus.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path2.tier1.description = "Makes the bloons so cold that they move slowly even after thawing out.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path2.tier2.description = "Freezes 2 layers of bloons instead of 1.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path2.tier3.description = "Creates razor sharp pieces of ice on frozen bloons, that when popped, fly out and pop more nearby bloons.";
         this.getUpgradeDefinitionByID("IceMonkeyUpgrades").path2.tier4.description = "Absolute Zero Ability: freezes the entire screen of bloons for 4 seconds. Does not affect MOAB-class bloons.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path1.tier1.description = "Gives tower longer attack range.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path1.tier2.description = "Each explosion throws out 8 sharp fragments that pop even more bloons.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path1.tier3.description = "Throws out secondary bombs instead of frags - causing widespread explosive poppage.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path1.tier4.description = "Impacts from this tower become so violent, bloons become stunned for a short time when they are hit.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path2.tier1.description = "Shoots much larger bombs than normal, they have a larger blast area and more popping power.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path2.tier2.description = "Converts the tower into a missile launcher - the missiles have higher velocity, longer range, more popping power, and faster shooting.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path2.tier3.description = "MOAB maulers are special missiles that wreak havoc on MOAB-class bloons, inflicting x10 damage.";
         this.getUpgradeDefinitionByID("BombTowerUpgrades").path2.tier4.description = "MOAB Assassin Ability: super deadly missile seeks the nearest MOAB-class bloon and destroys it instantly. Does 1000 damage to ZOMG bloons instead of destroying them.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path1.tier1.description = "Boomerangs can now pop 7 bloons each.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path1.tier2.description = "Throws glaives instead of boomerangs - they\'re sharper, faster, and more poptastic.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path1.tier3.description = "The glaives from this tower will automatically bounce from bloon to bloon as long as there is one close by.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path1.tier4.description = "Creates two permanent glaives that orbit round the tower, shredding almost anything that touches them. Glaive Lord can attack Camo Bloons.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path2.tier1.description = "Sonic boomerangs can smash through frozen bloons.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path2.tier2.description = "Red hot boomerangs can melt through lead bloons.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path2.tier3.description = "This tower replaces its arm with a super strong bionic arm. The Bionic Boomer throws boomerangs twice as fast.";
         this.getUpgradeDefinitionByID("BoomerangThrowerUpgrades").path2.tier4.description = "Turbo Charge Ability: increase attack speed to hypersonic for 10 seconds.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path1.tier1.description = "Shoots larger and more powerful magical bolts.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path1.tier2.description = "Unleash the power of lightning to zap many bloons at once.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path1.tier3.description = "Whirlwind blows bloons off the path away from the exit. Removes ice and glue from bloons however.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path1.tier4.description = "The tempest blows more bloons, faster, further and more often. Also pops bloons once before blowing. Removes ice and glue from bloons however.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path2.tier1.description = "The Apprentice adds a powerful fireball attack to its arsenal.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path2.tier2.description = "Allows the Monkey Apprentice to target and pop camo bloons. Does not grant detection to other towers.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path2.tier3.description = "Spews endless flames at nearby bloons, roasting and popping them with ease.";
         this.getUpgradeDefinitionByID("WizardMonkeyUpgrades").path2.tier4.description = "Summon Phoenix Ability: Creates a super powerful flying phoenix that flies around wreaking bloon havoc for 20 seconds.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path1.tier1.description = "Grows 6 bananas each round instead of 4.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path1.tier2.description = "Grows 13 bananas each round.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path1.tier3.description = "Generates 25 bananas every round!";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path1.tier4.description = "Produces 10 boxes of bananas every round. Each box is worth 300 cash.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path2.tier1.description = "Bananas last 20 seconds instead of the usual 10.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path2.tier2.description = "Each banana or box of bananas is worth 50% more cash.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path2.tier3.description = "Generates $675 cash each round which gets stored. Earns 10% interest each round and holds up to 5000 cash. Withdraw the cash at any time.";
         this.getUpgradeDefinitionByID("AgriculturalUpgrades").path2.tier4.description = "The investments advisory generates $1500 each round and earns 20% interest on uncollected funds. Withdraw the cash at any time, can hold up to $20,000.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path1.tier1.description = "Shoots faster.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path1.tier2.description = "Much longer range.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path1.tier3.description = "Attacks super duper fast!";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path1.tier4.description = "Rapidly launches Monkey Ace pilots that strafe the area with darts.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path2.tier1.description = "Sprays out a blast of 4 sharp grapes for additional poppage.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path2.tier2.description = "Allows the Buccaneer to detect and target camo bloons. Does not grant detection to other towers.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path2.tier3.description = "Adds a powerful, independently firing cannon to the Buccaneer.";
         this.getUpgradeDefinitionByID("BuccaneerUpgrades").path2.tier4.description = "MOAB Takedown Ability: takes hold of the nearest MOAB-class bloon with a grappling hook and brings it down. ZOMG bloons are immune to this.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path1.tier1.description = "Shoots darts more often.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path1.tier2.description = "Monkey Ace darts can pop 8 bloons each!";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path1.tier3.description = "Darts seek out and pop bloons intelligently.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path1.tier4.description = "Flying fortress of bloon doom.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path2.tier1.description = "Drops an exploding pineapple every 3 seconds.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path2.tier2.description = "Allows the Monkey Ace to hit camo bloons. Does not grant detection to other towers.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path2.tier3.description = "More darts = win.";
         this.getUpgradeDefinitionByID("AeroMonkeyUpgrades").path2.tier4.description = "Ground Zero Ability: drops a single devastating bomb that destroys all bloons on screen except MOAB-class bloons.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path1.tier1.description = "Shoots super powerful lasers instead of throwing darts. Lasers can pop frozen bloons.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path1.tier2.description = "Plasma vaporizes everything it touches.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path1.tier3.description = "It is said that bloons who doth touch the sun shall be cleansed, and then there shalt be peace.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path1.tier4.description = "The Temple demands sacrifice. Its arsenal of unstoppable bloon destruction is enhanced and modified by the types of tower sacrificed. Use at your own peril.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path2.tier1.description = "Super Monkey with super range = good!";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path2.tier2.description = "Why settle for super when you can have EPIC?";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path2.tier3.description = "Half Super Monkey, half killer robot of death. Super Monkey\'s arms become pulse cannons of annihilation, able to aim and target independently from each other.";
         this.getUpgradeDefinitionByID("SuperMonkeyUpgrades").path2.tier4.description = "Be proud of this Technological Terror you\'ve constructed. Bloon Annihilation Ability: Destroys all bloons within short radius of tower, completely, and utterly. Does 1000 damage to MOAB-class bloons.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path1.tier1.description = "Greatly reduces the spread of the gun.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path1.tier2.description = "Makes gun fire much faster.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path1.tier3.description = "Converts the gun into a super powerful laser cannon. Blasts from this cannon can pop 13 bloons each, can pop frozen bloons, and have increased attack rate.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path1.tier4.description = "The Ray of Doom is a persistent solid beam of bloon destruction.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path2.tier1.description = "Makes darts shoot with greater velocity. Darts move faster and can pop 3 bloons each.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path2.tier2.description = "Shoots specially modified darts that can hurt any bloon type.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path2.tier3.description = "Shoots vicious little missiles instead of darts. Hydra rockets have sharp tips that can pop Black Bloons.";
         this.getUpgradeDefinitionByID("DartlingGunUpgrades").path2.tier4.description = "The BADS covers a wide area with each shot. Enables the Rocket Storm Ability: Rocket Storm shoots out a missile towards the nearest 100 bloons on screen. Ouch.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path1.tier1.description = "Makes your mortar shots more accurate.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path1.tier2.description = "Heavy ordinance delivers a bigger explosion radius.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path1.tier3.description = "Bloon Buster Mortars smash through 2 layers of bloons at once!";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path1.tier4.description = "Devastatingly large explosions, and each pops through 5 layers of bloon.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path2.tier1.description = "Increase the attack speed of the Mortar.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path2.tier2.description = "A touch of Monkey napalm continues to pop layers for 6 seconds after impact.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path2.tier3.description = "Camo Bloons popped by this tower permanently lose their camo status, and can be attacked by towers without camo detection.";
         this.getUpgradeDefinitionByID("MortarTowerUpgrades").path2.tier4.description = "Shoots mortar shells 3x as fast. Pop And Awe Ability: bombards the screen for 5 seconds, popping every bloon 1 time per second, and immobilizes all bloons during that time. Does not affect MOAB-class bloons.";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path1.tier1.description = "Shots can pop through 4 layers of bloon - and can pop lead and frozen bloons.";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path1.tier2.description = "Shots can pop through 7 layers of bloon!";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path1.tier3.description = "Extreme accuracy and muzzle velocity cause up to 18 layers of bloon to be popped per shot - enough to destroy an entire ceramic bloon!";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path1.tier4.description = "Bullets from this tower temporarily take out propulsion systems of MOAB-class bloons, immobilising them for a short time.";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path2.tier1.description = "Allows Sniper to shoot faster.";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path2.tier2.description = "Allows Sniper to detect and shoot Camo bloons";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path2.tier3.description = "Allows Sniper to take multiple shots and attack 3x as fast";
         this.getUpgradeDefinitionByID("SniperMonkeyUpgrades").path2.tier4.description = "Supply Drop Ability: drops a crate full of cash.";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path1.tier1.description = "Increases attack range and attack speed.";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path1.tier2.description = "Shurikens can pop 4 bloons each";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path1.tier3.description = "Extreme Ninja skill enables him to throw 2 shurikens at once";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path1.tier4.description = "The art of Bloonjitsu allows Ninjas to throw 5 shurikens at once!";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path2.tier1.description = "Infuses bloon hatred into the weapons themselves - they will seek out and pop bloons automatically";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path2.tier2.description = "Some bloons struck by the Ninja\'s weapons will become distracted and move the wrong way temporarily.";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path2.tier3.description = "Sometimes throws a flash bomb that stuns bloons in a large radius.";
         this.getUpgradeDefinitionByID("NinjaMonkeyUpgrades").path2.tier4.description = "Sabotage Supply Lines Ability: Sabotage the bloons supply lines for 10 seconds. During the sabotage, all new bloons are crippled to half speed.";
         this.getUpgradeDefinitionByID("TownUpgrades").path1.tier1.description = "Increases attack range of all towers within Monkey Village radius by 15%.";
         this.getUpgradeDefinitionByID("TownUpgrades").path1.tier2.description = "Jungle drums inspire nearby towers to attack faster, increasing attack rate by 15%.";
         this.getUpgradeDefinitionByID("TownUpgrades").path1.tier3.description = "All Bloons popped by towers within the radius of the Monkey Town get 50% more cash per pop.";
         this.getUpgradeDefinitionByID("TownUpgrades").path1.tier4.description = "All nearby towers with \'Abilities\' have their cooldowns reduced by 20% and adds a powerful energy beam attack.";
         this.getUpgradeDefinitionByID("TownUpgrades").path2.tier1.description = "The Fort increases the popping power of all nearby towers by 1.";
         this.getUpgradeDefinitionByID("TownUpgrades").path2.tier2.description = "Radar Scanner allows all towers within its radius to be able to detect and target camo bloons.";
         this.getUpgradeDefinitionByID("TownUpgrades").path2.tier3.description = "The Bureau grants special bloon popping knowledge to all nearby towers, allowing them to pop all bloon types.";
         this.getUpgradeDefinitionByID("TownUpgrades").path2.tier4.description = "Call to Arms Ability: Doubles the attack speed and popping power of all nearby towers for 10 seconds.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path1.tier1.description = "Automatically creates sentry guns and deploys them on the ground nearby. Sentries shoot sharp steel pins at the bloons but only last a short time.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path1.tier2.description = "Fast Engineering increases the Engineer\'s build speed, producing sentry guns more often.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path1.tier3.description = "The Engineer uses special dispenser to spray down the track with a cleansing foam that removes camo and regen properties. Also pops lead bloons.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path1.tier4.description = "Creates a powerful bloon trap that destroys all bloons caught in it. Once full, trap will destroy itself after a short time. If emptied manually, gives you extra cash. Only one trap can be active at a time.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path2.tier1.description = "The Engineer\'s nailgun upgrades to shoot massive 9-inch long nails that can pop 8 bloons at once including frozen bloons";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path2.tier2.description = "The Engineer can shoot further and deploy sentries in a larger area.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path2.tier3.description = "Adding sprockets to sentries and the nailgun increase their fire rate appreciably.";
         this.getUpgradeDefinitionByID("EngineerUpgrades").path2.tier4.description = "Activated Ability: Overclock - target tower becomes super powered for 60 seconds.";
      }
   }
}

class SingletonEnforcer#182
{
    
   
   function SingletonEnforcer#182()
   {
      super();
   }
}
