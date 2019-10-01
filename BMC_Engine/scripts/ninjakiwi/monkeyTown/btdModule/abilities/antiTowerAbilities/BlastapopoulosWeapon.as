package ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities
{
   import assets.sounds.BlastapopoulosAttack;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.BlastapopoulosAttackAnimation;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.BlastopopoulosStunAnimation;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.modifiers.FreezeTemporaryModifier;
   
   public class BlastapopoulosWeapon
   {
       
      
      public var effectDuration:Number = 5;
      
      public var effectRadius:Number = 100;
      
      public var towersToStun:Number = 0;
      
      public var coolDown:Number = 0;
      
      private var _countdownTime:Number = 0;
      
      private var _bloon:Bloon;
      
      private var _animation:BlastapopoulosAttackAnimation;
      
      private var _mostExpensiveTowers:Vector.<Tower> = null;
      
      public function BlastapopoulosWeapon()
      {
         super();
         this._mostExpensiveTowers = new Vector.<Tower>();
         Level.towerSoldSignal.add(this.onTowerSold);
      }
      
      public function initialise(param1:Bloon) : void
      {
         this._bloon = param1;
      }
      
      public function clean() : void
      {
         Level.towerSoldSignal.remove(this.onTowerSold);
      }
      
      private function onTowerSold(... rest) : void
      {
         this.pulse();
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
         if(!this._bloon || this._bloon.health <= 0)
         {
            return;
         }
         this._countdownTime = this.coolDown;
         this._mostExpensiveTowers.length = 0;
         Main.instance.game.level.getMostExpensiveTowersInLevel(this.towersToStun,this._mostExpensiveTowers);
         new MaxSound(BlastapopoulosAttack).play();
         var _loc1_:int = 0;
         while(_loc1_ < this._mostExpensiveTowers.length)
         {
            _loc2_ = this._mostExpensiveTowers[_loc1_];
            if(_loc2_ != null)
            {
               this._animation = BlastapopoulosAttackAnimation.create(this._bloon,_loc2_);
               this._animation.hitTowerSignal.addOnce(this.onHitTower);
            }
            _loc1_++;
         }
      }
      
      private function onHitTower(param1:Tower) : void
      {
         param1.modifiers.add(new FreezeTemporaryModifier(param1,this.effectDuration));
         param1.addTemporaryAnimation(new BlastopopoulosStunAnimation());
      }
   }
}
