package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestMorePreparation extends Quest
   {
       
      
      private const DATA_VARIABLE_NAME:String = "hardRatedLandProgress";
      
      protected var _targetHardRatedLand:int;
      
      public function QuestMorePreparation(param1:int)
      {
         super();
         this._targetHardRatedLand = param1;
      }
      
      override public function activate() : void
      {
         super.activate();
         if(null == QuestCounter.getInstance().getCustomValue(this.DATA_VARIABLE_NAME))
         {
            QuestCounter.getInstance().setCustomValue(this.DATA_VARIABLE_NAME,0);
         }
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:TileAttackDefinition = null;
         if(rest != null && rest.length > 1 && rest[2] != null)
         {
            _loc2_ = TileAttackDefinition(rest[2]);
         }
         if(_loc2_ == null)
         {
            ErrorReporter.error("QuestMorePreparation::checkAchieveConditions - tileAttackDefinition cannot be null");
            return;
         }
         var _loc3_:Object = QuestCounter.getInstance().getCustomValue(this.DATA_VARIABLE_NAME);
         if(null == _loc3_)
         {
            return;
         }
         if(_loc2_.difficultyRankRelativeToMTL < 3)
         {
            return;
         }
         _loc3_ = _loc3_ + 1;
         QuestCounter.getInstance().setCustomValue(this.DATA_VARIABLE_NAME,_loc3_);
         if(_loc3_ >= this._targetHardRatedLand)
         {
            super.checkAchieveConditions();
         }
      }
   }
}
