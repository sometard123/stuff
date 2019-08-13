package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import assets.ui.BloonResearchLabUpgradesPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealViewCancelable;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BloonResearchLabPanel extends HideRevealViewCancelable
   {
       
      
      private const _clip:BloonResearchLabUpgradesPanelClip = new BloonResearchLabUpgradesPanelClip();
      
      private var _grid:BloonResearchLabUpgradesGrid;
      
      private var _okButton:ButtonControllerBase;
      
      private var _demolishButton:ButtonControllerBase;
      
      private var _tileOfSelectedLab:Tile;
      
      public function BloonResearchLabPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._grid = new BloonResearchLabUpgradesGrid(this._clip.upgradesGridBox);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._demolishButton = new ButtonControllerBase(this._clip.demolishButton);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(this.hide);
         this._demolishButton.setClickFunction(this.onDemolishButtonClicked);
         this._grid.buildView();
         this._clip.powerTxt.text = String(BuildingData.getInstance().BLOON_RESEARCH_LAB.powerUsed);
         this.setDemolishButtonActive(false);
      }
      
      public function updateDemolish(param1:Boolean = false, param2:Tile = null) : void
      {
         if(param1 || param2 == null)
         {
            this.setDemolishButtonActive(false);
            return;
         }
         this._tileOfSelectedLab = param2;
         var _loc3_:int = MonkeySystem.getInstance().city.buildingManager.getBuildingsOfType(BuildingData.getInstance().BLOON_RESEARCH_LAB.id).length;
         if(_loc3_ > 1)
         {
            this.setDemolishButtonActive(true);
         }
         else
         {
            this.setDemolishButtonActive(false);
         }
      }
      
      private function setDemolishButtonActive(param1:Boolean) : void
      {
         if(param1)
         {
            this._demolishButton.gotoAndStop(1);
            this._demolishButton.enableMouseInteraction();
         }
         else
         {
            this._demolishButton.gotoAndStop(3);
            this._demolishButton.disableMouseInteraction();
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this._grid.stage = _stage;
         this._grid.syncView();
         this._grid.on();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide();
         this._grid.off();
      }
      
      private function onDemolishButtonClicked() : void
      {
         TownUI.getInstance().demolishConfirmPanel.confirmSignal.addOnce(this.onDemolishConfirmed);
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().demolishConfirmPanel);
      }
      
      private function onDemolishConfirmed() : void
      {
         this.hide();
         this._tileOfSelectedLab.building.demolish(false,true);
      }
   }
}
