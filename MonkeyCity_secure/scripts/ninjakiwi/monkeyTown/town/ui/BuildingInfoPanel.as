package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.SpecialBuildingInforPanelClip;
   import com.lgrey.signal.SignalHub;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BuildingInfoPanel extends HideRevealViewPopup
   {
       
      
      private const _hubUI:SignalHub = SignalHub.getHub("ui");
      
      private const _clip:SpecialBuildingInforPanelClip = new SpecialBuildingInforPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _demolishButton:ButtonControllerBase = new ButtonControllerBase(this._clip.demolishButton);
      
      private const _fillTankButton:ButtonControllerBase = new ButtonControllerBase(this._clip.fillTankButton);
      
      private var _inspectingBuilding:Building;
      
      public function BuildingInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1);
         this._okButton.setClickFunction(this.hide);
         this._demolishButton.setClickFunction(this.demolishBuildingClicked);
         this._fillTankButton.setClickFunction(this.onFillTank);
         this.isModal = true;
         this.addChild(this._clip);
         setAutoPlayStopClipsArray([this._clip.fillTankButton.gem]);
      }
      
      public function baseBuildingInfo(param1:Building) : void
      {
         this._inspectingBuilding = param1;
         this._fillTankButton.target.visible = false;
         if(this._inspectingBuilding != null)
         {
            this._clip.BuildingTitle.htmlText = this._inspectingBuilding.definition.name;
            if(this._inspectingBuilding.isDemolishable())
            {
               this._demolishButton.unlock(1);
            }
            else
            {
               this._demolishButton.lock(3);
            }
            this._clip.powerTxt.htmlText = String(this._inspectingBuilding.definition.powerUsed);
            this._clip.description.htmlText = "<b>" + this._inspectingBuilding.definition.gameDescription + "</b>";
            if(this._inspectingBuilding.definition.id == BuildingData.getInstance().BLOONTONIUM_STORAGE_TANK.id)
            {
               this._fillTankButton.target.visible = true;
            }
            reveal();
         }
      }
      
      private function demolishBuildingClicked() : void
      {
         TownUI.getInstance().demolishConfirmPanel.confirmSignal.addOnce(this.demolishBuilding);
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().demolishConfirmPanel);
      }
      
      private function demolishBuilding() : void
      {
         if(this._inspectingBuilding != null)
         {
            this._inspectingBuilding.demolish();
         }
         this.hide();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         this._inspectingBuilding = null;
         super.hide(param1);
      }
      
      private function onFillTank() : void
      {
         this._hubUI.getSignal("requestBloonstonesToBloontoniumExchangeSignal").dispatch();
      }
   }
}
