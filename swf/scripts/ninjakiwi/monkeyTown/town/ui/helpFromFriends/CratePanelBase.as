package ninjakiwi.monkeyTown.town.ui.helpFromFriends
{
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class CratePanelBase extends HideRevealView
   {
      
      public static const Y_STEP:int = 50;
       
      
      private var _clip:MovieClip = null;
      
      protected var _listMask:MovieClip;
      
      protected var _friendsListContainer:MovieClip;
      
      protected var _friendsScrollBar:ScrollBar;
      
      protected var _infoBoxes:Array;
      
      protected var _selectedInfoBoxes:Array;
      
      protected var _maxAllowedSelectedCrates:int = 3;
      
      protected var _blocker:MovieClip = null;
      
      protected const _crateManager:CrateManager = CrateManager.getInstance();
      
      private var _scrollTimeout:uint = 0;
      
      private var boxDataLoader:UserDataLoader;
      
      public function CratePanelBase(param1:DisplayObjectContainer, param2:* = null)
      {
         this._infoBoxes = [];
         this._selectedInfoBoxes = [];
         this.boxDataLoader = UserDataLoader.getInstance();
         super(param1,param2);
         CrateManager.crateManagerDataSetSignal.addOnce(this.init);
      }
      
      protected function init() : void
      {
         isModal = true;
         uiMutexGroup = "mainUIPanel";
         autocloseMutexSiblings = true;
         FriendCrateInfoBox.selectedSignal.addWithPriority(this.onInfoBoxSelectedSignal,-10000);
         FriendCrateInfoBox.deselectedSignal.add(this.onInfoBoxDeselectedSignal);
         CrateManager.startRefreshingDataSignal.add(this.onBeginRefreshingSignal);
         CrateManager.endRefreshingDataSignal.add(this.onEndRefreshingSignal);
      }
      
      private function onBeginRefreshingSignal() : void
      {
         this.setLoadingState(true);
      }
      
      private function onEndRefreshingSignal() : void
      {
         this.setLoadingState(false);
         this.syncToCrateManager();
      }
      
      public function setClip(param1:MovieClip) : void
      {
         this._clip = param1;
         this._listMask = this._clip.playerMask;
         this._friendsListContainer = this._clip.playerListContainer;
         this._friendsListContainer.x = this._listMask.x;
         this._friendsListContainer.y = this._listMask.y;
         this._friendsListContainer.mask = this._listMask;
         this._friendsScrollBar = new ScrollBar(this._clip.scrollbar,this._friendsListContainer,this._listMask,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         this._friendsScrollBar.onScrollSignal.add(this.onScroll);
         this._blocker = this._clip.loadingBlocker;
         this.setLoadingState(false);
         enableDefaultOnResize(this._clip,new Rectangle(0,0,this._clip.resizeRectangle.width,this._clip.resizeRectangle.height));
         addChild(this._clip);
      }
      
      protected function setLoadingState(param1:Boolean) : void
      {
         if(param1)
         {
            this._clip.addChild(this._blocker);
            LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._blocker,true);
         }
         else if(this._clip.contains(this._blocker))
         {
            this._clip.removeChild(this._blocker);
            LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._blocker,false);
         }
      }
      
      protected function clearInfoBoxes() : void
      {
         while(this._friendsListContainer.numChildren > 0)
         {
            this._friendsListContainer.removeChildAt(0);
         }
      }
      
      protected function refreshFriendsList() : void
      {
         var i:int = 0;
         FriendsManager.getInstance().loadFriendsList(function(param1:Array):void
         {
            var _loc2_:Friend = null;
            var _loc3_:Object = null;
            var _loc4_:FriendCrateInfoBox = null;
            _infoBoxes.length = 0;
            i = 0;
            while(i < param1.length)
            {
               _loc4_ = new FriendCrateInfoBox();
               _loc2_ = param1[i];
               _loc4_.syncToOpponent(_loc2_,-1);
               _infoBoxes.push(_loc4_);
               i++;
            }
            sortInfoBoxes();
            checkForUnloadedInfoPanels();
            checkIfMaxBoxesAreSelected();
            if(_infoBoxes.length == 0)
            {
            }
            syncToCrateManager();
         });
      }
      
      protected function sortInfoBoxes() : void
      {
         var _loc1_:int = 0;
         var _loc3_:FriendCrateInfoBox = null;
         var _loc2_:int = 0;
         this.clearInfoBoxes();
         this._infoBoxes.sortOn(["playerName"],Array.CASEINSENSITIVE);
         _loc1_ = 0;
         while(_loc1_ < this._infoBoxes.length)
         {
            _loc3_ = this._infoBoxes[_loc1_];
            _loc3_.y = _loc2_;
            _loc3_.setBackground(_loc1_ % 2 === 0);
            this._friendsListContainer.addChild(_loc3_);
            _loc2_ = _loc2_ + Y_STEP;
            _loc1_++;
         }
      }
      
      protected function setScrollInfoBoxByLetter(param1:String) : InfoBoxBase
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         param1 = param1.charAt(0).toLowerCase();
         var _loc2_:InfoBoxBase = null;
         _loc3_ = 0;
         while(_loc3_ < this._infoBoxes.length)
         {
            _loc2_ = this._infoBoxes[_loc3_];
            _loc4_ = _loc2_.friend.name.charAt(0).toLowerCase();
            if(_loc4_ === param1)
            {
               break;
            }
            _loc2_ = null;
            _loc3_++;
         }
         if(_loc2_ !== null)
         {
            this._friendsScrollBar.setScrollPosition(_loc2_.y);
         }
         return _loc2_;
      }
      
      private function onScroll() : void
      {
         clearTimeout(this._scrollTimeout);
         this._scrollTimeout = setTimeout(this.checkForUnloadedInfoPanels,1000);
      }
      
      private function checkForUnloadedInfoPanels() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:InfoBoxBase = null;
         var _loc1_:Array = [];
         var _loc4_:int = this._clip.playerMask.height;
         var _loc5_:int = this._friendsScrollBar.scrollPosition;
         var _loc6_:int = 0;
         while(_loc6_ < this._friendsListContainer.numChildren)
         {
            _loc2_ = this._friendsListContainer.getChildAt(_loc6_);
            if(_loc2_ is InfoBoxBase)
            {
               _loc3_ = InfoBoxBase(_loc2_);
               if(_loc3_.y + _loc3_.height > _loc5_ && _loc3_.y < _loc5_ + _loc4_)
               {
                  if(!_loc3_.isInitialised)
                  {
                     _loc1_.push(_loc3_);
                     _loc3_.setState(LocalisationConstants.STRING_OPPONENT_LOADING);
                  }
               }
            }
            _loc6_++;
         }
         this.boxDataLoader.addBoxSet(_loc1_);
      }
      
      protected function checkIfMaxBoxesAreSelected() : Boolean
      {
         if(this._selectedInfoBoxes.length >= this._maxAllowedSelectedCrates)
         {
            this.setGreyOut(true);
            return true;
         }
         this.setGreyOut(false);
         return false;
      }
      
      protected function onInfoBoxSelectedSignal(param1:FriendCrateInfoBox) : void
      {
         this._selectedInfoBoxes = this.getSelectedFriends();
         this.checkIfMaxBoxesAreSelected();
      }
      
      protected function onInfoBoxDeselectedSignal(param1:FriendCrateInfoBox) : void
      {
         if(!isRevealed)
         {
            return;
         }
         this._selectedInfoBoxes = this.getSelectedFriends();
         this.checkIfMaxBoxesAreSelected();
      }
      
      public function getSelectedFriends() : Array
      {
         var _loc1_:FriendCrateInfoBox = null;
         var _loc2_:Friend = null;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < this._infoBoxes.length)
         {
            _loc1_ = this._infoBoxes[_loc4_];
            if(_loc1_.isSelected)
            {
               _loc3_.push(_loc1_.friend.userID);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function deselectAllInfoboxes() : void
      {
         var _loc1_:FriendCrateInfoBox = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._infoBoxes.length)
         {
            _loc1_ = this._infoBoxes[_loc2_];
            if(_loc1_.isSelected)
            {
               _loc1_.setSelected(false,false);
            }
            _loc2_++;
         }
         this._selectedInfoBoxes.length = 0;
      }
      
      protected function setGreyOut(param1:Boolean) : void
      {
         var _loc2_:FriendCrateInfoBox = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._infoBoxes.length)
         {
            _loc2_ = this._infoBoxes[_loc3_];
            if(!_loc2_.isSelected && _loc2_.isPlayingMonkeyCity)
            {
               _loc2_.setGreyout(param1);
               if(_loc2_.isPlayingMonkeyCity && !_loc2_.crateSent)
               {
                  _loc2_.locked = param1;
               }
            }
            _loc3_++;
         }
      }
      
      protected function syncToCrateManager() : void
      {
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         var _loc2_:Boolean = this._crateManager.checkTimeUntilMidnight();
         this.refreshFriendsList();
         this.syncToCrateManager();
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this.deselectAllInfoboxes();
         if(_stage !== null)
         {
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         }
      }
      
      private function onKeyDownHandler(param1:KeyboardEvent) : void
      {
         this.setScrollInfoBoxByLetter(String.fromCharCode(param1.keyCode));
      }
   }
}
