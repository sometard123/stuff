package ninjakiwi.monkeyTown.town.upgrades
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class UpgradeTree
   {
      
      public static const MAX_TIERS:int = 4;
       
      
      private var _stateDefinitions:Object;
      
      private var upgradeWarmupManager:UpgradeWarmupManager;
      
      public function UpgradeTree()
      {
         this._stateDefinitions = {};
         super();
         this.upgradeWarmupManager = new UpgradeWarmupManager(this);
      }
      
      public function tick() : void
      {
         this.upgradeWarmupManager.tick();
      }
      
      public function initialiseWithDefaults() : void
      {
         var _loc2_:UpgradeStateDefinition = null;
         var _loc3_:UpgradeDefinition = null;
         var _loc1_:UpgradeData = UpgradeData.getInstance();
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.upgradeDefinitions.length)
         {
            _loc3_ = _loc1_.upgradeDefinitions[_loc4_];
            _loc2_ = new UpgradeStateDefinition().Id(_loc3_.id);
            this._stateDefinitions[_loc3_.id] = _loc2_;
            _loc4_++;
         }
         var _loc5_:UpgradeStateDefinition = UpgradeStateDefinition(this._stateDefinitions["TownUpgrades"]);
         _loc5_.path1.unlockedTo = 1;
         _loc5_.path2.unlockedTo = 1;
      }
      
      public function addUpgrade(param1:UpgradeDefinition) : UpgradeStateDefinition
      {
         var _loc2_:UpgradeStateDefinition = new UpgradeStateDefinition().Id(param1.id);
         this._stateDefinitions[param1.id] = _loc2_;
         return _loc2_;
      }
      
      public function getHighestTierLevelForUpgrades(param1:Array) : int
      {
         var _loc2_:String = null;
         var _loc3_:UpgradeStateDefinition = null;
         if(param1 == null)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            _loc3_ = this._stateDefinitions[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.path1.aquiredTo > _loc4_)
               {
                  _loc4_ = _loc3_.path1.aquiredTo;
               }
               if(_loc3_.path2.aquiredTo > _loc4_)
               {
                  _loc4_ = _loc3_.path2.aquiredTo;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getHighestTierLevelForUpgradesPath(param1:Array, param2:int = 1) : int
      {
         var _loc3_:String = null;
         var _loc4_:UpgradeStateDefinition = null;
         if(param1 == null)
         {
            return 0;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc3_ = param1[_loc6_];
            _loc4_ = this._stateDefinitions[_loc3_];
            if(_loc4_ != null)
            {
               if(param2 == 1)
               {
                  if(_loc4_.path1.aquiredTo > _loc5_)
                  {
                     _loc5_ = _loc4_.path1.aquiredTo;
                  }
               }
               else if(param2 == 2)
               {
                  if(_loc4_.path2.aquiredTo > _loc5_)
                  {
                     _loc5_ = _loc4_.path2.aquiredTo;
                  }
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getBuildingUpgradeIndex(param1:Array) : int
      {
         var _loc2_:String = null;
         var _loc3_:UpgradeStateDefinition = null;
         if(param1 == null)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            _loc3_ = this._stateDefinitions[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.path1.aquiredTo === MAX_TIERS && _loc3_.path2.aquiredTo === MAX_TIERS)
               {
                  return 2;
               }
               if(_loc3_.path1.aquiredTo === MAX_TIERS && _loc3_.path2.aquiredTo < MAX_TIERS || _loc3_.path1.aquiredTo < MAX_TIERS && _loc3_.path2.aquiredTo === MAX_TIERS)
               {
                  if(_loc4_ < 1)
                  {
                     _loc4_ = 1;
                  }
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getSaveData() : Object
      {
         var _loc2_:UpgradeStateDefinition = null;
         var _loc1_:Object = {};
         for each(_loc2_ in this._stateDefinitions)
         {
            if(_loc2_.path1.unlockedTo > 0 || _loc2_.path2.unlockedTo > 0)
            {
               _loc1_[_loc2_.id] = _loc2_;
            }
         }
         _loc1_.bloonResearchLabStateSave = BloonResearchLabState.getSaveDefinition();
         return _loc1_;
      }
      
      public function populateFromSaveData(param1:Object) : void
      {
         var _loc2_:UpgradeStateDefinition = null;
         var _loc3_:* = null;
         this.clear();
         BloonResearchLabState.populateFromSaveDefinition(param1.bloonResearchLabStateSave);
         delete param1.bloonResearchLabStateSave;
         delete param1.bloonResearchLabTier;
         for(_loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            this._stateDefinitions[_loc2_.id] = _loc2_;
            if(_loc2_.path1.isWarmingUp)
            {
               this.upgradeWarmupManager.registerPath(_loc2_.path1);
            }
            if(_loc2_.path2.isWarmingUp)
            {
               this.upgradeWarmupManager.registerPath(_loc2_.path2);
            }
         }
      }
      
      public function getUpgradeStateDefinition(param1:String) : UpgradeStateDefinition
      {
         if(this._stateDefinitions[param1] == undefined || this._stateDefinitions[param1] == null)
         {
            return null;
         }
         return this._stateDefinitions[param1];
      }
      
      public function getDescription() : Object
      {
         var _loc2_:UpgradeStateDefinition = null;
         var _loc4_:* = null;
         var _loc1_:Object = {};
         var _loc3_:Object = {};
         for(_loc4_ in this._stateDefinitions)
         {
            _loc2_ = this.getUpgradeStateDefinition(_loc4_);
            _loc3_ = _loc2_.getDescription();
            if(_loc3_.path1 > 0 || _loc3_.path2 > 0)
            {
               _loc1_[_loc4_] = _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function getDescriptionForBTDModule() : Object
      {
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc1_:Object = this.getDescription();
         var _loc2_:Object = {};
         for(_loc4_ in _loc1_)
         {
            _loc3_ = Constants.TOWERS_BY_UPGRADES_ID[_loc4_];
            _loc2_[_loc3_] = _loc1_[_loc4_];
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         this.initialiseWithDefaults();
         this.upgradeWarmupManager.clear();
         BloonResearchLabState.reset();
      }
      
      public function logData(param1:Boolean = true) : void
      {
         ErrorReporter.deep(this.getDescription(),param1);
      }
   }
}
