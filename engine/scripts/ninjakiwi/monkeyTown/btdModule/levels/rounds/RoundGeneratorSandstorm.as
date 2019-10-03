package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class RoundGeneratorSandstorm extends RoundGeneratorPvP
   {
       
      
      public function RoundGeneratorSandstorm(param1:Level)
      {
         super(param1);
      }
      
      override public function generate(param1:BTDGameRequest) : void
      {
         super.generate(param1);
         _rounds = _rounds.slice(8);
         _totalRounds.value = _rounds.length;
      }
   }
}
