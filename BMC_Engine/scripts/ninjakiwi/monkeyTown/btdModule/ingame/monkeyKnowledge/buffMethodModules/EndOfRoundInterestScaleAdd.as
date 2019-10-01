package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class EndOfRoundInterestScaleAdd implements IBuffMethodModule
   {
       
      
      public function EndOfRoundInterestScaleAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         Main.instance.game.endOfRoundAddInterestScalar = Main.instance.game.endOfRoundAddInterestScalar + param1.buffValue;
      }
   }
}
