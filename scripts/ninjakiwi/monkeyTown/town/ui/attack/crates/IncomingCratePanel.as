package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import assets.ui.IncomingCratePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.CrateStruct;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class IncomingCratePanel extends HideRevealView
   {
       
      
      private var _clip:IncomingCratePanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _sendButton:ButtonControllerBase;
      
      private var _friendsManager:FriendsManager;
      
      public function IncomingCratePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new IncomingCratePanelClip();
         this._friendsManager = FriendsManager.getInstance();
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      public function init() : void
      {
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._sendButton = new ButtonControllerBase(this._clip.sendButton);
         this._cancelButton.setClickFunction(hide);
         this._sendButton.setClickFunction(this.onSendButtonClicked);
         CrateManager.newIncomingCratesSignal.add(this.onIncomingCrateRequestSignal);
         setAutoPlayStopClipsArray([this._clip.ray]);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
      }
      
      private function onSendButtonClicked() : void
      {
         hide();
         MonkeyCityMain.getInstance().ui.showSendCratePanel();
      }
      
      private function onIncomingCrateRequestSignal(param1:Array) : void
      {
         var _loc2_:CrateStruct = param1[0];
         if(!_loc2_ || !_loc2_.sender)
         {
            return;
         }
         if(_loc2_.sender == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id)
         {
            return;
         }
         var _loc3_:String = _loc2_.senderName;
         if(_loc3_ == null || _loc3_ == "null")
         {
            _loc3_ = "Your friend";
         }
         this._clip.messageField.text = _loc3_ + " sent you a supply Crate. Would you like to send one back?";
         this.reveal();
      }
   }
}
