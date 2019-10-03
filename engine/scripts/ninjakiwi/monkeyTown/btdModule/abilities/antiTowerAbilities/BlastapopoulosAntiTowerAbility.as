package ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   
   public class BlastapopoulosAntiTowerAbility
   {
      
      private static const PULSE_INTERVAL:Number = 5;
      
      private static const data:Object = {
         "levels":[{
            "toLevel":5,
            "towersToStun":1,
            "duration":5
         },{
            "toLevel":10,
            "towersToStun":2,
            "duration":5
         },{
            "toLevel":int.MAX_VALUE,
            "towersToStun":3,
            "duration":5
         }],
         "cooldowns":[5,10,15,20]
      };
       
      
      public var coolDown:Number = 10;
      
      private var _currentQuarter:int = -1;
      
      private var _timeOfLastPulse:Number = 0;
      
      private var _bossLevel:Number = 0;
      
      private var _boss:Bloon;
      
      private var _dataSet:Object;
      
      private var _pulse:BlastapopoulosWeapon;
      
      public function BlastapopoulosAntiTowerAbility()
      {
         super();
         this._pulse = new BlastapopoulosWeapon();
      }
      
      public function initialise(param1:Bloon, param2:int) : void
      {
         this._boss = param1;
         this._bossLevel = param2;
         this._pulse.initialise(param1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = this.getBossHealthQuarter();
         if(_loc2_ !== this._currentQuarter)
         {
            this._currentQuarter = this.clamp4(_loc2_);
            this.sync();
         }
         this._pulse.update(param1);
      }
      
      public function sync() : void
      {
         var _loc1_:Object = this.findDataForLevel(this._bossLevel);
         this._pulse.towersToStun = _loc1_.towersToStun;
         this._pulse.effectDuration = _loc1_.duration;
         this._pulse.coolDown = data.cooldowns[this._currentQuarter];
      }
      
      private function findDataForLevel(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < data.levels.length)
         {
            _loc3_ = data.levels[_loc2_];
            if(_loc3_.toLevel >= param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return data.levels[0];
      }
      
      private function getBossHealthQuarter() : int
      {
         if(this._boss == null)
         {
            return 0;
         }
         var _loc1_:Number = this._boss.health / this._boss.maxHealth;
         var _loc2_:int = 0;
         if(_loc1_ > 0.75)
         {
            _loc2_ = 3;
         }
         else if(_loc1_ > 0.5)
         {
            _loc2_ = 2;
         }
         else if(_loc1_ > 0.25)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function reset() : void
      {
         this._timeOfLastPulse = 0;
      }
      
      public function clean() : void
      {
         this._pulse.clean();
         this.reset();
         this._boss = null;
      }
      
      private function clamp4(param1:int) : int
      {
         return Math.max(0,Math.min(param1,3));
      }
   }
}
