package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   
   public class CTOccupationManager extends GameEventSubManager
   {
      
      public static var forceLastKnownTimeZero:Boolean = false;
       
      
      private var _persistentData:Object = null;
      
      public function CTOccupationManager()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "ctOccupation";
      }
      
      override public function setPersistentData(param1:Object) : void
      {
         if(param1 == null)
         {
            param1 = {};
         }
         this._persistentData = param1;
      }
      
      override public function getPersistentData() : Object
      {
         return this._persistentData;
      }
      
      public function findOccupationEvent(param1:Number) : GameplayEvent
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Number = param1 + ContestPanelHelper.MILLISECONDS_IN_A_WEEK;
         var _loc3_:Date = new Date();
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         _loc3_.setTime(param1);
         _loc3_.setTime(_loc2_);
         var _loc6_:int = 0;
         while(_loc6_ < gameplayEvents.length)
         {
            _loc7_ = gameplayEvents[_loc6_].startTime;
            _loc8_ = gameplayEvents[_loc6_].endTime;
            _loc3_.setTime(_loc7_);
            _loc3_.setTime(_loc8_);
            if(_loc7_ >= param1 && _loc7_ < _loc2_)
            {
               return gameplayEvents[_loc6_];
            }
            _loc6_++;
         }
         return null;
      }
      
      public function getLastKnownHoldTime(param1:int) : Number
      {
         if(null == this._persistentData || false == this._persistentData.hasOwnProperty("currentEvent") || false == this._persistentData.currentEvent.hasOwnProperty("lastKnownHoldTime") || false == this._persistentData.currentEvent.lastKnownHoldTime.hasOwnProperty(param1))
         {
            return 0;
         }
         if(forceLastKnownTimeZero)
         {
            return 0;
         }
         return this._persistentData.currentEvent.lastKnownHoldTime[param1];
      }
      
      public function getLastKnownHoldTimeForCurrentEvent(param1:int) : Number
      {
         var _loc5_:ContestedTerritoryPanel = null;
         var _loc6_:Number = NaN;
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(_loc2_ === null)
         {
            return -1;
         }
         if(null == this._persistentData)
         {
            return 0;
         }
         if(!this._persistentData.hasOwnProperty("currentEvent"))
         {
            return 0;
         }
         var _loc3_:String = _loc2_.uid;
         var _loc4_:Object = this._persistentData.currentEvent;
         if(_loc4_.uid !== _loc3_)
         {
            _loc5_ = MonkeyCityMain.getInstance().ui.contestedTerritoryPanel;
            if(_loc5_.isInContestedTerritory() && 0 != _loc5_.myPlayerData.timeHoldingTerritory)
            {
               if(this._persistentData.currentEvent.lastKnownHoldTime.hasOwnProperty(param1))
               {
                  _loc6_ = this._persistentData.currentEvent.lastKnownHoldTime[param1];
                  GameEventManager.getInstance().ctOccupationManager.setLastKnownHoldTimeForCurrentEvent(_loc6_,MonkeySystem.getInstance().city.cityIndex);
                  return _loc6_;
               }
            }
            GameEventManager.getInstance().ctOccupationManager.setLastKnownHoldTimeForCurrentEvent(0,MonkeySystem.getInstance().city.cityIndex);
            return 0;
         }
         if(false == this._persistentData.currentEvent.lastKnownHoldTime.hasOwnProperty(param1))
         {
            return 0;
         }
         if(forceLastKnownTimeZero)
         {
            return 0;
         }
         return this._persistentData.currentEvent.lastKnownHoldTime[param1];
      }
      
      public function setLastKnownHoldTimeForCurrentEvent(param1:Number, param2:int) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:GameplayEvent = findCurrentEvent();
         if(_loc3_ === null)
         {
            return;
         }
         if(false == this._persistentData.hasOwnProperty("currentEvent") || false == this._persistentData.currentEvent.hasOwnProperty("lastKnownHoldTime") || false == this._persistentData.currentEvent.hasOwnProperty("uid") || this._persistentData.currentEvent.uid !== _loc3_.uid)
         {
            _loc4_ = [];
            _loc5_ = 0;
            while(_loc5_ < Constants.NUMBER_OF_CITIES)
            {
               _loc4_[_loc5_] = 0;
               _loc5_++;
            }
            _loc4_[param2] = param1;
            this._persistentData.currentEvent = {
               "lastKnownHoldTime":_loc4_,
               "uid":_loc3_.uid
            };
         }
         else
         {
            this._persistentData.currentEvent.lastKnownHoldTime[param2] = param1;
         }
         save();
      }
      
      public function setLastKnownHoldTime(param1:Number, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(false == this._persistentData.hasOwnProperty("currentEvent") || false == this._persistentData.currentEvent.hasOwnProperty("lastKnownHoldTime") || false == this._persistentData.currentEvent.hasOwnProperty("uid"))
         {
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < Constants.NUMBER_OF_CITIES)
            {
               _loc3_[_loc4_] = 0;
               _loc4_++;
            }
            _loc3_[param2] = param1;
            this._persistentData.currentEvent = {
               "lastKnownHoldTime":_loc3_,
               "uid":"TEST_ID_THAT_SHOULDNT_APPEAR_LIVE"
            };
         }
         else
         {
            this._persistentData.currentEvent.lastKnownHoldTime[param2] = param1;
         }
         save();
      }
      
      public function getCTOccupationData(param1:Function, param2:Boolean = true) : void
      {
         var callback:Function = param1;
         var useCurrentEvent:Boolean = param2;
         var currentOccupationEvent:GameplayEvent = findCurrentEvent();
         if(currentOccupationEvent !== null)
         {
            SkuSettingsLoader.getGameEventDataByID("ctOccupation",currentOccupationEvent.dataID,function(param1:Object):void
            {
               callback(param1,useCurrentEvent);
            });
         }
         else
         {
            callback(null,useCurrentEvent);
         }
      }
      
      public function getOccupationDataFromID(param1:Function, param2:String, param3:Boolean) : void
      {
         var callback:Function = param1;
         var dataID:String = param2;
         var useCurrentEvent:Boolean = param3;
         SkuSettingsLoader.getGameEventDataByID("ctOccupation",dataID,function(param1:Object):void
         {
            callback(param1,useCurrentEvent);
         });
      }
   }
}
