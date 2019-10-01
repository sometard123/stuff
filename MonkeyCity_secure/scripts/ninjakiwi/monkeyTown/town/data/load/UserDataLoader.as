package ninjakiwi.monkeyTown.town.data.load
{
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.OutgoingAttack;
   import ninjakiwi.monkeyTown.pvp.Pacifist;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class UserDataLoader
   {
      
      public static const friendGroupDataLoaded:Signal = new Signal();
      
      private static var instance:UserDataLoader;
       
      
      private var _loadingBoxes:Array;
      
      private const CACHE_EXPIRATION_TIME:int = 1800000.0;
      
      private var _cachedDataByUserID:Object;
      
      private var _attackedUsers:Vector.<OutgoingAttack>;
      
      public function UserDataLoader(param1:SingletonEnforcer#393)
      {
         this._loadingBoxes = [];
         this._cachedDataByUserID = {};
         this._attackedUsers = new Vector.<OutgoingAttack>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use StatsData.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : UserDataLoader
      {
         if(instance == null)
         {
            instance = new UserDataLoader(new SingletonEnforcer#393());
         }
         return instance;
      }
      
      public function addBoxSet(param1:Array) : void
      {
         var _loc2_:InfoBoxBase = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         if(param1.length === 0)
         {
            return;
         }
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            _loc6_ = this._cachedDataByUserID.hasOwnProperty(_loc2_.userID);
            if(_loc6_)
            {
               _loc7_ = getTimer() - this._cachedDataByUserID[_loc2_.userID].timeStamp;
               if(_loc7_ > this.CACHE_EXPIRATION_TIME)
               {
                  delete this._cachedDataByUserID[_loc2_.userID];
                  _loc2_.isInitialised = false;
                  _loc6_ = false;
               }
            }
            if(_loc6_)
            {
               _loc2_.populateAdditionalDeferredData(this._cachedDataByUserID[_loc2_.userID].friend);
            }
            else if(!_loc2_.isInitialised)
            {
               _loc8_ = false;
               _loc9_ = 0;
               while(_loc9_ < this._loadingBoxes.length)
               {
                  if(this._loadingBoxes[_loc9_].userID == _loc2_.userID)
                  {
                     _loc8_ = true;
                     break;
                  }
                  _loc9_++;
               }
               if(!_loc8_)
               {
                  this._loadingBoxes.push(_loc2_);
                  _loc3_.push(_loc2_.userID);
                  _loc4_.push(_loc2_.getPlayerName());
                  _loc2_.setState(PvPMain.STATE_LOADING);
                  _loc2_.isInitialised = true;
               }
            }
            _loc5_++;
         }
         if(_loc3_.length > 0)
         {
            Kloud.loadDataForFriendGroup(_loc3_,this.onFriendGroupDataLoaded);
         }
      }
      
      public function populateWithCachedData(param1:InfoBoxBase) : void
      {
         var _loc2_:int = 0;
         if(this._cachedDataByUserID.hasOwnProperty(param1.userID))
         {
            _loc2_ = getTimer() - this._cachedDataByUserID[param1.userID].timeStamp;
            if(_loc2_ > this.CACHE_EXPIRATION_TIME)
            {
               delete this._cachedDataByUserID[param1.userID];
               param1.isInitialised = false;
               return;
            }
            param1.populateAdditionalDeferredData(this._cachedDataByUserID[param1.userID].friend);
         }
      }
      
      private function onFriendGroupDataLoaded(param1:Object) : void
      {
         var _loc2_:InfoBoxBase = null;
         var _loc5_:Object = null;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc15_:int = 0;
         var _loc3_:Array = param1.friends;
         var _loc4_:Array = param1.friendIDs;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_];
            _loc9_ = false;
            _loc10_ = 0;
            while(_loc10_ < _loc3_.length)
            {
               _loc11_ = _loc3_[_loc10_];
               if(_loc11_.userID == _loc8_)
               {
                  _loc9_ = true;
                  _loc12_ = 0;
                  while(_loc12_ < this._attackedUsers.length)
                  {
                     _loc13_ = this._attackedUsers[_loc12_].attack;
                     if(_loc13_.defenderID == _loc11_.userID && false == _loc13_.isRevenge)
                     {
                        PvPMain.getMatchingCity(_loc11_.cities,_loc13_.defenderCityIndex).youHaveAlreadyAttacked = true;
                     }
                     _loc12_++;
                  }
               }
               _loc10_++;
            }
            if(false == _loc9_)
            {
               _loc14_ = {
                  "userID":_loc8_,
                  "cities":[]
               };
               _loc3_.push(_loc14_);
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc7_];
            this._cachedDataByUserID[_loc5_.userID] = {
               "timeStamp":getTimer(),
               "friend":_loc5_
            };
            _loc15_ = this._loadingBoxes.length - 1;
            while(_loc15_ >= 0)
            {
               _loc2_ = this._loadingBoxes[_loc15_];
               if(Number(_loc2_.userID) === Number(_loc5_.userID))
               {
                  _loc2_.populateAdditionalDeferredData(_loc5_);
                  this._loadingBoxes.splice(_loc15_,1);
                  break;
               }
               _loc15_--;
            }
            _loc7_++;
         }
         PvPSignals.sendMVMAttackSucceeded.remove(this.onPVPAttackSuccessfullySent);
         PvPSignals.sendMVMAttackSucceeded.add(this.onPVPAttackSuccessfullySent);
         PvPSignals.attackResult.remove(this.onSentAttackResolved);
         PvPSignals.attackResult.add(this.onSentAttackResolved);
         PvPSignals.recievedNewPvPAttack.remove(this.onAttackRecieved);
         PvPSignals.recievedNewPvPAttack.add(this.onAttackRecieved);
         UserDataLoader.friendGroupDataLoaded.dispatch();
      }
      
      private function onPVPAttackSuccessfullySent(param1:PvPAttackDefinition) : void
      {
         var _loc3_:Object = null;
         if(false == this._cachedDataByUserID.hasOwnProperty(param1.defenderID))
         {
            return;
         }
         if(param1.isRevenge)
         {
            return;
         }
         var _loc2_:Object = this._cachedDataByUserID[param1.defenderID].friend;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.cities.length > 0)
         {
            _loc3_ = PvPMain.getMatchingCity(_loc2_.cities,param1.defenderCityIndex);
            _loc3_.youHaveAlreadyAttacked = true;
            TownUI.getInstance().pvpPanel.syncToData();
         }
      }
      
      private function onSentAttackResolved(param1:Boolean, param2:Object) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:PvPAttackDefinition = Squeeze.derialiseAndDecompress(param2.attack);
         var _loc4_:* = _loc3_.attackerID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id;
         if(!_loc4_)
         {
            return;
         }
         if(false == this._cachedDataByUserID.hasOwnProperty(_loc3_.defenderID))
         {
            return;
         }
         if(_loc3_.isRevenge)
         {
            return;
         }
         var _loc5_:Object = this._cachedDataByUserID[_loc3_.defenderID].friend;
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc5_.cities.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.cities.length)
            {
               _loc7_ = _loc5_.cities[_loc6_];
               if(_loc7_.cityIndex == _loc3_.defenderCityIndex)
               {
                  _loc8_ = PvPMain.getMatchingCity(_loc5_.cities,_loc3_.defenderCityIndex);
                  _loc8_.youHaveAlreadyAttacked = false;
                  TownUI.getInstance().pvpPanel.syncToData();
                  break;
               }
               _loc6_++;
            }
         }
      }
      
      private function onAttackRecieved(param1:Object) : void
      {
         var _loc4_:Object = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:PvPAttackDefinition = Squeeze.derialiseAndDecompress(param1.attack);
         if(false == this._cachedDataByUserID.hasOwnProperty(_loc2_.attackerID))
         {
            return;
         }
         var _loc3_:Object = this._cachedDataByUserID[_loc2_.attackerID].friend;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.cities.length > 0)
         {
            _loc4_ = _loc3_.cities[_loc2_.attackerCityIndex];
            _loc4_.pacifistExpireAt = MonkeySystem.getInstance().getSecureTime() + Pacifist.MAX_TIME_UNTIL_PACIFIST;
            TownUI.getInstance().pvpPanel.syncToData();
         }
      }
      
      public function populateAttackedUsers(param1:Array) : void
      {
         this._attackedUsers.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this._attackedUsers.push(param1[_loc2_] as OutgoingAttack);
            _loc2_++;
         }
      }
   }
}

class SingletonEnforcer#393
{
    
   
   function SingletonEnforcer#393()
   {
      super();
   }
}
