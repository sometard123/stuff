package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemMagicSpanner extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemMagicSpanner(param1:SpecialItemDefinition, param2:int = 0)
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
         _loc2_ = getTowerParam(param1,"MonkeyBuccaneer");
         _loc2_["costByPercentage"] = 0.95;
         _loc2_["upgrade"] = {"costByPercentage":0.95};
         _loc2_ = getTowerParam(param1,"MonkeyAce");
         _loc2_["costByPercentage"] = 0.95;
         _loc2_["upgrade"] = {"costByPercentage":0.95};
      }
   }
}
