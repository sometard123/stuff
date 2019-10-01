package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dreadbloon
{
   import assets.sounds.DreadBloonReshield;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.common.events.GameEvent;
   import org.osflash.signals.Signal;
   
   public class DreadBloonShield
   {
      
      private static const RESHIELD_SOUND_FREQUENCY:Number = 1000;
       
      
      public var maxHealth:Number = 0;
      
      public var regenSpeed:Number = 5;
      
      public var regenCompleteSignal:Signal;
      
      private var _health:Number = 0;
      
      private var _bossBloon:Bloon = null;
      
      private var _shieldView:DreadBloonShieldView;
      
      private var _regenTarget:Number = 1.0;
      
      private var _isRegenerating:Boolean;
      
      private var _reshieldSoundTriggerTime:Number = 0;
      
      private var _reshieldSound:MaxSound;
      
      public function DreadBloonShield()
      {
         this.regenCompleteSignal = new Signal();
         this._reshieldSound = new MaxSound(DreadBloonReshield);
         super();
      }
      
      public function reset() : void
      {
         this._health = this.maxHealth;
         this.syncUI();
      }
      
      public function setBoss(param1:Bloon) : void
      {
         this._bossBloon = param1;
         this._shieldView = new DreadBloonShieldView(this);
         this._shieldView.setBoss(param1);
      }
      
      public function damage(param1:int, param2:Tower) : void
      {
         if(this._bossBloon === null)
         {
            return;
         }
         if(false === this._isRegenerating)
         {
            this._health = this._health - param1;
            if(this._bossBloon.isShielded)
            {
               this._shieldView.damage(param1,param2);
            }
         }
         this.syncShieldState();
         this.syncUI();
         Bloon.ceramicHitSound.play();
      }
      
      public function syncShieldState() : void
      {
         var _loc1_:Number = NaN;
         if(this._health < 0)
         {
            this._bossBloon.isShielded = false;
            _loc1_ = Math.abs(this._health);
            this._health = 0;
            this._bossBloon.damage(_loc1_,1,null);
         }
         else
         {
            this._bossBloon.isShielded = true;
         }
      }
      
      private function syncUI() : void
      {
         InGameMenu.instance.bossHealthBar.setShieldHealth(this._health / this.maxHealth);
      }
      
      public function cancelRegen() : void
      {
         Main.instance.game.removeEventListener(GameEvent.PRE_PROCESS,this.updateRegen);
      }
      
      public function updateRegen(param1:GameEvent) : void
      {
         var _loc2_:Boolean = Main.instance.game.fastForward;
         var _loc3_:Number = !!_loc2_?Number(this.regenSpeed * Game.FAST_FORWARD_STEPS):Number(this.regenSpeed);
         this._health = this._health + _loc3_;
         this.syncShieldState();
         this.syncUI();
         var _loc4_:Number = getTimer();
         var _loc5_:Number = _loc4_ - this._reshieldSoundTriggerTime;
         if(_loc5_ > RESHIELD_SOUND_FREQUENCY)
         {
            this._reshieldSound.play();
            this._reshieldSoundTriggerTime = _loc4_;
         }
         if(this._health >= this._regenTarget)
         {
            this._health = this._regenTarget;
            this._isRegenerating = false;
            this._shieldView.showRegenRocks = false;
            this._bossBloon.isMoving = true;
            Main.instance.game.removeEventListener(GameEvent.PRE_PROCESS,this.updateRegen);
            this.regenCompleteSignal.dispatch();
            this._reshieldSound.stop();
         }
      }
      
      public function regenerateBy(param1:Number, param2:Number = 4) : void
      {
         var _loc3_:Number = this._health / this.maxHealth;
         var _loc4_:Number = Math.min(_loc3_ + param1,1);
         this.regenerateTo(_loc4_);
      }
      
      public function regenerateTo(param1:Number, param2:Number = 4) : void
      {
         this._regenTarget = this.maxHealth * param1;
         if(this._health >= this._regenTarget || this._isRegenerating)
         {
            return;
         }
         this.regenSpeed = this.maxHealth / (30 * param2);
         this._isRegenerating = true;
         this._shieldView.showRegenRocks = true;
         this._bossBloon.isMoving = false;
         Main.instance.game.addEventListener(GameEvent.PRE_PROCESS,this.updateRegen);
      }
      
      public function get health() : Number
      {
         return this._health;
      }
   }
}
