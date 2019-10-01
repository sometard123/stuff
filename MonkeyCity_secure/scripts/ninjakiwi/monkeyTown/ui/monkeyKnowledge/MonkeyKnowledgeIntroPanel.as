package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeIntroClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MonkeyKnowledgeIntroPanel extends HideRevealView
   {
       
      
      private var _clip:MonkeyKnowledgeIntroClip;
      
      private var _openNowButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      public function MonkeyKnowledgeIntroPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeIntroClip();
         this._openNowButton = new ButtonControllerBase(this._clip.openNowButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._openNowButton.setClickFunction(this.onOpenNow);
         this._closeButton.setClickFunction(hide);
      }
      
      private function onOpenNow() : void
      {
         hide();
         TownUI.getInstance().monkeyKnowledgeOpenPacksScreen.reveal();
      }
   }
}
