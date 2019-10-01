package ninjakiwi.monkeyTown.btdModule.game
{
   public class Balance
   {
      
      public static var instance:Balance = new Balance();
       
      
      public var STARTING_ENERGY:CryptScore;
      
      public var ENERGY_COST_PER_GAME:CryptScore;
      
      public var ENERGY_COST_SPY:CryptScore;
      
      public var ENERGY_COST_EXTRA_TOWER:CryptScore;
      
      public var ENERGY_REGEN_TIME:CryptScore;
      
      public var MEDS_FOR_WIN:CryptScore;
      
      public var MEDS_FOR_LOSS:CryptScore;
      
      public var BATTLESCORE_FOR_WIN:CryptScore;
      
      public var BATTLESCORE_FOR_LOSS:CryptScore;
      
      public var COST_MULTIPLIER_REGEN:Number = 1.5;
      
      public var COST_MULTIPLIER_CAMO:Number = 3;
      
      public var UNLOCK_ROUND_REGEN:int = 10;
      
      public var UNLOCK_ROUND_CAMO:int = 20;
      
      public var STARTING_CASH:Number = 650;
      
      public var STARTING_HEALTH:Number = 150;
      
      public var CASH_PER_TICK_MINIMUM:Number = 300;
      
      public var GIVE_CASH_TIME:Number = 5.0;
      
      public var FIRST_ROUND_START_TIME:Number = 6.0;
      
      public var PREMATCH_SCREEN_TIME:Number = 30.0;
      
      public function Balance()
      {
         this.STARTING_ENERGY = new CryptScore();
         this.ENERGY_COST_PER_GAME = new CryptScore();
         this.ENERGY_COST_SPY = new CryptScore();
         this.ENERGY_COST_EXTRA_TOWER = new CryptScore();
         this.ENERGY_REGEN_TIME = new CryptScore();
         this.MEDS_FOR_WIN = new CryptScore();
         this.MEDS_FOR_LOSS = new CryptScore();
         this.BATTLESCORE_FOR_WIN = new CryptScore();
         this.BATTLESCORE_FOR_LOSS = new CryptScore();
         super();
         this.STARTING_ENERGY.value = 50;
         this.ENERGY_COST_PER_GAME.value = 5;
         this.ENERGY_COST_SPY.value = 5;
         this.ENERGY_COST_EXTRA_TOWER.value = 5;
         this.ENERGY_REGEN_TIME.value = 720;
         this.MEDS_FOR_WIN.value = 5;
         this.MEDS_FOR_LOSS.value = 2;
         this.BATTLESCORE_FOR_WIN.value = 10;
         this.BATTLESCORE_FOR_LOSS.value = 2;
      }
      
      public function applyBalanceData(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:Array = null;
         var _loc12_:BloonSendDef = null;
         var _loc9_:String = param1.substring(param1.indexOf("baseVals") + "baseVals".length,param1.indexOf("baseValsEnd"));
         _loc8_ = _loc9_.split(";");
         _loc2_ = 0;
         while(_loc2_ < _loc8_.length)
         {
            _loc4_ = _loc8_[_loc2_];
            _loc5_ = _loc4_.indexOf("=");
            _loc6_ = _loc4_.substring(0,_loc5_);
            _loc7_ = _loc4_.substring(_loc5_ + 1);
            if(_loc6_ != null && _loc6_ != "")
            {
               this[_loc6_] = _loc7_;
            }
            _loc2_++;
         }
         Main.instance.bloonSendSet.clearAllBloonSendDefs();
         var _loc10_:String = param1.substring(param1.indexOf("bloonSets") + "bloonSets".length,param1.indexOf("bloonSetsEnd"));
         var _loc11_:Array = _loc10_.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc11_.length)
         {
            _loc12_ = new BloonSendDef();
            _loc8_ = _loc11_[_loc3_].split(";");
            _loc2_ = 0;
            while(_loc2_ < _loc8_.length)
            {
               _loc4_ = _loc8_[_loc2_];
               _loc5_ = _loc4_.indexOf("=");
               _loc6_ = _loc4_.substring(0,_loc5_);
               _loc7_ = _loc4_.substring(_loc5_ + 1);
               if(_loc6_ != null && _loc6_ != "")
               {
                  _loc12_[_loc6_] = _loc7_;
               }
               _loc2_++;
            }
            Main.instance.bloonSendSet.addBloonSendDef(_loc12_);
            _loc3_++;
         }
      }
   }
}
