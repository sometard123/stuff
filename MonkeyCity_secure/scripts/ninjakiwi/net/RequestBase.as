package ninjakiwi.net
{
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.QuestData;
   
   public class RequestBase extends EventDispatcher
   {
       
      
      public var isSave:Boolean = false;
      
      public var batchGroup:String = null;
      
      public var allowBatchCollapsing:Boolean = true;
      
      public function RequestBase()
      {
         super();
      }
      
      public function setRetry() : void
      {
      }
      
      public function go() : void
      {
      }
      
      public function end(param1:Object = null) : void
      {
      }
      
      public function cancel() : void
      {
      }
   }
}
