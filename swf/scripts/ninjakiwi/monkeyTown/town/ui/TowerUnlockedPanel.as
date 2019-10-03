package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.TowerUnlockedPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.PrioritySignal;
   
   public class TowerUnlockedPanel extends HideRevealView
   {
      
      public static const ENGINEER_UNLOCKED_STRING:String = "engineerUnlocked";
       
      
      private const _clip:TowerUnlockedPanelClip = new TowerUnlockedPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function TowerUnlockedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(this.onOkButtonClicked);
         MonkeyCityMain.globalResetSignal.addWithPriority(this.onReset,-1);
         PrioritySignal(WorldViewSignals.buildWorldEndSignal).addWithPriority(this.onBuildWorldEnd,-1);
         setAutoPlayStopClipsArray([this._clip.raysAnimate]);
         this._clip.descriptionTxt.text = LocalisationConstants.SECOND_CITY_ENGINEER_UNLOCKED_TEXT;
      }
      
      private function onReset() : void
      {
      }
      
      private function onBuildWorldEnd(... rest) : void
      {
         if(MonkeySystem.getInstance().city.cityIndex == 1)
         {
            ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
            ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
            this.onTownLevelChanged();
         }
         else
         {
            ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         }
      }
      
      private function onTownLevelChanged(... rest) : void
      {
         if(MonkeySystem.getInstance().city.cityIndex == 0)
         {
            return;
         }
         var _loc2_:Boolean = Boolean(QuestCounter.getInstance().getCustomValue(ENGINEER_UNLOCKED_STRING));
         if(_loc2_ == false)
         {
            if(ResourceStore.getInstance().townLevel >= Constants.ENGINEER_UNLOCK_LEVEL)
            {
               ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
               PanelManager.getInstance().showPanel(TownUI.getInstance().towerUnlockedPanel,null,2);
            }
         }
      }
      
      private function onOkButtonClicked() : void
      {
         QuestCounter.getInstance().setCustomValue(ENGINEER_UNLOCKED_STRING,true);
         hide();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
      }
   }
}
