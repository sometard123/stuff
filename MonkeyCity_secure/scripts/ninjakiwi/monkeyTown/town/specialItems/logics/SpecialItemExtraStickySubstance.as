package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemExtraStickySubstance extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemExtraStickySubstance(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function clear() : void
      {
         super.clear();
         MonkeyCityMain.getInstance().signals.btdGameRequestSet.remove(this.onBTDGameRequestSet);
      }
      
      override protected function applyAbility() : void
      {
         super.applyAbility();
         MonkeyCityMain.getInstance().signals.btdGameRequestSet.add(this.onBTDGameRequestSet);
      }
      
      private function onBTDGameRequestSet(param1:BTDGameRequest) : void
      {
         var _loc2_:Object = null;
         _loc2_ = getTowerParam(param1,"GlueGunner");
         _loc2_["glueEffectLifespanByPercentage"] = 1.2;
         _loc2_["glueEffectSpeedScale"] = -0.05;
         _loc2_ = getTowerParam(param1,"BloonDisolver");
         _loc2_["glueEffectLifespanByPercentage"] = 1.2;
         _loc2_["glueEffectSpeedScale"] = -0.05;
         _loc2_ = getTowerParam(param1,"BloonLiquefier");
         _loc2_["glueEffectLifespanByPercentage"] = 1.2;
         _loc2_["glueEffectSpeedScale"] = -0.05;
         _loc2_ = getTowerParam(param1,"GlueHose");
         _loc2_["glueEffectLifespanByPercentage"] = 1.2;
         _loc2_["glueEffectSpeedScale"] = -0.05;
         _loc2_ = getTowerParam(param1,"GlueStrike");
         _loc2_["glueEffectLifespanByPercentage"] = 1.2;
         _loc2_["glueEffectSpeedScale"] = -0.05;
      }
   }
}
