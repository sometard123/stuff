package ninjakiwi.monkeyTown.town.ui.helpFromFriends
{
   import assets.ui.RequestSupplyDropPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesAvailableIndicator;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class RequestCratePanel extends CratePanelBase
   {
       
      
      private var _clip:RequestSupplyDropPanelClip;
      
      protected var _cancelButton:ButtonControllerBase;
      
      protected var _requestButton:ButtonControllerBase;
      
      private var _cratesAvailableIndicator:CratesAvailableIndicator;
      
      public function RequestCratePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new RequestSupplyDropPanelClip();
         this._cratesAvailableIndicator = new CratesAvailableIndicator(this._clip.crateIndicator);
         super(param1,param2);
      }
      
      override protected function init() : void
      {
         super.init();
         isModal = true;
         setClip(this._clip);
         this.initButtons();
         this.syncToCrateManager();
         LoginSignals.userHasLoggedIn.add(refreshFriendsList);
         setAutoPlayStopClipsArray([this._clip.dude]);
         UserDataLoader.friendGroupDataLoaded.add(this.onFriendGroupDataLoadedSignal);
         this.syncSendButtonToSelection();
      }
      
      private function initButtons() : void
      {
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._requestButton = new ButtonControllerBase(this._clip.requestButton);
         this._requestButton.setClickFunction(this.onSendRequestButtonClick);
         this._cancelButton.setClickFunction(hide);
      }
      
      private function onSendRequestButtonClick() : void
      {
         CrateManager.getInstance().requestCrates(getSelectedFriends());
         deselectAllInfoboxes();
         this.syncToCrateManager();
         MonkeyCityMain.getInstance().ui.showCrateRequestSentPanel();
         hide();
      }
      
      private function onFriendGroupDataLoadedSignal() : void
      {
         if(isRevealed)
         {
            this.syncToCrateManager();
         }
      }
      
      override protected function syncToCrateManager() : void
      {
         var _loc2_:FriendCrateInfoBox = null;
         var _loc3_:CrateStruct = null;
         var _loc8_:int = 0;
         var _loc1_:Array = _crateManager.getRequested();
         _maxAllowedSelectedCrates = _crateManager.crateRequestsRemaining;
         this._cratesAvailableIndicator.setSelected(_maxAllowedSelectedCrates);
         this._clip.crateCount.text = "You have " + _maxAllowedSelectedCrates + "/3 requests left:";
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _infoBoxes.length)
         {
            _loc2_ = _infoBoxes[_loc5_];
            _loc2_.setState("");
            if(_loc2_.isSelected)
            {
               _loc4_.push(_loc2_);
            }
            _loc2_.locked = false;
            _loc2_.setCrateMessageVisible(false);
            if(_loc2_.friend.cities !== null && _loc2_.friend.cities.length > 0)
            {
               _loc2_.setTickboxVisible(true);
               _loc2_.locked = false;
            }
            else
            {
               _loc2_.setTickboxVisible(false);
               _loc2_.locked = true;
            }
            _loc2_.sortOrder = -1;
            _loc8_ = 0;
            while(_loc8_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc8_];
               if(_loc2_.userID === _loc3_.sender)
               {
                  _loc2_.sortOrder = 1;
                  _loc2_.setRequestSentMessage();
                  _loc2_.setTickboxVisible(false);
                  _loc2_.locked = true;
               }
               _loc8_++;
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc6_];
            _loc2_.setSelected(true,false);
            _loc6_++;
         }
         sortInfoBoxes();
         var _loc7_:Boolean = checkIfMaxBoxesAreSelected();
         this.setMaxBoxesAreSentUIState(_crateManager.crateSendsRemaining === 0);
         this.syncSendButtonToSelection();
         this.syncMessages();
      }
      
      private function syncMessages() : void
      {
         this._clip.cratesInInventoryMessage.visible = false;
         this._clip.maxRequestsMessage.visible = false;
         this._clip.requestTxt.visible = false;
         if(_crateManager.cratesAvailable() > 0)
         {
            this._clip.cratesInInventoryMessage.visible = true;
         }
         else if(_crateManager.crateRequestsRemaining > 0)
         {
            this._clip.requestTxt.visible = true;
         }
         else
         {
            this._clip.maxRequestsMessage.visible = true;
         }
      }
      
      private function setMaxBoxesAreSentUIState(param1:Boolean) : void
      {
         if(param1)
         {
            this._requestButton.lock(3);
         }
         else
         {
            this._requestButton.unlock(1);
         }
         if(param1)
         {
            this._clip.requestTxt.visible = false;
            this._clip.maxRequestsMessage.visible = true;
         }
         else
         {
            this._clip.requestTxt.visible = true;
            this._clip.maxRequestsMessage.visible = false;
         }
      }
      
      override protected function setGreyOut(param1:Boolean) : void
      {
         super.setGreyOut(param1);
         if(param1)
         {
            this._requestButton.lock(3);
         }
         else
         {
            this._requestButton.unlock(1);
         }
      }
      
      private function syncSendButtonToSelection() : void
      {
         var _loc1_:Array = getSelectedFriends();
         if(_loc1_.length > 0)
         {
            this._requestButton.unlock(1);
         }
         else
         {
            this._requestButton.lock(3);
         }
      }
      
      override protected function onInfoBoxSelectedSignal(param1:FriendCrateInfoBox) : void
      {
         if(!isRevealed)
         {
            return;
         }
         super.onInfoBoxSelectedSignal(param1);
         this.syncSendButtonToSelection();
      }
      
      override protected function onInfoBoxDeselectedSignal(param1:FriendCrateInfoBox) : void
      {
         if(!isRevealed)
         {
            return;
         }
         super.onInfoBoxDeselectedSignal(param1);
         this.syncSendButtonToSelection();
      }
   }
}
