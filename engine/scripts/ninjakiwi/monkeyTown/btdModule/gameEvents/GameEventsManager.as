package ninjakiwi.monkeyTown.btdModule.gameEvents
{
   import com.lgrey.events.LGDataEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   
   public class GameEventsManager
   {
       
      
      public function GameEventsManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         Main.instance.game.addEventListener(LevelEvent.ROUND_OVER,this.onRoundOver);
      }
      
      private function onRoundOver(param1:LevelEvent) : void
      {
         Main.instance.eventBridge.dispatchEvent(new LGDataEvent("roundOver",{
            "roundsCompleted":Main.instance.game.roundsCompleted + 1,
            "isContestedTerritory":Main.instance.game.gameRequest.isContestedTerritory
         }));
      }
   }
}
