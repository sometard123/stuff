package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.wattleTrees
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnDefinition;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerAvailabilityManager;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackWattleTrees extends SpecialTrack
   {
       
      
      private var _initialBoomerangCount:int = 0;
      
      private var _addedCount:int = 0;
      
      private var _backupPrice:int = 0;
      
      public function SpecialTrackWattleTrees()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc3_:Object = null;
         var _loc5_:* = null;
         super.setSpecialTrack(param1);
         param1.Difficulty(23);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.CERAMIC_ID).StrongestBloonType(Constants.CERAMIC_BLOON));
         this._backupPrice = Main.instance.towerMenuSet.getPickerByTowerID(Constants.TOWER_BOOMERANG).cost;
         param1.TerrainType(Constants.WATTLE_TREES);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         var _loc2_:Object = param1.availableTowers;
         if(_loc2_ != null)
         {
            for(_loc5_ in _loc2_)
            {
               if(_loc5_ == Constants.TOWER_BOOMERANG)
               {
                  this._initialBoomerangCount = _loc2_[_loc5_].count;
               }
               else if(_loc5_ != Constants.TOWER_ROADSPIKE && _loc5_ != Constants.TOWER_PINEAPPLE)
               {
                  _loc2_[_loc5_].allowed = false;
               }
            }
         }
         if(param1.availableUpgrades != null)
         {
            _loc3_ = param1.availableUpgrades.BoomerangThrower;
         }
         var _loc4_:Object = new Object();
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_;
         }
         else
         {
            _loc4_.path1 = 1;
            _loc4_.path2 = 1;
         }
         param1.availableUpgrades.BoomerangThrower = _loc4_;
         InGameMenu.prepareNextRoundSignal.remove(this.onPrepareNextRound);
         InGameMenu.prepareNextRoundSignal.add(this.onPrepareNextRound);
         RoundGenerator.camoModifierSet.add(this.onCamoModifierSet);
      }
      
      private function onCamoModifierSet(param1:Function) : void
      {
         param1(0);
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         RoundGenerator.camoModifierSet.remove(this.onCamoModifierSet);
         InGameMenu.prepareNextRoundSignal.remove(this.onPrepareNextRound);
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc4_:Round = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = Main.instance.game.level.roundGenerator.rounds;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.queuedBloons.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if((_loc4_.queuedBloons[_loc6_] as BloonSpawnDefinition).spawnType.type == Bloon.LEAD)
               {
                  (_loc4_.queuedBloons[_loc6_] as BloonSpawnDefinition).spawnType.camo = false;
               }
               _loc6_++;
            }
            _loc3_++;
         }
         this.addBoomerangTower();
      }
      
      private function onPrepareNextRound() : void
      {
         if(Main.instance.game.level.roundIndex % 3 == 2)
         {
            this.addBoomerangTower();
         }
      }
      
      private function addBoomerangTower() : void
      {
         TowerAvailabilityManager.instance.addFreeTower(Constants.TOWER_BOOMERANG);
      }
   }
}
