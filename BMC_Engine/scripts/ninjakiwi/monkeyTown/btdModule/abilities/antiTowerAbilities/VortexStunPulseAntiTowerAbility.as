package ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   
   public class VortexStunPulseAntiTowerAbility
   {
      
      private static const PULSE_INTERVAL:Number = 5;
      
      public static const RADIUS_1_EXTENSTION:Number = 100;
      
      public static const RADIUS_2_EXTENSTION:Number = 100;
      
      public static const RADIUS_3_EXTENSTION:Number = 100;
      
      public static const RADIUS_4_EXTENSTION:Number = 100;
      
      public static const STUN_MODIFIER:Number = 2;
      
      private static const data:Object = {"levels":[{"toLevel":5},{"toLevel":10},{"toLevel":15},{"toLevel":19},{"toLevel":int.MAX_VALUE}]};
       
      
      private var _currentQuarter:int = -1;
      
      private var _timeOfLastPulse:Number = 0;
      
      private var _bossLevel:Number = 0;
      
      private var _boss:Bloon;
      
      private var _dataSet:Object;
      
      private var _pulse:VortexStunPulseWeapon;
      
      public function VortexStunPulseAntiTowerAbility(param1:Bloon, param2:int)
      {
         super();
         this._boss = param1;
         this._bossLevel = param2;
         this._dataSet = this.findDataForLevel(param2);
         this._pulse = new VortexStunPulseWeapon(param1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = this.getBossHealthQuarter();
         if(_loc2_ !== this._currentQuarter)
         {
            this._currentQuarter = _loc2_;
            this.sync();
         }
         this._pulse.update(param1);
      }
      
      public function sync() : void
      {
         this._pulse.stunLevel = this.getStunLevelForQuarter(this._currentQuarter);
         this._pulse.effectRadius = this.getPulseRadiusForQuarter(this._currentQuarter);
         this._pulse.tier = Math.max(0,this._currentQuarter - 1);
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
         var _loc1_:Number = NaN;
         _loc1_ = 1 - this._boss.health / this._boss.maxHealth;
         var _loc2_:int = Math.floor(_loc1_ * 4);
         return _loc2_;
      }
      
      private function getPulseRadiusForQuarter(param1:int) : Number
      {
         param1 = this.clamp4(param1);
         var _loc2_:Number = this._boss.radius;
         switch(param1)
         {
            case 0:
               _loc2_ = this._boss.radius + RADIUS_1_EXTENSTION;
               break;
            case 1:
               _loc2_ = this._boss.radius + RADIUS_2_EXTENSTION;
               break;
            case 2:
               _loc2_ = this._boss.radius + RADIUS_3_EXTENSTION;
               break;
            case 3:
               _loc2_ = this._boss.radius + RADIUS_4_EXTENSTION;
         }
         return _loc2_;
      }
      
      private function getStunLevelForQuarter(param1:int) : Number
      {
         var _loc2_:Number = 1;
         param1 = this.clamp4(param1);
         switch(param1)
         {
            case 0:
               _loc2_ = 0.2 + this._bossLevel * 0.01 * STUN_MODIFIER;
               break;
            case 1:
               _loc2_ = 0.3 + this._bossLevel * 0.01 * STUN_MODIFIER;
               break;
            case 2:
               _loc2_ = 0.4 + this._bossLevel * 0.01 * STUN_MODIFIER;
               break;
            case 3:
               _loc2_ = 0.5 + this._bossLevel * 0.01 * STUN_MODIFIER;
         }
         _loc2_ = Math.min(_loc2_,1);
         return _loc2_;
      }
      
      public function reset() : void
      {
         this._timeOfLastPulse = 0;
      }
      
      public function clean() : void
      {
         this.reset();
         this._boss = null;
      }
      
      private function clamp4(param1:int) : int
      {
         return Math.max(0,Math.min(param1,3));
      }
   }
}
