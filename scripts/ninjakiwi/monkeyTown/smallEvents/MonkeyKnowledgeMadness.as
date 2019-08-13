package ninjakiwi.monkeyTown.smallEvents
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.QuestData;
   
   public class MonkeyKnowledgeMadness extends GameEventSubManager
   {
       
      
      private var _isMonkeyKnowledgeActive:INumber;
      
      public function MonkeyKnowledgeMadness()
      {
         this._isMonkeyKnowledgeActive = DancingShadows.getOne();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "monkeyKnowledgeMadness";
      }
      
      public function reset(... rest) : void
      {
         this._isMonkeyKnowledgeActive.value = 0;
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         this.reset();
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         SkuSettingsLoader.getGameEventDataByID("monkeyKnowledgeMadness",_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         if(null == param1 || false == param1.hasOwnProperty("enabled"))
         {
            this.reset();
            return;
         }
         this._isMonkeyKnowledgeActive.value = param1.enabled;
         callWhenCurrentEventEnds(this.reset);
      }
      
      public function getIsMonkeyKnowledgeMadnessActive() : Boolean
      {
         return this._isMonkeyKnowledgeActive.value != 0;
      }
   }
}
