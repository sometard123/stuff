package ninjakiwi.monkeyTown.analytics
{
   import flash.display.Stage;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.BuildingPlacer;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.ui.clock.BuildClock;
   import ninjakiwi.monkeyTown.town.ui.clock.Clock;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPPanel;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class Tracking
   {
      
      public static const LEAVE_IDLE:String = "entered_active";
      
      public static const ENTERED_IDLE:String = "entered_idle";
      
      public static const BTD_RETRY:String = "btd_retry";
      
      public static const BUILDING_COMPLETED:String = "building_completed";
      
      public static const TILE_CAPTURED:String = "tile_captured";
      
      public static const BTD_GAME_WIN:String = "btd_game_won";
      
      public static const BTD_GAME_LOST:String = "btd_game_lost";
      
      public static const BTD_GAME_WIN_2:String = "btd_game_won_2";
      
      public static const BTD_GAME_LOST_2:String = "btd_game_lost_2";
      
      public static const BTD_GAME_STARTED:String = "btd_started";
      
      public static const BTD_GAME_REPORT:String = "btd_game_report";
      
      public static const BTD_GAME_INFO_CASH:String = "btd_game_info_cash";
      
      public static const BTD_GAME_INFO_TOWER:String = "btd_game_info_tower";
      
      public static const BTD_GAME_INFO_BLOON:String = "btd_game_info_bloons";
      
      public static const MVM_WON:String = "won_mvm";
      
      public static const MVM_LOST:String = "lost_mvm";
      
      public static const MVM_EXPIRED_BY_DEFENDER:String = "mvm_expired_by_defender";
      
      public static const MVM_EXPIRED_BY_ATTACKER:String = "mvm_expired_by_attacker";
      
      public static const MVM_LAUNCHED:String = "launch_pvp";
      
      public static const SPEED_UP_UPGRADE:String = "speed_up_upgrade";
      
      public static const PURCHASED_PREMIUM_ITEM:String = "purchased_premium_item";
      
      public static const PURCHASED_PREMIUM_ITEM_KONG:String = "kong_purchased_premium_item";
      
      public static const PURCHASED_PREMIUM_BUILDING:String = "purchased_premium_building";
      
      public static const STORE_OPENED:String = "store_opened";
      
      public static const STORE_KONG_OPENED:String = "kong_store_opened";
      
      public static const BUILDING_UPGRADED:String = "building_upgraded";
      
      public static const BUILDING_PLACED:String = "building_placed";
      
      public static const SPEED_UP_BLOON_RESEARCH:String = "speed_up_bloon_research";
      
      public static const SPEED_UP_BUILDING:String = "speed_up_building";
      
      public static const FILL_BANK:String = "fill_bank";
      
      public static const FILL_BLOONTONIUM:String = "fill_bloontonium";
      
      public static const PLAYER_USED_BONUS_STARTING_CASH:String = "player_used_bonus_starting_cash";
      
      public static const OVERCLOCKED_MVM_WITH_BLOONSTONES:String = "overclocked_mvm_with_bloonstones";
      
      public static const BDT_GAME_DURATION:String = "btd_game_duration";
      
      public static const UPGRADE_COMPLETE:String = "upgrade_complete";
      
      public static const QUEST_COMPLETE:String = "quest_complete";
      
      public static const CONTESTED_TERRITORY_CLICKED:String = "contested_territory_clicked";
      
      public static const CONTESTED_TERRITORY_END_GAME:String = "contested_territory_end";
      
      public static const CONTESTED_TERRITORY_COLLECT_CASH:String = "contested_territory_collect_cash";
      
      public static const CONTESTED_TERRITORY_COLLECT_BLOONSTONES:String = "contested_territory_collect_bloonstones";
      
      public static const CONTESTED_TERRITORY_JOINED:String = "contested_territory_joined";
      
      public static const ERROR_LOG:String = "error_log";
      
      private static var _idleTracker:IdleTracker;
      
      private static var _stage:Stage = null;
      
      private static const LISTENER_PRIORITY:int = 99998;
       
      
      public function Tracking()
      {
         super();
      }
      
      public static function init(param1:Stage) : void
      {
         _stage = param1;
         _idleTracker = new IdleTracker(_stage);
         IdleTracker.enterIdleSignal.add(onEnterIdleHandler);
         IdleTracker.enterActiveSignal.add(onLeaveIdleHandler);
         GameSignals.TILE_CAPTURED_SIGNAL.addWithPriority(onTileCaptured,LISTENER_PRIORITY);
         Building.buildingWasCompletedSignal.addWithPriority(onBuildingWasCompleted,LISTENER_PRIORITY);
         GameSignals.BTD_GAME_LAUNCHED_SIGNAL.addWithPriority(onBTDGameLaunched,LISTENER_PRIORITY);
         GameSignals.PVP_WON_SIGNAL.addWithPriority(onPVPAttackWon,LISTENER_PRIORITY);
         GameSignals.PVP_LOST_SIGNAL.addWithPriority(onPVPAttackLost,LISTENER_PRIORITY);
         PvPSignals.attackExpired.addWithPriority(onPVPAttackExpired,LISTENER_PRIORITY);
         PvPSignals.pvpExpiredByAttacker.addWithPriority(onPVPExpiredByAttacker,LISTENER_PRIORITY);
         PvPSignals.sendPVPAttack.addWithPriority(onPVPAttackSent,LISTENER_PRIORITY);
         UpgradeSignals.purchasedSkipPathWarmup.addWithPriority(onPurchasedSkipPathWarmupSignal,LISTENER_PRIORITY);
         GameSignals.BTD_RETRY.addWithPriority(onBTDRetry,LISTENER_PRIORITY);
         Premium.premiumItemPurchasedSignal.addWithPriority(onPurchasedPremiumItem,LISTENER_PRIORITY);
         Premium.premiumItemPurchasedKongSignal.addWithPriority(onPurchasedPremiumItemKong,LISTENER_PRIORITY);
         Premium.openedStoreSignal.addWithPriority(onStoreOpened,LISTENER_PRIORITY);
         Premium.openedStoreKongSignal.addWithPriority(onStoreKongOpened,LISTENER_PRIORITY);
         PremiumBuildingManager.premiumBuildingPurchasedSignal.addWithPriority(onPurchasedPremiumBuilding,LISTENER_PRIORITY);
         GameSignals.BUILDING_UPGRADE_COMPLETE.addWithPriority(onBuildingUpgradeComplete,LISTENER_PRIORITY);
         BuildingPlacer.buildingWasPlacedForTheFirstTimeSignal.addOnceWithPriority(onBuildingWasPlaced,LISTENER_PRIORITY);
         UpgradeSignals.purchasedBloonResearchLabSkipWarmup.addOnceWithPriority(onPurchasedBloonResearchLabSkipWarmup,LISTENER_PRIORITY);
         BuildClock.buildClockSkippedSignal.addOnceWithPriority(onBuildClockSkipped,LISTENER_PRIORITY);
         GameSignals.BOUGHT_CASH_WITH_BLOONSTONES.addWithPriority(onFillBanks,LISTENER_PRIORITY);
         GameSignals.BOUGHT_BLOONTONIUM_WITH_BLOONSTONES.addWithPriority(onFillBloontonium,LISTENER_PRIORITY);
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.addWithPriority(onBTDGameComplete,LISTENER_PRIORITY);
         GameSignals.PLAYER_USED_BONUS_STARTING_CASH.addWithPriority(onPlayerUsedBonusStartingCash,LISTENER_PRIORITY);
         GameSignals.MVM_OVERCLOCKED_WITH_BLOONSTONES.addWithPriority(onMVMOverclockedWithBloonstones,LISTENER_PRIORITY);
         UpgradeSignals.pathWarmupComplete.add(onUpgradeComplete);
         Quest.QUEST_FINISHED_SIGNAL.add(onQuestComplete);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(onTownLevelChangedSignal);
         ContestedTerritoryPanel.panelRevealedSignal.add(onContestedTerritoryClickedButton);
         ContestedTerritoryPanel.gameEndedSignal.add(onContestedTerritoryEndGame);
         ContestedTerritoryPanel.collectCashSignal.add(onContestedTerritoryCollectCash);
         ContestedTerritoryPanel.collectBloonstonesSignal.add(onContestedTerritoryCollectBloonstones);
         ContestedTerritoryPanel.joinedSignal.add(onContestedTerritoryJoined);
         ErrorMessageTracking.errorTrackingSignal.add(onErrorLog);
      }
      
      private static function kongTrack(param1:String, param2:int) : void
      {
         if(Kong.isOnKong())
         {
            Kong.submitStat(param1,param2);
         }
      }
      
      private static function onTownLevelChangedSignal(... rest) : void
      {
         var _loc2_:String = MonkeySystem.getInstance().city.cityIndex == 0?"city1_level":"city2_level";
         kongTrack(_loc2_,ResourceStore.getInstance().townLevel);
      }
      
      private static function onQuestComplete(param1:Quest) : void
      {
         AnalyticsUtil.track(QUEST_COMPLETE,JSON.stringify({
            "questID":param1.id,
            "userID":MonkeySystem.getInstance().nkGatewayUser.loginInfo.id
         }));
      }
      
      private static function onUpgradeComplete(param1:UpgradePathStateDefinition) : void
      {
         AnalyticsUtil.track(UPGRADE_COMPLETE,param1.upgradeID);
      }
      
      private static function onMVMOverclockedWithBloonstones(param1:int, param2:PvPAttackDefinition) : void
      {
         AnalyticsUtil.track(OVERCLOCKED_MVM_WITH_BLOONSTONES,JSON.stringify({
            "bloonstones":param1,
            "moreCamos":param2.moreCamos,
            "moreLeads":param2.moreLeads,
            "moreRegens":param2.moreRegens,
            "moreMoabs":param2.moreMoabs
         }));
      }
      
      private static function onPlayerUsedBonusStartingCash(param1:int) : void
      {
         AnalyticsUtil.track(PLAYER_USED_BONUS_STARTING_CASH,param1.toString());
      }
      
      private static function onBTDGameComplete(param1:GameResultDefinition, param2:TileAttackDefinition, param3:BTDGameRequest) : void
      {
         var _loc4_:Object = null;
         var _loc5_:* = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = param3 !== null && param3.bossAttack !== null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = param3 && param3.isReplayMode;
         if(param3 !== null)
         {
            _loc5_ = param3.pvpAttackDefinition !== null;
            _loc6_ = param3.isBloonBeacon;
            _loc8_ = param3.isContestedTerritory;
         }
         if(param1.success)
         {
            _loc4_ = {
               "livesLost":param1.livesLost,
               "roundReached":param1.roundReached,
               "cancelledGame":param1.cancelledGame,
               "difficulty":(param2 != null?param2.difficultyLevel:0),
               "pips":param1.difficultyRankRelativeToMTL,
               "track":param1.trackPlayed,
               "townLevel":ResourceStore.getInstance().townLevel,
               "gameDuration":param1.durationOfGame / 1000,
               "roundsNeededToWin":param1.roundsNeededToWin,
               "wasMvM":_loc5_,
               "hardcore":param1.wasHardcore,
               "contested":param1.wasContestedTerritory,
               "wasMyMaps":_loc9_
            };
            if(_loc6_)
            {
               _loc4_.wasMvM = "bloon_beacon";
            }
            AnalyticsUtil.track(BTD_GAME_REPORT,JSON.stringify(param1.advancedTracking));
            if(false == _loc8_ && false == _loc7_)
            {
               AnalyticsUtil.track(BTD_GAME_WIN,JSON.stringify(_loc4_));
               if(_loc5_)
               {
                  kongTrack("mvm_defense_won",1);
               }
            }
         }
         else
         {
            _loc4_ = {
               "livesLost":param1.livesLost,
               "roundReached":param1.roundReached,
               "cancelledGame":param1.cancelledGame,
               "pips":param1.difficultyRankRelativeToMTL,
               "difficulty":(param2 != null?param2.difficultyLevel:0),
               "track":param1.trackPlayed,
               "townLevel":ResourceStore.getInstance().townLevel,
               "gameDuration":param1.durationOfGame / 1000,
               "roundsNeededToWin":param1.roundsNeededToWin,
               "wasMvM":_loc5_,
               "hardcore":param1.wasHardcore,
               "contested":param1.wasContestedTerritory,
               "wasMyMaps":_loc9_
            };
            if(_loc6_)
            {
               _loc4_.wasMvM = "bloon_beacon";
            }
            AnalyticsUtil.track(BTD_GAME_REPORT,JSON.stringify(param1.advancedTracking));
            if(false == _loc8_ && false == _loc7_)
            {
               AnalyticsUtil.track(BTD_GAME_LOST,JSON.stringify(_loc4_));
            }
         }
      }
      
      private static function onBTDRetry(param1:int, param2:int, param3:int, param4:String) : void
      {
         AnalyticsUtil.track(BTD_RETRY,param1.toString(),param2,param4);
      }
      
      private static function onEnterIdleHandler(param1:Number) : void
      {
         var _loc2_:int = param1 / 1000 / 60;
         AnalyticsUtil.track(ENTERED_IDLE,_loc2_.toString());
      }
      
      private static function onLeaveIdleHandler(param1:Number) : void
      {
         var _loc2_:int = param1 / 1000 / 60;
         AnalyticsUtil.track(LEAVE_IDLE,_loc2_.toString());
      }
      
      private static function onTileCaptured(... rest) : void
      {
         var arguments:Array = rest;
         setTimeout(function delayedCallTileCapturedTrack():void
         {
            AnalyticsUtil.track(TILE_CAPTURED);
         },5000 + Math.random() * 5000);
         if(MonkeySystem.getInstance().city.cityIndex === 0)
         {
            kongTrack("city1_territory_captured",1);
         }
         else
         {
            kongTrack("city2_territory_captured",1);
         }
      }
      
      private static function onBuildingWasCompleted(param1:Building) : void
      {
      }
      
      private static function onBTDGameLaunched(param1:Object) : void
      {
         AnalyticsUtil.track(BTD_GAME_STARTED,param1.track,param1.difficulty,param1.cityLevel,param1.bonusStartingCash);
      }
      
      private static function onPVPAttackExpired(param1:Object) : void
      {
         AnalyticsUtil.track(MVM_EXPIRED_BY_DEFENDER,param1.attackID,param1.wasRevenge,param1.attackerID,param1.defenderID);
      }
      
      private static function onPVPExpiredByAttacker(param1:Object) : void
      {
         AnalyticsUtil.track(MVM_EXPIRED_BY_ATTACKER,param1.attackID,param1.wasRevenge,param1.attackerID,param1.defenderID);
      }
      
      private static function onPVPAttackSent(param1:PvPAttackDefinition, ... rest) : void
      {
         var _loc3_:Boolean = false;
         if(PvPPanel.lastQuickmatchOpponentID !== null && PvPPanel.lastQuickmatchOpponentID === param1.defenderID)
         {
            _loc3_ = true;
         }
         PvPPanel.lastQuickmatchOpponentID = null;
         AnalyticsUtil.track(MVM_LAUNCHED,ResourceStore.getInstance().townLevel.toString(),param1.defenderCityLevel,param1.isRevenge.toString(),_loc3_.toString());
      }
      
      private static function onPVPAttackWon(param1:Object) : void
      {
         AnalyticsUtil.track(MVM_WON,param1.attackID,param1.xpEarned,param1.investedBloontonium,param1.defenderCityLevel);
         kongTrack("mvm_attack_won",1);
      }
      
      private static function onPVPAttackLost(param1:Object) : void
      {
         AnalyticsUtil.track(MVM_LOST,JSON.stringify(param1));
      }
      
      private static function onPurchasedSkipPathWarmupSignal(param1:UpgradePathStateDefinition, param2:int, param3:int, param4:int) : void
      {
         AnalyticsUtil.track(SPEED_UP_UPGRADE,param1.upgradeID,param2,param3.toString(),param4.toString());
      }
      
      private static function onPurchasedPremiumItem(param1:int, param2:int, param3:String) : void
      {
         AnalyticsUtil.track(PURCHASED_PREMIUM_ITEM,param1.toString(),param2,param3);
      }
      
      private static function onPurchasedPremiumItemKong(param1:int, param2:int, param3:String) : void
      {
         AnalyticsUtil.track(PURCHASED_PREMIUM_ITEM_KONG,param1.toString(),param2,param3);
      }
      
      private static function onPurchasedPremiumBuilding(param1:int, param2:int, param3:String) : void
      {
         AnalyticsUtil.track(PURCHASED_PREMIUM_BUILDING,param1.toString(),param2,param3);
      }
      
      private static function onStoreOpened() : void
      {
         AnalyticsUtil.track(STORE_OPENED);
      }
      
      private static function onStoreKongOpened() : void
      {
         AnalyticsUtil.track(STORE_KONG_OPENED);
      }
      
      private static function onBuildingUpgradeComplete(param1:UpgradeableBuilding) : void
      {
         AnalyticsUtil.track(BUILDING_UPGRADED,getBuildingUpgradeTrackingName(param1),param1.tier,param1.definition.id,param1.getXPAwardedForTier(param1.tier).toString());
      }
      
      private static function getBuildingUpgradeTrackingName(param1:UpgradeableBuilding) : String
      {
         if(param1.upgradeDefinition !== null)
         {
            return param1.upgradeDefinition.id;
         }
         return param1.definition.id + param1.tier;
      }
      
      private static function onBuildingWasPlaced(param1:Building) : void
      {
         AnalyticsUtil.track(BUILDING_PLACED,param1.definition.id,param1.definition.xpGivenForBuilding);
      }
      
      private static function onPurchasedBloonResearchLabSkipWarmup(param1:BloonResearchLabUpgrade, param2:int) : void
      {
         AnalyticsUtil.track(SPEED_UP_BLOON_RESEARCH,param1.id,param2,param1.tier.toString(),param1.xpGiven.toString());
      }
      
      private static function onBuildClockSkipped(param1:Clock) : void
      {
         AnalyticsUtil.track(SPEED_UP_BUILDING,param1.target.definition.name,param1.getBloonstonesRequiredToSkip(),param1.positionOnMap.toString());
      }
      
      private static function onFillBanks(param1:Number, param2:int, param3:int) : void
      {
         AnalyticsUtil.track(FILL_BANK,param1.toString(),param2,param3.toString());
      }
      
      private static function onFillBloontonium(param1:Number, param2:int, param3:int) : void
      {
         AnalyticsUtil.track(FILL_BLOONTONIUM,param1.toString(),param2,param3.toString());
      }
      
      private static function onContestedTerritoryClickedButton(param1:int) : void
      {
         AnalyticsUtil.track(CONTESTED_TERRITORY_CLICKED,param1.toString());
      }
      
      private static function onContestedTerritoryEndGame(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:String, param7:int, param8:int, param9:String) : void
      {
         var _loc10_:Object = null;
         _loc10_ = {
            "cityLevel":param1,
            "roundsCompleted":param2,
            "roundsCompletedSaved":param3,
            "hadLivesLeft":param4,
            "beatLeadScore":param5,
            "roomID":param6,
            "tier":param7,
            "requiredRoundToBeat":param8,
            "trackPlayed":param9
         };
         var _loc11_:String = JSON.stringify(_loc10_);
         AnalyticsUtil.track(CONTESTED_TERRITORY_END_GAME,_loc11_);
      }
      
      private static function onContestedTerritoryCollectCash(param1:int, param2:int, param3:String) : void
      {
         AnalyticsUtil.track(CONTESTED_TERRITORY_COLLECT_CASH,param1.toString(),param2,param3);
      }
      
      private static function onContestedTerritoryCollectBloonstones(param1:int, param2:String) : void
      {
         AnalyticsUtil.track(CONTESTED_TERRITORY_COLLECT_BLOONSTONES,param2.toString(),param1);
      }
      
      private static function onContestedTerritoryJoined() : void
      {
         AnalyticsUtil.track(CONTESTED_TERRITORY_JOINED);
      }
      
      private static function onErrorLog(param1:int, param2:String, param3:String) : void
      {
         AnalyticsUtil.track(ERROR_LOG,param2,param1,param3);
      }
   }
}
