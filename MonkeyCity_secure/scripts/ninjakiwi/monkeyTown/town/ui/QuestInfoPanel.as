package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.HideRevealViewHorizontalSlide;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class QuestInfoPanel extends HideRevealViewHorizontalSlide
   {
       
      
      private const _clip:QuestInfoPanelClip = new QuestInfoPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private var _quest:Quest;
      
      public function QuestInfoPanel(param1:Quest, param2:DisplayObjectContainer, param3:int, param4:int)
      {
         super(param2,param3,param4);
         this._quest = param1;
         this.isModal = true;
         addChild(this._clip);
         this._okButton.setClickFunction(this.hide);
         if(!QuestsUI.CLICK_FOR_VIEW_DETAIL)
         {
         }
         if(this._quest != null)
         {
            this._clip.descriptionBold.htmlText = this.removeFilter(this._quest.description);
            this._clip.description.htmlText = "<b>" + this._quest.longDescription + "</b>";
            this._clip.title.text = this._quest.name.toUpperCase();
            this._clip.rewardCash.text = LocalisationConstants.MONEY_SYMBOL + this._quest.rewardMonkeyMoney;
            this._clip.rewardXP.text = "" + this._quest.rewardXP;
         }
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
      }
      
      private function removeFilter(param1:String) : String
      {
         return param1;
      }
      
      public function setYPosition(param1:int = 0) : void
      {
         this._clip.y = param1 + 30;
         if(param1 < 100)
         {
            param1 = 100;
         }
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(0.2);
         MCSound.getInstance().playSound(MCSound.OPEN_QUEST_PANEL,0.6);
      }
      
      public function get quest() : Quest
      {
         return this._quest;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         MCSound.getInstance().playSound(MCSound.OPEN_QUEST_PANEL);
      }
      
      override protected function onRevealComplete() : void
      {
         super.onRevealComplete();
         if(!MonkeySystem.getInstance().flashStage.hasEventListener(MouseEvent.CLICK))
         {
            MonkeySystem.getInstance().flashStage.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.hide();
         if(MonkeySystem.getInstance().flashStage.hasEventListener(MouseEvent.CLICK))
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onReset(... rest) : void
      {
         if(MonkeySystem.getInstance().flashStage.hasEventListener(MouseEvent.CLICK))
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
   }
}
