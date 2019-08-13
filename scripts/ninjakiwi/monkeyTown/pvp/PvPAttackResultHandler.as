package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.PvPWinAttackInfoPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.pvp.MvMAttackFailedPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class PvPAttackResultHandler
   {
       
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var processedCompletedAttacks:Object;
      
      public function PvPAttackResultHandler()
      {
         this.processedCompletedAttacks = {};
         super();
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc4_:Array = param1.completedAttacks;
         var _loc5_:Array = param1.expiredAttacks;
         if(_loc4_.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc7_];
               _loc8_ = _loc6_.sender.userID == Kloud.userID?_loc6_.sender:_loc6_.target;
               _loc9_ = _loc6_.target.userID == Kloud.userID?_loc6_.sender:_loc6_.target;
               _loc10_ = false;
               if((false == _loc8_.hasOwnProperty("resolutionSeen") || _loc8_.resolutionSeen == -1) && (_loc9_.hasOwnProperty("resolutionSeen") && _loc9_.resolutionSeen != -1))
               {
                  _loc10_ = true;
               }
               if(false != _loc10_)
               {
                  _loc11_ = _loc6_.target.userID == Kloud.userID;
                  _loc12_ = !_loc11_;
                  if(_loc12_ && _loc6_.resolution == "win" || _loc11_ && _loc6_.resolution == "loss" || _loc12_ && _loc6_.resolution == "expire")
                  {
                     this.processWonOutgoingAttack(_loc6_);
                  }
                  else
                  {
                     this.processLostOutgoingAttack(_loc6_);
                  }
               }
               _loc7_++;
            }
         }
         if(_loc5_.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc6_ = _loc5_[_loc7_];
               if(_loc6_.target.userID == Kloud.userID)
               {
                  this.processExpiredAttack(_loc6_);
               }
               _loc7_++;
            }
         }
      }
      
      private function processWonOutgoingAttack(param1:Object) : void
      {
         var cashReward:INumber = null;
         var modifiedCashReward:INumber = null;
         var attackData:Object = param1;
         PvPTimerManager.getInstance().deleteTimer(attackData.attackID);
         if(this.processedCompletedAttacks.hasOwnProperty(attackData.attackID))
         {
            return;
         }
         this.processedCompletedAttacks[attackData.attackID] = 1;
         cashReward = DancingShadows.getOne();
         cashReward.value = !!attackData.hasOwnProperty("cashPillage")?Number(attackData.cashPillage):Number(0);
         var warmongerCashReward:INumber = DancingShadows.getOne();
         warmongerCashReward.value = 0;
         if(attackData.info != null && attackData.info.attackerCashReward != null)
         {
            cashReward.value = int(attackData.info.attackerCashReward);
            warmongerCashReward.value = GameEventManager.getInstance().warmonger.getBonusPillageAmount(cashReward.value);
         }
         modifiedCashReward = DancingShadows.getOne();
         modifiedCashReward.value = cashReward.value;
         modifiedCashReward.value = modifiedCashReward.value + warmongerCashReward.value;
         var onResolutionFunction:Function = function(param1:int):void
         {
            var _loc2_:int = ResourceStore.getInstance().honour + param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            ResourceStore.getInstance().setHonour(_loc2_,false,false,true);
            ResourceStore.getInstance().setMonkeyMoney(ResourceStore.getInstance().monkeyMoney + modifiedCashReward.value,true,false);
            var _loc3_:INumber = DancingShadows.getOne();
            _loc3_.value = int(QuestCounter.getInstance().getCustomValue(QuestCounter.KEY_MVM_PILLAGED_CASH));
            QuestCounter.getInstance().setCustomValue(QuestCounter.KEY_MVM_PILLAGED_CASH,_loc3_.value + modifiedCashReward.value);
            PvPSignals.attackRewards.dispatch(modifiedCashReward.value);
            var _loc4_:PvPWinAttackInfoPanel = new PvPWinAttackInfoPanel(TownUI.getInstance().popupLayer);
            TownUI.getInstance().informationBar.addRewardDisplay(_loc4_.hideStartSignal,0,0,modifiedCashReward.value,0,0,0,param1);
            _loc4_.syncToData(attackData);
            PanelManager.getInstance().showPanel(_loc4_,PanelManager.getInstance().DEFAULT_QUEUE_ID,2);
            DancingShadows.returnOne(_loc3_);
            DancingShadows.returnOne(cashReward);
            DancingShadows.returnOne(modifiedCashReward);
            PvPSignals.attackResult.dispatch(true,attackData);
            PvPSignals.attackWon.dispatch();
         };
         var expired:Boolean = attackData.resolution == "expire";
         this.closeAttack(attackData,expired,modifiedCashReward.value,onResolutionFunction);
      }
      
      private function processLostOutgoingAttack(param1:Object) : void
      {
         var attackData:Object = param1;
         PvPTimerManager.getInstance().deleteTimer(attackData.attackID);
         if(this.processedCompletedAttacks.hasOwnProperty(attackData.attackID))
         {
            return;
         }
         this.processedCompletedAttacks[attackData.attackID] = 1;
         var onResolutionFunction:Function = function(param1:int):void
         {
            var _loc2_:int = ResourceStore.getInstance().honour + param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            ResourceStore.getInstance().setHonour(_loc2_,false,false,true);
            var _loc3_:MvMAttackFailedPanel = new MvMAttackFailedPanel(TownUI.getInstance().popupLayer);
            _loc3_.syncToData(attackData);
            PanelManager.getInstance().showPanel(_loc3_,PanelManager.getInstance().DEFAULT_QUEUE_ID,2);
            TownUI.getInstance().informationBar.addRewardDisplay(_loc3_.hideStartSignal,0,0,0,0,0,0,param1);
            PvPSignals.attackResult.dispatch(false,attackData);
            PvPSignals.attackLost.dispatch();
         };
         var expired:Boolean = attackData.resolution == "expire";
         this.closeAttack(attackData,expired,0,onResolutionFunction);
      }
      
      private function processExpiredAttack(param1:Object) : void
      {
         var _loc2_:IncomingRaid = new IncomingRaid();
         _loc2_.syncData(param1,true);
      }
      
      private function closeAttack(param1:Object, param2:Boolean, param3:int, param4:Function) : void
      {
         var thisPlayer:Object = null;
         var attack:Object = param1;
         var expired:Boolean = param2;
         var cashPillage:int = param3;
         var callback:Function = param4;
         var resultObject:Object = {
            "attackID":attack.attackID,
            "attackSucceeded":false,
            "attackerCash":cashPillage,
            "attackerBloontonium":0,
            "wasHardcore":false
         };
         var infoObject:Object = {
            "trackName":"null",
            "rounds":0,
            "totalRounds":0,
            "bloonStrength":(attack == null?Constants.RED_BLOON:attack.strongestBloonType),
            "attackerCashReward":cashPillage,
            "attackerBloontoniumReward":0
         };
         thisPlayer = attack.sender.userID == Kloud.userID?attack.sender:attack.target;
         thisPlayer.resolutionSeen = MonkeySystem.getInstance().getSecureTime();
         PvPClient.closeAttack(MonkeySystem.getInstance().city.cityIndex,attack.attackID,function(param1:Object):void
         {
            callback(thisPlayer.honourChange);
         });
      }
   }
}
