package ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.VortexPulseAnimation;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.VortexStunAnimation;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.modifiers.AttackSpeedTemporaryModifierBoss;
   
   public class VortexStunPulseWeapon
   {
       
      
      public var frequency:Number = 7;
      
      public var effectDuration:Number = 6;
      
      public var effectRadius:Number = 100;
      
      public var stunLevel:Number = 0;
      
      private var _tier:int = 0;
      
      private var _countdownTime:Number = 0;
      
      private var _bloon:Bloon;
      
      public function VortexStunPulseWeapon(param1:Bloon)
      {
         super();
         this._bloon = param1;
      }
      
      public function update(param1:Number) : void
      {
         this._countdownTime = this._countdownTime - param1;
         if(this._countdownTime <= 0)
         {
            this.pulse();
         }
      }
      
      private function pulse() : void
      {
         var _loc2_:Tower = null;
         this._countdownTime = this.frequency;
         var _loc1_:Vector.<Tower> = Main.instance.game.level.getTowersInRange(this._bloon.x,this._bloon.y,this.effectRadius);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            _loc2_.modifiers.add(new AttackSpeedTemporaryModifierBoss(_loc2_,this.effectDuration,Math.max(0,1 - this.stunLevel)));
            _loc2_.addTemporaryAnimation(new VortexStunAnimation());
            _loc3_++;
         }
         var _loc4_:VortexPulseAnimation = VortexPulseAnimation.create(this._tier);
         _loc4_.x = this._bloon.x;
         _loc4_.y = this._bloon.y;
      }
      
      public function get tier() : int
      {
         return this._tier;
      }
      
      public function set tier(param1:int) : void
      {
         this._tier = Math.max(0,Math.min(param1,3));
      }
   }
}
