package ninjakiwi.monkeyTown.town.gameEvents
{
   import org.osflash.signals.Signal;
   
   public class GameEventMonitor
   {
      
      public static const gameEventStarted:Signal = new Signal(GameplayEvent,GameEventSubManager);
      
      public static const gameEventEnded:Signal = new Signal(GameplayEvent,GameEventSubManager);
       
      
      private var _subManagers:Vector.<GameEventSubManager>;
      
      public function GameEventMonitor()
      {
         this._subManagers = new Vector.<GameEventSubManager>();
         super();
      }
      
      public function add(param1:GameEventSubManager) : void
      {
         this._subManagers.push(param1);
         this.monitor(param1);
      }
      
      private function monitor(param1:GameEventSubManager) : void
      {
         var _loc2_:GameplayEvent = param1.findCurrentEvent();
         if(_loc2_ !== null)
         {
            param1.callWhenCurrentEventEnds(this.onEventEnd);
         }
         else
         {
            param1.callWhenNextEventBecomesActive(this.onEventStart);
         }
      }
      
      private function onEventEnd(param1:GameplayEvent, param2:GameEventSubManager) : void
      {
         GameEventMonitor.gameEventEnded.dispatch(param1,param2);
         this.monitor(param2);
      }
      
      private function onEventStart(param1:GameplayEvent, param2:GameEventSubManager) : void
      {
         GameEventMonitor.gameEventStarted.dispatch(param1,param2);
         param2.callWhenCurrentEventEnds(this.onEventEnd);
      }
   }
}
