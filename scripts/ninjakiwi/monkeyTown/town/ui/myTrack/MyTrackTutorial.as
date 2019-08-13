package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.MyTracksUnlockedPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MyTrackTutorial extends HideRevealViewPopup
   {
       
      
      private const _clip:MyTracksUnlockedPanelClip = new MyTracksUnlockedPanelClip();
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function MyTrackTutorial(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._ok.setClickFunction(hide);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.initialMVMDataReceived.add(this.onBuildWorldEnd);
      }
      
      private function onReset() : void
      {
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
      }
      
      private function onBuildWorldEnd() : void
      {
         if(this.initListener() == true)
         {
            this.onTownLevelChanged();
         }
      }
      
      private function initListener() : Boolean
      {
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         if(int(QuestCounter.getInstance().getCustomValue("myTrackTutorial")) == 0)
         {
            ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
            return true;
         }
         return false;
      }
      
      private function onTownLevelChanged(... rest) : void
      {
         if(int(QuestCounter.getInstance().getCustomValue("myTrackTutorial")) == 0 && ResourceStore.getInstance().townLevel >= Constants.MIN_MYTRACK_LEVEL)
         {
            QuestCounter.getInstance().setCustomValue("myTrackTutorial",1);
            ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
            TrackManager.getInstance().dispatchUnlockedCount();
            PanelManager.getInstance().showPanel(this);
         }
      }
   }
}
