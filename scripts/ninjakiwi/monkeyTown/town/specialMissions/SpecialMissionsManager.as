package ninjakiwi.monkeyTown.town.specialMissions
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   
   public class SpecialMissionsManager
   {
      
      private static var instance:SpecialMissionsManager;
       
      
      private var _mission:SpecialMissionDefinition;
      
      public function SpecialMissionsManager(param1:SingletonEnforcer#1091)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use QuestManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : SpecialMissionsManager
      {
         if(instance == null)
         {
            instance = new SpecialMissionsManager(new SingletonEnforcer#1091());
         }
         return instance;
      }
      
      public function populateFromData(param1:Object) : void
      {
         var _loc3_:SpecialMissionDefinition = null;
         var _loc4_:Object = null;
         var _loc2_:DefinitionPopulator = new DefinitionPopulator();
         var _loc5_:int = 0;
         while(_loc5_ < SpecialMissionsData.SPECIAL_MISSIONS.length)
         {
            _loc3_ = SpecialMissionsData.SPECIAL_MISSIONS[_loc5_];
            _loc4_ = param1[_loc3_.id];
            if(_loc4_ !== null)
            {
               _loc2_.populateDefinitionFromObject(_loc3_,_loc4_);
            }
            _loc5_++;
         }
      }
      
      public function applySpecialMission(param1:BTDGameRequest, param2:Tile) : void
      {
         this._mission = this.findSpecialMission(param2);
         if(this._mission != null)
         {
            param1.SpecialMissionID(this._mission.id);
         }
      }
      
      public function setBaseReward(param1:Object) : void
      {
         if(this._mission != null)
         {
            if(this._mission.rewardCash > 0)
            {
               param1.cashEarned = this._mission.rewardCash;
            }
            if(this._mission.rewardXP > 0)
            {
               param1.xpEarned = this._mission.rewardXP;
            }
            param1.bloonstonesEarned = param1.bloonstonesEarned + Constants.BLOONSTONES_REWARD_SPECIAL_MISSIONS;
            param1.cashEarned = param1.cashEarned + Constants.CASH_REWARD_SPECIAL_MISSIONS;
         }
      }
      
      public function resetMission() : void
      {
         this._mission = null;
      }
      
      public function rewardSpecialMission() : void
      {
         this.rewardSpecialBloonstones();
         this.rewardSpecialItem();
         this.rewardSpecialAgent();
         this.rewardSpecialBloontoniums();
         this._mission = null;
      }
      
      private function rewardSpecialItem() : void
      {
         if(this._mission != null)
         {
            if(SpecialItemStore.getInstance().hasSpecialItem(this._mission.rewardSpecialItemId))
            {
               return;
            }
            if(this._mission.rewardSpecialItemId != null && this._mission.rewardSpecialItemId != "")
            {
               SpecialItemStore.getInstance().acquiredSpecialItem(this._mission.rewardSpecialItemId);
            }
         }
      }
      
      private function rewardSpecialAgent() : void
      {
         if(this._mission != null)
         {
            if(this._mission.rewardSpecialAgentId != null && this._mission.rewardSpecialAgentId != "")
            {
            }
         }
      }
      
      private function rewardSpecialBloonstones() : void
      {
         if(this._mission != null)
         {
            if(!SpecialItemStore.getInstance().hasSpecialItem(this._mission.rewardSpecialItemId))
            {
               return;
            }
            if(this._mission.rewardBloonstones > 0)
            {
               SpecialItemStore.getInstance().acquiredBloonstones(this._mission.rewardBloonstones);
            }
         }
      }
      
      private function rewardSpecialBloontoniums() : void
      {
         if(this._mission != null)
         {
            if(this._mission.rewardBloontoniums > 0)
            {
               SpecialItemStore.getInstance().acquiredBloontoniums(this._mission.rewardBloontoniums);
            }
         }
      }
      
      public function findSpecialMission(param1:Tile) : SpecialMissionDefinition
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Vector.<SpecialMissionDefinition> = SpecialMissionsData.SPECIAL_MISSIONS;
         if(param1.terrainSpecialProperty != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(param1.terrainSpecialProperty.id == _loc2_[_loc3_].id)
               {
                  return _loc2_[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function isSpecialMissionHasCamo(param1:Tile) : Boolean
      {
         var _loc2_:SpecialMissionDefinition = this.findSpecialMission(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.id == SpecialMissionsData.MOAB_GRAVEYARD.id || _loc2_.id == SpecialMissionsData.WATTLE_TREES.id)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function findSpecialMissionMoabClass(param1:Tile) : String
      {
         var _loc2_:SpecialMissionDefinition = this.findSpecialMission(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.id == SpecialMissionsData.MOAB_GRAVEYARD.id)
            {
               return Constants.BOSS_BLOON;
            }
            if(_loc2_.id == SpecialMissionsData.GLACIER.id)
            {
               return Constants.MOAB_BLOON;
            }
            if(_loc2_.id == SpecialMissionsData.SHIPWRECK.id)
            {
               return Constants.MOAB_BLOON;
            }
            if(_loc2_.id == SpecialMissionsData.CONSECRATED_GROUND.id)
            {
               return Constants.BFB_BLOON;
            }
            if(_loc2_.id == SpecialMissionsData.PHASE_CRYSTAL.id)
            {
               return Constants.BFB_BLOON;
            }
         }
         return null;
      }
   }
}

class SingletonEnforcer#1091
{
    
   
   function SingletonEnforcer#1091()
   {
      super();
   }
}
