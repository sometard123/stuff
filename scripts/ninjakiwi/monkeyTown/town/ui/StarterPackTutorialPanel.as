package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.StarterPackTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class StarterPackTutorialPanel extends HideRevealViewPopup
   {
      
      private static const STARTER_PACK_TUTORIAL_STRING:String = STARTER_PACK_TUTORIAL_STRING;
       
      
      private const _clip:StarterPackTutorialPanelClip = new StarterPackTutorialPanelClip();
      
      private const _button:ButtonControllerBase = new ButtonControllerBase(this._clip.starterPackButton);
      
      private const _close:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      public function StarterPackTutorialPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._button.setClickFunction(this.showStarterPack);
         this._close.setClickFunction(hide);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.initialMVMDataReceived.add(this.onBuildWorldEnd);
      }
      
      private function onReset() : void
      {
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onTownLevelChanged);
      }
      
      private function showStarterPack() : void
      {
         if(Premium.getInstance().isStarterPackPurchased() == false)
         {
            if(Kong.isOnKong())
            {
               Premium.getInstance().showStore([Premium.STARTER_PACK_ID]);
            }
            else
            {
               Premium.getInstance().showStore([{
                  "id":Premium.STARTER_PACK_ID,
                  "quantity":1
               }]);
            }
         }
         hide();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         if(Kong.isOnKong())
         {
            this._clip.currencyIcon.gotoAndStop(2);
         }
         else
         {
            this._clip.currencyIcon.gotoAndStop(1);
         }
         super.reveal();
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
         if(Premium.getInstance().isStarterPackPurchased() == false)
         {
            ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
            return true;
         }
         return false;
      }
      
      private function onTownLevelChanged(... rest) : void
      {
         if(Premium.getInstance().isStarterPackPurchased())
         {
            return;
         }
         var _loc2_:int = int(QuestCounter.getInstance().getCustomValue(STARTER_PACK_TUTORIAL_STRING));
         if(ResourceStore.getInstance().townLevel >= 4 && ResourceStore.getInstance().townLevel <= 10 && ResourceStore.getInstance().townLevel != _loc2_)
         {
            QuestCounter.getInstance().setCustomValue(STARTER_PACK_TUTORIAL_STRING,ResourceStore.getInstance().townLevel);
            PanelManager.getInstance().showPanel(this);
         }
      }
   }
}
