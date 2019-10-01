package ninjakiwi.monkeyTown.btdModule.utils
{
   public class GameInRoundTimer extends GameSpeedTimer
   {
       
      
      public function GameInRoundTimer(param1:Number = 0, param2:int = 1)
      {
         super(param1,param2);
      }
      
      override public function process(param1:Number) : void
      {
         if(!Main.instance.game.level.isRoundInProgress())
         {
            return;
         }
         super.process(param1);
      }
   }
}
