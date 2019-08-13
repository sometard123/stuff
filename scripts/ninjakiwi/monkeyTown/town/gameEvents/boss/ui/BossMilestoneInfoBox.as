package ninjakiwi.monkeyTown.town.gameEvents.boss.ui
{
   import assets.ui.BossMilestonePaneClip;
   import assets.ui.BossMilestonelUnlockedEffect;
   import assets.ui.MonkeyKnowledgeCardLayout;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.RewardItem;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   import ninjakiwi.monkeyTown.utils.widgets.Wafter;
   
   public class BossMilestoneInfoBox extends MovieClip
   {
       
      
      public var tier:int;
      
      private var _clip:BossMilestonePaneClip;
      
      private var _container:MovieClip;
      
      private var _backgroundAchieved:MovieClip;
      
      private var _backgroundNext:MovieClip;
      
      private var _effectContainer:Sprite = null;
      
      public function BossMilestoneInfoBox()
      {
         this._clip = new BossMilestonePaneClip();
         super();
         addChild(this._clip);
         this._container = this._clip.rewardItemContainer;
      }
      
      public function setEffectContainer(param1:Sprite) : void
      {
         this._effectContainer = param1;
      }
      
      public function build(param1:Object, param2:int, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         this.tier = param2;
         this._container.removeChildren();
         this._backgroundAchieved = this._clip.backgroundAchieved;
         this._backgroundNext = this._clip.backgroundNext;
         this._clip.description.text = "Level " + param2;
         var _loc4_:Array = [];
         for(_loc6_ in param1)
         {
            _loc10_ = param1[_loc6_];
            _loc5_ = new RewardItem(_loc6_,_loc10_);
            _loc4_.push(_loc5_);
         }
         _loc4_.sortOn("sortIndex");
         _loc7_ = 35;
         _loc8_ = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc9_];
            _loc4_[_loc9_].y = _loc8_;
            _loc8_ = _loc8_ + _loc7_;
            this._container.addChild(_loc5_);
            _loc9_++;
         }
      }
      
      public function setAsGoal() : void
      {
         this._backgroundAchieved.visible = false;
         this._backgroundAchieved.stop();
         this._backgroundNext.visible = true;
         this._clip.tick.visible = false;
      }
      
      public function setGraphicsAsAchieved() : void
      {
         this._clip.tick.visible = true;
         this._backgroundAchieved.visible = true;
         this._backgroundAchieved.play();
         this._backgroundNext.visible = false;
      }
      
      public function hideSpecialStateBackgrounds() : void
      {
         this._backgroundAchieved.visible = false;
         this._backgroundAchieved.stop();
         this._backgroundNext.visible = false;
         this._clip.tick.visible = false;
      }
      
      public function awardAnimation() : void
      {
         var _loc1_:BossMilestonelUnlockedEffect = new BossMilestonelUnlockedEffect();
         _loc1_.x = this.x + this._clip.tick.x;
         _loc1_.y = this.y + this._clip.tick.y;
         this._effectContainer.addChild(_loc1_);
         this.setGraphicsAsAchieved();
         MCSound.getInstance().playSound(MCSound.MILESTONE_REWARD);
      }
   }
}
