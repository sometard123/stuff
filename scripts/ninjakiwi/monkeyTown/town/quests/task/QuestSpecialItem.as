package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class QuestSpecialItem extends Quest
   {
       
      
      private var _specialItemCount:int = 0;
      
      private var _specialItemID:String = null;
      
      public function QuestSpecialItem(param1:String = null, param2:int = 0)
      {
         super();
         this._specialItemID = param1;
         this._specialItemCount = param2;
         symbolFrame = 6;
         AchieveSignal(SpecialItemStore.TREASURE_CHEST_AQUIRED);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(int(QuestCounter.getInstance().treasureCount) >= this._specialItemCount)
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            if(this._specialItemID == null || SpecialItemDefinition(rest[0]).id == this._specialItemID)
            {
               if(int(QuestCounter.getInstance().treasureCount) + 1 >= this._specialItemCount)
               {
                  achieved();
               }
            }
         }
      }
   }
}
