package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemNinjaScrolls extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemNinjaScrolls(param1:SpecialItemDefinition, param2:int = 0)
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
         getTowerParam(param1,"NinjaMonkey")["reloadTimeByPercentage"] = 0.95;
         getTowerParam(param1,"DoubleShot")["reloadTimeByPercentage"] = 0.95;
         getTowerParam(param1,"Bloonjitsu")["reloadTimeByPercentage"] = 0.95;
         getTowerParam(param1,"FlashBomb")["reloadTimeByPercentage"] = 0.95;
         getTowerParam(param1,"SabotageSupplyLines")["reloadTimeByPercentage"] = 0.95;
      }
   }
}
