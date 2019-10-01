package ninjakiwi.monkeyTown.ui
{
   import assets.ui.BuildingInfoPanelPremiumClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BuildingInfoPanelPremium extends HideRevealViewPopup
   {
       
      
      private const _clip:BuildingInfoPanelPremiumClip = new BuildingInfoPanelPremiumClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _demolishButton:ButtonControllerBase = new ButtonControllerBase(this._clip.demolishButton);
      
      private var _inspectingBuilding:Building;
      
      public function BuildingInfoPanelPremium(param1:DisplayObjectContainer)
      {
         super(param1);
         this._okButton.setClickFunction(this.onOKButtonClicked);
         this._demolishButton.setClickFunction(this.onDemolishBuildingClicked);
         this.isModal = true;
         this.addChild(this._clip);
      }
      
      public function baseBuildingInfo(param1:Building) : void
      {
         this._inspectingBuilding = param1;
         if(this._inspectingBuilding != null)
         {
            this._clip.BuildingTitle.htmlText = this._inspectingBuilding.definition.name;
            this._clip.description.htmlText = "<b>" + this._inspectingBuilding.definition.gameDescription + "</b>";
            reveal();
         }
      }
      
      private function onDemolishBuildingClicked() : void
      {
         if(this._inspectingBuilding != null)
         {
            this._inspectingBuilding.demolish();
         }
         hide();
      }
      
      private function demolishBuilding() : void
      {
         if(this._inspectingBuilding != null)
         {
            this._inspectingBuilding.demolish();
         }
         hide();
      }
      
      public function onOKButtonClicked() : void
      {
         this._inspectingBuilding = null;
         hide();
      }
   }
}
