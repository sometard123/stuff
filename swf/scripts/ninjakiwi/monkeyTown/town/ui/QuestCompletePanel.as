package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestCompletePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class QuestCompletePanel extends HideRevealViewPopup
   {
      
      public static const revealedSignal:Signal = new Signal();
      
      public static const collectButtonClickedSignal:Signal = new Signal();
       
      
      private const _clip:QuestCompletePanelClip = new QuestCompletePanelClip();
      
      private const _collectBtn:ButtonControllerBase = new ButtonControllerBase(this._clip.collectButton);
      
      private var _quest:Quest;
      
      public function QuestCompletePanel(param1:Quest, param2:DisplayObjectContainer, param3:* = null)
      {
         super(param2,param3);
         this._quest = param1;
         if(param1 != null)
         {
            this._clip.title.text = this._quest.name;
            this._clip.descriptionBold.htmlText = "<b>" + this._quest.description + "</b>";
            this._clip.rewardCash.text = LocalisationConstants.MONEY_SYMBOL + this._quest.rewardMonkeyMoney;
            this._clip.rewardXP.text = "" + this._quest.rewardXP;
            if(this._clip.questSymbol != null)
            {
               this._clip.questSymbol.gotoAndStop(param1.symbolFrame);
            }
         }
         this.isModal = true;
         addChild(this._clip);
         this._collectBtn.setClickFunction(this.hide);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         revealedSignal.dispatch();
      }
      
      public function get quest() : Quest
      {
         return this._quest;
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         collectButtonClickedSignal.dispatch(this._quest);
      }
   }
}
