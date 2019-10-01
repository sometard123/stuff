package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestsListBoxClip;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class NotificationUI
   {
      
      public static const notificationStateChanged:Signal = new Signal();
      
      private static const DEFAULT_AUTOCLOSE_TIME:Number = 5;
       
      
      private var _infoButton:ButtonControllerBase;
      
      private var _newsButton:ButtonControllerBase;
      
      private var _listBox:QuestsListBoxClip;
      
      private var _currentIndex:int = 1;
      
      private var _totalIndex:int = 0;
      
      private var _listBoxInY:int = 0;
      
      private var _listBoxOutY:int = 0;
      
      private const ANIMATION_TERM:Number = 0.2;
      
      private var _upButton:ButtonControllerBase;
      
      private var _downButton:ButtonControllerBase;
      
      private const MESSAGE_BUILDING_COMPLETE:String = "Your <building name> has finished building.";
      
      private const MESSAGE_UPGRADE_COMPLETE:String = "Researching <upgrade name> is complete.";
      
      private const MESSAGE_QUEST_GIVEN:String = "New Quest: <short quest decription>";
      
      private const MESSAGE_QUEST_COMPLETE:String = "You completed the quest: <quest name>";
      
      private const MESSAGE_LEVEL_UP:String = "<city name> is now Level <level num>";
      
      private const MESSAGE_UNDER_ATTACK:String = "<city name> is under attack from <attacker name>!";
      
      private const MESSAGE_SPECIAL_MISSION_COMPLETE:String = "You completed the Special Mission <mission name>";
      
      private const MESSAGE_PVP_ATTACK_SUCCESS:String = "Your attack on <playername> was successful, you stole $<amount> City Cash from them.";
      
      private const MESSAGE_PVP_ATTACK_FAIL:String = "Your attack on <playername> was defended successfully...";
      
      private const MESSAGE_HONOR_GAIN:String = "You have gained <honor> honor.";
      
      private const MESSAGE_HONOR_LOST:String = "You have lost <honor> honor.";
      
      private var listenersAreActive:Boolean = false;
      
      private var _listBoxVisible:Boolean = false;
      
      private const MAX_NOTIFICATIONS:int = 10;
      
      private var _notifications:Vector.<String>;
      
      public function NotificationUI(param1:MovieClip, param2:MovieClip, param3:QuestsListBoxClip)
      {
         this._notifications = new Vector.<String>();
         super();
         this._listBox = param3;
         this._listBoxInY = this._listBox.y;
         this._listBoxOutY = this._listBox.y + 200;
         this._listBoxVisible = false;
         this._listBox.y = this._listBoxOutY;
         this._listBox.listText.htmlText = "";
         this._infoButton = new ButtonControllerBase(param1);
         this._infoButton.setClickFunction(this.infoButtonClicked);
         this._newsButton = new ButtonControllerBase(param2);
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            this._newsButton.disableMouseInteraction();
            this._newsButton.fadeOut(0);
         }
         else
         {
            this._newsButton.setClickFunction(this.newsButtonClicked);
         }
         this._upButton = new ButtonControllerBase(param3.listArrowUp);
         this._downButton = new ButtonControllerBase(param3.listArrowDown);
         this._upButton.setClickFunction(this.onUpClicked);
         this._downButton.setClickFunction(this.onDownClicked);
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         this.glow(false);
      }
      
      private function onReset() : void
      {
         this._listBox.listText.htmlText = "";
         this._notifications.length = 0;
         this.removeListeners();
      }
      
      public function startNotification() : void
      {
         this.addListeners();
      }
      
      private function addListeners() : void
      {
         if(this.listenersAreActive)
         {
            return;
         }
         this.listenersAreActive = true;
         Building.buildingWasCompletedSignal.add(this.onBuildingComplete);
         GameSignals.UPGRADE_WARMUP_COMPLETE.add(this.onUpgradeComplete);
         Quest.QUEST_GIVEN_SIGNAL.add(this.onQuestGiven);
         Quest.QUEST_FINISHED_SIGNAL.add(this.onQuestComplete);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
         ResourceStore.getInstance().honourChangedDiffSignal.add(this.onHonorChanged);
      }
      
      private function removeListeners() : void
      {
         this.listenersAreActive = false;
         Building.buildingWasCompletedSignal.remove(this.onBuildingComplete);
         GameSignals.UPGRADE_WARMUP_COMPLETE.remove(this.onUpgradeComplete);
         Quest.QUEST_GIVEN_SIGNAL.remove(this.onQuestGiven);
         Quest.QUEST_FINISHED_SIGNAL.remove(this.onQuestComplete);
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         ResourceStore.getInstance().honourChangedDiffSignal.remove(this.onHonorChanged);
      }
      
      private function glow(param1:Boolean = true) : void
      {
         if(this._infoButton.target.glowBook != null)
         {
            this._infoButton.target.glowBook.visible = param1;
         }
         if(this._infoButton.target.glowBG != null)
         {
            this._infoButton.target.glowBG.visible = param1;
         }
      }
      
      private function onBuildingComplete(param1:Building) : void
      {
         this.addNotification(this.MESSAGE_BUILDING_COMPLETE.split("<building name>").join(param1.definition.name));
      }
      
      private function onUpgradeComplete(param1:UpgradePathTierDefinition, param2:UpgradePathStateDefinition) : void
      {
         this.addNotification(this.MESSAGE_UPGRADE_COMPLETE.split("<upgrade name>").join(param1.name));
      }
      
      private function onQuestGiven(param1:Quest) : void
      {
         this.addNotification(this.MESSAGE_QUEST_GIVEN.split("<short quest decription>").join(param1.description));
      }
      
      private function onQuestComplete(param1:Quest) : void
      {
         this.addNotification(this.MESSAGE_QUEST_COMPLETE.split("<quest name>").join(param1.name));
      }
      
      private function onTownLevelChanged(param1:int) : void
      {
         this.addNotification(this.MESSAGE_LEVEL_UP.split("<level num>").join(String(ResourceStore.getInstance().townLevel)).split("<city name>").join(MonkeySystem.getInstance().city.name));
      }
      
      private function onHonorChanged(param1:int) : void
      {
         if(param1 > 60)
         {
            return;
         }
         if(param1 > 0)
         {
            this.addNotification(this.MESSAGE_HONOR_GAIN.split("<honor>").join(String(param1)));
         }
         else if(param1 < 0)
         {
            this.addNotification(this.MESSAGE_HONOR_LOST.split("<honor>").join(String(-param1)));
         }
      }
      
      private function addNotification(param1:String) : void
      {
         this.addMessage(param1);
         this._notifications.unshift(param1);
         this._totalIndex++;
         if(this._notifications.length > this.MAX_NOTIFICATIONS)
         {
            this._notifications.pop();
         }
         notificationStateChanged.dispatch();
         this.glow();
      }
      
      public function addMessage(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 5) : void
      {
         this._listBox.listText.htmlText = "<b>" + param1 + "</b>" + "<br/>" + this._listBox.listText.htmlText;
         if(param2)
         {
            this.open(param3,param4);
         }
      }
      
      private function infoButtonClicked() : void
      {
         if(this._listBoxVisible)
         {
            this.close();
         }
         else
         {
            this.open();
         }
      }
      
      private function newsButtonClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().newsPanelScroller);
      }
      
      private function open(param1:Boolean = false, param2:Number = 5) : void
      {
         if(this._listBoxVisible)
         {
            return;
         }
         TweenLite.to(this._listBox,this.ANIMATION_TERM,{"y":this._listBoxInY});
         this._listBoxVisible = true;
         this.activateAutoClose(param2);
         this.glow(false);
      }
      
      private function activateAutoClose(param1:Number) : void
      {
         this.cancelAutoClose();
         TweenLite.delayedCall(param1,this.close);
      }
      
      private function cancelAutoClose() : void
      {
         TweenLite.killDelayedCallsTo(this.close);
      }
      
      private function close() : void
      {
         TweenLite.to(this._listBox,this.ANIMATION_TERM,{"y":this._listBoxOutY});
         this._listBoxVisible = false;
      }
      
      private function onUpClicked() : void
      {
         this.cancelAutoClose();
         this._currentIndex = this._currentIndex - 1;
         if(this._currentIndex < 1)
         {
            this._currentIndex = 1;
         }
         this._listBox.listText.scrollV = this._currentIndex;
      }
      
      private function onDownClicked() : void
      {
         this.cancelAutoClose();
         this._currentIndex = this._currentIndex + 1;
         if(this._currentIndex >= this._listBox.listText.maxScrollV)
         {
            this._currentIndex = this._listBox.listText.maxScrollV - 1;
         }
         this._listBox.listText.scrollV = this._currentIndex;
      }
      
      public function getSaveData() : Object
      {
         var _loc1_:Object = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < this._notifications.length)
         {
            _loc1_[_loc2_] = this._notifications[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function setSaveData(param1:Object) : void
      {
         this._notifications = new Vector.<String>();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_NOTIFICATIONS)
         {
            if(param1[_loc2_] != null)
            {
               this._notifications.push(String(param1[_loc2_]));
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._notifications.length)
         {
            this.addMessage(this._notifications[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(param1)
         {
            this._infoButton.fadeIn(0);
            this._newsButton.fadeIn(0);
         }
         else
         {
            this._infoButton.fadeOut(0);
            this._newsButton.fadeOut(0);
         }
      }
   }
}
