package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   
   public class AbilityEmpowerPierceDuration implements IBuffMethodModule
   {
       
      
      public function AbilityEmpowerPierceDuration()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         ActiveAbilityEmpower.instance.empowerPierceDuration = param1.buffValue;
      }
   }
}
