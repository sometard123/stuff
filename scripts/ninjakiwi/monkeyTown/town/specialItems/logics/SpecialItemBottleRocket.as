package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemBottleRocket extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemBottleRocket(param1:SpecialItemDefinition, param2:int = 0)
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
         _loc2_ = getTowerParam(param1,"BombTower");
         _loc2_["upgrade"] = {
            "path":2,
            "tier":2,
            "extraAttackRangeByPercentage":0.1
         };
         _loc2_ = getTowerParam(param1,"ClusterBombTower");
         _loc2_["attackRangeByPercentage"] = 1.1;
         _loc2_ = getTowerParam(param1,"BloonImpactBombTower");
         _loc2_["attackRangeByPercentage"] = 1.1;
         _loc2_ = getTowerParam(param1,"MoabMauler");
         _loc2_["attackRangeByPercentage"] = 1.1;
         _loc2_ = getTowerParam(param1,"MoabAssassin");
         _loc2_["attackRangeByPercentage"] = 1.1;
      }
   }
}
