package ninjakiwi.monkeyTown.town.ui
{
   import assets.icons.BlankUpgradeIcon;
   import assets.town.LockClip;
   import assets.town.Tick;
   import assets.town.UnlockCantAffordClip;
   import assets.town.UnlockClip;
   import assets.town.UpgradeTreeClip;
   import assets.town.UpgradesPanelClip;
   import assets.ui.BloonReseachUpgradesClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.clock.PassiveUpgradeBuildingWarmupClock;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabUpgradesGrid;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class UpgradesPanel extends HideRevealViewBottomUIPanel
   {
       
      
      private var _clip:UpgradesPanelClip;
      
      private var _buttonContainer:MovieClip;
      
      private var _buttonMask:MovieClip;
      
      private var _contentArea:MovieClip;
      
      private var _contentContainer:Sprite;
      
      private var _scrollBar:ScrollBar;
      
      private var _initialSize:Rectangle;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _toolTip:ToolTip;
      
      private var unavailableFilter:ColorMatrixFilter;
      
      private var _currentFocusedBuilding:MonkeyTownBuildingDefinition;
      
      private var _isInitialised:Boolean = false;
      
      private var _buttons:Array;
      
      private var _buttonsByBuildingDefinition:Dictionary;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private var _bloonResearchLabGridClip:BloonReseachUpgradesClip;
      
      private var _bloonResearchLabGrid:BloonResearchLabUpgradesGrid;
      
      private var _viewIsActive:Boolean = false;
      
      public function UpgradesPanel(param1:DisplayObjectContainer)
      {
         this._toolTip = new ToolTip();
         this._buttons = [];
         this._buttonsByBuildingDefinition = new Dictionary();
         this._bloonResearchLabGridClip = new BloonReseachUpgradesClip();
         this._bloonResearchLabGrid = new BloonResearchLabUpgradesGrid(this._bloonResearchLabGridClip);
         super(param1);
         isModal = true;
         this.init();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._bloonResearchLabGrid.stage = stage;
      }
      
      private function init() : void
      {
         _stage = _system.flashStage;
         this._toolTip.width = 300;
         _stage.addChild(this._toolTip);
         this._toolTip.scaleWidthByTextWidth = true;
         UpgradeSignals.pathWarmupComplete.add(this.onPathWarmupCompleteSignal);
         this._resourceStore.monkeyMoneyChangedDiffSignal.add(this.reSync);
         this._resourceStore.bloonstonesChangedDiffSignal.add(this.reSync);
         this._bloonResearchLabGridClip.title.visible = true;
         this._bloonResearchLabGridClip.x = 15;
         this._bloonResearchLabGridClip.y = 85;
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new UpgradesPanelClip();
         this._buttonContainer = this._clip.buttonContainer;
         this._buttonMask = this._clip.buttonMask;
         this._contentArea = this._clip.contentArea;
         this._contentArea.visible = false;
         this._contentContainer = new Sprite();
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._buttonContainer,this._buttonMask,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         addChild(this._clip);
         addChild(this._buttonContainer);
         this._buttonContainer.mask = this._buttonMask;
         enableDefaultOnResize(this._clip);
         this._initialSize = new Rectangle(0,0,this._clip.background.width,this._clip.background.height);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(this.onCloseButtonClicked);
         this._contentContainer.x = this._contentArea.x;
         this._contentContainer.y = this._contentArea.y;
         addChild(this._contentContainer);
         this.buildButtons();
         MonkeyCityMain.getInstance().stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         MonkeyCityMain.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = String.fromCharCode(param1.keyCode).toLowerCase();
         var _loc3_:Object = null;
         if(_loc2_ == "q" || _loc2_ == "r")
         {
            _loc3_ = this._buttonsByBuildingDefinition["MonkeyAcademy"];
         }
         else if(_loc2_ == "c")
         {
            _loc3_ = this._buttonsByBuildingDefinition["MonkeyTownHall"];
         }
         else if(_loc2_ == "m" || _loc2_ == "w")
         {
            _loc3_ = this._buttonsByBuildingDefinition["SpikeProductionBuilding"];
         }
         else if(_loc2_ == "y" || _loc2_ == "b")
         {
            _loc3_ = this._buttonsByBuildingDefinition["OrdnanceAndMunitionsSupport"];
         }
         else if(_loc2_ == "e" || _loc2_ == "n")
         {
            _loc3_ = this._buttonsByBuildingDefinition["GunTrainingHall"];
         }
         else if(_loc2_ == "h")
         {
            _loc3_ = this._buttonsByBuildingDefinition["ApprenticeSchoolOfWizardry"];
         }
         else if(_loc2_ == "g")
         {
            _loc3_ = this._buttonsByBuildingDefinition["SuperEnhancements"];
         }
         else if(_loc2_ == "d")
         {
            _loc3_ = this._buttonsByBuildingDefinition["ShipsFoundry"];
         }
         else if(_loc2_ == "s")
         {
            _loc3_ = this._buttonsByBuildingDefinition["GlueFactory"];
         }
         else if(_loc2_ == "t")
         {
            _loc3_ = this._buttonsByBuildingDefinition["NinjaDojo"];
         }
         else if(_loc2_ == "f")
         {
            _loc3_ = this._buttonsByBuildingDefinition["AeronauticsLaboratory"];
         }
         else if(_loc2_ == "a")
         {
            _loc3_ = this._buttonsByBuildingDefinition["CryoLab"];
         }
         else if(_loc2_ == "v")
         {
            _loc3_ = this._buttonsByBuildingDefinition["MicroAgricultureDevelopmentBuilding"];
         }
         else if(_loc2_ == "l")
         {
            _loc3_ = this._buttonsByBuildingDefinition["EngineeringSchool"];
         }
         if(_loc3_ == null)
         {
            return;
         }
         this.focusBuildingButton(_loc3_ as BuildingIcon);
         this.buildUpgradeTreeView(_loc3_.building);
      }
      
      private function destroyView() : void
      {
         var _loc2_:* = null;
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         LGDisplayListUtil.getInstance().removeAllChildren(this._buttonContainer);
         LGDisplayListUtil.getInstance().removeAllChildren(this._contentContainer);
         this._clip = null;
         this._buttonMask = null;
         this._contentArea = null;
         this._contentContainer = null;
         this._scrollBar.destroy();
         this._scrollBar = null;
         this._buttonContainer.mask = null;
         this._buttonContainer = null;
         disableDefaultOnResize();
         this._closeButton.destroy();
         this._closeButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.lenth)
         {
            this._buttons[_loc1_].destroy();
            _loc1_++;
         }
         for(_loc2_ in this._buttonsByBuildingDefinition)
         {
            delete this._buttonsByBuildingDefinition[_loc2_];
         }
         this._buttons.length = 0;
         MonkeyCityMain.getInstance().stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function buildButtons() : void
      {
         var _loc3_:BuildingIcon = null;
         var _loc4_:MonkeyTownBuildingDefinition = null;
         var _loc13_:MovieClip = null;
         var _loc1_:Array = [this._buildingData.MONKEY_TOWN_HALL].concat(this._buildingData.upgradeBuildingDefinitions).concat([this._buildingData.BLOON_RESEARCH_LAB]);
         var _loc2_:int = _loc1_.length;
         var _loc5_:int = 10;
         var _loc6_:int = 5;
         var _loc7_:int = 0;
         var _loc8_:int = 10;
         var _loc9_:int = 3;
         var _loc10_:int = 85;
         var _loc11_:int = 96;
         this._buttonContainer.y = 135;
         var _loc12_:int = 0;
         while(_loc12_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc12_];
            _loc13_ = new _loc4_.iconGraphicClass();
            _loc3_ = new BuildingIcon(_loc13_,false);
            _loc3_.building = _loc4_;
            _loc3_.syncAvailabilityToBuilding();
            _loc3_.view.x = _loc10_ * (_loc12_ % _loc9_);
            _loc3_.view.y = _loc11_ * int(_loc12_ / _loc9_) + _loc8_;
            _loc3_.view.addEventListener(MouseEvent.CLICK,this.upgradeButtonClickedFunction,false,0,true);
            _loc3_.view.addEventListener(MouseEvent.ROLL_OVER,this.upgradeButtonRolloverFunction,false,0,true);
            _loc3_.view.addEventListener(MouseEvent.ROLL_OUT,this.upgradeButtonRolloutFunction,false,0,true);
            _loc3_.activateRollovers();
            _loc3_.index = _loc12_;
            this._buttonContainer.addChild(_loc3_.view);
            this._buttons.push(_loc3_);
            this._buttonsByBuildingDefinition[_loc4_.id] = _loc3_;
            _loc12_++;
         }
         this.focusBuildingButton(this._buttons[0]);
         this.buildUpgradeTreeView(this._buttons[0].building);
      }
      
      public function syncButtons() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.length)
         {
            BuildingIcon(this._buttons[_loc1_]).syncAvailabilityToBuilding();
            _loc1_++;
         }
      }
      
      private function reSync(param1:int, param2:Boolean = true) : void
      {
         if(isRevealed)
         {
            this.syncButtons();
            if(this._currentFocusedBuilding !== null)
            {
               this.buildUpgradeTreeView(this._currentFocusedBuilding);
            }
         }
      }
      
      private function upgradeButtonClickedFunction(param1:MouseEvent) : void
      {
         var _loc2_:BuildingIcon = param1.currentTarget.buildingIcon;
         this.focusBuildingButton(_loc2_);
         this.buildUpgradeTreeView(_loc2_.building);
      }
      
      private function upgradeButtonRolloverFunction(param1:MouseEvent) : void
      {
         var _loc2_:BuildingIcon = param1.currentTarget.buildingIcon;
         var _loc3_:* = _loc2_.building.name;
         if(!_loc2_.available)
         {
            _loc3_ = _loc3_ + " (<span class = \'red\'>Not Built</span>)";
         }
         this._toolTip.message = _loc3_;
         this._toolTip.reveal(0.2);
         this._toolTip.activateMouseFollow();
      }
      
      private function upgradeButtonRolloutFunction(param1:MouseEvent) : void
      {
         var _loc2_:BuildingIcon = param1.currentTarget.buildingIcon;
         this._toolTip.hide(0.6);
         this._toolTip.activateMouseFollow();
      }
      
      private function focusBuildingButton(param1:BuildingIcon, param2:Boolean = false) : void
      {
         param1.focus();
         var _loc3_:int = 12;
         if(param2)
         {
            if(param1.index >= _loc3_)
            {
               this._scrollBar.setToBottom();
            }
            else
            {
               this._scrollBar.setToTop();
            }
         }
         this._clip.upgradeBuildingTitle.text = param1.building.name;
         this._clip.upgradeBuildingTitle.height = this._clip.upgradeBuildingTitle.textHeight + 20;
         if(this._clip.upgradeBuildingTitle.textHeight > 40)
         {
            this._clip.upgradeBuildingTitle.y = 60;
         }
         else
         {
            this._clip.upgradeBuildingTitle.y = 75;
         }
         this._clip.powerUsedBox.powerTxt.text = String(param1.building.powerUsed);
      }
      
      private function buildUpgradeTreeView(param1:MonkeyTownBuildingDefinition) : void
      {
         var _loc5_:UpgradeTreeClip = null;
         var _loc6_:String = null;
         var _loc7_:UpgradeDefinition = null;
         var _loc8_:Boolean = false;
         var _loc9_:UpgradeStateDefinition = null;
         this.clear();
         this._currentFocusedBuilding = param1;
         var _loc2_:int = 20;
         var _loc3_:int = 20;
         if(param1 === this._buildingData.BLOON_RESEARCH_LAB)
         {
            this.buildBloonResearchLab();
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param1.upgrades.length)
         {
            _loc5_ = new UpgradeTreeClip();
            _loc6_ = param1.upgrades[_loc4_];
            _loc7_ = this._upgradeData.getUpgradeDefinitionByID(_loc6_);
            _loc8_ = _system.city.buildingManager.hasCompletedBuilding(_loc7_.building);
            _loc5_.label.htmlText = String(_loc7_.name);
            _loc5_.towerIcon.gotoAndStop(_loc7_.id);
            if(_loc7_ != null)
            {
               _loc9_ = _system.city.upgradeTree.getUpgradeStateDefinition(_loc6_);
               this.addIcon(_loc9_,1,_loc5_.path1.tier1Box,_loc7_.path1.tier1,_loc7_,1);
               this.addIcon(_loc9_,1,_loc5_.path1.tier2Box,_loc7_.path1.tier2,_loc7_,2);
               this.addIcon(_loc9_,1,_loc5_.path1.tier3Box,_loc7_.path1.tier3,_loc7_,3);
               this.addIcon(_loc9_,1,_loc5_.path1.tier4Box,_loc7_.path1.tier4,_loc7_,4);
               this.addIcon(_loc9_,2,_loc5_.path2.tier1Box,_loc7_.path2.tier1,_loc7_,1);
               this.addIcon(_loc9_,2,_loc5_.path2.tier2Box,_loc7_.path2.tier2,_loc7_,2);
               this.addIcon(_loc9_,2,_loc5_.path2.tier3Box,_loc7_.path2.tier3,_loc7_,3);
               this.addIcon(_loc9_,2,_loc5_.path2.tier4Box,_loc7_.path2.tier4,_loc7_,4);
               _loc5_.x = 5;
               _loc5_.y = _loc2_;
               _loc2_ = _loc2_ + (_loc5_.height + _loc3_);
               this._contentContainer.addChild(_loc5_);
            }
            _loc4_++;
         }
      }
      
      private function buildBloonResearchLab() : void
      {
         this._contentContainer.removeChildren();
         this._bloonResearchLabGrid.buildView();
         this._bloonResearchLabGrid.on();
         this._contentContainer.addChild(this._bloonResearchLabGridClip);
      }
      
      private function clear() : void
      {
         if(!this._viewIsActive || this._contentContainer === null)
         {
            return;
         }
         while(this._contentContainer.numChildren > 0)
         {
            this._contentContainer.removeChildAt(0);
         }
      }
      
      private function addIcon(param1:UpgradeStateDefinition, param2:int, param3:MovieClip, param4:UpgradePathTierDefinition, param5:UpgradeDefinition, param6:int) : MovieClip
      {
         var upgradePathStateDefinition:UpgradePathStateDefinition = null;
         var otherUpgradePathStateDefinition:UpgradePathStateDefinition = null;
         var defClass:Class = null;
         var qualifiedIconClassName:String = null;
         var clock:PassiveUpgradeBuildingWarmupClock = null;
         var upgradeStateDefinition:UpgradeStateDefinition = param1;
         var pathIndex:int = param2;
         var container:MovieClip = param3;
         var tierDefinition:UpgradePathTierDefinition = param4;
         var upgradeDefinition:UpgradeDefinition = param5;
         var tierIndex:int = param6;
         if(pathIndex === 1)
         {
            upgradePathStateDefinition = upgradeStateDefinition.path1;
            otherUpgradePathStateDefinition = upgradeStateDefinition.path2;
         }
         else
         {
            upgradePathStateDefinition = upgradeStateDefinition.path2;
            otherUpgradePathStateDefinition = upgradeStateDefinition.path1;
         }
         var isLocked:Boolean = tierIndex > upgradePathStateDefinition.unlockedTo;
         var purchased:Boolean = tierIndex <= upgradePathStateDefinition.aquiredTo;
         var availabilityReport:UpgradeAvailabilityReport = new UpgradeAvailabilityReport(tierDefinition,upgradePathStateDefinition,otherUpgradePathStateDefinition,upgradeDefinition,tierIndex,null);
         var iconClassName:String = tierDefinition.iconClassName;
         if(iconClassName == "")
         {
            iconClassName = "BlankUpgradeIcon";
         }
         try
         {
            qualifiedIconClassName = "assets.icons." + iconClassName;
            defClass = getDefinitionByName(qualifiedIconClassName) as Class;
         }
         catch(error:Error)
         {
            defClass = BlankUpgradeIcon;
         }
         var icon:MovieClip = new MovieClip();
         var iconGraphic:MovieClip = new defClass();
         icon.addChild(iconGraphic);
         iconGraphic.x = -2;
         iconGraphic.y = -2;
         if(purchased)
         {
            container.gotoAndStop(1);
         }
         else
         {
            container.gotoAndStop(2);
            if(isLocked)
            {
               icon.addChild(new LockClip());
            }
            else if(!availabilityReport.available)
            {
               icon.addChild(new UnlockCantAffordClip());
            }
            else if(!availabilityReport.warmingUp)
            {
               icon.addChild(new UnlockClip());
            }
         }
         if(availabilityReport.warmingUp)
         {
            clock = new PassiveUpgradeBuildingWarmupClock(upgradePathStateDefinition);
            clock.dieOnRemoveFromStage = true;
            clock.x = 32;
            clock.y = 28;
            clock.syncToTarget();
            icon.addChild(clock);
         }
         if(purchased)
         {
            icon.addChild(new Tick());
         }
         var iconInformation:IconInformation = new IconInformation();
         iconInformation.upgradeDefinition = upgradeDefinition;
         iconInformation.tierDefinition = tierDefinition;
         iconInformation.upgradePathStateDefinition = upgradePathStateDefinition;
         iconInformation.otherUpgradePathStateDefinition = otherUpgradePathStateDefinition;
         iconInformation.upgradePathStateDefinition.upgradeID = iconInformation.upgradeDefinition.id;
         iconInformation.tierIndex = tierIndex;
         iconInformation.availabilityReport = availabilityReport;
         container.iconInformation = iconInformation;
         container.addChild(icon);
         if(!availabilityReport.warmingUp && availabilityReport.available)
         {
            container.addEventListener(MouseEvent.CLICK,this.iconClickedHandler,false,0,true);
         }
         container.addEventListener(MouseEvent.ROLL_OVER,this.tierIconRolloverHandler,false,0,true);
         container.addEventListener(MouseEvent.ROLL_OUT,this.tierIconRolloutHandler,false,0,true);
         return icon;
      }
      
      private function tierIconRolloverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IconInformation = param1.currentTarget.iconInformation;
         var _loc3_:UpgradePathStateDefinition = _loc2_.upgradePathStateDefinition;
         var _loc4_:String = _loc2_.availabilityReport.message;
         if(_loc3_.isWarmingUp && _loc2_.tierIndex == _loc3_.unlockedTo)
         {
            _loc4_ = _loc4_ + ("<span class = \'upgradeNow\'>Click to complete upgrade for " + _loc3_.getBloonstonesRequiredToSkip() + " Bloonstones</span>");
         }
         this._toolTip.message = _loc4_;
         this._toolTip.reveal();
         this._toolTip.activateMouseFollow();
      }
      
      private function tierIconRolloutHandler(param1:MouseEvent) : void
      {
         this._toolTip.hide();
         this._toolTip.deactivateMouseFollow();
      }
      
      private function iconClickedHandler(param1:MouseEvent) : void
      {
         var _loc2_:IconInformation = param1.currentTarget.iconInformation;
         var _loc3_:UpgradeAvailabilityReport = _loc2_.availabilityReport = new UpgradeAvailabilityReport(_loc2_.tierDefinition,_loc2_.upgradePathStateDefinition,_loc2_.otherUpgradePathStateDefinition,_loc2_.upgradeDefinition,_loc2_.tierIndex,this._buildingData.getRequiredSpecialBuildingForUpgrade(_loc2_.tierDefinition.id));
         if(_loc3_.available === false)
         {
            return;
         }
         var _loc4_:* = _loc2_.upgradePathStateDefinition.aquiredTo >= _loc2_.tierIndex;
         if(_loc4_)
         {
            return;
         }
         var _loc5_:UpgradePathStateDefinition = _loc2_.upgradePathStateDefinition;
         _loc5_.startWarmupForNextTier(_loc2_.tierDefinition.time,_loc2_.tierDefinition.xpGiven,this._currentFocusedBuilding);
         if(_loc2_.tierDefinition.bloonstoneCost > 0)
         {
            this._resourceStore.addMoneyWithoutSaving(-_loc2_.tierDefinition.cost);
            this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc2_.tierDefinition.bloonstoneCost;
         }
         else
         {
            this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney - _loc2_.tierDefinition.cost;
         }
         UpgradeSignals.upgradePurchased.dispatch(_loc5_);
         this.buildUpgradeTreeView(this._currentFocusedBuilding);
      }
      
      private function onPathWarmupCompleteSignal(param1:UpgradePathStateDefinition) : void
      {
         if(this._viewIsActive && this._currentFocusedBuilding)
         {
            this.buildUpgradeTreeView(this._currentFocusedBuilding);
         }
      }
      
      private function onCloseButtonClicked() : void
      {
         this.hide();
         this._bloonResearchLabGrid.off();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         this._toolTip.hide();
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this.initView();
         if(_system.city.buildingManager.hasCompletedBuilding(this._buildingData.MONKEY_ACADEMY.id) === true)
         {
            this.revealForBuildingDefinition(this._buildingData.MONKEY_ACADEMY);
            return;
         }
         if(this._currentFocusedBuilding)
         {
            this.buildUpgradeTreeView(this._currentFocusedBuilding);
         }
         super.reveal(param1);
         this.syncButtons();
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
      }
      
      public function revealForBuilding(param1:Building) : void
      {
         this.revealForBuildingDefinition(param1.definition);
      }
      
      private function revealForBuildingDefinition(param1:MonkeyTownBuildingDefinition) : void
      {
         this.initView();
         if(param1 && param1.upgrades)
         {
            this._currentFocusedBuilding = param1;
            this.buildUpgradeTreeView(param1);
            this.focusBuildingButton(this._buttonsByBuildingDefinition[this._currentFocusedBuilding.id],true);
            super.reveal(0.5);
         }
         this.syncButtons();
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
      }
   }
}

import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
import ninjakiwi.monkeyTown.town.ui.UpgradeAvailabilityReport;

class IconInformation
{
    
   
   public var tierDefinition:UpgradePathTierDefinition;
   
   public var upgradePathStateDefinition:UpgradePathStateDefinition;
   
   public var otherUpgradePathStateDefinition:UpgradePathStateDefinition;
   
   public var tierIndex:int;
   
   public var upgradeDefinition:UpgradeDefinition;
   
   public var availabilityReport:UpgradeAvailabilityReport;
   
   function IconInformation()
   {
      this.tierIndex = this.tierIndex;
      super();
   }
}
