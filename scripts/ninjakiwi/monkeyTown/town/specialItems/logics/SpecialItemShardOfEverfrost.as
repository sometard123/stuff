package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemShardOfEverfrost extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemShardOfEverfrost(param1:SpecialItemDefinition, param2:int = 0)
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
         _loc2_ = getTowerParam(param1,"IceTower");
         _loc2_["iceEffectLifespanByPercentage"] = 1.05;
         _loc2_["reloadTimeByPercentage"] = 0.95;
         _loc2_ = getTowerParam(param1,"ArcticWind");
         _loc2_["iceEffectLifespanByPercentage"] = 1.05;
         _loc2_["reloadTimeByPercentage"] = 0.95;
         _loc2_ = getTowerParam(param1,"ViralFrost");
         _loc2_["iceEffectLifespanByPercentage"] = 1.05;
         _loc2_["reloadTimeByPercentage"] = 0.95;
         _loc2_ = getTowerParam(param1,"IceShards");
         _loc2_["iceEffectLifespanByPercentage"] = 1.05;
         _loc2_["reloadTimeByPercentage"] = 0.95;
         _loc2_ = getTowerParam(param1,"AbsoluteZero");
         _loc2_["iceEffectLifespanByPercentage"] = 1.05;
         _loc2_["reloadTimeByPercentage"] = 0.95;
      }
   }
}
