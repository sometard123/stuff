package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.BossRewardSubpanelClip;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossMilestonesRewardPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.RewardItem;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BossRewardsSubpanel
   {
       
      
      private var _clip:BossRewardSubpanelClip;
      
      private var _container:MovieClip;
      
      private var _buttonController:ButtonControllerBase;
      
      public function BossRewardsSubpanel(param1:BossRewardSubpanelClip)
      {
         super();
         this._clip = param1;
         this._buttonController = new ButtonControllerBase(this._clip);
         this._container = this._clip.rewardItemContainer;
         this._clip.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BossMilestonesRewardPanel = TownUI.getInstance().gameEventsUIManager.bossMilestonesPanel;
         PanelManager.getInstance().showFreePanel(_loc2_);
      }
      
      public function build(param1:Array, param2:int) : void
      {
         var _loc4_:Object = null;
         var _loc7_:RewardItem = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         this._clip.maxRewardAchieved.visible = false;
         this._container.removeChildren();
         var _loc3_:int = param1[param1.length - 1].tier;
         if(param2 > _loc3_)
         {
            this._clip.maxRewardAchieved.visible = true;
            this._clip.messageField.text = "";
            this._clip.levelField.text = "";
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            if(_loc4_.tier >= param2)
            {
               break;
            }
            _loc5_++;
         }
         this._clip.messageField.text = "Next Reward";
         this._clip.levelField.text = "At level " + _loc4_.tier;
         var _loc6_:Array = [];
         for(_loc8_ in _loc4_.rewards)
         {
            _loc12_ = _loc4_.rewards[_loc8_];
            _loc7_ = new RewardItem(_loc8_,_loc12_);
            _loc6_.push(_loc7_);
         }
         _loc6_.sortOn("sortIndex");
         _loc9_ = 35;
         _loc10_ = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc11_];
            _loc7_.y = _loc10_;
            _loc10_ = _loc10_ + _loc9_;
            this._container.addChild(_loc7_);
            _loc11_++;
         }
      }
   }
}
