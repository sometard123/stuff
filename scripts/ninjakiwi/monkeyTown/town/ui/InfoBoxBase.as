package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.InfoBoxBackground;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.pvp.CityMatchMaker;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.InviteUser;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.UIConstants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class InfoBoxBase extends MovieClip
   {
      
      public static const DEFAULT_GROUP:String = "defaultGroup";
      
      protected static var _selectionGroups:Dictionary = new Dictionary();
      
      public static const deferredDataSetSignal:Signal = new Signal(InfoBoxBase);
      
      public static const selectionMadeSignal:Signal = new Signal(String,InfoBoxBase);
      
      public static const STATE_LOADING:String = "loading";
       
      
      public var isInitialised:Boolean = false;
      
      public var isPlayingMonkeyCity:Boolean = false;
      
      private var _honourModule:HonourDisplayModule;
      
      private var _playerName:String;
      
      public var cityIndex:int = 0;
      
      protected var _viewClip:MovieClip;
      
      protected var _clanHolder:MovieClip;
      
      protected var _levelField:TextField;
      
      protected var _honorField:TextField;
      
      protected var _playerNameField:TextField;
      
      protected var _selectedBG:MovieClip;
      
      protected var _rolloverBG:MovieClip;
      
      protected var _selectionGroupID:String = "defaultGroup";
      
      protected var _locked:Boolean = false;
      
      protected var _friend:Friend;
      
      protected var _isSelected:Boolean = false;
      
      protected var _inviteButton:ButtonControllerBase;
      
      public function InfoBoxBase()
      {
         super();
      }
      
      public static function getSelected(param1:String = "defaultGroup") : InfoBoxBase
      {
         return _selectionGroups[param1];
      }
      
      public static function clearSelectedForAllGroups() : void
      {
         var _loc1_:* = null;
         var _loc2_:InfoBoxBase = null;
         for(_loc1_ in _selectionGroups)
         {
            _loc2_ = _selectionGroups[_loc1_];
            if(_loc2_)
            {
               _loc2_.setSelected(false);
               delete _selectionGroups[_loc1_];
            }
         }
      }
      
      public static function clearSelected(param1:String) : void
      {
         var _loc2_:InfoBoxBase = _selectionGroups[param1];
         if(_loc2_)
         {
            _loc2_.setSelected(false);
            delete _selectionGroups[param1];
         }
      }
      
      protected function setClip(param1:*) : void
      {
         this._viewClip = param1;
         this.processViewClip(this._viewClip);
         this._viewClip.addEventListener(MouseEvent.CLICK,this.onClick);
         this._viewClip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._viewClip.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
         this._selectedBG.visible = false;
         this._rolloverBG.visible = false;
         if(this._viewClip.hasOwnProperty("inviteButton"))
         {
            this._viewClip.inviteButton.visible = false;
         }
         addChild(param1);
      }
      
      protected function processViewClip(param1:MovieClip) : void
      {
         this._clanHolder = param1.clanHolder;
         this._levelField = this._viewClip.cityLevelField;
         this._honorField = this._viewClip.honorField;
         this._playerNameField = param1.nameField;
         this._selectedBG = param1.selectedBG;
         this._rolloverBG = param1.rolloverBG;
         this._honourModule = new HonourDisplayModule(param1.honourSymbol,param1.honorField);
         while(this._clanHolder.numChildren > 0)
         {
            this._clanHolder.removeChildAt(0);
         }
         if(this._viewClip.hasOwnProperty("inviteButton"))
         {
            this._inviteButton = new ButtonControllerBase(this._viewClip.inviteButton);
            this._inviteButton.setClickFunction(this.onInvite);
         }
         else
         {
            this._inviteButton = new ButtonControllerBase(new MovieClip());
         }
      }
      
      private function onInvite() : void
      {
         QuestCounter.getInstance().setCustomValue("invite_" + this._friend.userID,getTimer());
         InviteUser.invite(this._friend.name);
         if(!Kong.isOnKong())
         {
            this._inviteButton.lock(3);
         }
      }
      
      protected function onRollover(param1:MouseEvent) : void
      {
         if(this._locked)
         {
            return;
         }
         this._rolloverBG.visible = true;
      }
      
      protected function onRollout(param1:MouseEvent) : void
      {
         if(this._locked)
         {
            return;
         }
         this._rolloverBG.visible = false;
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(this._locked)
         {
            return;
         }
         this.setSelected(true);
      }
      
      public function syncToOpponent(param1:Friend, param2:int) : void
      {
         this.cityIndex = param2;
         this._friend = param1;
         this._playerName = param1.name;
         this._playerNameField.text = this._playerName;
         if(param2 >= 0 && param1.cities && param1.cities.length > 0)
         {
            this._honorField.text = PvPMain.getMatchingCity(param1.cities,param2).honour.toString();
         }
         this.setClan(param1.clan);
         UserDataLoader.getInstance().populateWithCachedData(this);
      }
      
      public function setClan(param1:String) : void
      {
         while(this._clanHolder.numChildren > 0)
         {
            this._clanHolder.removeChildAt(0);
         }
         this._clanHolder.addChild(UIConstants.getClanIconSmall(param1));
      }
      
      public function setLevel(param1:int) : void
      {
         this._levelField.text = param1.toString();
      }
      
      public function setHonour(param1:int) : void
      {
         this._honourModule.setHonour(param1);
      }
      
      public function setLevelVisible(param1:Boolean) : void
      {
         this._levelField.visible = param1;
      }
      
      public function getPlayerName() : String
      {
         return this._playerName;
      }
      
      public function setPlayerName(param1:String) : void
      {
         if(param1 != null)
         {
            this._playerNameField.text = param1;
         }
         this._playerName = param1;
      }
      
      public function setBackground(param1:Boolean = true) : void
      {
         while(this._viewClip.bgContainer.numChildren > 0)
         {
            this._viewClip.bgContainer.removeChildAt(0);
         }
         if(param1)
         {
            this._viewClip.bgContainer.addChild(new InfoBoxBackground());
         }
      }
      
      public function reset() : void
      {
         while(this._viewClip.bgContainer.numChildren > 0)
         {
            this._viewClip.bgContainer.removeChildAt(0);
         }
      }
      
      public function setSelected(param1:Boolean, param2:Boolean = true) : void
      {
         if(_selectionGroups[this._selectionGroupID] !== undefined && _selectionGroups[this._selectionGroupID] !== null && _selectionGroups[this._selectionGroupID] !== this)
         {
            _selectionGroups[this._selectionGroupID].setSelected(!param1);
         }
         this._selectedBG.visible = param1;
         this._viewClip.bgContainer.visible = !param1;
         if(param1)
         {
            _selectionGroups[this._selectionGroupID] = this;
            selectionMadeSignal.dispatch(this._selectionGroupID,this);
         }
         this._isSelected = param1;
      }
      
      public function populateAdditionalDeferredData(param1:Object) : void
      {
         var _loc2_:Object = null;
         this._friend.cities = param1.cities;
         this.cityIndex = CityMatchMaker.selectMatchedCity(param1);
         if(param1.cities.length > 0)
         {
            _loc2_ = PvPMain.getMatchingCity(param1.cities,this.cityIndex);
            if(_loc2_ == null)
            {
            }
            this._viewClip.levelIcon.visible = true;
            this._viewClip.cityLevelField.visible = true;
            this._viewClip.honourSymbol.visible = true;
            this._viewClip.honorField.visible = true;
            this._viewClip.cityLevelField.text = _loc2_.level;
            this._viewClip.honorField.visible = _loc2_.honour;
            this.isPlayingMonkeyCity = true;
         }
         else
         {
            this.showNotPlayingMessage();
            this.isPlayingMonkeyCity = false;
         }
         this.isInitialised = true;
         deferredDataSetSignal.dispatch(this);
      }
      
      public function showNotPlayingMessage() : void
      {
         this._viewClip.inviteButton.visible = true;
         if(InviteUser.userHasBeenInvited(this._friend.name))
         {
            if(!Kong.isOnKong())
            {
               this._inviteButton.lock(3);
            }
         }
         else
         {
            this._inviteButton.unlock(1);
         }
      }
      
      public function setState(param1:String = "") : void
      {
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function get friend() : Friend
      {
         return this._friend;
      }
      
      public function get userID() : String
      {
         return this._friend.userID;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
      }
      
      public function get playerName() : String
      {
         return this._playerName;
      }
   }
}
