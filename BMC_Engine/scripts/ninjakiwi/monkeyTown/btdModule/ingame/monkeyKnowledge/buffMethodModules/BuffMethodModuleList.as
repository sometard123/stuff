package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class BuffMethodModuleList
   {
       
      
      private const _allModules:Vector.<Class> = new <Class>[CostScale,CostSubtract,SightScale,BaseAttackCooldownScale,AttackCooldownScale,PierceAdd,ProjectileLifetimeScale,ProjectileSpeedScale,ProjectileAdd,HitAreaScale,LayersRemovedAdd,FootprintScale,Disposable,ImmunityBlack,CostSubtractBiggerBombs,CostSubtractBladeShooter,CostSubtractFullMetalJacket,CostScaleFlashBomb,DamageScaleMOAB,LifetimeAddPhoenix,PermafrostSlowAdd,PierceAddWhirlwind,PierceAddFrag,AttackCooldownScaleFireball,PurgeRegenChance,DamageAddCeramicSnapFreeze,ImmunityWhiteZebraSnapFreeze,PurgeRegenChanceLightning,CostSubtractLaserBlasts,CostSubtractSunGod,CooldownSubtractAnnihilation,SacrificeValueScaleSet,DamageScaleMOABShredder,DamageAddCeramicSpikedBall,PineappleSurpriseCooldownSet,CostSubtractSpectre,CostSubtractGlueSoak,CostSubtractCorrosiveGlue,PierceAddGlueSplatter,SlowScaleGlueAdd,CostSubtractMonkeyPirates,SightScaleLongerCannons,ProjectileAddGrape,AreaDiscountAdd,AreaRangeScale,AreaAttackSpeedAdd,AreaPopCashScaleAdd,LifetimeAddCallToArms,BananaCashAdd,BananasInRoundAdd,InterestRateAdd,EndOfRoundBalanceScaleAdd,SightScaleSentry,ImmunityCamoSentry,CooldownSubtractFoam,CostScaleOverclockBloonTrap,HealthScaleMOABSubtract,MovementScaleMOABSubtract,BaseTowersCostScale,UpgradesCostScale,TowerSellRefundPercentSet,BananaCashScale,AbilityCooldownsScale,AbilityEmpowerPierceDuration,AbilityEmpowerAttackCooldown,HealthChance,HealthCashChance,HealthCashStunChance,SignalFlareRemoveRegenCount,BurnyStuffDurationAdd,DamageAddTheBigOne,SpreadScale,CostSubtractBloontoniumDarts,CooldownSubtractSpikeStorm,BaseCostScale,PineappleSurpriseCooldownSet,PineappleSurpriseGrill,PierceAddSentry,ImmunityLeadSentry,ProjectileAddBloonjitsu,SightCollisionScaleArcticWind,EndOfRoundInterestScaleAdd,BananasInRoundAddBananaPlantation,WildCard];
      
      private const buffMethodModuleInstancesByClass:Dictionary = new Dictionary();
      
      private const buffMethodModuleClassesByShortClassName:Dictionary = new Dictionary();
      
      public function BuffMethodModuleList()
      {
         super();
         this.initData();
      }
      
      private function initData() : void
      {
         var _loc2_:Class = null;
         var _loc3_:IBuffMethodModule = null;
         var _loc4_:String = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._allModules.length)
         {
            _loc2_ = this._allModules[_loc1_];
            _loc3_ = new _loc2_();
            _loc4_ = this.getClassNameShortFromClass(_loc2_);
            this.buffMethodModuleInstancesByClass[_loc2_] = _loc3_;
            this.buffMethodModuleClassesByShortClassName[_loc4_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function getClassNameShortFromClass(param1:Class) : String
      {
         var _loc2_:String = null;
         _loc2_ = getQualifiedClassName(param1);
         var _loc3_:String = _loc2_.split("::").pop();
         return _loc3_;
      }
      
      public function getBuffMethodModuleClass(param1:String) : Class
      {
         this.doesModuleExistInListByString(param1);
         var _loc2_:Class = this.buffMethodModuleClassesByShortClassName[param1];
         return _loc2_;
      }
      
      public function invokeBuffMethod(param1:Buff) : void
      {
         if(param1.hasBeenInvoked)
         {
            return;
         }
         var _loc2_:IBuffMethodModule = this.getBuffMethodModule(param1.buffMethodModuleClass);
         _loc2_.invoke(param1);
         param1.HasBeenInvoked(true);
      }
      
      public function getBuffMethodModule(param1:Class) : IBuffMethodModule
      {
         var _loc3_:Error = null;
         var _loc2_:IBuffMethodModule = this.buffMethodModuleInstancesByClass[param1];
         if(null == _loc2_)
         {
            _loc3_ = new Error(new String("Could not find the buff method module instance by class: " + param1));
            throw _loc3_;
         }
         return _loc2_;
      }
      
      public function doesModuleExistInListByString(param1:String) : Boolean
      {
         var _loc3_:Error = null;
         var _loc2_:Boolean = this.buffMethodModuleClassesByShortClassName.hasOwnProperty(param1);
         if(false == _loc2_)
         {
            _loc3_ = new Error(new String("Could not find the buff method module class: " + param1));
            throw _loc3_;
         }
         return _loc2_;
      }
   }
}
