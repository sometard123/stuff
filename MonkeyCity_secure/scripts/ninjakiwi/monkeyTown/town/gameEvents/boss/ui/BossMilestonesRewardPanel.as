package ninjakiwi.monkeyTown.town.gameEvents.boss.ui
{
   import assets.ui.BossMilestonesPanelClip;
   import assets.ui.MilestoneRewardClip;
   import com.codecatalyst.promise.Deferred;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import com.ninjakiwi.gateway.nk.NKBarContainer;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossEventManager;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BossMilestonesRewardPanel extends HideRevealView
   {
       
      
      private var _clip:BossMilestonesPanelClip;
      
      private var _contentContainer:MovieClip;
      
      private var _infoBoxes:Vector.<BossMilestoneInfoBox>;
      
      private var _mask:MovieClip;
      
      private var _descriptionField:TextField;
      
      private var _okButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _leftButton:ButtonControllerBase;
      
      private var _rightButton:ButtonControllerBase;
      
      private var _bossEventManager:BossEventManager;
      
      private var _rewardIndex:int = 0;
      
      private var _effectContainer:Sprite;
      
      private var _winAnimationOnRevealIndex:int = -1;
      
      private const MILESTONE_REACHED:String = "BOSS MILESTONE REACHED!";
      
      private const BOSS_MILESTONES:String = "BOSS REWARD MILESTONES";
      
      public function BossMilestonesRewardPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new BossMilestonesPanelClip();
         this._contentContainer = this._clip.contentContainer;
         this._infoBoxes = new Vector.<BossMilestoneInfoBox>();
         this._mask = this._clip.contentMask;
         this._descriptionField = this._clip.description;
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._leftButton = new ButtonControllerBase(this._clip.leftArrow);
         this._rightButton = new ButtonControllerBase(this._clip.rightArrow);
         this._bossEventManager = GameEventManager.getInstance().bossEventManager;
         this._effectContainer = new Sprite();
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      private function init() : void
      {
         isModal = true;
         this._contentContainer.mask = this._clip.contentMask;
         this._okButton.setClickFunction(hide);
         this._closeButton.setClickFunction(hide);
         this._effectContainer.x = this._contentContainer.x;
         this._effectContainer.y = this._contentContainer.y;
         this._leftButton.setClickFunction(function():void
         {
            cycle(-1);
         });
         this._rightButton.setClickFunction(function():void
         {
            cycle(1);
         });
         addChild(this._effectContainer);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this.build();
         if(this._winAnimationOnRevealIndex !== -1)
         {
            this._clip.titleField.text = this.MILESTONE_REACHED;
            this.playWinAnimationForTier(this._winAnimationOnRevealIndex);
            this._winAnimationOnRevealIndex = -1;
         }
         else
         {
            this._clip.titleField.text = this.BOSS_MILESTONES;
         }
      }
      
      public function build() : void
      {
         this._bossEventManager.getDataForCurrentEvent(function(param1:Object):void
         {
            syncToEventData(param1);
         });
      }
      
      private function syncToEventData(param1:Object) : void
      {
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:BossMilestoneInfoBox = null;
         this._contentContainer.removeChildren();
         var _loc2_:Array = param1.rewards;
         var _loc3_:int = this._bossEventManager.bossLevel;
         var _loc4_:int = 137;
         var _loc5_:Boolean = false;
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc8_ = _loc2_[_loc7_].rewards;
            _loc9_ = _loc2_[_loc7_].tier;
            _loc10_ = new BossMilestoneInfoBox();
            _loc10_.build(_loc8_,_loc9_,_loc3_);
            _loc10_.setEffectContainer(this._effectContainer);
            if(_loc9_ < _loc3_)
            {
               _loc10_.setGraphicsAsAchieved();
            }
            else if(false == _loc5_ && _loc9_ >= _loc3_)
            {
               _loc10_.setAsGoal();
               _loc5_ = true;
               _loc6_ = _loc9_;
            }
            else
            {
               _loc10_.hideSpecialStateBackgrounds();
            }
            _loc10_.x = _loc7_ * _loc4_;
            this._infoBoxes.push(_loc10_);
            this._contentContainer.addChild(_loc10_);
            _loc7_++;
         }
         if(_loc6_ !== -1)
         {
            this._descriptionField.text = "Beat the level " + _loc6_ + " Boss for next reward.";
         }
         else
         {
            this._descriptionField.text = "All milestones achieved!";
         }
      }
      
      public function queueWinAnimationOnReveal(param1:int) : void
      {
         this._winAnimationOnRevealIndex = param1;
      }
      
      private function playWinAnimationForTier(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._infoBoxes.length)
         {
            if(this._infoBoxes[_loc2_].tier == param1)
            {
               this.cycleTo(_loc2_,true);
               this._infoBoxes[_loc2_].awardAnimation();
               return;
            }
            _loc2_++;
         }
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
         var maxLimit:int = this._infoBoxes.length - boxesVisible;
         this._rewardIndex = this._rewardIndex + amount;
         this._rewardIndex = this._rewardIndex > maxLimit?int(maxLimit):int(this._rewardIndex);
         this._rewardIndex = this._rewardIndex < 0?0:int(this._rewardIndex);
         if(false == this._rewardIndex in this._infoBoxes)
         {
            return;
         }
         var time:Number = !!instant?Number(0):Number(0.3);
         var targetX:int = -this._infoBoxes[this._rewardIndex].x + this._mask.x;
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
   }
}
