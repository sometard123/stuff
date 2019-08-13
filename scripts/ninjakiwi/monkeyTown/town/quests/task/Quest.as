package ninjakiwi.monkeyTown.town.quests.task
{
   import com.codecatalyst.promise.Promise;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestData;
   import ninjakiwi.monkeyTown.town.quests.QuestDefinition;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BossIsHidingCustomButtons;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class Quest extends QuestDefinition
   {
      
      private static const STATE_DEACTIVATED:int = 0;
      
      private static const STATE_ACTIVATED:int = 1;
      
      private static const STATE_ACHIEVED:int = 2;
      
      private static const STATE_RECEIVED:int = 3;
      
      public static const EXTRA_NONE:int = 0;
      
      public static const EXTRA_TREASURE_VISIBLE:int = 1;
      
      public static const EXTRA_DEFENDING_FINISHED:int = 2;
      
      public static const EXTRA_HAVE_MONKEY_ACADEMY:int = 3;
      
      public static const EXTRA_SPECIAL_TERRAIN_VISIBLE:int = 4;
      
      public static const EXTRA_HAVE_MONKEY_ACADEMY_AND_BOOMERANG_HUT:int = 5;
      
      public static const QUEST_GIVEN_SIGNAL:Signal = new Signal(Quest);
      
      public static const QUEST_FINISHED_SIGNAL:Signal = new Signal(Quest);
      
      public static const NEED_TO_REFRESH_LIST_SIGNAL:Signal = new Signal(Quest);
       
      
      private var state:int = 0;
      
      private var _prevQuest:Quest;
      
      public var extraCondition:int = 0;
      
      public var finishedSignal:Signal;
      
      public function Quest()
      {
         this.finishedSignal = new Signal(Quest);
         super();
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      protected function onReset() : void
      {
         this.state = STATE_DEACTIVATED;
      }
      
      public function preSetPrevQuest() : void
      {
         if(completingID != null)
         {
            this._prevQuest = QuestData.findQuest(completingID);
         }
      }
      
      public function ExtraCondition(param1:int) : Quest
      {
         this.extraCondition = param1;
         return this;
      }
      
      public function checkPreAchieved() : Boolean
      {
         return false;
      }
      
      protected function checkAchieveConditions(... rest) : void
      {
         this.achieved();
      }
      
      protected function achieved() : void
      {
         if(achieveSignal != null)
         {
            achieveSignal.remove(this.checkAchieveConditions);
         }
         this.state = STATE_ACHIEVED;
         this.finishedSignal.dispatch(this);
         QUEST_FINISHED_SIGNAL.dispatch(this);
      }
      
      public function activate() : void
      {
         if(achieveSignal != null)
         {
            achieveSignal.remove(this.checkAchieveConditions);
            achieveSignal.add(this.checkAchieveConditions);
         }
         this.state = STATE_ACTIVATED;
         QUEST_GIVEN_SIGNAL.dispatch(this);
      }
      
      public function deactivate() : void
      {
         if(achieveSignal != null)
         {
            achieveSignal.remove(this.checkAchieveConditions);
         }
         this.state = STATE_DEACTIVATED;
      }
      
      public function setAsAchieved() : void
      {
         this.state = STATE_ACHIEVED;
         QUEST_FINISHED_SIGNAL.dispatch(this);
         if(achieveSignal != null)
         {
            achieveSignal.remove(this.checkAchieveConditions);
         }
      }
      
      public function setAsReceived(param1:Boolean = false) : void
      {
         this.state = STATE_RECEIVED;
         if(param1)
         {
            QUEST_FINISHED_SIGNAL.dispatch(this);
         }
         if(achieveSignal != null)
         {
            achieveSignal.remove(this.checkAchieveConditions);
         }
      }
      
      public function receiveReward() : void
      {
         this.state = STATE_RECEIVED;
         GameMods.awardCash(rewardMonkeyMoney);
         GameMods.awardXP(rewardXP);
      }
      
      public function isAchieved() : Boolean
      {
         if(this.state == STATE_ACHIEVED)
         {
            return true;
         }
         return false;
      }
      
      public function isDeactivated() : Boolean
      {
         if(this.state == STATE_DEACTIVATED)
         {
            return true;
         }
         return false;
      }
      
      public function isReceived() : Boolean
      {
         if(this.state == STATE_RECEIVED)
         {
            return true;
         }
         return false;
      }
      
      public function get prevQuest() : Quest
      {
         return this._prevQuest;
      }
      
      public function isAvailableToCity(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < cityAvailability.length)
         {
            _loc3_ = cityAvailability[_loc2_];
            if(_loc3_ === param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
