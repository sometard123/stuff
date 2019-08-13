package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import assets.ui.SupplyDropFailPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class CratesReturnedPanel extends HideRevealView
   {
       
      
      private var _clip:SupplyDropFailPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _idsOfUsernamesToLoad:Vector.<String>;
      
      private var _usernamesLoaded:Vector.<String>;
      
      private var _text:TextField;
      
      private var _onAllUsersLoadedCallback:Function;
      
      public function CratesReturnedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new SupplyDropFailPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._idsOfUsernamesToLoad = new Vector.<String>();
         this._usernamesLoaded = new Vector.<String>();
         this._text = this._clip.text;
         super(param1,param2);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
         addChild(this._clip);
      }
      
      public function populateInfo(param1:Vector.<String>, param2:Function) : void
      {
         this._idsOfUsernamesToLoad = param1;
         this._onAllUsersLoadedCallback = param2;
         this._usernamesLoaded.length = 0;
         this.loadNextUsername();
      }
      
      private function loadNextUsername() : void
      {
         var _loc1_:String = this._idsOfUsernamesToLoad[this._usernamesLoaded.length];
         FriendsManager.getInstance().getUserNameByID(_loc1_,this.onUsernameLoaded);
      }
      
      private function onUsernameLoaded(param1:String) : void
      {
         this._usernamesLoaded.push(param1);
         if(this._usernamesLoaded.length == this._idsOfUsernamesToLoad.length)
         {
            this.onAllUsernamesLoaded();
         }
         else
         {
            this.loadNextUsername();
         }
      }
      
      private function onAllUsernamesLoaded() : void
      {
         if(this._usernamesLoaded.length == 1)
         {
            this._text.text = LocalisationConstants.CRATES_RETURNED_1.split("<friend>").join(this._usernamesLoaded[0]);
         }
         else if(this._usernamesLoaded.length == 2)
         {
            this._text.text = LocalisationConstants.CRATES_RETURNED_2.split("<friend1>").join(this._usernamesLoaded[0]).split("<friend2>").join(this._usernamesLoaded[1]);
         }
         else if(this._usernamesLoaded.length == 3)
         {
            this._text.text = LocalisationConstants.CRATES_RETURNED_3.split("<friend1>").join(this._usernamesLoaded[0]).split("<friend2>").join(this._usernamesLoaded[1]).split("<friend3>").join(this._usernamesLoaded[2]);
         }
         this._onAllUsersLoadedCallback();
      }
   }
}
