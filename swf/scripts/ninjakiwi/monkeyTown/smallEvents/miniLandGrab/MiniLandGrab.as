package ninjakiwi.monkeyTown.smallEvents.miniLandGrab
{
   import assets.ui.MonkeyKnowledgeIntroClip;
   import flash.display.DisplayObjectContainer;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MiniLandGrab extends GameEventSubManager
   {
      
      public static const UI_REWARD_INDEX_NONE:int = 0;
      
      public static const UI_REWARD_INDEX_CASH:int = 1;
      
      public static const UI_REWARD_INDEX_BLOONSTONES:int = 2;
      
      public static const UI_REWARD_INDEX_CRATES:int = 3;
      
      public static const UI_REWARD_INDEX_BOOSTS:int = 4;
      
      public static const UI_REWARD_INDEX_SPIKES:int = 5;
      
      public static const UI_REWARD_INDEX_KNOWLEDGE:int = 6;
      
      public static const UI_REWARD_INDEX_KNOWLEDGE_ANCIENT:int = 7;
      
      public static const UI_REWARD_INDEX_BANE:int = 8;
      
      public static const UI_REWARD_INDEX_CHILL:int = 9;
      
      public static const UI_REWARD_INDEX_BLAST:int = 10;
      
      public static const UI_REWARD_INDEX_WEAKEN:int = 11;
      
      public static const UI_REWARD_INDEX_KNOWLEDGE_WILD:int = 12;
       
      
      private var _levels:Array = null;
      
      private var _rewards:Array = null;
      
      private var _tilesCaptured:INumber;
      
      private var _landCaptureThreshold:INumber;
      
      private var _rewardedForAmount:INumber;
      
      private var _rewardIndex:INumber;
      
      private var _activeEventID:String = "";
      
      public function MiniLandGrab()
      {
         this._tilesCaptured = DancingShadows.getOne();
         this._landCaptureThreshold = DancingShadows.getOne();
         this._rewardedForAmount = DancingShadows.getOne();
         this._rewardIndex = DancingShadows.getOne();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "miniLandGrab";
      }
      
      public function reset(... rest) : void
      {
         this._levels = null;
         this._rewards = null;
         this._tilesCaptured.value = 0;
         this._landCaptureThreshold.value = 0;
         this._rewardedForAmount.value = 0;
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            this.reset();
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         this._activeEventID = _loc2_.uid;
         SkuSettingsLoader.getGameEventDataByID("miniLandGrab",_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         this.reset();
         if(null == param1)
         {
            return;
         }
         if(param1.hasOwnProperty("captureThreshold"))
         {
            this._landCaptureThreshold.value = param1.captureThreshold;
            if(param1.hasOwnProperty("levels"))
            {
               this._levels = param1.levels;
               if(param1.hasOwnProperty("rewards"))
               {
                  this._rewards = param1.rewards;
                  callWhenCurrentEventEnds(this.reset);
                  return;
               }
               this.reset();
               return;
            }
            this.reset();
            return;
         }
         this.reset();
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
         if(param1.hasOwnProperty("tilesCaptured"))
         {
            this._tilesCaptured.value = param1.tilesCaptured;
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
            "tilesCaptured":this._tilesCaptured.value,
            "rewardedForAmount":this._rewardedForAmount.value
         };
      }
      
      public function onTileCaptured() : void
      {
         if(0 == this._landCaptureThreshold.value)
         {
            return;
         }
         this._tilesCaptured.value = this._tilesCaptured.value + 1;
         persistentDataChangedSignal.dispatch();
      }
      
      public function getNumOfPendingRewards() : int
      {
         var _loc1_:int = 0;
         _loc1_ = this._tilesCaptured.value - this._rewardedForAmount.value;
         var _loc2_:int = _loc1_ / this._landCaptureThreshold.value;
         return _loc2_;
      }
      
      public function givePendingReward(param1:Object) : MiniLandGrabRewardDef
      {
         var _loc2_:MiniLandGrabRewardDef = new MiniLandGrabRewardDef().UiRewardIndex(UI_REWARD_INDEX_NONE).RewardAmount(0);
         var _loc3_:int = this.getNumOfPendingRewards();
         if(_loc3_ == 0)
         {
            return _loc2_;
         }
         _loc2_ = this.claimReward(this._rewardIndex.value,param1);
         this._rewardedForAmount.value = this._rewardedForAmount.value + this._landCaptureThreshold.value;
         persistentDataChangedSignal.dispatch();
         return _loc2_;
      }
      
      public function claimReward(param1:int, param2:Object) : MiniLandGrabRewardDef
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:MiniLandGrabRewardDef = new MiniLandGrabRewardDef().UiRewardIndex(UI_REWARD_INDEX_NONE).RewardAmount(0);
         var _loc4_:Object = this.findCurrentReward();
         if(null == _loc4_)
         {
            return _loc3_;
         }
         var _loc5_:Array = null;
         if(_loc4_.hasOwnProperty("bloonstones") && _loc4_.bloonstones != 0)
         {
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_BLOONSTONES;
            _loc3_.rewardAmount = _loc4_.bloonstones;
            param2.bloonstonesEarned = param2.bloonstonesEarned + _loc4_.bloonstones;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("cash") && _loc4_.cash != 0)
         {
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_CASH;
            _loc3_.rewardAmount = _loc4_.cash;
            param2.cashEarned = param2.cashEarned + _loc4_.cash;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("spikes") && _loc4_.spikes != 0)
         {
            ResourceStore.getInstance().redHotSpikes = ResourceStore.getInstance().redHotSpikes + _loc4_.spikes;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_SPIKES;
            _loc3_.rewardAmount = _loc4_.spikes;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("boosts") && _loc4_.boosts != 0)
         {
            ResourceStore.getInstance().monkeyBoosts = ResourceStore.getInstance().monkeyBoosts + _loc4_.boosts;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_BOOSTS;
            _loc3_.rewardAmount = _loc4_.boosts;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("crates") && _loc4_.crates != 0)
         {
            CrateManager.getInstance().addNewCrates(_loc4_.crates);
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_CRATES;
            _loc3_.rewardAmount = _loc4_.crates;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("knowledgePack") && _loc4_.knowledgePack != 0)
         {
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc4_.knowledgePack)
            {
               _loc5_.push(0);
               _loc6_++;
            }
            MonkeyKnowledge.getInstance().winPacks(_loc5_);
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_KNOWLEDGE;
            _loc3_.rewardAmount = _loc5_.length;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("ancientKnowledgePack") && _loc4_.ancientKnowledgePack != 0)
         {
            _loc5_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc4_.ancientKnowledgePack)
            {
               _loc5_.push(1);
               _loc7_++;
            }
            MonkeyKnowledge.getInstance().winPacks(_loc5_);
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_KNOWLEDGE_ANCIENT;
            _loc3_.rewardAmount = _loc5_.length;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("wildcardKnowledgePack") && _loc4_.wildcardKnowledgePack != 0)
         {
            MonkeyKnowledge.getInstance().unopenedWildcardPacks = MonkeyKnowledge.getInstance().unopenedWildcardPacks + _loc4_.wildcardKnowledgePack;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_KNOWLEDGE_WILD;
            _loc3_.rewardAmount = _loc4_.wildcardKnowledgePack;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("bossBanes") && _loc4_.bossBanes != 0)
         {
            ResourceStore.getInstance().bossBanes = ResourceStore.getInstance().bossBanes + _loc4_.bossBanes;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_BANE;
            _loc3_.rewardAmount = _loc4_.bossBanes;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("bossChills") && _loc4_.bossChills != 0)
         {
            ResourceStore.getInstance().bossChills = ResourceStore.getInstance().bossChills + _loc4_.bossChills;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_CHILL;
            _loc3_.rewardAmount = _loc4_.bossChills;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("bossBlasts") && _loc4_.bossBlasts != 0)
         {
            ResourceStore.getInstance().bossBlasts = ResourceStore.getInstance().bossBlasts + _loc4_.bossBlasts;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_BLAST;
            _loc3_.rewardAmount = _loc4_.bossBlasts;
            return _loc3_;
         }
         if(_loc4_.hasOwnProperty("bossWeakens") && _loc4_.bossWeakens != 0)
         {
            ResourceStore.getInstance().bossWeakens = ResourceStore.getInstance().bossWeakens + _loc4_.bossWeakens;
            _loc3_.uiRewardIndex = UI_REWARD_INDEX_WEAKEN;
            _loc3_.rewardAmount = _loc4_.bossWeakens;
            return _loc3_;
         }
         return _loc3_;
      }
      
      private function findCurrentReward() : Object
      {
         var _loc3_:Object = null;
         var _loc1_:Object = null;
         if(null == this._levels || null == this._rewards)
         {
            return _loc1_;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._rewards.length)
         {
            if(_loc2_ > this._levels.length)
            {
               break;
            }
            _loc3_ = this._rewards[_loc2_];
            if(ResourceStore.getInstance().townLevel < this._levels[_loc2_])
            {
               _loc1_ = _loc3_;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
