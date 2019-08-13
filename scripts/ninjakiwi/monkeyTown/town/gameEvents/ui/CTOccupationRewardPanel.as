package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.CTRewardsPanelClip_Occupation;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.DateTool;
   
   public class CTOccupationRewardPanel extends HideRevealView
   {
      
      private static var showPanelInBTDGame:Boolean = false;
       
      
      private const _clip:CTRewardsPanelClip_Occupation = new CTRewardsPanelClip_Occupation();
      
      private var _leftButton:ButtonControllerBase;
      
      private var _rightButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      private const _holdTextField:TextField = this._clip.description;
      
      private var _contentContainer:MovieClip;
      
      private var _timerField:TextField;
      
      private var _pastEventLabel:MovieClip;
      
      private var _mask:MovieClip;
      
      private var _effectContainer:Sprite;
      
      private var _rewardInfoBoxes:Vector.<OccupationRewardInfoBox>;
      
      private var _data:Object = null;
      
      private var _rewardIndex:int = 0;
      
      private var _lastKnownHoldTimeForCity:Number = 0;
      
      private var _forceRebuildOfData:Boolean = false;
      
      private var _revealExpiredPanel:Boolean = false;
      
      private const _gameEventManger:GameEventManager = GameEventManager.getInstance();
      
      public function CTOccupationRewardPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         var container:DisplayObjectContainer = param1;
         var mutexGroup:* = param2;
         this._leftButton = new ButtonControllerBase(this._clip.leftArrow);
         this._rightButton = new ButtonControllerBase(this._clip.rightArrow);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._contentContainer = this._clip.contentContainer;
         this._pastEventLabel = this._clip.pastEventLabel;
         this._mask = this._clip.contentMask;
         this._effectContainer = new Sprite();
         this._rewardInfoBoxes = new Vector.<OccupationRewardInfoBox>();
         super(container,mutexGroup);
         this.init();
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
      
      private function init() : void
      {
         BTDView.btdLoadCompleteSignal.addOnce(function():void
         {
            Main.instance.btdView.eventBridge.addEventListener("gameIsReady",onBTDGameReady);
         });
         GameEventManager.gameEventManagerReadySignal.addOnce(function():void
         {
            _gameEventManger.ctOccupationManager.getCTOccupationData(function(param1:Object, param2:Boolean):void
            {
               _data = param1;
               lazyInitialise();
            });
         });
         WorldViewSignals.initialMVMDataReceived.add(function():void
         {
            _forceRebuildOfData = true;
            _revealExpiredPanel = false;
         });
         ContestedTerritoryPanel.updateOccupationSignal.add(this.onUpdateTime);
         ContestedTerritoryPanel.historyFoundSignal.add(this.onCTHistoryFound);
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
      
      private function buildFromData(param1:Boolean = true) : void
      {
         this._gameEventManger.ctOccupationManager.getCTOccupationData(this.onGetCTOccupationData,param1);
         this._forceRebuildOfData = false;
      }
      
      private function buildFromDataBasedOnEventID(param1:String, param2:Boolean = true) : void
      {
         this._gameEventManger.ctOccupationManager.getOccupationDataFromID(this.onGetCTOccupationData,param1,param2);
      }
      
      private function onGetCTOccupationData(param1:Object, param2:Boolean = true) : void
      {
         var _loc10_:Object = null;
         var _loc11_:Number = NaN;
         var _loc12_:OccupationRewardInfoBox = null;
         this._data = param1;
         if(null == this._data)
         {
            return;
         }
         var _loc3_:ContestedTerritoryPanel = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel;
         var _loc4_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc5_:int = 0;
         var _loc6_:int = 133;
         this.lazyInitialise();
         while(this._contentContainer.numChildren > 0)
         {
            this._contentContainer.removeChildAt(0);
         }
         this._rewardInfoBoxes.length = 0;
         if(param2)
         {
            this._lastKnownHoldTimeForCity = this._gameEventManger.ctOccupationManager.getLastKnownHoldTimeForCurrentEvent(_loc4_);
         }
         else
         {
            this._lastKnownHoldTimeForCity = this._gameEventManger.ctOccupationManager.getLastKnownHoldTime(_loc4_);
         }
         var _loc7_:int = 0;
         while(_loc7_ < this._data.timeHeld.length)
         {
            _loc10_ = this._data.timeHeld[_loc7_];
            _loc11_ = _loc10_.timeHeld * OccupationRewardInfoBox.TIME_IN_HOUR_UNIX;
            _loc12_ = new OccupationRewardInfoBox();
            _loc12_.setData(_loc10_,_loc11_,this._lastKnownHoldTimeForCity);
            _loc12_.setEffectContainer(this._effectContainer);
            _loc12_.index = _loc7_;
            _loc12_.x = _loc5_;
            _loc5_ = _loc5_ + _loc6_;
            this._rewardInfoBoxes.push(_loc12_);
            this._contentContainer.addChild(_loc12_);
            _loc7_++;
         }
         var _loc8_:OccupationRewardInfoBox = this._rewardInfoBoxes[this._rewardInfoBoxes.length - 1];
         var _loc9_:Object = this._data.timeHeld[this._data.timeHeld.length - 1];
         _loc8_.setAsLastGoal();
         _loc8_.achieved = this._lastKnownHoldTimeForCity >= _loc8_.achievedAtTime;
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         var _loc2_:GameplayEvent = this._gameEventManger.ctOccupationManager.findCurrentEvent();
         this.lazyInitialise();
         super.reveal(param1);
         Main.instance.btdView.pauseGame();
         if(false == MonkeyCityMain.isInGame)
         {
            this.cycleTo(0,true);
         }
         this.syncAchievedStates();
         if(this._revealExpiredPanel)
         {
            this._pastEventLabel.visible = true;
            this._clip.timeLeftDisplay.visible = false;
            this._revealExpiredPanel = false;
         }
         else
         {
            this._pastEventLabel.visible = false;
            this._clip.timeLeftDisplay.visible = true;
            if(_loc2_ != null)
            {
               this._timerField.text = DateTool.getTimeStringFromUnixTime(_loc2_.endTime - MonkeySystem.getInstance().getSecureTime()).toString();
            }
         }
      }
      
      private function onUpdateTime(param1:Number) : void
      {
         var ctPanel:ContestedTerritoryPanel = null;
         var boxesToAward:Vector.<OccupationRewardInfoBox> = null;
         var timeHeld:Number = param1;
         if(this.isRevealed)
         {
            if(this._forceRebuildOfData)
            {
               this.onHideSignal.remove(this.forceRebuildOfData);
               this.onHideSignal.add(this.forceRebuildOfData);
            }
            return;
         }
         if(false == this.stillValidForEvent())
         {
            return;
         }
         ctPanel = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel;
         if(false == ctPanel.isInContestedTerritory())
         {
            return;
         }
         this.lazyInitialise();
         if(this._forceRebuildOfData)
         {
            this.forceRebuildOfData();
         }
         this.syncAchievedStates();
         boxesToAward = this.getNewRewards(timeHeld);
         if(boxesToAward.length === 0)
         {
            return;
         }
         var cityIndex:int = MonkeySystem.getInstance().city.cityIndex;
         PanelManager.getInstance().showPanel(this);
         var cycleToIndex:int = boxesToAward[0].index - 1;
         if(cycleToIndex < 0)
         {
            cycleToIndex = 0;
         }
         this.cycleTo(cycleToIndex,false);
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
            _lastKnownHoldTimeForCity = ctPanel.myPlayerData.timeHoldingTerritory;
            _gameEventManger.ctOccupationManager.setLastKnownHoldTimeForCurrentEvent(_lastKnownHoldTimeForCity,MonkeySystem.getInstance().city.cityIndex);
         };
         setTimeout(delayed,500);
      }
      
      public function forceRebuildOfData(... rest) : void
      {
         this.onHideSignal.remove(this.forceRebuildOfData);
         this.buildFromData();
      }
      
      public function onCTHistoryFound(param1:Object, param2:Number) : void
      {
         var startTimeOfRoom:Number = NaN;
         var boxesToAward:Vector.<OccupationRewardInfoBox> = null;
         var room:Object = param1;
         var myTimeHeld:Number = param2;
         if(myTimeHeld <= 0)
         {
            return;
         }
         startTimeOfRoom = ContestPanelHelper.getStartTimeOfRoomInHistory(room);
         var occupationEvent:GameplayEvent = this._gameEventManger.ctOccupationManager.findOccupationEvent(startTimeOfRoom);
         if(null == occupationEvent)
         {
            return;
         }
         this.lazyInitialise();
         this.buildFromDataBasedOnEventID(occupationEvent.dataID,false);
         boxesToAward = this.getNewRewards(myTimeHeld);
         if(boxesToAward.length === 0)
         {
            return;
         }
         var cityIndex:int = MonkeySystem.getInstance().city.cityIndex;
         this._revealExpiredPanel = true;
         PanelManager.getInstance().showPanel(this);
         var cycleToIndex:int = boxesToAward[0].index - 1;
         if(cycleToIndex < 0)
         {
            cycleToIndex = 0;
         }
         this.cycleTo(cycleToIndex,false);
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
            _gameEventManger.ctOccupationManager.setLastKnownHoldTime(myTimeHeld,MonkeySystem.getInstance().city.cityIndex);
            _lastKnownHoldTimeForCity = 0;
            _forceRebuildOfData = true;
            onUpdateTime(0);
         };
         setTimeout(delayed,500);
      }
      
      private function findNextUnachievedHoldTime() : Number
      {
         var _loc2_:OccupationRewardInfoBox = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rewardInfoBoxes.length)
         {
            _loc2_ = this._rewardInfoBoxes[_loc1_];
            if(false == _loc2_.achieved)
            {
               return _loc2_.achievedAtTime;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function findIndexOfNextUnachievedHoldTime() : int
      {
         var _loc2_:OccupationRewardInfoBox = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rewardInfoBoxes.length)
         {
            _loc2_ = this._rewardInfoBoxes[_loc1_];
            if(false == _loc2_.achieved)
            {
               return _loc2_.index;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function syncNextGoalMessage() : void
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Number = this.findNextUnachievedHoldTime();
         if(_loc1_ < 0)
         {
            this._holdTextField.text = "All rewards earned!";
         }
         else
         {
            if(_loc1_ >= OccupationRewardInfoBox.TIME_IN_DAY_UNIX)
            {
               _loc3_ = _loc1_ / OccupationRewardInfoBox.TIME_IN_DAY_UNIX;
               _loc2_ = _loc3_.toString() + " day";
               if(_loc3_ != 1)
               {
                  _loc2_ = _loc2_ + "s";
               }
            }
            else
            {
               _loc4_ = _loc1_ / OccupationRewardInfoBox.TIME_IN_HOUR_UNIX;
               _loc2_ = _loc4_.toString() + " hour";
               if(_loc4_ != 1)
               {
                  _loc2_ = _loc2_ + "s";
               }
            }
            this._holdTextField.text = LocalisationConstants.OCCUPATION_HOLD_TERRITORY.split("<time>").join(_loc2_);
         }
      }
      
      private function syncAchievedStates() : void
      {
         var _loc3_:OccupationRewardInfoBox = null;
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
         this.syncNextGoalMessage();
      }
      
      private function getNewRewards(param1:Number) : Vector.<OccupationRewardInfoBox>
      {
         var _loc4_:OccupationRewardInfoBox = null;
         var _loc2_:Vector.<OccupationRewardInfoBox> = new Vector.<OccupationRewardInfoBox>();
         var _loc3_:int = 0;
         while(_loc3_ < this._rewardInfoBoxes.length)
         {
            _loc4_ = this._rewardInfoBoxes[_loc3_];
            if(false == _loc4_.achieved && param1 >= _loc4_.achievedAtTime)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onBTDGameReady(param1:Event) : void
      {
         if(false == showPanelInBTDGame)
         {
            return;
         }
         var _loc2_:GameplayEvent = this._gameEventManger.ctOccupationManager.findCurrentEvent();
         if(false == MonkeyCityMain.getInstance().isContestedTerritory || _loc2_ == null || _loc2_.active !== true)
         {
            return;
         }
         this.onUpdateTime(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel.myPlayerData.timeHoldingTerritory);
         var _loc3_:int = this.findIndexOfNextUnachievedHoldTime() - 2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this.cycleTo(_loc3_,true);
         PanelManager.getInstance().showFreePanel(this);
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
         Main.instance.btdView.unPauseGame();
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardInfoBoxes.length)
         {
            this._rewardInfoBoxes[_loc2_].hideSpecialStateBackgrounds();
            _loc2_++;
         }
      }
      
      private function stillValidForEvent() : Boolean
      {
         var _loc1_:GameplayEvent = this._gameEventManger.ctOccupationManager.findCurrentEvent();
         if(_loc1_ === null || _loc1_.active === false)
         {
            return false;
         }
         return true;
      }
      
      public function test() : void
      {
         this.onUpdateTime(OccupationRewardInfoBox.TIME_IN_DAY_UNIX + this._lastKnownHoldTimeForCity);
      }
      
      public function set lastKnownHoldTimeForCity(param1:Number) : void
      {
         this._lastKnownHoldTimeForCity = param1;
      }
   }
}
