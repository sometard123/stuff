package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   
   public class HealthCashChance implements IBuffMethodModule
   {
       
      
      public function HealthCashChance()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         if(ActiveAbilityEmpower.instance.healthCashStunTier < ActiveAbilityEmpower.EMPOWER_ABILITY_TIER_HEALTH_CASH)
         {
            ActiveAbilityEmpower.instance.healthCashStunTier = ActiveAbilityEmpower.EMPOWER_ABILITY_TIER_HEALTH_CASH;
         }
         ActiveAbilityEmpower.instance.healthCashStunChance = param1.buffValue;
      }
   }
}
