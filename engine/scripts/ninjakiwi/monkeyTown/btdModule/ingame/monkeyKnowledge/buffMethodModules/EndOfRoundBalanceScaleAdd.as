package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class EndOfRoundBalanceScaleAdd implements IBuffMethodModule
   {
       
      
      public function EndOfRoundBalanceScaleAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         Main.instance.game.endOfRoundAwardScalar = Main.instance.game.endOfRoundAwardScalar + param1.buffValue;
      }
   }
}
