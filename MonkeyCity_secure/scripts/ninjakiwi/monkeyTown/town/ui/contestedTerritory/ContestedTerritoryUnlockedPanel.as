package ninjakiwi.monkeyTown.town.ui.contestedTerritory
{
   import assets.ui.ContestedTerritoryUnlockedPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class ContestedTerritoryUnlockedPanel extends HideRevealViewPopup
   {
      
      public static const CONTEST_UNLOCKED_QUEST_STRING:String = "contestUnlocked";
       
      
      private const _clip:ContestedTerritoryUnlockedPanelClip = new ContestedTerritoryUnlockedPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _goButton:ButtonControllerBase = new ButtonControllerBase(this._clip.go_btn);
      
      private var _hasBeenRevealedThisSession:Boolean = false;
      
      public function ContestedTerritoryUnlockedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
         this._goButton.setClickFunction(this.onGoButton);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.initialMVMDataReceived.add(this.onBuildWorldEnd);
      }
      
      private function onReset() : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         this._hasBeenRevealedThisSession = false;
      }
      
      private function onBuildWorldEnd() : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
         this.onTownLevelChanged();
      }
      
      private function onTownLevelChanged(... rest) : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY || Kong.isOnKong() && Constants.DISABLE_CT_ON_KONG)
         {
            return;
         }
         var _loc2_:int = int(QuestCounter.getInstance().getCustomValue(CONTEST_UNLOCKED_QUEST_STRING));
         if(_loc2_ == 0)
         {
            if(ResourceStore.getInstance().townLevel >= ContestedTerritoryPanel.CONTESTED_TERRITORY_LEVEL_REQUIREMENT)
            {
               QuestCounter.getInstance().setCustomValue(CONTEST_UNLOCKED_QUEST_STRING,1);
               PanelManager.getInstance().showPanel(this);
               ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
               this._hasBeenRevealedThisSession = true;
            }
         }
      }
      
      private function onGoButton() : void
      {
         PanelManager.getInstance().showFreePanel(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel);
         hide();
      }
      
      public function get hasBeenRevealedThisSession() : Boolean
      {
         return this._hasBeenRevealedThisSession;
      }
   }
}
