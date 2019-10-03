package ninjakiwi.monkeyTown.town.ui.helpFromFriends
{
   import assets.ui.SendCratePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.NotEnoughBloonstonesPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesAvailableIndicator;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class SendCratePanel extends CratePanelBase
   {
      
      public static var forceError:Boolean = false;
       
      
      private var _clip:SendCratePanelClip;
      
      protected var _cancelButton:ButtonControllerBase;
      
      protected var _sendCratesButton:ButtonControllerBase;
      
      protected var _sendMoreButton:ButtonControllerBase;
      
      private var _cratesAvailableIndicator:CratesAvailableIndicator;
      
      private var _notEnoughBloonstonesPanel:NotEnoughBloonstonesPanel;
      
      public function SendCratePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new SendCratePanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._sendCratesButton = new ButtonControllerBase(this._clip.sendCratesButton);
         this._sendMoreButton = new ButtonControllerBase(this._clip.sendMoreButton);
         this._cratesAvailableIndicator = new CratesAvailableIndicator(this._clip.crateIndicator);
         super(param1,param2);
      }
      
      override protected function init() : void
      {
         super.init();
         setClip(this._clip);
         this.initButtons();
         this.syncToCrateManager();
         this.syncCratesAvailableMessage(true);
         this.syncSendButtons();
         CrateManager.dataChangedSignal.add(this.syncToCrateManager);
         UserDataLoader.friendGroupDataLoaded.add(this.onFriendGroupDataLoadedSignal);
         this.syncSendButtonToSelection();
         this._notEnoughBloonstonesPanel = new NotEnoughBloonstonesPanel(TownUI.getInstance().popupLayer);
      }
      
      private function onFriendGroupDataLoadedSignal() : void
      {
         if(isRevealed)
         {
            this.syncToCrateManager();
         }
      }
      
      public function initButtons() : void
      {
         this._cancelButton.setClickFunction(hide);
         this._sendCratesButton.setClickFunction(this.sendCrates);
         this._sendMoreButton.setClickFunction(this.buyMoreCrateSends);
      }
      
      private function sendCrates() : void
      {
         var _loc1_:Array = getSelectedFriends();
         _crateManager.sendCrates(_loc1_,this.onCratesSent);
         deselectAllInfoboxes();
         this.syncToCrateManager();
         hide();
      }
      
      private function onCratesSent(param1:Object) : void
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         if(SendCratePanel.forceError)
         {
            param1 = {
               "success":false,
               "remainingSends":2,
               "report":{
                  "8235272":false,
                  "8235273":true,
                  "8235274":false
               }
            };
         }
         if(false == param1.hasOwnProperty("report"))
         {
            MonkeyCityMain.getInstance().ui.showCratesSentPanel();
            return;
         }
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:Boolean = false;
         for(_loc4_ in param1.report)
         {
            _loc5_ = param1.report[_loc4_];
            if(_loc5_ == false)
            {
               _loc2_.push(_loc4_);
               _loc3_ = true;
            }
         }
         CrateManager.getInstance().returnSentCrates(_loc2_.length);
         if(_loc3_)
         {
            MonkeyCityMain.getInstance().ui.showCratesReturnedPanel(_loc2_);
         }
         else
         {
            MonkeyCityMain.getInstance().ui.showCratesSentPanel();
         }
      }
      
      private function buyMoreCrateSends() : void
      {
         var resourceStore:ResourceStore = ResourceStore.getInstance();
         if(resourceStore.bloonstones < CrateManager.BLOONSTONE_COST_FOR_EXTRA_SENDS)
         {
            this._notEnoughBloonstonesPanel.setRequiredBloonstones(CrateManager.BLOONSTONE_COST_FOR_EXTRA_SENDS - ResourceStore.getInstance().bloonstones,"to purchase more crates");
            this._clip.visible = false;
            this._notEnoughBloonstonesPanel.onHideSignal.addOnce(function(... rest):void
            {
               _clip.visible = true;
            });
            PanelManager.getInstance().showPanel(this._notEnoughBloonstonesPanel);
            return;
         }
         setLoadingState(true);
         _crateManager.buyMoreCrateSends(function(param1:Object):void
         {
            setLoadingState(false);
            syncToCrateManager();
         });
      }
      
      override protected function syncToCrateManager() : void
      {
         var _loc2_:FriendCrateInfoBox = null;
         var _loc3_:CrateStruct = null;
         var _loc8_:int = 0;
         var _loc1_:Array = _crateManager.getSent();
         _maxAllowedSelectedCrates = _crateManager.crateSendsRemaining;
         this._cratesAvailableIndicator.setSelected(_maxAllowedSelectedCrates);
         this._clip.crateCount.text = "Send " + _maxAllowedSelectedCrates + "/3 Supply Crates:";
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
               if(_loc2_.userID === _loc3_.receiver)
               {
                  _loc2_.sortOrder = 1;
                  _loc2_.setSentCrateMessage();
                  _loc2_.crateSent = true;
                  _loc2_.setTickboxVisible(false);
                  _loc2_.locked = true;
               }
               _loc8_++;
            }
            if(!_loc2_.crateSent && _crateManager.hasRequestedCrate(_loc2_.userID))
            {
               _loc2_.setWantsCrateMessage(true);
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
      }
      
      private function setMaxBoxesAreSentUIState(param1:Boolean) : void
      {
         this._sendCratesButton.target.visible = !param1;
         this._sendMoreButton.target.visible = param1;
      }
      
      private function syncSendButtons() : void
      {
         this._sendCratesButton.unlock(1);
         this._sendCratesButton.target.visible = true;
         this._sendMoreButton.target.visible = false;
      }
      
      private function syncCratesAvailableMessage(param1:Boolean) : void
      {
         this._clip.cantSendCrateTxt.visible = !param1;
         this._clip.requestTxt.visible = param1;
      }
      
      private function syncSendButtonToSelection() : void
      {
         var _loc1_:Array = getSelectedFriends();
         if(_loc1_.length > 0)
         {
            this._sendCratesButton.unlock(1);
         }
         else
         {
            this._sendCratesButton.lock(3);
         }
      }
      
      override protected function onInfoBoxSelectedSignal(param1:FriendCrateInfoBox) : void
      {
         super.onInfoBoxSelectedSignal(param1);
         this.syncSendButtonToSelection();
      }
      
      override protected function onInfoBoxDeselectedSignal(param1:FriendCrateInfoBox) : void
      {
         super.onInfoBoxDeselectedSignal(param1);
         this.syncSendButtonToSelection();
      }
      
      override protected function setGreyOut(param1:Boolean) : void
      {
         super.setGreyOut(param1);
         if(param1)
         {
            this._sendCratesButton.lock(3);
         }
         else
         {
            this._sendCratesButton.unlock(1);
         }
      }
   }
}
