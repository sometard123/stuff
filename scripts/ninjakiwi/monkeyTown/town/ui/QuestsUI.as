package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestsUIClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelGroups;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class QuestsUI extends Sprite
   {
      
      public static const CLICK_FOR_VIEW_DETAIL:Boolean = true;
      
      private static const INFO_PANEL_IN_X:int = 90;
      
      private static const INFO_PANEL_OUT_X:int = -300;
       
      
      private var _clip:QuestsUIClip;
      
      private var _buttonManager:QuestsUIButtonManager;
      
      private const _infoPanelContainer:Sprite = new Sprite();
      
      private var _container:DisplayObjectContainer;
      
      private var _infoPanelList:Vector.<QuestInfoPanel>;
      
      private var _infoSlideoutManager:QuestInfoSlideoutManager;
      
      private var _enable:Boolean = false;
      
      public var completePanelHideSignal:Signal;
      
      public function QuestsUI(param1:DisplayObjectContainer, param2:QuestsUIClip)
      {
         this._infoPanelList = new Vector.<QuestInfoPanel>();
         this._infoSlideoutManager = new QuestInfoSlideoutManager();
         this.completePanelHideSignal = new Signal(Quest);
         super();
         this._clip = param2;
         this._container = param1;
         this._clip.removeChild(this._clip.questButton1);
         this._clip.removeChild(this._clip.questButton2);
         this._clip.removeChild(this._clip.questButton3);
         this._clip.removeChild(this._clip.questButton4);
         this._clip.removeChild(this._clip.questButton5);
         this._buttonManager = new QuestsUIButtonManager(this._clip,this._clip.listArrowUp,this._clip.listArrowDown);
         this._buttonManager.buttonOverSignal.add(this.onOverButton);
         this._buttonManager.buttonOutSignal.add(this.onOutButton);
         this._buttonManager.buttonClickSignal.add(this.onClickButton);
         this._buttonManager.buttonRefreshed.add(this.onButtonRefreshed);
         this._clip.addChild(this._infoPanelContainer);
         FirstTimeTriggerManager.firstTimeTutorialFinished.addOnce(this.startQuest);
      }
      
      public function reset() : void
      {
         FirstTimeTriggerManager.firstTimeTutorialFinished.remove(this.startQuest);
         this._infoPanelList = new Vector.<QuestInfoPanel>();
         this._buttonManager.reset();
         FirstTimeTriggerManager.firstTimeTutorialFinished.addOnce(this.startQuest);
      }
      
      public function cancelSelection() : void
      {
         this._buttonManager.cancelButtons();
      }
      
      private function startQuest() : void
      {
         this.enable = true;
         this.refreshQuests();
      }
      
      public function refreshQuests(param1:Boolean = false) : void
      {
         if(!this._enable)
         {
            return;
         }
         this._buttonManager.refreshButtons(param1);
      }
      
      public function addQuest(param1:Quest, param2:Boolean) : void
      {
         this._buttonManager.addQuestButton(param1);
         var _loc3_:QuestInfoPanel = new QuestInfoPanel(param1,this._infoPanelContainer,INFO_PANEL_IN_X,INFO_PANEL_OUT_X);
         this._infoPanelList.push(_loc3_);
         if(!param2)
         {
            this.onClickButton(this._buttonManager.findQuestButton(param1));
         }
      }
      
      public function finishQuest(param1:Quest) : void
      {
         var _loc4_:int = 0;
         var _loc2_:QuestInfoPanel = this.findQuestInfoPanel(param1);
         if(_loc2_ != null)
         {
            _loc4_ = this._infoPanelList.indexOf(_loc2_);
            if(_loc4_ != -1)
            {
               this._infoPanelList.splice(_loc4_,1);
            }
         }
         var _loc3_:QuestCompletePanel = new QuestCompletePanel(param1,this._container);
         _loc3_.onRevealSignal.addOnce(this.onCompletePopupRevealed);
         _loc3_.onHideSignal.addOnce(this.onCompletePopupHide);
         PanelManager.getInstance().showPanel(_loc3_,PanelGroups.QUESTS);
      }
      
      private function onCompletePopupRevealed(param1:HideRevealView) : void
      {
         var _loc3_:Quest = null;
         var _loc2_:QuestCompletePanel = param1 as QuestCompletePanel;
         try
         {
            _loc3_ = _loc2_.quest;
            this._buttonManager.highlightButton(this._buttonManager.findQuestButton(_loc3_));
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function onCompletePopupHide(param1:HideRevealView) : void
      {
         var _loc3_:Quest = null;
         var _loc2_:QuestCompletePanel = param1 as QuestCompletePanel;
         try
         {
            _loc3_ = _loc2_.quest;
            this._buttonManager.hideQuestButtonAndRemove(this._buttonManager.findQuestButton(_loc3_));
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function onOverButton(param1:QuestButton) : void
      {
         var _loc2_:QuestInfoPanel = null;
         if(!CLICK_FOR_VIEW_DETAIL)
         {
            if(MonkeyCityMain.isInGame)
            {
               return;
            }
            _loc2_ = this.findQuestInfoPanel(param1.quest);
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.setYPosition(this._buttonManager.getYPositionAtParentContainer(param1));
            this._infoSlideoutManager.showPanel(_loc2_);
         }
      }
      
      private function onOutButton(param1:QuestButton) : void
      {
         var _loc2_:QuestInfoPanel = null;
         if(!CLICK_FOR_VIEW_DETAIL)
         {
            _loc2_ = this.findQuestInfoPanel(param1.quest);
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.hide();
         }
      }
      
      private function onClickButton(param1:QuestButton) : void
      {
         var _loc2_:QuestInfoPanel = null;
         if(CLICK_FOR_VIEW_DETAIL)
         {
            if(MonkeyCityMain.isInGame)
            {
               return;
            }
            if(param1 == null)
            {
               return;
            }
            _loc2_ = this.findQuestInfoPanel(param1.quest);
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.revealStartSignal.addOnce(this.infoPanelStartReveal);
            _loc2_.onHideSignal.addOnce(this.onInfoPanelHide);
            _loc2_.onRevealSignal.addOnce(this.onInfoPanelReveal);
            this._infoSlideoutManager.showPanel(_loc2_);
         }
      }
      
      private function onInfoPanelHide(param1:QuestInfoPanel) : void
      {
         var _loc2_:QuestButton = this._buttonManager.findQuestButton(param1.quest);
         if(_loc2_ != null)
         {
            _loc2_.checked();
            _loc2_.cancelSelect();
         }
      }
      
      private function infoPanelStartReveal(param1:QuestInfoPanel) : void
      {
         this.setInfoPanelYPosition(param1);
      }
      
      private function onInfoPanelReveal(param1:QuestInfoPanel) : void
      {
         this.setInfoPanelYPosition(param1);
      }
      
      private function setInfoPanelYPosition(param1:QuestInfoPanel) : void
      {
         var _loc2_:QuestButton = this._buttonManager.findQuestButton(param1.quest);
         if(_loc2_ == null)
         {
            return;
         }
         param1.setYPosition(this._buttonManager.highlightButton(_loc2_));
      }
      
      private function onButtonRefreshed(param1:QuestButton) : void
      {
         var _loc2_:QuestInfoPanel = this.findQuestInfoPanel(param1.quest);
         if(_loc2_ == null)
         {
            return;
         }
         this.setInfoPanelYPosition(_loc2_);
      }
      
      public function set enable(param1:Boolean) : void
      {
         this._enable = param1;
         this._buttonManager.enable = this._enable;
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      private function findQuestInfoPanel(param1:Quest) : QuestInfoPanel
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._infoPanelList.length)
         {
            if(this._infoPanelList[_loc2_].quest == param1)
            {
               return this._infoPanelList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
