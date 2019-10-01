package ninjakiwi.monkeyTown.analytics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonsPoppedReport;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.BuildingPlacer;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   
   public class StatsDataManager
   {
      
      private static var instance:StatsDataManager;
       
      
      private var _statsData:StatsData;
      
      private var _active:Boolean = false;
      
      private const LISTENER_PRIORITY:int = 99999;
      
      public function StatsDataManager(param1:SingletonEnforcer#1023)
      {
         this._statsData = StatsData.getInstance();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use StatsDataManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : StatsDataManager
      {
         if(instance == null)
         {
            instance = new StatsDataManager(new SingletonEnforcer#1023());
         }
         return instance;
      }
      
      public function activate() : void
      {
         this.activateListeners();
         this._active = true;
      }
      
      public function deactivate(... rest) : void
      {
         this.deactivateListeners();
         this._active = false;
      }
      
      public function activateListeners() : void
      {
         if(this._active)
         {
            return;
         }
         PvPSignals.attackRewards.addWithPriority(this.onCashPillaged,this.LISTENER_PRIORITY);
         PvPSignals.revengeAttackLaunched.addWithPriority(this.onRevengeAttackLaunched,this.LISTENER_PRIORITY);
         PvPSignals.defendAttackComplete.addWithPriority(this.onDefendAttackComplete,this.LISTENER_PRIORITY);
         PvPSignals.attackWon.addWithPriority(this.onPvPAttackWon,this.LISTENER_PRIORITY);
         PvPSignals.attackLost.addWithPriority(this.onPvPAttackLost,this.LISTENER_PRIORITY);
         GameSignals.TILE_CAPTURED_SIGNAL.addWithPriority(this.onTileCaptured,this.LISTENER_PRIORITY);
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.addWithPriority(this.onBTDGameComplete,this.LISTENER_PRIORITY);
         GameSignals.TREASURE_CHEST_CAPTURED.addWithPriority(this.onTreasureChestCaptured,this.LISTENER_PRIORITY);
         BuildingPlacer.buildingWasPlacedForTheFirstTimeSignal.addWithPriority(this.onBuildingWasPlaced,this.LISTENER_PRIORITY);
         PvPSignals.sendMVMAttackSucceeded.add(this.onMvMSent);
         PvPSignals.attackResult.addWithPriority(this.onPvPAttackResult,this.LISTENER_PRIORITY);
         ContestedTerritoryPanel.endContestSignal.addWithPriority(this.onContestedTerritoryEnded,this.LISTENER_PRIORITY);
         ContestedTerritoryPanel.winSignal.addWithPriority(this.onContestedTerritoryWon,this.LISTENER_PRIORITY);
      }
      
      public function deactivateListeners() : void
      {
         if(!this._active)
         {
            return;
         }
         PvPSignals.attackRewards.remove(this.onCashPillaged);
         PvPSignals.revengeAttackLaunched.remove(this.onRevengeAttackLaunched);
         PvPSignals.defendAttackComplete.remove(this.onDefendAttackComplete);
         PvPSignals.attackWon.remove(this.onPvPAttackWon);
         PvPSignals.attackLost.remove(this.onPvPAttackLost);
         GameSignals.TILE_CAPTURED_SIGNAL.remove(this.onTileCaptured);
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.remove(this.onBTDGameComplete);
         GameSignals.TREASURE_CHEST_CAPTURED.remove(this.onTreasureChestCaptured);
         BuildingPlacer.buildingWasPlacedForTheFirstTimeSignal.remove(this.onBuildingWasPlaced);
         PvPSignals.sendMVMAttackSucceeded.remove(this.onMvMSent);
         PvPSignals.attackResult.remove(this.onPvPAttackResult);
         ContestedTerritoryPanel.endContestSignal.remove(this.onContestedTerritoryEnded);
         ContestedTerritoryPanel.winSignal.remove(this.onContestedTerritoryWon);
      }
      
      private function onBuildingWasPlaced(param1:Building) : void
      {
         if(this._statsData.buildingsBuilt.hasOwnProperty(param1.definition.id) && this._statsData.buildingsBuilt[param1.definition.id] is Number)
         {
            this._statsData.buildingsBuilt[param1.definition.id]++;
         }
         else
         {
            this._statsData.buildingsBuilt[param1.definition.id] = 1;
         }
         this.save();
      }
      
      private function onCashPillaged(param1:int) : void
      {
         var cash:int = param1;
         try
         {
            if(cash > 0)
            {
               this._statsData.totalCashPillaged.value = this._statsData.totalCashPillaged.value + cash;
               this.save();
            }
            return;
         }
         catch(e:Error)
         {
            t.obj(e);
            return;
         }
      }
      
      private function onRevengeAttackLaunched() : void
      {
         this._statsData.totalMvMRevengeAttacks.value++;
         this.save();
      }
      
      private function onDefendAttackComplete(... rest) : void
      {
         var _loc3_:IncomingRaid = null;
         var _loc5_:String = null;
         var _loc2_:GameResultDefinition = rest[0];
         if(_loc2_.success)
         {
            this._statsData.totalMvMDefensiveWins.value++;
            this._statsData.globalMvMDefensiveWinChain.value++;
            _loc5_ = "totalMvMDefensiveWinsCity" + MonkeySystem.getInstance().city.cityIndex.toString();
            KeyValueStore.getInstance().set(_loc5_,this._statsData.totalMvMDefensiveWins.value);
         }
         else
         {
            this._statsData.globalMvMDefensiveWinChain.value = 0;
         }
         _loc3_ = rest[1];
         var _loc4_:Friend = FriendsManager.getInstance().findOpponentByID(_loc3_.attack.attackerID);
         if(_loc4_ == null)
         {
            this._statsData.quickMatchDefended.value++;
            if(_loc2_.success)
            {
               this._statsData.quickMatchDefensiveWinChain.value++;
               this._statsData.quickMatchDefensiveLoseChain.value = 0;
            }
            else
            {
               this._statsData.quickMatchDefensiveWinChain.value = 0;
               this._statsData.quickMatchDefensiveLoseChain.value++;
            }
         }
         this.save();
      }
      
      private function onPvPAttackWon() : void
      {
         this._statsData.globalMvMAttackWinChain.value++;
         this._statsData.totalMvMAttackWins.value++;
         this.save();
      }
      
      private function onPvPAttackLost() : void
      {
         this._statsData.globalMvMAttackWinChain.value = 0;
         this.save();
      }
      
      private function onTreasureChestCaptured(... rest) : void
      {
         this._statsData.treasureChestsCaptured.value++;
         this.save();
      }
      
      private function onTileCaptured(... rest) : void
      {
         var _loc2_:TileDefinitions = TileDefinitions.getInstance();
         var _loc3_:Tile = rest[0];
         var _loc4_:String = _loc3_.terrainDefinition.groundType;
         var _loc5_:String = _loc3_.terrainDefinition.id;
         this._statsData.tilesCaptured.value++;
         if(_loc5_ === _loc2_.RIVER || _loc5_ === _loc2_.LAKE)
         {
            this._statsData.waterTilesCaptured.value++;
         }
         else if(_loc5_ === _loc2_.MOUNTAINS || _loc5_ === _loc2_.VOLCANO)
         {
            this._statsData.highGroundTilesCaptured.value++;
         }
         if(_loc3_.terrainSpecialProperty)
         {
            if(!this._statsData.specialTerrainsCaptured.hasOwnProperty(_loc3_.terrainSpecialProperty.id))
            {
               this._statsData.specialTerrainsCaptured[_loc3_.terrainSpecialProperty.id] = true;
            }
            else
            {
               this._statsData.specialTerrainsCaptured[_loc3_.terrainSpecialProperty.id]++;
            }
         }
         this.save();
      }
      
      public function attackSent() : void
      {
         this._statsData.totalAttackSent.value++;
         this.save();
      }
      
      public function attackReceived() : void
      {
         this._statsData.totalAttackReceived.value++;
         this.save();
      }
      
      private function onBTDGameComplete(param1:GameResultDefinition, ... rest) : void
      {
         this.trackBloonsPopped(param1);
      }
      
      public function trackBloonsPopped(param1:GameResultDefinition) : void
      {
         var _loc2_:BloonsPoppedReport = param1.bloonsPopped;
         if(_loc2_ != null)
         {
            this._statsData.leadBloonsPopped.value = this._statsData.leadBloonsPopped.value + _loc2_.leadsPopped;
            this._statsData.camoBloonsPopped.value = this._statsData.camoBloonsPopped.value + _loc2_.camosPopped;
            this._statsData.ceramicBloonsPopped.value = this._statsData.ceramicBloonsPopped.value + _loc2_.ceramicsPopped;
            this._statsData.moabsDestroyed.value = this._statsData.moabsDestroyed.value + _loc2_.moabsPopped;
            this._statsData.bfbsDestroyed.value = this._statsData.bfbsDestroyed.value + _loc2_.bfbsPopped;
            this._statsData.zomgsDestroyed.value = this._statsData.zomgsDestroyed.value + _loc2_.zomgsPopped;
            this._statsData.ddtsDestroyed.value = this._statsData.ddtsDestroyed.value + _loc2_.ddtsPopped;
            this._statsData.totalBloonsPopped.value = this._statsData.totalBloonsPopped.value + _loc2_.totalBloonsPopped;
            this.save();
         }
      }
      
      private function onMvMSent(param1:PvPAttackDefinition) : void
      {
         if(param1.quickMatchID != "")
         {
            this._statsData.quickMatchLaunched.value++;
            this.save();
         }
      }
      
      private function onPvPAttackResult(param1:Boolean, param2:Object) : void
      {
         var _loc3_:PvPAttackDefinition = null;
         if(param2 != null && param2.attack != null)
         {
            _loc3_ = Squeeze.derialiseAndDecompress(param2.attack);
            if(_loc3_.quickMatchID != "")
            {
               if(param1 == true)
               {
                  this._statsData.quickMatchOffensiveWinChain.value++;
                  this._statsData.quickMatchOffensiveLoseChain.value = 0;
               }
               else
               {
                  this._statsData.quickMatchOffensiveWinChain.value = 0;
                  this._statsData.quickMatchOffensiveLoseChain.value++;
               }
               this.save();
            }
         }
      }
      
      private function onContestedTerritoryEnded() : void
      {
         this._statsData.contestedTerritoriesParticipated.value++;
         this.save();
      }
      
      private function onContestedTerritoryWon() : void
      {
         this._statsData.contestedTerritoriesWon.value++;
         this.save();
      }
      
      private function save() : void
      {
         this._statsData.save();
      }
   }
}

class SingletonEnforcer#1023
{
    
   
   function SingletonEnforcer#1023()
   {
      super();
   }
}
