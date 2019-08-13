package ninjakiwi.monkeyTown.town.quests.task.capture
{
   import com.greensock.TweenLite;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.path;
   
   public class QuestHunter extends Quest
   {
       
      
      protected var _capturedCount:int = 1;
      
      protected var _strongestIDList:Vector.<int> = null;
      
      public function QuestHunter(param1:int, param2:Vector.<int>)
      {
         super();
         this._capturedCount = param1;
         this._strongestIDList = param2;
         symbolFrame = 9;
         AchieveSignal(GameSignals.BTD_GAME_WON_SIGNAL);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         return false;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:GameResultDefinition = null;
         var _loc3_:int = 0;
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            _loc2_ = GameResultDefinition(rest[0]);
         }
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this._strongestIDList.length)
            {
               if(_loc2_.bloonTypeList != null)
               {
                  if(_loc2_.bloonTypeList.indexOf(this._strongestIDList[_loc3_]) != -1)
                  {
                     if(this._capturedCount == 1)
                     {
                        achieved();
                     }
                     else
                     {
                        this.saveCapturedCount(this._strongestIDList[_loc3_]);
                     }
                  }
               }
               _loc3_++;
            }
         }
         if(this._capturedCount > 1)
         {
            if(this.checkCount())
            {
               achieved();
            }
         }
      }
      
      private function checkCount() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._strongestIDList.length)
         {
            _loc2_ = _loc2_ + this.getCapturedCount(this._strongestIDList[_loc3_]);
            _loc3_++;
         }
         if(_loc2_ >= this._capturedCount)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function saveCapturedCount(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = QuestCounter.getInstance().getCustomValue("StrongestBloonType" + param1);
         if(_loc3_ != null)
         {
            _loc2_ = int(_loc3_);
         }
         QuestCounter.getInstance().setCustomValue("StrongestBloonType" + param1,_loc2_ + 1);
      }
      
      private function getCapturedCount(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Object = QuestCounter.getInstance().getCustomValue("StrongestBloonType" + param1);
         if(_loc3_ != null)
         {
            _loc2_ = int(_loc3_);
         }
         return _loc2_;
      }
   }
}
