package ninjakiwi.monkeyTown.friends
{
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.net.JSONRequest;
   
   public class FriendsManagerKong extends FriendsManager
   {
      
      private static var instance:FriendsManagerKong;
       
      
      private var _kongUserData:Object = null;
      
      public function FriendsManagerKong(param1:String)
      {
         super("_singleton_only_");
         if(param1 !== "_singleton_only_")
         {
            throw new Error("Error: Instantiation failed: Use FriendsManagerKong.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : FriendsManagerKong
      {
         if(instance == null)
         {
            instance = new FriendsManagerKong("_singleton_only_");
         }
         return instance;
      }
      
      public function findKongUserNameByKongUserID(param1:String) : String
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._kongUserData.friend_ids.length)
         {
            if(this._kongUserData.friend_ids[_loc2_].toString() === param1)
            {
               return this._kongUserData.friends[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function findKongUserIDByKongUserName(param1:String) : String
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._kongUserData.friend_ids.length)
         {
            if(this._kongUserData.friends[_loc2_].toString() === param1)
            {
               return this._kongUserData.friend_ids[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      override public function loadFriendsList(param1:Function = null) : void
      {
         var callback:Function = param1;
         var currentTime:Number = getTimer();
         startLoadingFriendsListSignal.dispatch();
         if(_hasInitialised && currentTime - _timeLastUpdated < MIN_UPDATE_FREQUENCY)
         {
            finishedLoadingFriendsListSignal.dispatch();
            if(callback !== null)
            {
               callback(_opponentsList);
            }
            return;
         }
         _cuedCallbacks.push(callback);
         if(_isLoading)
         {
            return;
         }
         _isLoading = true;
         Kong.loadFriends(function onUserDataLoaded(param1:Object):void
         {
            var _loc3_:Object = null;
            var _loc4_:String = null;
            var _loc5_:JSONRequest = null;
            _kongUserData = param1;
            var _loc2_:Array = _kongUserData.friend_ids;
            if(null != _loc2_ && _loc2_.length == 0)
            {
               _loc3_ = [];
               getFriendsResponseCallback(_loc3_);
            }
            else
            {
               _loc4_ = "https://mynk.ninjakiwi.com/check_kong_user?userids=" + _kongUserData.friend_ids.join(",");
               _loc5_ = new JSONRequest(_loc4_,null,getFriendsResponseCallback);
               _loc5_.go();
            }
         });
      }
      
      private function getFriendsResponseCallback(param1:Object) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Friend = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         if(param1.hasOwnProperty("error"))
         {
            param1 = [];
         }
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc8_ = param1[_loc3_];
            _loc9_ = {
               "avatar":"kong",
               "clan":"kong",
               "user_id":_loc8_.nkuserid,
               "username":this.findKongUserNameByKongUserID(_loc8_.konguserid) || "Kong Friend"
            };
            _loc2_.push(_loc9_);
            _loc3_++;
         }
         _friendsData = _loc2_;
         processFriendsData(_loc2_);
         _timeLastUpdated = getTimer();
         var _loc6_:int = 0;
         while(_loc6_ < _opponentsList.length)
         {
            _loc5_ = _opponentsList[_loc6_];
            _usersByID[_loc5_.userID] = _loc5_;
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _cuedCallbacks.length)
         {
            _loc4_ = _cuedCallbacks[_loc7_];
            if(_loc4_ !== null)
            {
               _loc4_(_opponentsList);
            }
            _loc7_++;
         }
         _cuedCallbacks.length = 0;
         _isLoading = false;
         _hasInitialised = true;
         finishedLoadingFriendsListSignal.dispatch();
      }
   }
}
