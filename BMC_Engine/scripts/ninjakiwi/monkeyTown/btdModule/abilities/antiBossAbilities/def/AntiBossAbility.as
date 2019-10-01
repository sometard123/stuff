package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def
{
   import com.lgrey.events.LGDataEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class AntiBossAbility
   {
       
      
      private var _abilityDef:AntiBossAbilityDef = null;
      
      private var _abilityBehaviour:IAntiBossAbilityBehaviour = null;
      
      private var _abilityButton:AntiBossAbilityButton = null;
      
      private var _cooldownTimeLeft:Number;
      
      private var _activationTimeLeft:Number;
      
      private var _bonusActivationsLeft:int;
      
      private var _activationsLeft:int;
      
      public function AntiBossAbility(param1:IAntiBossAbilityBehaviour, param2:AntiBossAbilityButton, param3:AntiBossAbilityDef)
      {
         super();
         this._abilityDef = param3;
         this._abilityBehaviour = param1;
         this._abilityButton = param2;
         this._abilityButton.onButtonPressedSignal.add(this.requestToActivateAbility);
         this.setBonusActivations(param3.bonusCount);
         this.reset();
      }
      
      public function reset() : void
      {
         this.exitCooldownPeriod();
         this.exitActivationPeriod();
         this.resetActivations();
         this._abilityBehaviour.reset();
      }
      
      private function exitCooldownPeriod() : void
      {
         this._cooldownTimeLeft = 0;
         this._abilityButton.setCooldownPercent(0);
      }
      
      private function exitActivationPeriod() : void
      {
         this._activationTimeLeft = 0;
         this._abilityBehaviour.deactivate();
      }
      
      private function resetActivations() : void
      {
         this._activationsLeft = this._abilityDef.activationLimit;
         this._abilityButton.setQuantity(this._activationsLeft);
      }
      
      public function setBonusActivations(param1:int) : void
      {
         this._bonusActivationsLeft = param1;
         this._abilityButton.setBonusQuantity(this._bonusActivationsLeft);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.isInCooldownPeriod())
         {
            _loc2_ = this._cooldownTimeLeft - param1;
            if(_loc2_ <= 0)
            {
               this.exitCooldownPeriod();
            }
            else
            {
               this._cooldownTimeLeft = _loc2_;
               _loc3_ = this._cooldownTimeLeft / this._abilityDef.cooldown;
               this._abilityButton.setCooldownPercent(_loc3_);
            }
         }
         if(this.isInActivationPeriod())
         {
            _loc4_ = this._activationTimeLeft - param1;
            this._abilityBehaviour.update(param1);
            if(_loc4_ <= 0)
            {
               this.exitActivationPeriod();
            }
            else
            {
               this._activationTimeLeft = _loc4_;
            }
         }
      }
      
      public function requestToActivateAbility() : void
      {
         if(this.isInCooldownPeriod())
         {
            return;
         }
         if(false == this.hasActivationsLeft())
         {
            return;
         }
         var _loc1_:Boolean = true;
         if(this._bonusActivationsLeft > 0)
         {
            this.consumeBonus();
            _loc1_ = false;
            this.trackConsumeBonus();
         }
         else if(this._activationsLeft > 0)
         {
            this.consumeActivation();
         }
         if(_loc1_)
         {
            if(Main.instance.game.inGameMenu.bs.value < this._abilityDef.cost)
            {
               Main.instance.notEnoughBloonstonesSidePanel.reveal();
               return;
            }
            this.consumeBloonstones(this._abilityDef.cost);
         }
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.TRACK_ANTI_BOSS_ABILITY,{
            "type":this._abilityDef.type,
            "wasFree":!_loc1_
         }));
         this.activateAbility();
         if(false == this.hasActivationsLeft())
         {
            this._abilityButton.setIsDisabled(true);
         }
      }
      
      private function consumeBonus() : void
      {
         if(this._bonusActivationsLeft > 0)
         {
            this._bonusActivationsLeft--;
            this._abilityButton.setBonusQuantity(this._bonusActivationsLeft);
         }
      }
      
      private function consumeActivation() : void
      {
         if(this._activationsLeft > 0)
         {
            this._activationsLeft--;
            this._abilityButton.setQuantity(this._activationsLeft);
         }
      }
      
      private function consumeBloonstones(param1:int) : void
      {
         var amount:int = param1;
         Game.GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(amount,function(param1:Boolean, param2:int):void
         {
            if(param1)
            {
               trackConsumeBloonstones();
            }
         },true);
      }
      
      public function activateAbility() : void
      {
         this._activationTimeLeft = this._abilityDef.duration;
         this._cooldownTimeLeft = this._abilityDef.cooldown;
         var _loc1_:Boolean = this._abilityButton.getIsOver();
         this._abilityBehaviour.activate();
         if(this._abilityDef.duration <= 0)
         {
            this.exitActivationPeriod();
         }
         if(this._abilityDef.cooldown <= 0)
         {
            this.exitCooldownPeriod();
            if(_loc1_)
            {
               this._abilityButton.clipInner.gotoAndStop(AntiBossAbilityButton.BUTTON_STATE_OVER);
            }
         }
      }
      
      public function hasActivationsLeft() : Boolean
      {
         if(-1 == this._activationsLeft)
         {
            return true;
         }
         return this._activationsLeft > 0 || this._bonusActivationsLeft > 0;
      }
      
      public function onBossSpawned() : void
      {
         this.disable(false);
      }
      
      public function onBossDespawned() : void
      {
         this.disable(true);
      }
      
      private function disable(param1:Boolean) : void
      {
         this._abilityButton.setIsDisabled(param1);
      }
      
      public function isInCooldownPeriod() : Boolean
      {
         return this._cooldownTimeLeft > 0;
      }
      
      public function isInActivationPeriod() : Boolean
      {
         return this._activationTimeLeft > 0;
      }
      
      private function trackConsumeBonus() : void
      {
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_ANTI_BOSS_ABILITY_BONUS + this._abilityDef.tooltipName,{"howMany":1}));
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_ANTI_BOSS_ABILITY,{"type":this._abilityDef.type}));
      }
      
      private function trackConsumeBloonstones() : void
      {
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_ANTI_BOSS_ABILITY_BLOONSTONES + this._abilityDef.tooltipName,{"howMany":1}));
      }
   }
}
