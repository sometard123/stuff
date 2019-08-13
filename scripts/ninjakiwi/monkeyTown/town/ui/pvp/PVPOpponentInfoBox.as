package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PvPOpponentInfoBoxClip;
   import flash.utils.getTimer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.pvp.CityMatchMaker;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.InviteUser;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class PVPOpponentInfoBox extends PvPInfoBox
   {
      
      private static const INVITE_INTERVAL:int = 7 * 24 * 60 * 60 * 1000;
      
      public static const selectionGroup:String = "opponentInfoBoxClip";
      
      private static const _pool:Vector.<PVPOpponentInfoBox> = new Vector.<PVPOpponentInfoBox>();
       
      
      private const _clip:PvPOpponentInfoBoxClip = new PvPOpponentInfoBoxClip();
      
      private var _selectable:Boolean = true;
      
      public var yPos:int;
      
      public function PVPOpponentInfoBox(param1:Friend)
      {
         super();
         super.setClip(this._clip);
         _selectionGroupID = selectionGroup;
         this.init(param1);
      }
      
      public static function getInfoBox(param1:Friend) : PVPOpponentInfoBox
      {
         var _loc2_:PVPOpponentInfoBox = null;
         if(_pool.length > 0)
         {
            _loc2_ = _pool.pop();
            _loc2_.init(param1);
            return _loc2_;
         }
         return new PVPOpponentInfoBox(param1);
      }
      
      public static function recycleInfoBox(param1:PVPOpponentInfoBox) : void
      {
         if(_pool.indexOf(param1) == -1)
         {
            param1.reset();
            _pool.push(param1);
         }
      }
      
      public function init(param1:Friend) : void
      {
         var _loc3_:int = 0;
         _friend = param1;
         _inviteButton = new ButtonControllerBase(this._clip.inviteButton);
         this._selectable = true;
         this.setSelected(false);
         var _loc2_:Object = QuestCounter.getInstance().getCustomValue("invite_" + _friend.userID);
         if(_loc2_ === null)
         {
            _inviteButton.setClickFunction(this.onInvite);
         }
         else
         {
            _loc3_ = getTimer() - int(_loc2_);
            if(_loc3_ > INVITE_INTERVAL)
            {
               _inviteButton.setClickFunction(this.onInvite);
            }
            else if(!Kong.isOnKong())
            {
               _inviteButton.lock(3);
            }
         }
      }
      
      override public function populateAdditionalDeferredData(param1:Object) : void
      {
         var _loc2_:Object = null;
         _friend.cities = param1.cities;
         cityIndex = CityMatchMaker.selectMatchedCity(param1);
         if(cityIndex >= 0)
         {
            _loc2_ = PvPMain.getMatchingCity(param1.cities,cityIndex);
            if(_loc2_.hasOwnProperty("honour"))
            {
               setHonour(_loc2_.honour);
            }
            if(_loc2_.level === -1)
            {
               this.setState(PvPMain.STATE_NOT_PLAYING);
            }
            else
            {
               if(_loc2_.level < Constants.MINIMUM_PVP_LEVEL)
               {
                  this.setState(PvPMain.STATE_LOW_LEVEL);
               }
               else if(MonkeySystem.getInstance().getSecureTime() > _loc2_.pacifistExpireAt)
               {
                  this.setState(PvPMain.STATE_PACIFIST);
               }
               else if(_loc2_.youHaveAlreadyAttacked)
               {
                  this.setState(PvPMain.STATE_ALREADY);
               }
               else
               {
                  this.setState("");
               }
               setLevel(_loc2_.level);
            }
         }
         else
         {
            this.setState(PvPMain.STATE_NOT_PLAYING);
            setLevel(0);
         }
         isInitialised = true;
      }
      
      override public function setState(param1:String = "") : void
      {
         this._clip.pacifistModeIcon.visible = false;
         this._clip.levelSymbol.visible = true;
         this._clip.cityLevelField.visible = true;
         this._clip.honourSymbol.visible = true;
         this._clip.honorField.visible = true;
         if(param1 == PvPMain.STATE_LOW_LEVEL)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_LOW_LEVEL;
            this.disable();
         }
         else if(param1 == PvPMain.STATE_NOT_PLAYING)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_NOT_PLAYING;
            this._clip.levelSymbol.visible = false;
            this._clip.cityLevelField.visible = false;
            this._clip.honourSymbol.visible = false;
            this._clip.honorField.visible = false;
            this.disable(true);
         }
         else if(param1 == PvPMain.STATE_ALREADY)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_ALREADY;
            this.disable();
         }
         else if(param1 == PvPMain.STATE_PACIFIST)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_PACIFIST;
            this._clip.pacifistModeIcon.visible = true;
            this.disable();
         }
         else if(param1 == PvPMain.STATE_MAXATTACKS)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_MAX_ATTACKS;
            this.disable();
         }
         else if(param1 == PvPMain.STATE_NOT_INITIALISED)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_UNINITIALISED;
            this._clip.levelSymbol.visible = false;
            this._clip.cityLevelField.visible = false;
            this._clip.honourSymbol.visible = false;
            this._clip.honorField.visible = false;
            this.disable();
         }
         else if(param1 == PvPMain.STATE_LOADING)
         {
            this._clip.opponentState.opponentStateTxt.text = LocalisationConstants.STRING_OPPONENT_LOADING;
            this._clip.levelSymbol.visible = false;
            this._clip.cityLevelField.visible = false;
            this._clip.honourSymbol.visible = false;
            this._clip.honorField.visible = false;
            this.disable();
         }
         else
         {
            this._clip.opponentState.opponentStateTxt.text = "";
            this.enable();
         }
      }
      
      public function setMaxCashPillage(param1:int) : void
      {
         this._clip.opponentState.opponentStateTxt.text = "";
      }
      
      private function disable(param1:Boolean = false) : void
      {
         if(param1)
         {
            _inviteButton.target.visible = true;
            this._clip.opponentState.visible = false;
         }
         else
         {
            this._clip.opponentState.visible = true;
            _inviteButton.target.visible = false;
         }
         this._selectable = false;
      }
      
      private function enable() : void
      {
         this._clip.opponentState.visible = true;
         _inviteButton.target.visible = false;
         this._selectable = true;
      }
      
      override public function setSelected(param1:Boolean, param2:Boolean = true) : void
      {
         if(this._selectable)
         {
            super.setSelected(param1);
         }
      }
      
      private function onInvite() : void
      {
         QuestCounter.getInstance().setCustomValue("invite_" + _friend.userID,getTimer());
         InviteUser.invite(_friend.name);
         if(!Kong.isOnKong())
         {
            _inviteButton.lock(3);
         }
      }
   }
}
