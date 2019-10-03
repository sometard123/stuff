package ninjakiwi.monkeyTown.btdModule.BSSpecialAbility
{
   import assets.btdmodule.ui.MonkeyBoostClip;
   import assets.btdmodule.ui.MonkeyBoostFullScreenEffect;
   import assets.sound.BoostEnd;
   import assets.sound.BoostStart;
   import com.greensock.TweenLite;
   import com.lgrey.events.LGDataEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameInRoundTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class MonkeyBoost extends BSSpecialAbility
   {
      
      private static const OFFSET_X:Number = 7;
      
      private static const OFFSET_Y:Number = 0;
      
      private static var upgrade:UpgradeDef = new UpgradeDef().Id("MonkeyBoost").Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(0.5).ReloadTimeAsScale(true)));
       
      
      private const _clip:MonkeyBoostClip = new MonkeyBoostClip();
      
      private const _abilityTimer:GameInRoundTimer = new GameInRoundTimer(10);
      
      private const _affectedTowers:Vector.<Tower> = new Vector.<Tower>();
      
      private const _screenEffect:MonkeyBoostFullScreenEffect = new MonkeyBoostFullScreenEffect();
      
      private const _boostStartSound:MaxSound = new MaxSound(BoostStart);
      
      private const _boostEndSound:MaxSound = new MaxSound(BoostEnd);
      
      private const _bonusCounterClip:MovieClip = this._clip.bonusCounter;
      
      public function MonkeyBoost(param1:DisplayObjectContainer)
      {
         this._screenEffect.visible = false;
         this._screenEffect.gotoAndStop(1);
         param1.addChild(this._screenEffect);
         super(param1,this._clip,"Monkey Boost","Double attack speed for all units for 10 seconds.");
         this._clip.activatedPulse.mouseEnabled = false;
         this._clip.activatedPulse.mouseChildren = false;
         _button.target.x = OFFSET_X;
         _button.target.y = OFFSET_Y;
         this.setBonusCount(0);
         timer = new GameInRoundTimer(90);
         timer.stop();
         Main.instance.eventBridge.addEventListener(Constants.MONKEY_BOOSTS_BALANCE_CHANGED,this.onBonusBalanceChangedHandler);
      }
      
      private function onBonusBalanceChangedHandler(param1:LGDataEvent) : void
      {
         this.setBonusCount(param1.data.balance);
      }
      
      private function resetIconEffect() : void
      {
         TweenLite.killTweensOf(this._clip.boostCooldownText);
         this._clip.boostCooldownText.visible = false;
         this._clip.activatedPulse.visible = false;
         this._clip.activatedPulse.gotoAndStop(1);
      }
      
      private function removeIconEffect() : void
      {
         TweenLite.killTweensOf(this._clip.boostCooldownText);
         TweenLite.to(this._clip.boostCooldownText,0.5,{
            "alpha":0,
            "onComplete":this.boostComplete
         });
         this._clip.activatedPulse.visible = false;
      }
      
      private function boostComplete() : void
      {
         this._clip.boostCooldownText.visible = false;
         this._clip.activatedPulse.visible = false;
         this._boostEndSound.play();
      }
      
      override public function reset() : void
      {
         super.reset();
         this.removeAbilityListener();
         this.removeEffect();
         this._abilityTimer.stop();
         this.resetIconEffect();
         timer.reset();
         timer.stop();
         this._clip.bloonstones.visible = true;
      }
      
      override protected function action() : void
      {
         var _loc2_:Tower = null;
         super.action();
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_MONKEY_BOOSTS,{"howMany":1}));
         this._clip.bloonstones.visible = false;
         var _loc1_:Vector.<Tower> = Main.instance.game.level.allTowers;
         for each(_loc2_ in _loc1_)
         {
            if(!(_loc2_.def == null || _loc2_.def.areaEffects != null))
            {
               this.addBoost(_loc2_);
            }
         }
         TowerPlace.towerPlacedSignal.add(this.addBoost);
         this._clip.boostCooldownText.x = -21.6;
         this._clip.boostCooldownText.alpha = 0.2;
         TweenLite.killTweensOf(this._clip.boostCooldownText);
         TweenLite.to(this._clip.boostCooldownText,0.2,{
            "alpha":1,
            "x":-48.6
         });
         this._clip.boostCooldownText.visible = true;
         this._clip.activatedPulse.visible = true;
         this._clip.activatedPulse.gotoAndPlay(1);
         this._screenEffect.visible = true;
         this._screenEffect.gotoAndPlay(1);
         this._abilityTimer.addEventListener(GameSpeedTimer.COMPLETE,this.onAbilityTimer);
         this._abilityTimer.reset();
         Main.instance.tooltip.hide();
         this._boostStartSound.play();
      }
      
      private function addBoost(param1:Tower) : void
      {
         param1.addUpgrade(upgrade);
         this._affectedTowers.push(param1);
      }
      
      override protected function ready() : void
      {
         super.ready();
         this._clip.bloonstones.visible = true;
      }
      
      private function onAbilityTimer(param1:Event) : void
      {
         this.removeAbilityListener();
         this.removeEffect();
         this.removeIconEffect();
      }
      
      private function removeEffect() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._affectedTowers.length)
         {
            this._affectedTowers[_loc1_].removeUpgrade(upgrade);
            _loc1_++;
         }
         this._affectedTowers.length = 0;
         this._screenEffect.gotoAndStop(1);
         this._screenEffect.visible = false;
         TowerPlace.towerPlacedSignal.remove(this.addBoost);
      }
      
      private function removeAbilityListener() : void
      {
         if(this._abilityTimer.hasEventListener(GameSpeedTimer.COMPLETE) == true)
         {
            this._abilityTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.onAbilityTimer);
         }
      }
      
      override public function setBonusCount(param1:int) : void
      {
         super.setBonusCount(param1);
         this._bonusCounterClip.counter.text = param1.toString();
         this._bonusCounterClip.visible = param1 > 0;
      }
      
      override public function get isAvailable() : Boolean
      {
         return !timer.running;
      }
   }
}
