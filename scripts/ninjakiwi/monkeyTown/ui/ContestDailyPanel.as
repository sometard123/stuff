package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryDaily1PanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class ContestDailyPanel extends HideRevealView
   {
       
      
      private var _clip:ContestedTerritoryDaily1PanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      public function ContestDailyPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryDaily1PanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._closeButton.setClickFunction(hide);
         this._goButton.setClickFunction(this.onButtonGo);
         hide();
      }
      
      private function onButtonGo() : void
      {
         PanelManager.getInstance().showFreePanel(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel);
         hide();
      }
   }
}
