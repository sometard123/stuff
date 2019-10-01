package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   
   public class AbilityEmpowerAttackCooldown implements IBuffMethodModule
   {
       
      
      public function AbilityEmpowerAttackCooldown()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         ActiveAbilityEmpower.instance.attackSpeedMultiplier = ActiveAbilityEmpower.instance.attackSpeedMultiplier + (1 - param1.buffValue);
      }
   }
}
