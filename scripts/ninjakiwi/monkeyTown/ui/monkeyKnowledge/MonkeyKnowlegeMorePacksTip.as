package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeMorePacksTipClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MonkeyKnowlegeMorePacksTip extends HideRevealView
   {
       
      
      private const _clip:MonkeyKnowledgeMorePacksTipClip = new MonkeyKnowledgeMorePacksTipClip();
      
      private var _buyPacksButton:ButtonControllerBase;
      
      public function MonkeyKnowlegeMorePacksTip(param1:DisplayObjectContainer, param2:* = null)
      {
         this._buyPacksButton = new ButtonControllerBase(this._clip.buyPacksButton);
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this._buyPacksButton.setClickFunction(this.openBuyPacksPanel);
      }
      
      override public function reveal(param1:Number = 1.0) : void
      {
         super.reveal(param1);
      }
      
      private function openBuyPacksPanel() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().knowledgePackSalePanel);
      }
   }
}
