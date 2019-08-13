package ninjakiwi.monkeyTown.pvp
{
   import flash.utils.setTimeout;
   import ninjakiwi.data.TypeSafeStruct;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   
   public class OutgoingAttack extends TypeSafeStruct
   {
       
      
      public var attackID:String;
      
      public var timeLaunched:int;
      
      public var timeLeft:int;
      
      public var attack:Object;
      
      public var cashPillage:int;
      
      public function OutgoingAttack()
      {
         super();
      }
      
      public function syncToData(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         this.attackID = param1.attackID;
         this.timeLaunched = param1.timeLaunched;
         var _loc2_:Number = param1.expireAt;
         this.timeLeft = _loc2_ - MonkeySystem.getInstance().getSecureTime();
         this.attack = Squeeze.derialiseAndDecompress(param1.attack);
         this.cashPillage = param1.cashPillage;
         if(param1.attackID != null && param1.timeLeft != null)
         {
            _loc3_ = int(param1.timeLeft) * 0.001 + Constants.PVP_DEFENSE_EXTRA_TIME_S + 5 * 60;
            if(_loc3_ > 0)
            {
               PvPTimerManager.getInstance().registerTimer(this.attackID,_loc3_,this.onOutgoingAttackTimer);
            }
            else
            {
               this.onOutgoingAttackTimer();
               return false;
            }
         }
         return true;
      }
      
      private function onOutgoingAttackTimer() : void
      {
         PvPTimerManager.getInstance().deleteTimer(this.attackID);
         var resultObject:Object = {
            "attackID":this.attackID,
            "attackSucceeded":true,
            "attackerCash":this.cashPillage,
            "attackerBloontonium":0,
            "wasHardcore":false
         };
         PvPClient.sendAttackResult(resultObject,{
            "trackName":"null",
            "rounds":0,
            "totalRounds":0,
            "bloonStrength":(this.attack == null?Constants.RED_BLOON:this.attack.strongestBloonType),
            "attackerCashReward":this.cashPillage,
            "attackerBloontoniumReward":0
         },function(param1:Object):void
         {
            var response:Object = param1;
            PvPTimerManager.getInstance().registerTimer("expireAttackResult",30,function():void
            {
               PvPSignals.requestRefeshPvPData.dispatch();
            });
            PvPSignals.pvpExpiredByAttacker.dispatch({
               "attackID":attackID,
               "isRevenge":(attack.isRevenge == true?1:0),
               "attackerID":attack.attackerID,
               "defenderID":attack.defenderID
            });
         },true);
      }
   }
}
