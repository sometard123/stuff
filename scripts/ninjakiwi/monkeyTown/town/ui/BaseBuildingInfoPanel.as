package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.BuildingInforPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.PopulationData;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionTowerIcon;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BaseBuildingInfoPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:BuildingInforPanelClip = new BuildingInforPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _demolishButton:ButtonControllerBase = new ButtonControllerBase(this._clip.demolishButton);
      
      private const _icon:TerrainRestrictionTowerIcon = new TerrainRestrictionTowerIcon(this._clip.towerIcon);
      
      private var _inspectingBuilding:Building;
      
      public function BaseBuildingInfoPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this._okButton.setClickFunction(this.hide);
         this._demolishButton.setClickFunction(this.demolishBuildingClicked);
         this.isModal = true;
         this.addChild(this._clip);
      }
      
      public function baseBuildingInfo(param1:Building) : void
      {
         var _loc2_:PopulationDefinition = null;
         this._inspectingBuilding = param1;
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
            this._icon.setIcon(this._inspectingBuilding.definition.populationType);
            this._clip.powerTxt.htmlText = String(this._inspectingBuilding.definition.powerUsed);
            _loc2_ = PopulationData.getInstance().getDefinitionByID(this._inspectingBuilding.definition.populationType);
            if(_loc2_ != null)
            {
               this._clip.description.htmlText = "<b>" + LocalisationConstants.STRING_BUILDING_GIVE_YOU_TOWER.split("<tower name>").join(_loc2_.name).split("<amount>").join(_loc2_.populationCountString) + "</b>";
               this._clip.amountTxt.htmlText = "+" + _loc2_.populationCount;
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
   }
}
