package ninjakiwi.monkeyTown.town.ui.helpFromFriends
{
   import assets.ui.FriendCrateInfoBoxClip;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class FriendCrateInfoBox extends InfoBoxBase
   {
      
      public static const selectedSignal:PrioritySignal = new PrioritySignal(FriendCrateInfoBox);
      
      public static const deselectedSignal:Signal = new Signal(FriendCrateInfoBox);
       
      
      private var _clip:FriendCrateInfoBoxClip;
      
      private var _greyOut:MovieClip;
      
      private var _selectedTick:MovieClip;
      
      public var sortOrder:int = -1;
      
      public var crateSent:Boolean = false;
      
      public function FriendCrateInfoBox()
      {
         this._clip = new FriendCrateInfoBoxClip();
         this._greyOut = this._clip.greyOut;
         this._selectedTick = this._clip.selectedTick;
         super();
         this.init();
      }
      
      private function init() : void
      {
         setClip(this._clip);
         _selectionGroupID = "pvpInfoBox";
         this._greyOut.visible = false;
         this._selectedTick.visible = false;
         this._clip.crateStatusMessage.visible = false;
         this.setState("");
      }
      
      public function setGreyout(param1:Boolean) : void
      {
         this._greyOut.visible = param1;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(_locked)
         {
            return;
         }
         this.setSelected(!_isSelected);
      }
      
      override public function setSelected(param1:Boolean, param2:Boolean = true) : void
      {
         this._selectedTick.visible = param1;
         _isSelected = param1;
         if(param2)
         {
            if(param1)
            {
               FriendCrateInfoBox.selectedSignal.dispatch(this);
            }
            else
            {
               FriendCrateInfoBox.deselectedSignal.dispatch(this);
            }
         }
      }
      
      public function setWantsCrateMessage(param1:Boolean = true) : void
      {
         if(param1)
         {
            this._clip.crateStatusMessage.gotoAndStop(1);
         }
         this._clip.crateStatusMessage.visible = param1;
      }
      
      public function setSentCrateMessage() : void
      {
         this._clip.crateStatusMessage.gotoAndStop(3);
         this._clip.crateStatusMessage.visible = true;
      }
      
      public function setRequestSentMessage() : void
      {
         this._clip.crateStatusMessage.gotoAndStop(4);
         this._clip.crateStatusMessage.visible = true;
      }
      
      public function setCrateMessageVisible(param1:Boolean) : void
      {
         this._clip.crateStatusMessage.visible = param1;
      }
      
      public function setTickboxVisible(param1:Boolean = true) : void
      {
         this._clip.tickboxBackground.visible = param1;
         locked = true;
      }
      
      override protected function processViewClip(param1:MovieClip) : void
      {
         super.processViewClip(param1);
         _levelField.visible = false;
         _honorField.visible = false;
         this._clip.levelIcon.visible = false;
         this._clip.honourSymbol.visible = false;
         this._clip.crateStatusMessage.gotoAndStop(1);
      }
      
      override public function syncToOpponent(param1:Friend, param2:int) : void
      {
         super.syncToOpponent(param1,param2);
         if(param2 >= 0 && param1.cities !== null && param1.cities.length > 0)
         {
            this.setTickboxVisible(true);
            locked = false;
         }
         else
         {
            this.setTickboxVisible(false);
            locked = true;
         }
      }
      
      override public function showNotPlayingMessage() : void
      {
         super.showNotPlayingMessage();
         this.setTickboxVisible(false);
      }
      
      override public function setState(param1:String = "") : void
      {
         this._clip.stateText.text = param1;
      }
      
      override public function populateAdditionalDeferredData(param1:Object) : void
      {
         super.populateAdditionalDeferredData(param1);
         _viewClip.levelIcon.visible = false;
         _viewClip.cityLevelField.visible = false;
         _viewClip.honourSymbol.visible = false;
         _viewClip.honorField.visible = false;
      }
   }
}
