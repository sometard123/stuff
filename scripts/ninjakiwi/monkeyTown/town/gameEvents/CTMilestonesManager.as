package ninjakiwi.monkeyTown.town.gameEvents
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   
   public class CTMilestonesManager extends GameEventSubManager
   {
       
      
      private var _persistentData:Object = null;
      
      public function CTMilestonesManager()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "ctMilestones";
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
      
      public function getBestRoundForCurrentEvent(param1:int) : int
      {
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(_loc2_ === null)
         {
            return -1;
         }
         if(!this._persistentData.hasOwnProperty("currentEvent"))
         {
            return 0;
         }
         var _loc3_:String = _loc2_.uid;
         var _loc4_:Object = this._persistentData.currentEvent;
         if(_loc4_.uid !== _loc3_)
         {
            return 0;
         }
         return this._persistentData.currentEvent.bestRounds[param1];
      }
      
      public function setBestRoundForCurrentEvent(param1:int, param2:int) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:GameplayEvent = findCurrentEvent();
         if(_loc3_ === null)
         {
            return;
         }
         if(false == this._persistentData.hasOwnProperty("currentEvent") || false == this._persistentData.currentEvent.hasOwnProperty("bestRounds") || false == this._persistentData.currentEvent.hasOwnProperty("uid") || this._persistentData.currentEvent.uid !== _loc3_.uid)
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
               "bestRounds":_loc4_,
               "uid":_loc3_.uid
            };
         }
         else
         {
            this._persistentData.currentEvent.bestRounds[param2] = param1;
         }
         save();
      }
      
      public function getCTMilestoneData(param1:Function) : void
      {
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(_loc2_ !== null)
         {
            SkuSettingsLoader.getGameEventDataByID("ctMilestones",_loc2_.dataID,param1);
         }
         else
         {
            param1(null);
         }
      }
   }
}
