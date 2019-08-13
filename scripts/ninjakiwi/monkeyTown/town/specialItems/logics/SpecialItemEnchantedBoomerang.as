package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemEnchantedBoomerang extends SpecialItemInBTDGame
   {
       
      
      public function SpecialItemEnchantedBoomerang(param1:SpecialItemDefinition, param2:int = 0)
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
         getTowerParam(param1,"BoomerangThrower")["addPierce"] = 1;
         getTowerParam(param1,"GlaiveRiccochet")["addPierce"] = 1;
         getTowerParam(param1,"GlaiveLord")["addPierce"] = 1;
         getTowerParam(param1,"BioninBoomer")["addPierce"] = 1;
         getTowerParam(param1,"TurboCharge")["addPierce"] = 1;
      }
   }
}
