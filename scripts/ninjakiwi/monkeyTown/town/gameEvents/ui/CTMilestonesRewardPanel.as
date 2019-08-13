package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.CTRewardsPanelClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.AvatarLoader;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.manageCitiesPanel.CityInformation;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class CTMilestonesRewardPanel extends HideRevealView
   {
       
      
      private var _clip:CTRewardsPanelClip;
      
      private var _leftButton:ButtonControllerBase;
      
      private var _rightButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      private var _timerField:TextField;
      
      private var _messageField:TextField;
      
      private var _mask:MovieClip;
      
      private var _contentContainer:MovieClip;
      
      private var _effectContainer:Sprite;
      
      private var _rewardInfoBoxes:Vector.<MilestoneRewardInfoBox>;
      
      private var _data:Object = null;
      
      private var _rewardIndex:int = 0;
      
      private var _countdownTimer:CountdownTimer = null;
      
      private const _gameEventManger:GameEventManager = GameEventManager.getInstance();
      
      public function CTMilestonesRewardPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._effectContainer = new Sprite();
         this._rewardInfoBoxes = new Vector.<MilestoneRewardInfoBox>();
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         BTDView.btdLoadCompleteSignal.addOnce(function():void
         {
            Main.instance.btdView.gameModule.contestedTerritoryRoundCompletedSignal.addWithPriority(onRoundOver,-1000);
            Main.instance.btdView.eventBridge.addEventListener("gameIsReady",onBTDGameReady);
         });
         GameEventManager.gameEventManagerReadySignal.addOnce(function():void
         {
            _gameEventManger.ctMilestonesManager.getCTMilestoneData(function(param1:Object):void
            {
               lazyInitialise();
            });
         });
      }
      
      private function setupArrowButtons() : void
      {
         this._leftButton.setClickFunction(function():void
         {
            cycle(-1);
         });
         this._rightButton.setClickFunction(function():void
         {
            cycle(1);
         });
      }
      
      private function cycleTo(param1:int, param2:Boolean = false) : void
      {
         this._rewardIndex = param1;
         this.cycle(0,param2);
      }
      
      private function cycle(param1:int, param2:Boolean = false) : void
      {
         var amount:int = param1;
         var instant:Boolean = param2;
         var boxesVisible:int = 4;
         var maxLimit:int = this._rewardInfoBoxes.length - boxesVisible;
         this._rewardIndex = this._rewardIndex + amount;
         this._rewardIndex = this._rewardIndex > maxLimit?int(maxLimit):int(this._rewardIndex);
         this._rewardIndex = this._rewardIndex < 0?0:int(this._rewardIndex);
         if(!(this._rewardIndex in this._rewardInfoBoxes))
         {
            return;
         }
         var time:Number = !!instant?Number(0):Number(0.3);
         var targetX:int = -this._rewardInfoBoxes[this._rewardIndex].x + this._mask.x;
         TweenLite.to(this._contentContainer,time,{
            "x":targetX,
            "ease":Cubic.easeOut,
            "onUpdate":function():void
            {
               _effectContainer.x = _contentContainer.x;
               _effectContainer.y = _contentContainer.y;
            }
         });
      }
      
      override protected function lazyInitialise() : void
      {
         var _loc1_:ContestedTerritoryPanel = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel;
         if(!_loc1_.isInContestedTerritory())
         {
            return;
         }
         if(_hasBeenLazyInitialised)
         {
            return;
         }
         super.lazyInitialise();
         this._clip = new CTRewardsPanelClip();
         isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._timerField = this._clip.timerField;
         this._messageField = this._clip.description;
         this._mask = this._clip.contentMask;
         var _loc2_:GameplayEvent = this._gameEventManger.ctMilestonesManager.findCurrentEvent();
         if(_loc2_ !== null)
         {
            this._countdownTimer = new CountdownTimer(this._clip.timerField,_loc2_.endTime);
         }
         this._leftButton = new ButtonControllerBase(this._clip.leftArrow);
         this._rightButton = new ButtonControllerBase(this._clip.rightArrow);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._closeButton.setClickFunction(this.hide);
         this._okButton.setClickFunction(this.hide);
         this._contentContainer = this._clip.contentContainer;
         this._contentContainer.mask = this._mask;
         this._effectContainer.x = this._contentContainer.x;
         this._effectContainer.y = this._contentContainer.y;
         addChild(this._contentContainer);
         addChild(this._effectContainer);
         this.setupArrowButtons();
      }
      
      private function findNextUnachievedRound() : int
      {
         var _loc2_:MilestoneRewardInfoBox = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rewardInfoBoxes.length)
         {
            _loc2_ = this._rewardInfoBoxes[_loc1_];
            if(!_loc2_.achieved)
            {
               return _loc2_.achievedAtRound;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function buildFromData(param1:Object) : void
      {
         var data:Object = param1;
         this._gameEventManger.ctMilestonesManager.getCTMilestoneData(function(param1:Object):void
         {
            var _loc11_:Object = null;
            var _loc12_:MilestoneRewardInfoBox = null;
            _data = param1;
            if(_data === null)
            {
               return;
            }
            var _loc2_:ContestedTerritoryPanel = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel;
            if(!_loc2_.isInContestedTerritory())
            {
               return;
            }
            var _loc3_:int = MonkeySystem.getInstance().city.cityIndex;
            var _loc4_:int = _gameEventManger.ctMilestonesManager.getBestRoundForCurrentEvent(_loc3_);
            var _loc5_:int = _loc2_.sessionData.minimumRound;
            var _loc6_:int = 0;
            var _loc7_:int = 133;
            lazyInitialise();
            while(_contentContainer.numChildren > 0)
            {
               _contentContainer.removeChildAt(0);
            }
            _rewardInfoBoxes.length = 0;
            var _loc8_:int = 0;
            while(_loc8_ < _data.rounds.length)
            {
               _loc11_ = _data.rounds[_loc8_];
               _loc12_ = new MilestoneRewardInfoBox();
               _loc12_.setData(_loc11_,_loc5_,_loc4_);
               _loc12_.setEffectContainer(_effectContainer);
               _loc12_.index = _loc8_;
               _loc12_.x = _loc6_;
               _loc6_ = _loc6_ + _loc7_;
               _rewardInfoBoxes.push(_loc12_);
               _contentContainer.addChild(_loc12_);
               _loc8_++;
            }
            var _loc9_:MilestoneRewardInfoBox = _rewardInfoBoxes[_rewardInfoBoxes.length - 1];
            var _loc10_:Object = _data.rounds[_data.rounds.length - 1];
            _loc9_.setAsLastGoal();
            if(_loc4_ >= _loc9_.achievedAtRound)
            {
               _loc9_.achieved = true;
            }
            cycleTo(0,true);
         });
      }
      
      private function syncNextRoundGoalMessage() : void
      {
         var _loc1_:int = this.findNextUnachievedRound();
         if(_loc1_ < 0)
         {
            this._messageField.text = "All rewards earned!";
         }
         else
         {
            this._messageField.text = "Pass Round " + _loc1_ + " for next reward";
         }
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         var _loc2_:GameplayEvent = this._gameEventManger.ctMilestonesManager.findCurrentEvent();
         if(_loc2_ === null || !_loc2_.active)
         {
            return;
         }
         super.reveal(param1);
         this.buildFromData(this._data);
         this.syncAchievedStates();
         this._countdownTimer.setEndTime(_loc2_.endTime);
         this._countdownTimer.start();
         Main.instance.btdView.pauseGame();
         this.cycleTo(0,true);
      }
      
      override public function hide(param1:Number = 0.4) : void
      {
         super.hide(param1);
         Main.instance.btdView.unPauseGame();
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardInfoBoxes.length)
         {
            this._rewardInfoBoxes[_loc2_].hideSpecialStateBackgrounds();
            _loc2_++;
         }
         if(this._countdownTimer !== null)
         {
            this._countdownTimer.stop();
         }
      }
      
      private function currentBTDGameIsValidForEvent() : Boolean
      {
         var _loc1_:BTDGameRequest = MonkeyCityMain.getInstance().activeBTDGameRequest;
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc2_:Number = _loc1_.timeLaunched;
         var _loc3_:GameplayEvent = this._gameEventManger.ctMilestonesManager.findCurrentEvent();
         if(_loc3_ === null || _loc3_.active === false || _loc2_ < _loc3_.startTime)
         {
            return false;
         }
         return true;
      }
      
      private function onRoundOver(param1:int, param2:Number) : void
      {
         var boxesToAward:Vector.<MilestoneRewardInfoBox> = null;
         var roundCompleted:int = param1;
         var timestamp:Number = param2;
         if(!this.currentBTDGameIsValidForEvent())
         {
            return;
         }
         boxesToAward = this.getNewRewards(roundCompleted);
         if(boxesToAward.length === 0)
         {
            return;
         }
         var cityIndex:int = MonkeySystem.getInstance().city.cityIndex;
         this._gameEventManger.ctMilestonesManager.setBestRoundForCurrentEvent(roundCompleted,cityIndex);
         if(roundCompleted === 100)
         {
         }
         PanelManager.getInstance().showFreePanel(this);
         var nextRewardIndex:int = boxesToAward[0].index - 1;
         if(nextRewardIndex < 0)
         {
            nextRewardIndex = 0;
         }
         this.cycleTo(nextRewardIndex,false);
         this.syncNextRoundGoalMessage();
         var delayed:Function = function():void
         {
            var _loc2_:int = 0;
            var _loc1_:int = 0;
            while(_loc1_ < boxesToAward.length)
            {
               _loc2_ = boxesToAward[_loc1_].index;
               boxesToAward[_loc1_] = _rewardInfoBoxes[_loc2_];
               boxesToAward[_loc1_].award();
               _loc1_++;
            }
            syncAchievedStates();
         };
         setTimeout(delayed,500);
      }
      
      private function syncAchievedStates() : void
      {
         var _loc3_:MilestoneRewardInfoBox = null;
         var _loc4_:int = 0;
         var _loc1_:int = -1;
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardInfoBoxes.length)
         {
            _loc3_ = this._rewardInfoBoxes[_loc2_];
            if(_loc3_.achieved)
            {
               _loc3_.setGraphicsAsAchieved();
               _loc1_ = _loc3_.index;
            }
            else
            {
               _loc3_.lock();
            }
            _loc2_++;
         }
         if(_loc1_ > -1)
         {
            _loc4_ = _loc1_ + 2;
            while(_loc4_ < this._rewardInfoBoxes.length)
            {
               this._rewardInfoBoxes[_loc4_].lock();
               _loc4_++;
            }
         }
         if(_loc1_ + 1 in this._rewardInfoBoxes)
         {
            this._rewardInfoBoxes[_loc1_ + 1].setAsGoal();
         }
         this.syncNextRoundGoalMessage();
      }
      
      private function getNewRewards(param1:int) : Vector.<MilestoneRewardInfoBox>
      {
         var _loc4_:MilestoneRewardInfoBox = null;
         var _loc2_:Vector.<MilestoneRewardInfoBox> = new Vector.<MilestoneRewardInfoBox>();
         var _loc3_:int = 0;
         while(_loc3_ < this._rewardInfoBoxes.length)
         {
            _loc4_ = this._rewardInfoBoxes[_loc3_];
            if(!_loc4_.achieved && param1 === _loc4_.achievedAtRound)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onBTDGameReady(param1:Event) : void
      {
         var _loc2_:GameplayEvent = this._gameEventManger.ctMilestonesManager.findCurrentEvent();
         if(!MonkeyCityMain.getInstance().isContestedTerritory || _loc2_ == null || _loc2_.active !== true)
         {
            return;
         }
         var _loc3_:int = this.findNextUnachievedRound() - 2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this.cycleTo(_loc3_,true);
         PanelManager.getInstance().showFreePanel(this);
      }
      
      public function test() : void
      {
         this.onRoundOver(this.findNextUnachievedRound(),new Date().getTime());
      }
   }
}
