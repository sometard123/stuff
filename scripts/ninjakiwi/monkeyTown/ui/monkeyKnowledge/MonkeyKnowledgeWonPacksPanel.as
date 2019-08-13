package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.WonMonkeyKnowledgeClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MonkeyKnowledgeWonPacksPanel extends HideRevealView
   {
       
      
      private var _clip:WonMonkeyKnowledgeClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _openNowButton:ButtonControllerBase;
      
      public function MonkeyKnowledgeWonPacksPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new WonMonkeyKnowledgeClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._openNowButton = new ButtonControllerBase(this._clip.openNowButton);
         super(param1,param2);
         this.init();
         setAutoPlayStopClipsArray([this._clip.boxAnimation.spinningLight]);
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._closeButton.setClickFunction(hide);
         this._openNowButton.setClickFunction(this.openNowClicked);
      }
      
      private function openNowClicked() : void
      {
         hide();
         TownUI.getInstance().monkeyKnowledgeOpenPacksScreen.reveal();
      }
   }
}
