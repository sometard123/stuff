package ninjakiwi.monkeyTown.ui
{
   import assets.tiles.BuildingPlaceholder;
   import assets.town.BuildPanelItemClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.buildings.BuildingAvailabilityReport;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.BuildingIcon;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BuildPanelItem extends MovieClip
   {
       
      
      private var _available:Boolean = true;
      
      protected var _clip:MovieClip;
      
      private var _buildingIcon:BuildingIcon;
      
      protected var _iconContainer:MovieClip;
      
      protected var _titleField:TextField;
      
      protected var _bodyField:TextField;
      
      protected var _costField:TextField;
      
      protected var _background:MovieClip;
      
      private var DisplayListUtil:LGDisplayListUtil;
      
      public var buttonController:ButtonControllerBase;
      
      public var buildingDefinition:MonkeyTownBuildingDefinition;
      
      public function BuildPanelItem(param1:MonkeyTownBuildingDefinition)
      {
         this.DisplayListUtil = LGDisplayListUtil.getInstance();
         super();
         this.init(param1);
      }
      
      protected function init(param1:MonkeyTownBuildingDefinition) : void
      {
         this.buildingDefinition = param1;
         this.createClip();
         addChild(this._clip);
         this.buttonController = new ButtonControllerBase(this._clip.mainHit);
         this.buttonController.data = {"buildPanelItem":this};
         this.DisplayListUtil.removeAllChildren(this._iconContainer);
         this._buildingIcon = this.getIcon();
         this._iconContainer.addChild(this._buildingIcon.view);
         this._titleField.text = param1.name;
         var _loc2_:BuildingAvailabilityReport = new BuildingAvailabilityReport(param1);
         this._bodyField.htmlText = "<b>" + param1.gameDescription + "</b>";
      }
      
      protected function createClip() : void
      {
         this._clip = new BuildPanelItemClip();
         this._iconContainer = this._clip.iconContainer;
         this._titleField = this._clip.titleField;
         this._bodyField = this._clip.bodyField;
         this._costField = this._clip.costField;
         this._background = this._clip.background;
         this._costField.text = "";
      }
      
      public function getIcon() : BuildingIcon
      {
         if(!this.buildingDefinition.iconGraphicClass)
         {
            this.buildingDefinition.iconGraphicClass = BuildingPlaceholder;
         }
         var _loc1_:MovieClip = new this.buildingDefinition.iconGraphicClass();
         var _loc2_:BuildingIcon = new BuildingIcon(_loc1_);
         _loc2_.label = "$" + this.buildingDefinition.monkeyMoneyCost;
         _loc2_.buildingDefinition = this.buildingDefinition;
         return _loc2_;
      }
      
      public function get available() : Boolean
      {
         return this._available;
      }
      
      public function set available(param1:Boolean) : void
      {
         this._available = param1;
         this._buildingIcon.available = param1;
         this._buildingIcon.greyedOut = !param1;
         if(this._available)
         {
            this._clip.background.gotoAndStop(1);
         }
         else
         {
            this._clip.background.gotoAndStop(2);
         }
      }
      
      public function overState() : void
      {
         if(this._available)
         {
            this._buildingIcon.overState();
         }
      }
      
      public function outState() : void
      {
         this._buildingIcon.outState();
      }
      
      public function destroy() : void
      {
         this._clip = null;
         this._iconContainer = null;
         this._buildingIcon = null;
         this._titleField = null;
         this._bodyField = null;
         this._costField = null;
         this._background = null;
         this.buttonController = null;
      }
   }
}
