package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import assets.ui.FestivalOfBloonstonesPanelClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.DateTool;
   
   public class BloonstoneSpendRewardPanel extends HideRevealView
   {
       
      
      private const BOXES_VISIBLE:int = 4;
      
      private const SPACING:int = 133;
      
      private const _clip:FestivalOfBloonstonesPanelClip = new FestivalOfBloonstonesPanelClip();
      
      private var _leftButton:ButtonControllerBase;
      
      private var _rightButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      private const _holdTextField:TextField = this._clip.description;
      
      private var _contentContainer:MovieClip;
      
      private var _mask:MovieClip;
      
      private var _timerField:TextField;
      
      private var _effectContainer:Sprite;
      
      private var _rewardInfoBoxes:Vector.<BloonstoneSpendRewardInfoBox>;
      
      private var _rewardIndex:int = 0;
      
      public function BloonstoneSpendRewardPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         var container:DisplayObjectContainer = param1;
         var mutexGroup:* = param2;
         this._leftButton = new ButtonControllerBase(this._clip.leftArrow);
         this._rightButton = new ButtonControllerBase(this._clip.rightArrow);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._contentContainer = this._clip.contentContainer;
         this._mask = this._clip.contentMask;
         this._effectContainer = new Sprite();
         this._rewardInfoBoxes = new Vector.<BloonstoneSpendRewardInfoBox>();
         super(container,mutexGroup);
         this._leftButton.setClickFunction(function():void
         {
            cycle(-1);
         });
         this._rightButton.setClickFunction(function():void
         {
            cycle(1);
         });
         this._closeButton.setClickFunction(this.hide);
         this._okButton.setClickFunction(this.hide);
      }
      
      public function populateWithMilestones(param1:Vector.<BloonstoneSpendMilestone>, param2:Vector.<BloonstoneSpendMilestone>, param3:Boolean = true) : void
      {
         while(this._contentContainer.numChildren > 0)
         {
            this._contentContainer.removeChildAt(0);
         }
         this._rewardInfoBoxes.length = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            this.addMilestone(param1[_loc4_]);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            this.addMilestone(param2[_loc5_]);
            _loc5_++;
         }
         this.lazyInitialise();
         this.syncAchievedStates();
      }
      
      public function addMilestone(param1:BloonstoneSpendMilestone) : void
      {
         var _loc2_:BloonstoneSpendRewardDef = param1.bloonstoneSpendMilestoneDef.rewards as BloonstoneSpendRewardDef;
         var _loc3_:BloonstoneSpendRewardInfoBox = new BloonstoneSpendRewardInfoBox();
         _loc3_.setData(_loc2_,param1.spendAmount,param1.hasBeenRewarded);
         _loc3_.setEffectContainer(this._effectContainer);
         _loc3_.index = this._rewardInfoBoxes.length;
         _loc3_.x = this.SPACING * _loc3_.index;
         if(param1.hasBeenRewarded)
         {
            _loc3_.achieved = true;
         }
         this._rewardInfoBoxes.push(_loc3_);
         this._contentContainer.addChild(_loc3_);
      }
      
      override protected function lazyInitialise() : void
      {
         if(_hasBeenLazyInitialised)
         {
            return;
         }
         super.lazyInitialise();
         isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._timerField = this._clip.timeLeftDisplay.timerField;
         this._contentContainer = this._clip.contentContainer;
         this._contentContainer.mask = this._mask;
         this._effectContainer.x = this._contentContainer.x;
         this._effectContainer.y = this._contentContainer.y;
         addChild(this._contentContainer);
         addChild(this._effectContainer);
         this.setupArrowButtons();
         this.cycleTo(0,true);
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         this.lazyInitialise();
         this.updateTimeLeftInEvent();
         super.reveal(param1);
      }
      
      private function updateTimeLeftInEvent() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:GameplayEvent = GameEventManager.getInstance().bloonstonesSpendTracker.findCurrentEvent();
         if(null == _loc2_)
         {
            this._timerField.text = "expired";
            return;
         }
         this._timerField.text = DateTool.getTimeStringFromUnixTime(_loc2_.endTime - MonkeySystem.getInstance().getSecureTime());
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
      
      private function syncAchievedStates() : void
      {
         var _loc4_:BloonstoneSpendRewardInfoBox = null;
         var _loc5_:int = 0;
         var _loc1_:int = -1;
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardInfoBoxes.length)
         {
            _loc4_ = this._rewardInfoBoxes[_loc2_];
            if(_loc4_.achieved)
            {
               _loc4_.setGraphicsAsAchieved();
               _loc1_ = _loc4_.index;
            }
            else
            {
               _loc4_.lock();
            }
            _loc2_++;
         }
         if(_loc1_ > -1)
         {
            _loc5_ = _loc1_ + 2;
            while(_loc5_ < this._rewardInfoBoxes.length)
            {
               this._rewardInfoBoxes[_loc5_].lock();
               _loc5_++;
            }
         }
         var _loc3_:BloonstoneSpendRewardInfoBox = this.findNextUnachievedBox();
         if(null != _loc3_)
         {
            _loc3_.setAsGoal();
         }
         this.syncNextGoalMessage();
      }
      
      public function syncNextGoalMessage() : void
      {
         var _loc1_:BloonstoneSpendRewardInfoBox = this.findNextUnachievedBox();
         if(null == _loc1_)
         {
            return;
         }
         var _loc2_:int = _loc1_.requiredBloonstones - GameEventManager.getInstance().bloonstonesSpendTracker.bloonstonesSpent;
         _loc2_ = _loc2_ < 0?0:int(_loc2_);
         this._holdTextField.text = LocalisationConstants.BLOONSTONE_SPEND_EVENT.split("<bloonstones>").join(_loc2_.toString());
      }
      
      private function findNextUnachievedBox() : BloonstoneSpendRewardInfoBox
      {
         var _loc2_:BloonstoneSpendRewardInfoBox = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rewardInfoBoxes.length)
         {
            _loc2_ = this._rewardInfoBoxes[_loc1_];
            if(false == _loc2_.achieved)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function cycleTo(param1:int, param2:Boolean = false) : void
      {
         this._rewardIndex = param1;
         if(this._rewardIndex < 0)
         {
            this._rewardIndex = 0;
         }
         this.cycle(0,param2);
      }
      
      public function cycle(param1:int, param2:Boolean = false) : void
      {
         var amount:int = param1;
         var instant:Boolean = param2;
         var maxLimit:int = this._rewardInfoBoxes.length - this.BOXES_VISIBLE;
         this._rewardIndex = this._rewardIndex + amount;
         this._rewardIndex = this._rewardIndex > maxLimit?int(maxLimit):int(this._rewardIndex);
         this._rewardIndex = this._rewardIndex < 0?0:int(this._rewardIndex);
         if(false == this._rewardIndex in this._rewardInfoBoxes)
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
      
      override public function hide(param1:Number = 0.4) : void
      {
         super.hide(param1);
      }
      
      public function giveRewardsAndPlayAnimations(param1:Vector.<BloonstoneSpendMilestone>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(_loc2_ < this.BOXES_VISIBLE - 1)
            {
               this._rewardInfoBoxes[param1[_loc2_].rewardIndex].award();
            }
            else
            {
               this._rewardInfoBoxes[param1[_loc2_].rewardIndex].awardOffscreen();
            }
            _loc2_++;
         }
         var _loc3_:int = 2 + param1[param1.length - 1].rewardIndex;
         if(_loc3_ < this._rewardInfoBoxes.length)
         {
            this._rewardInfoBoxes[_loc3_].setAsGoal();
         }
      }
      
      public function get rewardIndex() : int
      {
         return this._rewardIndex;
      }
   }
}
