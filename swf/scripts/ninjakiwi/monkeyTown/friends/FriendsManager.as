package ninjakiwi.monkeyTown.friends
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quart;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.*;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeOpenPacksScreen;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.WildCardFront;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.flipTime;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class FriendsManager
   {
      
      private static var instance:FriendsManager;
       
      
      protected var _opponentsList:Array;
      
      protected var _friendsData:Array;
      
      protected var _hasInitialised:Boolean = false;
      
      protected var _timeLastUpdated:Number = 0;
      
      protected var _isLoading:Boolean = false;
      
      protected var _cuedCallbacks:Array;
      
      protected var _usersByID:Object;
      
      protected var startLoadingFriendsListSignal:Signal;
      
      protected var finishedLoadingFriendsListSignal:Signal;
      
      protected const MIN_UPDATE_FREQUENCY:Number = 60000.0;
      
      public function FriendsManager(param1:String)
      {
         this._opponentsList = [];
         this._friendsData = [];
         this._cuedCallbacks = [];
         this._usersByID = {};
         this.startLoadingFriendsListSignal = new Signal();
         this.finishedLoadingFriendsListSignal = new Signal();
         super();
         if(param1 !== "_singleton_only_")
         {
            throw new Error("Error: Instantiation failed: Use FriendsManager.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         LoginSignals.userHasLoggedIn.add(this.loadFriendsList);
      }
      
      public static function getInstance() : FriendsManager
      {
         if(Kong.isOnKong())
         {
            return FriendsManagerKong.getInstance();
         }
         if(instance == null)
         {
            instance = new FriendsManager("_singleton_only_");
         }
         return instance;
      }
      
      private function onReset() : void
      {
         this._opponentsList = [];
         this._hasInitialised = false;
         this._timeLastUpdated = 0;
      }
      
      public function loadFriendsList(param1:Function = null) : void
      {
         var callback:Function = param1;
         var currentTime:Number = getTimer();
         this.startLoadingFriendsListSignal.dispatch();
         if(this._hasInitialised && currentTime - this._timeLastUpdated < this.MIN_UPDATE_FREQUENCY)
         {
            this.finishedLoadingFriendsListSignal.dispatch();
            if(callback !== null)
            {
               callback(this._opponentsList);
            }
            return;
         }
         this._cuedCallbacks.push(callback);
         if(this._isLoading)
         {
            return;
         }
         this._isLoading = true;
         Kloud.loadFullFriendsList(function(param1:Array):void
         {
            var _loc2_:Function = null;
            var _loc3_:Friend = null;
            _friendsData = param1;
            processFriendsData(param1);
            _timeLastUpdated = getTimer();
            var _loc4_:int = 0;
            while(_loc4_ < _opponentsList.length)
            {
               _loc3_ = _opponentsList[_loc4_];
               _usersByID[_loc3_.userID] = _loc3_;
               _loc4_++;
            }
            var _loc5_:int = 0;
            while(_loc5_ < _cuedCallbacks.length)
            {
               _loc2_ = _cuedCallbacks[_loc5_];
               if(_loc2_ !== null)
               {
                  _loc2_(_opponentsList);
               }
               _loc5_++;
            }
            _cuedCallbacks.length = 0;
            _isLoading = false;
            _hasInitialised = true;
            finishedLoadingFriendsListSignal.dispatch();
         });
      }
      
      public function getFriendsList() : Array
      {
         return this._friendsData;
      }
      
      public function getOpponentsList() : Array
      {
         return this._opponentsList;
      }
      
      protected function processFriendsData(param1:Array) : void
      {
         var _loc2_:Friend = null;
         var _loc3_:int = 0;
         if(param1 === null || !param1 is Array)
         {
            return;
         }
         this._opponentsList.length = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new Friend(param1[_loc3_]);
            this._opponentsList.push(_loc2_);
            _loc3_++;
         }
         if(this._opponentsList.length == 0)
         {
         }
      }
      
      public function findOpponentByID(param1:String) : Friend
      {
         var _loc2_:int = 0;
         if(this._opponentsList != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this._opponentsList.length)
            {
               if(this._opponentsList[_loc2_] is Friend)
               {
                  if(param1 == (this._opponentsList[_loc2_] as Friend).userID)
                  {
                     return this._opponentsList[_loc2_];
                  }
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function getUserNameByID(param1:String, param2:Function) : void
      {
         var informationLoader:UserInformationLoader = null;
         var userID:String = param1;
         var callback:Function = param2;
         var opponent:Friend = this.findOpponentByID(userID);
         if(opponent === null)
         {
            informationLoader = new UserInformationLoader(userID,function(param1:Object):void
            {
               callback(param1.username);
            });
         }
         else
         {
            callback(opponent.name);
         }
      }
      
      public function isUserFriend(param1:String) : Boolean
      {
         return this.findOpponentByID(param1) !== null;
      }
      
      public function get hasInitialised() : Boolean
      {
         return this._hasInitialised;
      }
   }
}
