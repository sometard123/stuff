package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.MyTowersPanelClip;
   import assets.town.MyTowersRollover;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.PopulationData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MyTowersPanel extends HideRevealViewBottomUIPanel
   {
       
      
      private var _clip:MyTowersPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _towerContentContainer:MovieClip;
      
      private var _specialContentContainer:Sprite;
      
      private var _towerContentArea:MovieClip;
      
      private var _specialContentArea:MovieClip;
      
      public var _initialSize:Rectangle;
      
      private var _tooltip:ToolTip;
      
      private var _infoPane:MyTowersInfoPane;
      
      private var _rollOver:MyTowersRollover;
      
      private var _myTrackButton:ButtonControllerBase;
      
      private var _specialItemsButton:ButtonControllerBase;
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private const _populationData:PopulationData = PopulationData.getInstance();
      
      private var _viewIsActive:Boolean = false;
      
      private var _tabEnabled:Boolean = true;
      
      public function MyTowersPanel(param1:DisplayObjectContainer)
      {
         this._tooltip = new ToolTip();
         super(param1);
         isModal = true;
         this.init();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._tooltip.stage = stage;
         this._tooltip.activateMouseFollow();
      }
      
      private function init() : void
      {
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new MyTowersPanelClip();
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._initialSize = new Rectangle(0,0,this._clip.background.width,this._clip.background.height);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(this.closeButtonClicked);
         this._towerContentArea = this._clip.towerContentArea;
         this._specialContentArea = this._clip.specialContentArea;
         this._towerContentContainer = this._clip.monkeysContainer;
         this._towerContentContainer.mask = this._towerContentArea;
         this._myTrackButton = new ButtonControllerBase(this._clip.myTrackButton);
         if(this._tabEnabled == true)
         {
            this._myTrackButton.setClickFunction(this.myTrackClicked);
         }
         else
         {
            this._myTrackButton.lock(4);
         }
         this._specialItemsButton = new ButtonControllerBase(this._clip.specialItemsButton);
         if(this._tabEnabled == true)
         {
            this._specialItemsButton.setClickFunction(this.specialItemsClicked);
         }
         else
         {
            this._specialItemsButton.lock(4);
         }
         this.addChild(this._towerContentContainer);
         this.addChild(this._tooltip);
         this._specialContentContainer = new Sprite();
         this._specialContentContainer.x = this._specialContentArea.x;
         this._specialContentContainer.y = this._specialContentArea.y;
         this._specialContentContainer.mask = this._specialContentArea;
         this._infoPane = new MyTowersInfoPane(this._clip.infoPane);
         this._rollOver = new MyTowersRollover();
         this._rollOver.visible = false;
      }
      
      private function destroyView() : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         LGDisplayListUtil.getInstance().removeAllChildren(this._towerContentContainer);
         this._clip = null;
         disableDefaultOnResize();
         this._initialSize = null;
         this._closeButton.destroy();
         this._closeButton = null;
         this._myTrackButton.destroy();
         this._myTrackButton = null;
         this._rollOver = null;
         this._towerContentArea = null;
         this._specialContentArea = null;
         this._towerContentContainer.mask = null;
         this._towerContentContainer = null;
         this._specialContentContainer.mask = null;
         this._specialContentContainer = null;
         this._infoPane.destroy();
         this._infoPane = null;
      }
      
      private function buildView() : void
      {
         var _loc4_:MonkeyTownBuildingDefinition = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc17_:Object = null;
         var _loc1_:Object = _system.city.buildingManager.getBuiltAndUnbuiltBaseBuildings();
         var _loc2_:Object = _loc1_.available;
         var _loc3_:Object = _loc1_.unavailable;
         LGDisplayListUtil.getInstance().removeAllChildren(this._towerContentContainer);
         this._towerContentContainer.addChild(this._rollOver);
         _loc2_.sortOn("count",Array.NUMERIC | Array.DESCENDING);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 4;
         var _loc12_:int = 67;
         var _loc13_:int = 67;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Array = _loc2_.concat(_loc3_);
         _loc15_ = 0;
         while(_loc15_ < _loc16_.length)
         {
            _loc17_ = _loc16_[_loc15_];
            _loc7_ = _loc17_.id;
            _loc4_ = _loc17_.definition;
            _loc6_ = _loc4_.populationType;
            if(_loc6_ != "")
            {
               if(_loc6_ == PopulationData.getInstance().EXPLODING_PINEAPPLE.id)
               {
                  _loc9_ = 3 * _loc12_;
                  _loc8_ = 5 * _loc13_ - _loc13_;
                  this.addTowerDescriptionClip(_loc6_,_loc9_,_loc8_,_loc17_);
               }
               else if(_loc6_ == PopulationData.getInstance().ROAD_SPIKES.id)
               {
                  _loc9_ = 2 * _loc12_;
                  _loc8_ = 5 * _loc13_ - _loc13_;
                  this.addTowerDescriptionClip(_loc6_,_loc9_,_loc8_,_loc17_);
               }
               else
               {
                  if(_loc14_ % _loc11_ === 0)
                  {
                     _loc10_++;
                  }
                  _loc9_ = _loc14_ % _loc11_ * _loc12_;
                  _loc8_ = _loc10_ * _loc13_ - _loc13_;
                  this.addTowerDescriptionClip(_loc6_,_loc9_,_loc8_,_loc17_);
                  _loc14_++;
               }
            }
            _loc15_++;
         }
         this.highlightTowerAndSync(0,0,_loc16_[0].definition.populationType,_loc16_[0].count);
      }
      
      private function addTowerDescriptionClip(param1:String, param2:Number, param3:Number, param4:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:TowerDescription = new TowerDescription();
         var _loc7_:PopulationDefinition = PopulationData.getInstance().getDefinitionByID(param1);
         if(_loc7_ == null)
         {
            return;
         }
         var _loc8_:Class = _loc7_.iconClass;
         var _loc9_:* = param4.count >= 1;
         var _loc10_:int = param4.count;
         if(param1 == Constants.TOWER_FARM)
         {
            _loc10_ = MonkeySystem.getInstance().city.buildingManager.getAvailableFarmCount();
         }
         _loc6_.setIconFromClass(_loc8_,!_loc9_,this._rollOver.width,this._rollOver.height);
         _loc6_.setCount(_loc10_,param4.damagedCount);
         _loc6_.available = _loc9_;
         this._towerContentContainer.addChild(_loc6_);
         _loc6_.info = param4;
         _loc6_.addEventListener(MouseEvent.ROLL_OVER,this.onTowerIconRollover,false,0,true);
         _loc6_.addEventListener(MouseEvent.ROLL_OUT,this.onTowerIconRollout,false,0,true);
         _loc6_.x = param2 + _loc5_;
         _loc6_.y = param3 + _loc5_;
      }
      
      private function onTowerIconRollout(param1:MouseEvent) : void
      {
         this._tooltip.hide();
      }
      
      private function onTowerIconRollover(param1:MouseEvent) : void
      {
         var _loc2_:TowerDescription = TowerDescription(param1.currentTarget);
         var _loc3_:MonkeyTownBuildingDefinition = _loc2_.info.definition;
         this.highlightTowerAndSync(_loc2_.x,_loc2_.y,_loc3_.populationType,_loc2_.count);
      }
      
      private function highlightTowerAndSync(param1:int, param2:int, param3:String, param4:int) : void
      {
         this._infoPane.syncToTower(param3,param4);
         this._rollOver.visible = true;
         this._rollOver.x = param1;
         this._rollOver.y = param2;
      }
      
      private function closeButtonClicked() : void
      {
         hide();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         this.initView();
         this.buildView();
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
      
      private function myTrackClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().myTracksPanel);
      }
      
      private function specialItemsClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().specialItemsPanel);
      }
      
      public function disableTab() : void
      {
         this._tabEnabled = false;
      }
      
      public function enableTab() : void
      {
         this._tabEnabled = true;
      }
   }
}
