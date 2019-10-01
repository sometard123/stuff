package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   
   public class HealthChance implements IBuffMethodModule
   {
       
      
      public function HealthChance()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         if(ActiveAbilityEmpower.instance.healthCashStunTier < ActiveAbilityEmpower.EMPOWER_ABILITY_TIER_HEALTH)
         {
            ActiveAbilityEmpower.instance.healthCashStunTier = ActiveAbilityEmpower.EMPOWER_ABILITY_TIER_HEALTH;
         }
         ActiveAbilityEmpower.instance.healthCashStunChance = param1.buffValue;
      }
   }
}
