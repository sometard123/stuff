package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PacifistModePanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.TimeUntilPacifistTracker;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PacifistModePanel extends HideRevealViewPopup
   {
       
      
      private const _clip:PacifistModePanelClip = new PacifistModePanelClip();
      
      private const _cancel:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._clip.pacifistButton);
      
      public function PacifistModePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.addChild(this._clip);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this._cancel.setClickFunction(this.onCancel);
         this._ok.setClickFunction(this.onOk);
      }
      
      public function renewTimeUntilPacifist() : void
      {
         PvPSignals.updatePacifistModeUI.dispatch(false);
         PvPClient.extendPacifist(MonkeySystem.getInstance().city.cityIndex);
         TimeUntilPacifistTracker.resetTimeUntilPacifist();
         PvPMain.instance.pacifist.updateTimeOfLastPacifistModeUpdate(MonkeySystem.getInstance().getSecureTime());
      }
      
      private function onCancel() : void
      {
         this.renewTimeUntilPacifist();
         hide();
      }
      
      private function onOk() : void
      {
         if(ResourceStore.getInstance().honour >= Constants.PACIFIST_HONOR_THRESHOLD)
         {
            hide();
            return;
         }
         PvPSignals.updatePacifistModeUI.dispatch(true);
         hide();
      }
   }
}
