package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.data.TypeSafeStruct;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   
   public class IncomingRaid extends TypeSafeStruct
   {
       
      
      public var checked:Boolean = false;
      
      public var attackID:String = null;
      
      public var attack:PvPAttackDefinition;
      
      public var cashPillage:int;
      
      public var sender:Object = null;
      
      public var timeLaunched:Number = -1;
      
      public var timeLeft:Number = -1;
      
      public var stated:Boolean = false;
      
      public var target:Object = null;
      
      public var linkedTile:Object = null;
      
      public function IncomingRaid()
      {
         super();
      }
      
      public function clear() : void
      {
         PvPTimerManager.getInstance().deleteTimer(this.attackID);
      }
      
      public function syncData(param1:Object, param2:Boolean = false) : Boolean
      {
         this.attackID = param1.attackID;
         this.attack = Squeeze.derialiseAndDecompress(param1.attack);
         this.cashPillage = param1.sender.maxCashPillage;
         this.sender = param1.sender;
         this.target = param1.target;
         this.timeLaunched = param1.timeLaunched;
         this.linkedTile = param1.linkedTile;
         var _loc3_:Number = param1.expireAt;
         var _loc4_:Number = MonkeySystem.getInstance().getSecureTime();
         this.timeLeft = _loc3_ - _loc4_;
         if(param1.started != null && param1.started == true)
         {
            this.onTimer();
            return false;
         }
         if(this.timeLeft * 0.001 > 0 && !param2)
         {
            PvPTimerManager.getInstance().registerTimer(this.attackID,this.timeLeft * 0.001,this.onTimer);
            return true;
         }
         this.onTimer();
         return false;
      }
      
      private function onTimer() : void
      {
         if(this.attack === null)
         {
            return;
         }
         PvPSignals.attackExpired.dispatch({
            "attackID":this.attackID,
            "wasRevenge":(this.attack.isRevenge == true?1:0),
            "attackerID":this.attack.attackerID,
            "defenderID":this.attack.defenderID
         });
         PvPSignals.defendAttackComplete.dispatch(new GameResultDefinition().Success(false),this,true);
      }
      
      public function get userID() : String
      {
         return this.sender.userID;
      }
      
      public function get cityLevel() : int
      {
         return this.sender.cityLevel;
      }
      
      public function get clan() : String
      {
         return this.sender.clan;
      }
      
      public function get name() : String
      {
         return this.sender.name;
      }
   }
}
