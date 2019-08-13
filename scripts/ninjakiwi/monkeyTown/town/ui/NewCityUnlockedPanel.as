package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.NewWorldPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.city.CityLoader;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.myCitiesPanel.MyCitiesPanel;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.PrioritySignal;
   
   public class NewCityUnlockedPanel extends HideRevealViewPopup
   {
      
      public static const SECOND_CITY_UNLOCKED_QUEST_STRING:String = "newCityUnlocked";
       
      
      private const _clip:NewWorldPanelClip = new NewWorldPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _addNewCityButton:ButtonControllerBase = new ButtonControllerBase(this._clip.btnNewCity);
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _desertTileAnim:MovieClip = this._clip.desertTileAnim;
      
      private var _hasBeenRevealedThisSession:Boolean = false;
      
      public function NewCityUnlockedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
         this._addNewCityButton.setClickFunction(this.onGoButton);
         this._closeButton.setClickFunction(hide);
         MonkeyCityMain.globalResetSignal.addWithPriority(this.onReset,int.MIN_VALUE);
         PrioritySignal(WorldViewSignals.buildWorldEndSignal).addWithPriority(this.onBuildWorldEnd,int.MIN_VALUE);
         setAutoPlayStopClipsArray([this._clip.desertTileAnim]);
         this._desertTileAnim.mouseEnabled = false;
         this._desertTileAnim.mouseChildren = false;
      }
      
      private function onReset() : void
      {
         PrioritySignal(WorldViewSignals.buildWorldEndSignal).remove(this.onBuildWorldEnd);
         PrioritySignal(WorldViewSignals.buildWorldEndSignal).addWithPriority(this.onBuildWorldEnd,int.MIN_VALUE);
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
         this._hasBeenRevealedThisSession = false;
      }
      
      private function onBuildWorldEnd() : void
      {
         if(CityCommonDataManager.getInstance().numberOfCities == 1 && MonkeySystem.getInstance().city.cityIndex == 0 && TownUI.getInstance().myCitiesPanel.unlockAnimPlayedThisSession == false)
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
         var _loc2_:int = int(QuestCounter.getInstance().getCustomValue(SECOND_CITY_UNLOCKED_QUEST_STRING));
         if(_loc2_ == 0)
         {
            if(ResourceStore.getInstance().townLevel >= Constants.SECOND_CITY_UNLOCK_LEVEL)
            {
               ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
               PanelManager.getInstance().showPanel(TownUI.getInstance().newCityUnlockedPanel,null,-10);
            }
         }
      }
      
      private function onGoButton() : void
      {
         if(CityCommonDataManager.getInstance().numberOfCities > MyCitiesPanel.CITY_ID_BLOON_DUNES)
         {
            CityLoader.loadCity(CityCommonDataManager.getInstance().getCitySlotClone(MyCitiesPanel.CITY_ID_BLOON_DUNES));
         }
         else
         {
            TownUI.getInstance().newCityPanel.showNewCity();
         }
         hide();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         QuestCounter.getInstance().setCustomValue(SECOND_CITY_UNLOCKED_QUEST_STRING,1);
         this._hasBeenRevealedThisSession = true;
         super.reveal(param1);
      }
      
      public function get hasBeenRevealedThisSession() : Boolean
      {
         return this._hasBeenRevealedThisSession;
      }
   }
}
