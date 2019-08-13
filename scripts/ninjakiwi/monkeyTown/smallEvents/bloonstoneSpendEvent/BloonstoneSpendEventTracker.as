package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.premiums.SecureBloonstones;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BloonstoneSpendEventTracker extends GameEventSubManager
   {
      
      private static const REWARD_BOUNDS:int = 55;
      
      private static const TYPE_ID:String = "bloonstoneSpend";
       
      
      private var _bloonstoneSpendRewardPanel:BloonstoneSpendRewardPanel;
      
      private var _bloonstonesSpent:INumber;
      
      private var _rewardedForAmount:INumber;
      
      private var _milestoneDefs:Vector.<BloonstoneSpendMilestoneDef>;
      
      private var _milestonesRewarded:Vector.<BloonstoneSpendMilestone>;
      
      private var _milestonesToReward:Vector.<BloonstoneSpendMilestone>;
      
      private var _activeMilestones:Vector.<BloonstoneSpendMilestone>;
      
      private var _milestoneIDGeneratedUpTo:int = 0;
      
      private var _activeEventID:String = "";
      
      public function BloonstoneSpendEventTracker()
      {
         this._bloonstonesSpent = DancingShadows.getOne();
         this._rewardedForAmount = DancingShadows.getOne();
         this._milestoneDefs = new Vector.<BloonstoneSpendMilestoneDef>();
         this._milestonesRewarded = new Vector.<BloonstoneSpendMilestone>();
         this._milestonesToReward = new Vector.<BloonstoneSpendMilestone>();
         this._activeMilestones = new Vector.<BloonstoneSpendMilestone>();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
         MonkeyCityMain.globalResetSignal.add(this.reset);
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         this.reset();
         this._bloonstoneSpendRewardPanel = MonkeyCityMain.getInstance().ui.gameEventsUIManager.bloonstoneSpendRewardPanel;
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         this._activeEventID = _loc2_.uid;
         SkuSettingsLoader.getGameEventDataByID(TYPE_ID,_loc2_.dataID,this.setGameEventData);
      }
      
      override public function get typeID() : String
      {
         return TYPE_ID;
      }
      
      public function get bloonstonesSpent() : int
      {
         return this._bloonstonesSpent.value;
      }
      
      public function set bloonstonesSpent(param1:int) : void
      {
         this._bloonstonesSpent.value = param1;
      }
      
      private function setGameEventData(param1:Object) : void
      {
         this.reset();
         if(null == param1)
         {
            return;
         }
         this.setMilestoneDefs(param1);
         if(MonkeySystem.getInstance().map.cityIsReady)
         {
            this.onCityFinallyReady();
         }
         GameSignals.CITY_IS_FINALLY_READY.remove(this.onCityFinallyReady);
         GameSignals.CITY_IS_FINALLY_READY.add(this.onCityFinallyReady);
         callWhenCurrentEventEnds(this.reset);
      }
      
      private function onCityFinallyReady(... rest) : void
      {
         this.clearGeneratedMilestones();
         this.generateMilestones(REWARD_BOUNDS,true);
         this.revealPanelIfRewardsArePending();
         SecureBloonstones.onBloonstonesSpentSignal.remove(this.onBloonstonesSpent);
         SecureBloonstones.onBloonstonesSpentSignal.add(this.onBloonstonesSpent);
      }
      
      public function setMilestoneDefs(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BloonstoneSpendRewardDef = null;
         var _loc5_:Object = null;
         var _loc6_:BloonstoneSpendMilestoneDef = null;
         this._milestoneDefs.length = 0;
         var _loc2_:Object = param1.milestones;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new BloonstoneSpendRewardDef();
            _loc4_.populateFromObject(_loc3_.rewards);
            _loc5_ = JSON.parse(JSON.stringify(_loc3_));
            _loc5_.rewards = _loc4_;
            _loc6_ = new BloonstoneSpendMilestoneDef();
            _loc6_.populateFromObject(_loc5_);
            this._milestoneDefs.push(_loc6_);
         }
      }
      
      private function generateMilestones(param1:int, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BloonstoneSpendMilestone = null;
         if(0 == param1)
         {
            return;
         }
         var _loc3_:int = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._milestoneIDGeneratedUpTo / this._milestoneDefs.length;
            _loc6_ = this._milestoneIDGeneratedUpTo % this._milestoneDefs.length;
            _loc7_ = new BloonstoneSpendMilestone();
            _loc7_.bloonstoneSpendMilestoneDef = this._milestoneDefs[_loc6_];
            _loc7_.iteration = _loc5_;
            _loc7_.rewardIndex = this._milestoneIDGeneratedUpTo;
            _loc7_.spendAmount = this.getSpendAmountForMilestone(_loc7_);
            this._milestoneIDGeneratedUpTo++;
            if(this._rewardedForAmount.value >= _loc7_.spendAmount)
            {
               _loc7_.hasBeenRewarded = true;
               _loc3_++;
               this._milestonesRewarded.push(_loc7_);
            }
            else
            {
               this._activeMilestones.push(_loc7_);
            }
            _loc4_++;
         }
         if(param2)
         {
            this.cullRewardedMilestones();
         }
         this._bloonstoneSpendRewardPanel.populateWithMilestones(this._milestonesRewarded,this._activeMilestones);
      }
      
      private function getSpendAmountForMilestone(param1:BloonstoneSpendMilestone) : int
      {
         var _loc2_:BloonstoneSpendMilestoneDef = param1.bloonstoneSpendMilestoneDef as BloonstoneSpendMilestoneDef;
         var _loc3_:int = _loc2_.spendAmountBase;
         _loc3_ = _loc3_ + this._milestoneDefs[this._milestoneDefs.length - 1].spendAmountBase * param1.iteration;
         return _loc3_;
      }
      
      private function onHide(... rest) : void
      {
         this.cullRewardedMilestones();
         this._bloonstoneSpendRewardPanel.populateWithMilestones(this._milestonesRewarded,this._activeMilestones);
      }
      
      private function cullRewardedMilestones() : void
      {
         if(REWARD_BOUNDS >= this._milestonesRewarded.length)
         {
            return;
         }
         var _loc1_:int = this._milestonesRewarded.length - REWARD_BOUNDS;
         this._milestonesRewarded.splice(0,_loc1_);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._milestonesRewarded.length)
         {
            this._milestonesRewarded[_loc3_].rewardIndex = _loc2_;
            _loc2_++;
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._activeMilestones.length)
         {
            this._activeMilestones[_loc4_].rewardIndex = _loc2_;
            _loc2_++;
            _loc4_++;
         }
      }
      
      private function removeActiveMilestones(param1:Vector.<BloonstoneSpendMilestone>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this._activeMilestones.length)
            {
               if(this._activeMilestones[_loc3_] == param1[_loc2_])
               {
                  this._activeMilestones.splice(_loc3_,1);
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function reset(... rest) : void
      {
         this._bloonstonesSpent.value = 0;
         this._rewardedForAmount.value = 0;
         this.clearGeneratedMilestones();
         SecureBloonstones.onBloonstonesSpentSignal.remove(this.onBloonstonesSpent);
         if(null != this._bloonstoneSpendRewardPanel)
         {
            this._bloonstoneSpendRewardPanel.onRevealSignal.remove(this.onRevealWithNewRewards);
         }
      }
      
      private function clearGeneratedMilestones() : void
      {
         this._milestoneIDGeneratedUpTo = 0;
         this._activeMilestones.length = 0;
         this._milestonesRewarded.length = 0;
         this._milestonesToReward.length = 0;
      }
      
      override public function setPersistentData(param1:Object) : void
      {
         if(null == param1)
         {
            return;
         }
         if(param1.eventID != this._activeEventID)
         {
            return;
         }
         if(param1.hasOwnProperty("spent"))
         {
            this._bloonstonesSpent.value = param1.spent;
         }
         if(param1.hasOwnProperty("rewardedForAmount"))
         {
            this._rewardedForAmount.value = param1.rewardedForAmount;
         }
      }
      
      override public function getPersistentData() : Object
      {
         return {
            "eventID":this._activeEventID,
            "spent":this._bloonstonesSpent.value,
            "rewardedForAmount":this._rewardedForAmount.value
         };
      }
      
      private function onBloonstonesSpent(param1:Object) : void
      {
         if(param1 == null || param1.success == false)
         {
            return;
         }
         this._bloonstonesSpent.value = this._bloonstonesSpent.value + param1.spent;
         persistentDataChangedSignal.dispatch();
         if(false == MonkeyCityMain.isInGame)
         {
            this.revealPanelIfRewardsArePending();
         }
         else
         {
            GameSignals.BTD_GAME_COMPLETE_SIGNAL.remove(this.revealPanelIfRewardsArePending);
            GameSignals.BTD_GAME_COMPLETE_SIGNAL.add(this.revealPanelIfRewardsArePending);
         }
         this._bloonstoneSpendRewardPanel.syncNextGoalMessage();
      }
      
      private function revealPanelIfRewardsArePending(... rest) : void
      {
         this.populateMilestonesToReward();
         if(0 != this._milestonesToReward.length)
         {
            this.updatePanelToNextReward();
            this._bloonstoneSpendRewardPanel.onRevealSignal.remove(this.onRevealWithNewRewards);
            this._bloonstoneSpendRewardPanel.onRevealSignal.add(this.onRevealWithNewRewards);
            PanelManager.getInstance().showPanel(this._bloonstoneSpendRewardPanel);
         }
      }
      
      private function populateMilestonesToReward() : void
      {
         var _loc3_:BloonstoneSpendMilestone = null;
         var _loc4_:BloonstoneSpendMilestoneDef = null;
         this._milestonesToReward.length = 0;
         var _loc1_:int = this._bloonstonesSpent.value - this._rewardedForAmount.value;
         var _loc2_:int = 0;
         while(_loc2_ < this._activeMilestones.length)
         {
            _loc3_ = this._activeMilestones[_loc2_];
            _loc4_ = _loc3_.bloonstoneSpendMilestoneDef as BloonstoneSpendMilestoneDef;
            if(!_loc3_.hasBeenRewarded)
            {
               if(this._bloonstonesSpent.value >= _loc3_.spendAmount)
               {
                  this._milestonesToReward.push(this._activeMilestones[_loc2_]);
               }
            }
            _loc2_++;
         }
      }
      
      private function onRevealWithNewRewards(... rest) : void
      {
         this._bloonstoneSpendRewardPanel.giveRewardsAndPlayAnimations(this._milestonesToReward);
         this._bloonstoneSpendRewardPanel.syncNextGoalMessage();
         this.markPendingRewardsAsRewarded();
         this._bloonstoneSpendRewardPanel.onRevealSignal.remove(this.onRevealWithNewRewards);
         this._bloonstoneSpendRewardPanel.onHideSignal.remove(this.onHide);
         this._bloonstoneSpendRewardPanel.onHideSignal.add(this.onHide);
      }
      
      private function markPendingRewardsAsRewarded() : void
      {
         var _loc2_:BloonstoneSpendMilestone = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._milestonesToReward.length)
         {
            _loc2_ = this._milestonesToReward[_loc1_];
            this._rewardedForAmount.value = _loc2_.spendAmount;
            this._milestonesRewarded.push(_loc2_);
            _loc2_.hasBeenRewarded = true;
            _loc1_++;
         }
         this.removeActiveMilestones(this._milestonesToReward);
         this.generateMilestones(this._milestonesToReward.length,false);
         this._milestonesToReward.length = 0;
         persistentDataChangedSignal.dispatch();
      }
      
      public function updatePanelToNextReward() : void
      {
         this._bloonstoneSpendRewardPanel.cycleTo(this._milestonesRewarded.length - 1,true);
      }
   }
}
