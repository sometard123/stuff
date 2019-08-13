package ninjakiwi.monkeyTown.town.ui.contestedTerritory
{
   import assets.ui.CTEventsModuleLarge;
   import assets.ui.CTEventsModuleSmall;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   
   public class ContestedTerritoryEventsModule
   {
       
      
      private var _clipSmall:CTEventsModuleSmall;
      
      private var _clipLarge:CTEventsModuleLarge;
      
      private var _buttonContainerSmall:MovieClip;
      
      private var _buttonContainerLarge:MovieClip;
      
      private var previousActiveEventIDs:Array;
      
      private var refreshTimer:Timer;
      
      public function ContestedTerritoryEventsModule(param1:CTEventsModuleSmall, param2:CTEventsModuleLarge)
      {
         this.previousActiveEventIDs = [];
         this.refreshTimer = new Timer(1000 * 5);
         super();
         this._clipSmall = param1;
         this._clipLarge = param2;
         this._buttonContainerSmall = this._clipSmall.buttonContainer;
         this._buttonContainerLarge = this._clipLarge.buttonContainer;
         GameEventManager.gameEventManagerReadySignal.add(this.setUp);
         this.refreshTimer.addEventListener(TimerEvent.TIMER,this.onRefreshTimerTick);
      }
      
      private function onRefreshTimerTick(param1:TimerEvent) : void
      {
         this.refresh();
      }
      
      public function refresh() : void
      {
         this.setUp();
      }
      
      public function activate() : void
      {
         this.refresh();
         this.refreshTimer.start();
      }
      
      public function deactivate() : void
      {
         this.refreshTimer.stop();
         this.previousActiveEventIDs.length = 0;
      }
      
      private function previousActiveEventsAreTheSame(param1:Array) : Boolean
      {
         var _loc3_:GameplayEvent = null;
         var _loc4_:String = null;
         if(param1.length !== this.previousActiveEventIDs.length)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = _loc3_.type;
            if(_loc4_ !== this.previousActiveEventIDs[_loc2_])
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function setUp() : void
      {
         var _loc9_:int = 0;
         var _loc10_:GameplayEvent = null;
         var _loc11_:String = null;
         var _loc1_:Array = GameEventManager.getInstance().getActiveEvents();
         var _loc2_:* = ResourceStore.getInstance().townLevel >= ContestedTerritoryPanel.CONTESTED_TERRITORY_LEVEL_REQUIREMENT;
         if(_loc1_.length < 1 || !_loc2_)
         {
            this._clipSmall.visible = false;
            this._clipLarge.visible = false;
            return;
         }
         if(this.previousActiveEventsAreTheSame(_loc1_))
         {
            return;
         }
         this._clipSmall.visible = false;
         this._clipLarge.visible = false;
         while(this._buttonContainerSmall.numChildren > 0)
         {
            this._buttonContainerSmall.removeChildAt(0);
         }
         while(this._buttonContainerLarge.numChildren > 0)
         {
            this._buttonContainerLarge.removeChildAt(0);
         }
         this.previousActiveEventIDs.length = 0;
         var _loc3_:int = 60;
         var _loc4_:DisplayObject = null;
         var _loc5_:Array = [];
         var _loc6_:MovieClip = this._buttonContainerSmall;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_.length)
         {
            if("ctMilestones" == _loc1_[_loc9_].type || "ctOccupation" == _loc1_[_loc9_].type)
            {
               _loc7_++;
            }
            _loc8_++;
         }
         this._clipSmall.visible = false;
         this._clipLarge.visible = false;
         if(_loc7_ == 1)
         {
            this._clipSmall.visible = true;
            _loc6_ = this._buttonContainerSmall;
         }
         else if(_loc7_ > 1)
         {
            this._clipLarge.visible = true;
            _loc6_ = this._buttonContainerLarge;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc1_.length)
         {
            _loc10_ = _loc1_[_loc9_];
            _loc11_ = _loc10_.type;
            this.previousActiveEventIDs.push(_loc11_);
            switch(_loc11_)
            {
               case "ctMilestones":
                  _loc4_ = new CTEventRewardsButtonMilestone();
                  _loc4_.y = _loc9_ * _loc3_;
                  _loc5_.push(_loc4_);
                  _loc6_.addChild(_loc4_);
                  break;
               case "ctOccupation":
                  _loc4_ = new CTOccupationRewardsButtonMilestone();
                  _loc4_.y = _loc9_ * _loc3_;
                  _loc5_.push(_loc4_);
                  _loc6_.addChild(_loc4_);
            }
            _loc9_++;
         }
      }
   }
}
