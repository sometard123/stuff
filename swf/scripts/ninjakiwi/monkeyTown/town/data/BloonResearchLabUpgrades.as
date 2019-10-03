package ninjakiwi.monkeyTown.town.data
{
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   
   public class BloonResearchLabUpgrades
   {
      
      public static const FAST_BLOONS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("FastBloons").IconClassName("BloonResearchFastBloonsIcon");
      
      public static const THERMAL_BLOONS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("ThermalBloons").IconClassName("BloonResearchThermalIcon");
      
      public static const MULTILAYER_TECH:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("MultilayerTech").IconClassName("BloonResearchMultilayerTechIcon");
      
      public static const RUBBER_REPAIR:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("RubberRepair").IconClassName("BloonResearchRubberRepairIcon");
      
      public static const CAMO_MOD_TECH:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("CamoModTech").IconClassName("BloonResearchCamoModIcon");
      
      public static const HEAVY_BLOON_ARMOUR:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("HeavyBloonArmour").IconClassName("BloonResearchHeavyBloonArmourIcon");
      
      public static const CERAMIC_BLOON_CONSTRUCTION:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("CeramicBloonConstruction").IconClassName("BloonResearchCeramicIcon");
      
      public static const MOABS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("MOAB").IconClassName("BloonResearchMOABIcon");
      
      public static const BFBS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("BFB").IconClassName("BloonResearchBFBIcon");
      
      public static const ZOMGS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("ZOMG").IconClassName("BloonResearchZOMGIcon");
      
      public static const DDTS:BloonResearchLabUpgrade = new BloonResearchLabUpgrade().Id("DDT").IconClassName("BloonResearchDDTIcon");
      
      public static const UPGRADES:Array = [FAST_BLOONS,THERMAL_BLOONS,HEAVY_BLOON_ARMOUR,RUBBER_REPAIR,CAMO_MOD_TECH,MULTILAYER_TECH,CERAMIC_BLOON_CONSTRUCTION,MOABS,BFBS,ZOMGS,DDTS];
      
      public static var UPGRADES_BY_ID:Object = {};
      
      {
         setupUpgradesByID();
         setupRequiresUpgrade();
      }
      
      public function BloonResearchLabUpgrades()
      {
         super();
      }
      
      private static function setupUpgradesByID() : void
      {
         var _loc1_:BloonResearchLabUpgrade = null;
         UPGRADES_BY_ID = {};
         var _loc2_:int = 0;
         while(_loc2_ < UPGRADES.length)
         {
            _loc1_ = UPGRADES[_loc2_];
            UPGRADES_BY_ID[_loc1_.id] = _loc1_;
            _loc2_++;
         }
      }
      
      private static function setupRequiresUpgrade() : void
      {
         var _loc1_:BloonResearchLabUpgrade = null;
         var _loc2_:BloonResearchLabUpgrade = null;
         var _loc3_:int = 1;
         while(_loc3_ < UPGRADES.length)
         {
            _loc1_ = UPGRADES[_loc3_];
            _loc2_ = UPGRADES[_loc3_ - 1];
            _loc1_.requiresUpgrade = _loc2_.id;
            _loc3_++;
         }
      }
      
      public static function processData(param1:Object) : void
      {
         var _loc3_:BloonResearchLabUpgrade = null;
         var _loc2_:DefinitionPopulator = new DefinitionPopulator();
         var _loc4_:int = 0;
         while(_loc4_ < param1.id.length)
         {
            _loc3_ = getUpgradeByID(param1.id[_loc4_]);
            _loc2_.populateDefinitionFromTableObject(_loc3_,param1,_loc4_);
            _loc3_.tier = _loc4_ + 1;
            _loc4_++;
         }
      }
      
      public static function getUpgradeByID(param1:String) : BloonResearchLabUpgrade
      {
         return UPGRADES_BY_ID[param1] || null;
      }
      
      public static function getUpgradeByTier(param1:int) : BloonResearchLabUpgrade
      {
         param1--;
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > UPGRADES.length - 1)
         {
            param1 = UPGRADES.length - 1;
         }
         return UPGRADES[param1];
      }
   }
}
