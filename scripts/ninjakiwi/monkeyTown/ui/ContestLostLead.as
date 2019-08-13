package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryLostLeadPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.AvatarLoader;
   import ninjakiwi.monkeyTown.town.ui.ClanLoader;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class ContestLostLead extends HideRevealView
   {
       
      
      private var _clip:ContestedTerritoryLostLeadPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      public function ContestLostLead(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryLostLeadPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._closeButton.setClickFunction(hide);
         this._goButton.setClickFunction(this.onButtonGo);
         this._clip.avatarModule.honourField.visible = false;
         this._clip.avatarModule.honourSymbol.visible = false;
         hide();
      }
      
      public function updateInfo(param1:int, param2:String, param3:String, param4:int, param5:int) : void
      {
         this._clip.tier.text = LocalisationConstants.CONTEST_TIER.split("<tier>").join(String(param1));
         this._clip.description.text = LocalisationConstants.CONTEST_LOST_CONTROL.split("<player name>").join(param2);
         this._clip.description.text = this._clip.description.text.split("<round>").join(String(param5));
         this._clip.avatarModule.avatarContainer.container.removeChildren();
         this._clip.avatarModule.avatarContainer.container.addChild(new AvatarLoader(param3));
         this._clip.avatarModule.clanContainer.removeChildren();
         this._clip.avatarModule.clanContainer.addChild(new ClanLoader(param3));
         this._clip.avatarModule.levelField.text = String(param4);
         reveal();
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
