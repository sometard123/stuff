package ninjakiwi.monkeyTown.town.quests.task.capture
{
   import com.greensock.TweenLite;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.town.quests.task.QuestCapture;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.path;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestCaptureDifficulty extends QuestCapture
   {
      
      public static const EQUAL:int = 0;
      
      public static const HIGHER_THAN:int = 1;
       
      
      private var _difficulty:int = -1;
      
      private var _type:int = 1;
      
      public function QuestCaptureDifficulty(param1:int = 1, param2:int = -1)
      {
         super();
         this._difficulty = param2;
         this._type = param1;
      }
      
      override public function checkPreAchieved() : Boolean
      {
         return false;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:Tile = null;
         var _loc3_:TownMap = null;
         var _loc4_:TileAttackDefinition = null;
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            _loc2_ = Tile(rest[0]);
         }
         if(rest != null && rest.length > 1 && rest[1] != null)
         {
            _loc3_ = TownMap(rest[1]);
         }
         if(rest != null && rest.length > 2 && rest[2] != null)
         {
            _loc4_ = TileAttackDefinition(rest[2]);
         }
         if(_loc3_ == null || _loc2_ == null || _loc4_ == null)
         {
            ErrorReporter.error("QuestCaptureDifficulty::checkAchieveConditions - map & tile & attackDef cannot be null");
         }
         switch(this._type)
         {
            case HIGHER_THAN:
               if(_loc4_.difficultyRankRelativeToMTL < this._difficulty)
               {
                  return;
               }
               break;
            case EQUAL:
         }
         super.checkAchieveConditions(rest[0],rest[1]);
      }
   }
}
