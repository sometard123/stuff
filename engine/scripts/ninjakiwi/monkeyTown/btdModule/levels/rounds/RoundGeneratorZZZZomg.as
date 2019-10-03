package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.zzzzomg.SpecialTrackZZZZOMG;
   
   public class RoundGeneratorZZZZomg extends RoundGeneratorPvP
   {
       
      
      public function RoundGeneratorZZZZomg(param1:Level)
      {
         super(param1);
      }
      
      override public function get currentRoundDuration() : Number
      {
         return SpecialTrackZZZZOMG.TICK_FREQUENCY_SEC;
      }
   }
}
