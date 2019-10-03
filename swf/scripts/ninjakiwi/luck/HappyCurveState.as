package ninjakiwi.luck
{
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestoneDef;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackBase;
   
   public class HappyCurveState
   {
       
      
      protected var target:HappyCurve = null;
      
      var _persistentKeys:Array;
      
      var _allKeys:Array;
      
      var storedState:Object = null;
      
      public function HappyCurveState(param1:HappyCurve)
      {
         this._persistentKeys = ["growthRate","curve","charges","_bonusProbability","_generationsSinceHit"];
         this._allKeys = ["hitCurvePenalty","badLuckProtectionFactor","baseProbability","growthRate","curve","charges","protectAgainstBadLuck","badLuckProtectionThreshold","badLuckProtectionCurve","_badLuckProtectionGrowthRate","_bonusProbability","_generationsSinceHit"];
         super();
         this.target = param1;
      }
      
      public function getSaveData() : Object
      {
         var _loc1_:Object = this.read(this._persistentKeys);
         return _loc1_;
      }
      
      public function setSaveData(param1:Object) : void
      {
         this.write(param1,this._persistentKeys);
      }
      
      public function storeState() : void
      {
         this.storedState = this.read(this._allKeys);
      }
      
      public function rollBackState() : void
      {
         if(this.storedState !== null)
         {
            this.write(this.storedState,this._allKeys);
         }
      }
      
      public function read(param1:Array) : Object
      {
         var _loc4_:String = null;
         var _loc2_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc2_[_loc4_] = this.target[_loc4_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function write(param1:Object, param2:Array) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            if(param1.hasOwnProperty(_loc4_))
            {
               this.target[_loc4_] = param1[_loc4_];
            }
            _loc3_++;
         }
      }
   }
}
