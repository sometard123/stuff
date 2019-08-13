package ninjakiwi.monkeyTown.ui
{
   import assets.ui.ContestedTerritoryExpiredPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class ContestExpiredPanel extends HideRevealView
   {
       
      
      private var _clip:ContestedTerritoryExpiredPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      public function ContestExpiredPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryExpiredPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._closeButton.setClickFunction(hide);
         this._goButton.setClickFunction(this.onButtonGo);
         hide();
      }
      
      private function onButtonGo() : void
      {
         if(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel.isRevealed)
         {
            MonkeyCityMain.getInstance().ui.contestedTerritoryPanel.onPlay();
         }
         else
         {
            PanelManager.getInstance().showFreePanel(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel);
         }
         hide();
      }
   }
}
