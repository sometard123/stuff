package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.CTRewardPanelUnlockedEffect;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.AncientKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BloonstonesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBaneAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBlastAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossChillAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossWeakenAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CashAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CratesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.KnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.MonkeyBoostAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.RedHotSpikesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.WildcardKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.FriendCrateInfoBox;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class RewardInfoBox extends Sprite
   {
      
      private static const ITEM_SPACING:int = 34;
       
      
      private var _clip:MovieClip = null;
      
      private var _awarders:Vector.<Awarder>;
      
      public var achieved:Boolean = false;
      
      public var index:int = -1;
      
      private var _rewardItemCount:int = 0;
      
      private var _backgroundAchieved:MovieClip;
      
      private var _backgroundNext:MovieClip;
      
      private var _lockedOverlay:MovieClip;
      
      private var _effectContainer:DisplayObjectContainer;
      
      public function RewardInfoBox(param1:MovieClip)
      {
         this._awarders = new Vector.<Awarder>();
         super();
         this._clip = param1;
         this._backgroundAchieved = this._clip.backgroundAchieved;
         this._backgroundNext = this._clip.backgroundNext;
         this._lockedOverlay = this._clip.lockedOverlay;
         addChild(this._clip);
         this.setAchieved(false);
         this.hideSpecialStateBackgrounds();
      }
      
      public function setEffectContainer(param1:DisplayObjectContainer) : void
      {
         this._effectContainer = param1;
      }
      
      protected function setAchieved(param1:Boolean) : void
      {
         this.achieved = param1;
      }
      
      public function setAsGoal() : void
      {
         this._backgroundAchieved.visible = false;
         this._backgroundAchieved.stop();
         this._backgroundNext.visible = true;
         this._lockedOverlay.visible = false;
         this._clip.tick.visible = false;
      }
      
      public function setGraphicsAsAchieved() : void
      {
         this._clip.tick.visible = true;
         this._backgroundAchieved.visible = true;
         this._backgroundAchieved.play();
         this._backgroundNext.visible = false;
         this._lockedOverlay.visible = false;
      }
      
      public function hideSpecialStateBackgrounds() : void
      {
         this._backgroundAchieved.visible = false;
         this._backgroundAchieved.stop();
         this._backgroundNext.visible = false;
         this._lockedOverlay.visible = false;
         this._clip.tick.visible = false;
      }
      
      protected function syncToData(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1.hasOwnProperty("cash") && param1.cash != 0)
         {
            _loc3_ = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel.sessionData.levelTier;
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            _loc4_ = param1.cash * _loc3_;
            this.addRewardItem("cash",_loc4_);
            this._awarders.push(new CashAwarder(_loc4_));
         }
         if(param1.hasOwnProperty("bloonstones") && param1.bloonstones != 0)
         {
            this.addRewardItem("bloonstones",param1.bloonstones);
            this._awarders.push(new BloonstonesAwarder(param1.bloonstones));
         }
         if(param1.hasOwnProperty("crates") && param1.crates != 0)
         {
            this.addRewardItem("crates",param1.crates);
            this._awarders.push(new CratesAwarder(param1.crates));
         }
         if(param1.hasOwnProperty("boosts") && param1.boosts != 0)
         {
            this.addRewardItem("boosts",param1.boosts);
            this._awarders.push(new MonkeyBoostAwarder(param1.boosts));
         }
         if(param1.hasOwnProperty("spikes") && param1.spikes != 0)
         {
            this.addRewardItem("spikes",param1.spikes);
            this._awarders.push(new RedHotSpikesAwarder(param1.spikes));
         }
         if(ResourceStore.getInstance().townLevel >= 12)
         {
            if(param1.hasOwnProperty("knowledgePack") && param1.knowledgePack != 0)
            {
               this.addRewardItem("knowledgePack",param1.knowledgePack);
               this._awarders.push(new KnowledgePackAwarder(param1.knowledgePack));
            }
            if(param1.hasOwnProperty("ancientKnowledgePack") && param1.ancientKnowledgePack != 0)
            {
               this.addRewardItem("ancientKnowledgePack",param1.ancientKnowledgePack);
               this._awarders.push(new AncientKnowledgePackAwarder(param1.ancientKnowledgePack));
            }
            if(param1.hasOwnProperty("wildcardKnowledgePack") && param1.wildcardKnowledgePack != 0)
            {
               this.addRewardItem("wildcardKnowledgePack",param1.wildcardKnowledgePack);
               this._awarders.push(new WildcardKnowledgePackAwarder(param1.wildcardKnowledgePack));
            }
            if(param1.hasOwnProperty("bossBanes") && param1.bossBanes != 0)
            {
               this.addRewardItem("bossBanes",param1.bossBanes);
               this._awarders.push(new BossBaneAwarder(param1.bossBanes));
            }
            if(param1.hasOwnProperty("bossChills") && param1.bossChills != 0)
            {
               this.addRewardItem("bossChills",param1.bossChills);
               this._awarders.push(new BossChillAwarder(param1.bossChills));
            }
            if(param1.hasOwnProperty("bossBlasts") && param1.bossBanes != 0)
            {
               this.addRewardItem("bossBlasts",param1.bossBlasts);
               this._awarders.push(new BossBlastAwarder(param1.bossBlasts));
            }
            if(param1.hasOwnProperty("bossWeakens") && param1.bossChills != 0)
            {
               this.addRewardItem("bossWeakens",param1.bossWeakens);
               this._awarders.push(new BossWeakenAwarder(param1.bossWeakens));
            }
         }
      }
      
      private function addRewardItem(param1:String, param2:int) : void
      {
         if(this._rewardItemCount >= 4)
         {
            return;
         }
         var _loc3_:RewardItem = new RewardItem(param1,param2);
         _loc3_.y = this._rewardItemCount * ITEM_SPACING;
         this._rewardItemCount++;
         this._clip.rewardItemContainer.addChild(_loc3_);
      }
      
      public function award() : void
      {
         var _loc3_:Awarder = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._awarders.length)
         {
            _loc3_ = this._awarders[_loc1_];
            _loc3_.award();
            _loc1_++;
         }
         this._awarders.length = 0;
         var _loc2_:CTRewardPanelUnlockedEffect = new CTRewardPanelUnlockedEffect();
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         this._effectContainer.addChild(_loc2_);
         this.setGraphicsAsAchieved();
         this.setAchieved(true);
         MCSound.getInstance().playSound(MCSound.MILESTONE_REWARD);
      }
      
      public function awardOffscreen() : void
      {
         var _loc3_:Awarder = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._awarders.length)
         {
            _loc3_ = this._awarders[_loc1_];
            _loc3_.award();
            _loc1_++;
         }
         this._awarders.length = 0;
         var _loc2_:CTRewardPanelUnlockedEffect = new CTRewardPanelUnlockedEffect();
         _loc2_.gotoAndStop(_loc2_.totalFrames - 1);
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         this._effectContainer.addChild(_loc2_);
         this.setGraphicsAsAchieved();
         this.setAchieved(true);
      }
      
      public function lock() : void
      {
         this.hideSpecialStateBackgrounds();
         this._lockedOverlay.visible = true;
      }
   }
}
