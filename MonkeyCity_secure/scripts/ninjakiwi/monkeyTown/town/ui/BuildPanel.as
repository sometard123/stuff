package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.BuildViewClip;
   import assets.ui.MoreSash;
   import assets.ui.NewSash;
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import fl.motion.AdjustColor;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.ads.VideoAds;
   import ninjakiwi.monkeyTown.analytics.StatsData;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.BuildingAvailabilityReport;
   import ninjakiwi.monkeyTown.town.buildings.BuildingFactory;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.ui.BuildPanelItem;
   import ninjakiwi.monkeyTown.ui.BuildPanelItemPremium;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.WatchVideosForBloonstonesPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class BuildPanel extends HideRevealViewBottomUIPanel
   {
       
      
      private var _clip:BuildViewClip;
      
      private var _scrollBar:ScrollBar;
      
      private var _toolTip:ToolTip;
      
      private var _baseBuildingsButton:BuildPanelMainButton;
      
      private var _upgradeBuildingsButton:BuildPanelMainButton;
      
      private var _specialBuildingsButton:BuildPanelMainButton;
      
      private var _pvpBuildingsButton:BuildPanelMainButton;
      
      private var _resourceBuildingsButton:BuildPanelMainButton;
      
      private var _premiumBuildingsButton:BuildPanelPremiumBuildingButton;
      
      private var _freeBloonstonesButton:ButtonControllerBase;
      
      private var _contentContainer:Sprite;
      
      private var _contentArea:MovieClip;
      
      private var _initialSize:Rectangle;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _currentFocusedButton:ButtonControllerBase = null;
      
      private var _unavailableFilter:ColorMatrixFilter = null;
      
      private var _onNextOpenParams:Object;
      
      private var _targetBuildTile:Tile = null;
      
      private var _currentDefinitionList:Array = null;
      
      private var _buildingPanelItems:Array;
      
      private const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private const _buildingFactory:BuildingFactory = BuildingFactory.getInstance();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _townUI:TownUI = TownUI.getInstance();
      
      private const _monkeySystem:MonkeySystem = MonkeySystem.getInstance();
      
      public const buildPanelWasClosedSignal:Signal = new Signal();
      
      public const buildingWasSelectedSignal:Signal = new Signal(MonkeyTownBuildingDefinition);
      
      public const buildingWasSelectedForTileSignal:Signal = new Signal(MonkeyTownBuildingDefinition);
      
      private var _viewIsActive:Boolean = false;
      
      public function BuildPanel(param1:DisplayObjectContainer)
      {
         this._toolTip = new ToolTip();
         this._onNextOpenParams = {};
         this._buildingPanelItems = [];
         super(param1);
         isModal = true;
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this.init();
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         _stage = stage;
         _stage.addChild(this._toolTip);
      }
      
      private function init() : void
      {
         this.initColorTransforms();
         this._toolTip.width = 250;
         this._toolTip.scaleWidthByTextWidth = true;
         this.initListeners();
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new BuildViewClip();
         this._clip.premiumBuildingBuyContainer.visible = false;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._initialSize = new Rectangle(0,0,this._clip.background.width,this._clip.background.height);
         this._contentContainer = this._clip.contentContainer;
         this._contentArea = this._clip.contentArea;
         this._contentContainer.mask = this._contentArea;
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._contentContainer,this._contentArea,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         this._scrollBar.fitView = this._clip.background;
         this._baseBuildingsButton = new BuildPanelMainButton(this._clip.baseBuildingsButton);
         this._upgradeBuildingsButton = new BuildPanelMainButton(this._clip.upgradeBuildingsButton);
         this._specialBuildingsButton = new BuildPanelMainButton(this._clip.specialBuildingsButton);
         this._pvpBuildingsButton = new BuildPanelMainButton(this._clip.pvpBuildingsButton);
         this._resourceBuildingsButton = new BuildPanelMainButton(this._clip.resourceBuildings,true);
         this._premiumBuildingsButton = new BuildPanelPremiumBuildingButton(this._clip.premiumButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._baseBuildingsButton.setClickFunction(this.buildBaseBuildingsIcons);
         this._upgradeBuildingsButton.setClickFunction(this.buildUpgradeBuildingsIcons);
         this._resourceBuildingsButton.setClickFunction(this.buildResourceBuildingsIcons);
         this._specialBuildingsButton.setClickFunction(this.buildSpecialBuildingsIcons);
         this._pvpBuildingsButton.setClickFunction(this.buildPVPBuildingsIcons);
         this._premiumBuildingsButton.setClickFunction(this.buildPremiumBuildingsIcons);
         this._closeButton.setClickFunction(this.onCloseButtonClicked);
         this.focusButton(this._baseBuildingsButton);
         this._currentDefinitionList = this._buildingData.baseBuildingDefinitions;
         this.reSync();
         this._freeBloonstonesButton = new ButtonControllerBase(this._clip.freeBloonstonesButton);
         this._freeBloonstonesButton.setClickFunction(WatchVideosForBloonstonesPanel.reveal);
         this._clip.freeBloonstonesButton.visible = false;
         this._clip.freeBloonstonesButton.alpha = 0;
         VideoAds.videoAvailabilitySignal.addOnce(function(param1:Boolean):void
         {
            if(param1 && _clip !== null)
            {
               _clip.freeBloonstonesButton.visible = true;
               _clip.freeBloonstonesButton.alpha = 0;
               TweenLite.to(_clip.freeBloonstonesButton,0.3,{"alpha":1});
            }
         });
         VideoAds.checkInventory();
      }
      
      private function destroyView() : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         removeChild(this._clip);
         this.clearBuildingItems();
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this._contentContainer);
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         this._toolTip.deactivateMouseFollow();
         this._toolTip.hide(0.2);
         this._clip = null;
         disableDefaultOnResize();
         this._initialSize = null;
         this._contentArea = null;
         this._contentContainer.mask = null;
         this._contentContainer = null;
         this._scrollBar.destroy();
         this._scrollBar = null;
         this._baseBuildingsButton.destroy();
         this._baseBuildingsButton = null;
         this._upgradeBuildingsButton.destroy();
         this._upgradeBuildingsButton = null;
         this._specialBuildingsButton.destroy();
         this._specialBuildingsButton = null;
         this._pvpBuildingsButton.destroy();
         this._pvpBuildingsButton = null;
         this._resourceBuildingsButton.destroy();
         this._resourceBuildingsButton = null;
         this._premiumBuildingsButton.destroy();
         this._premiumBuildingsButton = null;
         this._closeButton.destroy();
         this._closeButton = null;
         this._currentFocusedButton = null;
         this._targetBuildTile = null;
         this._freeBloonstonesButton.destroy();
         this._freeBloonstonesButton = null;
      }
      
      private function initListeners() : void
      {
         this._resourceStore.bloonstonesChangedDiffSignal.add(this.reSync);
         this._resourceStore.monkeyMoneyChangedDiffSignal.add(this.reSync);
         this._resourceStore.townLevelChangedDiffSignal.add(this.reSync);
      }
      
      private function reSync(... rest) : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         if(this._currentDefinitionList !== null)
         {
            this.buildIconsWithData(this._currentDefinitionList,false);
         }
         this.reSyncButtonSashes();
      }
      
      private function reSyncButtonSashes() : void
      {
         if(FirstTimeTriggerManager.tutorialIsActive)
         {
            this._baseBuildingsButton.setNewSashVisible(false);
            this._upgradeBuildingsButton.setNewSashVisible(false);
            this._resourceBuildingsButton.setNewSashVisible(false);
            this._specialBuildingsButton.setNewSashVisible(false);
            this._pvpBuildingsButton.setNewSashVisible(false);
            this._premiumBuildingsButton.setNewSashVisible(false);
            return;
         }
         this.doNewSashTest(this._baseBuildingsButton,this._buildingData.baseBuildingDefinitions);
         this.doNewSashTest(this._upgradeBuildingsButton,this._buildingData.upgradeBuildingDefinitions);
         this.doNewSashTest(this._resourceBuildingsButton,this._buildingData.resourceBuildingDefinitions);
         this.doNewSashTest(this._specialBuildingsButton,this._buildingData.specialBuildingDefinitions);
         this.doNewSashTest(this._pvpBuildingsButton,this._buildingData.pvpBuildingDefinitions);
         this.doNewSashTestPremiumBuildings(this._premiumBuildingsButton,this._buildingData.premiumBuildingDefinitions);
         this._resourceBuildingsButton.setMoreSashVisible(this.canBuildResourceBuildings());
      }
      
      private function canBuildResourceBuildings() : Boolean
      {
         var _loc1_:Object = this._buildingFactory.getAvailableBuildings(this._buildingData.resourceBuildingDefinitions);
         return _loc1_.hasAvailableBuildings;
      }
      
      private function doNewSashTest(param1:BuildPanelMainButton, param2:Array) : void
      {
         var _loc3_:Boolean = this.groupHasNewItems(param2);
         param1.setNewSashVisible(_loc3_);
      }
      
      private function doNewSashTestPremiumBuildings(param1:BuildPanelMainButton, param2:Array) : void
      {
         var _loc3_:Boolean = this.groupHasNewItemsPremiumBuildings(param2);
         param1.setNewSashVisible(_loc3_);
      }
      
      public function buildBaseBuildingsIcons() : void
      {
         this.focusButton(this._baseBuildingsButton);
         this.buildIconsWithData(this._buildingData.baseBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      public function buildUpgradeBuildingsIcons() : void
      {
         this.focusButton(this._upgradeBuildingsButton);
         this.buildIconsWithData(this._buildingData.upgradeBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      public function buildResourceBuildingsIcons() : void
      {
         this.focusButton(this._resourceBuildingsButton);
         this.buildIconsWithData(this._buildingData.resourceBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      public function buildSpecialBuildingsIcons() : void
      {
         this.focusButton(this._specialBuildingsButton);
         this.buildIconsWithData(this._buildingData.specialBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      public function buildPVPBuildingsIcons() : void
      {
         this.focusButton(this._pvpBuildingsButton);
         this.buildIconsWithData(this._buildingData.pvpBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      public function buildPremiumBuildingsIcons() : void
      {
         this.focusButton(this._premiumBuildingsButton);
         this.buildIconsWithData(this._buildingData.premiumBuildingDefinitions);
         this.reSyncButtonSashes();
      }
      
      private function isInArray(param1:Array, param2:*) : Boolean
      {
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] === param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function groupHasNewItems(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:MonkeyTownBuildingDefinition = null;
         var _loc7_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc5_:BuildingManager = _system.city.buildingManager;
         var _loc6_:StatsData = StatsData.getInstance();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = param1[_loc2_];
            _loc3_ = this._buildingFactory.isAvailableToBuild(_loc4_);
            if(_loc3_)
            {
               _loc7_ = _loc5_.hasBuiltBuilding(_loc4_.id);
               if(!_loc7_)
               {
                  _loc7_ = _loc6_.hasBuiltBuilding(_loc4_.id);
               }
               if(!_loc7_)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function groupHasNewItemsPremiumBuildings(param1:Array) : Boolean
      {
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:Object = PremiumBuildingManager.getInstance().premiumBuildingsFromLastSession;
         for each(_loc4_ in _loc3_)
         {
            _loc2_++;
         }
         return _loc2_ < param1.length;
      }
      
      private function clearBuildingItems() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._buildingPanelItems.length)
         {
            this._buildingPanelItems[_loc1_].destroy();
            _loc1_++;
         }
         this._buildingPanelItems.length = 0;
         LGDisplayListUtil.getInstance().removeAllChildren(this._contentContainer);
      }
      
      public function buildIconsWithData(param1:Array, param2:Boolean = true) : void
      {
         var _loc4_:MonkeyTownBuildingDefinition = null;
         var _loc5_:MovieClip = null;
         var _loc6_:BuildingIcon = null;
         var _loc7_:int = 0;
         var _loc8_:BuildPanelItem = null;
         var _loc9_:BuildingAvailabilityReport = null;
         var _loc21_:Boolean = false;
         var _loc22_:NewSash = null;
         var _loc23_:MoreSash = null;
         if(param2)
         {
            this._scrollBar.setToTop();
         }
         this._currentDefinitionList = param1;
         this.clearBuildingItems();
         var _loc3_:int = param1.length;
         var _loc10_:int = 10;
         var _loc11_:int = 105;
         var _loc12_:int = 20;
         var _loc13_:int = _loc12_;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = this._onNextOpenParams != null && this._onNextOpenParams.enableBuildings != null;
         var _loc16_:BuildingManager = _system.city.buildingManager;
         var _loc17_:StatsData = StatsData.getInstance();
         var _loc18_:* = this._currentDefinitionList === this._buildingData.resourceBuildingDefinitions;
         var _loc19_:Sprite = new Sprite();
         var _loc20_:int = _system.city.cityIndex;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = param1[_loc7_];
            if(_loc4_.buildable)
            {
               if(_loc4_.minimumCityIndex <= _loc20_)
               {
                  if(_loc15_)
                  {
                     _loc14_ = this.isInArray(this._onNextOpenParams.enableBuildings,_loc4_);
                  }
                  else if(_loc4_.nkCoinCost > 0)
                  {
                     _loc14_ = true;
                  }
                  else
                  {
                     _loc14_ = this._buildingFactory.isAvailableToBuild(_loc4_);
                  }
                  _loc8_ = this.getBuildPanelItem(_loc19_,_loc4_);
                  _loc8_.y = _loc13_;
                  _loc13_ = _loc13_ + _loc11_;
                  _loc8_.available = _loc14_;
                  this.addMouseListenersToBuildingItem(_loc8_);
                  this._buildingPanelItems.push(_loc8_);
                  _loc21_ = _loc16_.hasBuiltBuilding(_loc4_.id);
                  if(!_loc21_)
                  {
                     _loc21_ = _loc17_.hasBuiltBuilding(_loc4_.id);
                  }
                  if(_loc8_.buildingDefinition.nkCoinCost > 0)
                  {
                     if(!FirstTimeTriggerManager.tutorialIsActive)
                     {
                        if(!_loc21_)
                        {
                           if(null == PremiumBuildingManager.getInstance().premiumBuildingsFromLastSession[_loc4_.id])
                           {
                              _loc22_ = new NewSash();
                              _loc22_.x = 455;
                              _loc22_.y = 12;
                              _loc8_.addChild(_loc22_);
                           }
                        }
                        PremiumBuildingManager.getInstance().addLastKnownPremiumBuilding(_loc4_.id);
                     }
                  }
                  else if(_loc14_)
                  {
                     if(!FirstTimeTriggerManager.tutorialIsActive)
                     {
                        if(!_loc21_)
                        {
                           _loc22_ = new NewSash();
                           _loc22_.x = 455;
                           _loc22_.y = 12;
                           _loc8_.addChild(_loc22_);
                        }
                        else if(_loc18_)
                        {
                           _loc23_ = new MoreSash();
                           _loc23_.x = 448;
                           _loc23_.y = 12;
                           _loc8_.addChild(_loc23_);
                        }
                     }
                  }
                  this._contentContainer.addChild(_loc8_);
                  this._contentContainer.addChild(_loc19_);
               }
            }
            _loc7_++;
         }
         if(param2)
         {
            this._scrollBar.setToTop();
         }
      }
      
      private function addMouseListenersToBuildingItem(param1:BuildPanelItem) : void
      {
         if(param1.available)
         {
            param1.buttonController.setClickFunction(this.baseBuildingIconClicked,false,true);
         }
         param1.buttonController.setOverFunction(this.buildIconRolloverHandler,false,true);
         param1.buttonController.setLockedOverFunction(this.buildIconRolloverHandler,false,true);
         param1.buttonController.setLockedOutFunction(this.buildIconRolloutHandler,false,true);
         param1.buttonController.setOutFunction(this.buildIconRolloutHandler,false,true);
      }
      
      private function initColorTransforms() : void
      {
         var _loc1_:AdjustColor = new AdjustColor();
         var _loc2_:Array = [];
         _loc1_.hue = 0;
         _loc1_.saturation = -100;
         _loc1_.brightness = 0;
         _loc1_.contrast = 0;
         _loc2_ = _loc1_.CalculateFinalFlatArray();
         this._unavailableFilter = new ColorMatrixFilter(_loc2_);
      }
      
      public function getBuildPanelItem(param1:Sprite, param2:MonkeyTownBuildingDefinition) : BuildPanelItem
      {
         var _loc3_:BuildPanelItem = null;
         if(param2.nkCoinCost > 0)
         {
            _loc3_ = new BuildPanelItemPremium(param2,param1);
         }
         else
         {
            _loc3_ = new BuildPanelItem(param2);
         }
         return _loc3_;
      }
      
      private function buildIconRolloverHandler(param1:ButtonControllerBase) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc2_:BuildPanelItem = BuildPanelItem(param1.data.buildPanelItem);
         var _loc3_:* = "";
         var _loc4_:BuildingAvailabilityReport = new BuildingAvailabilityReport(_loc2_.buildingDefinition,true);
         if(_loc4_.available)
         {
            _loc6_ = _loc2_.buildingDefinition.timeToBuild * 60;
            if(_loc6_ < 60)
            {
               if(_loc6_ == 1)
               {
                  _loc3_ = _loc3_ + ("Takes " + _loc6_ + " second to build");
               }
               else if(_loc6_ > 0)
               {
                  _loc3_ = _loc3_ + ("Takes " + _loc6_ + " seconds to build");
               }
               else
               {
                  _loc3_ = _loc3_ + "Builds immediately";
               }
            }
            else
            {
               _loc7_ = _loc2_.buildingDefinition.timeToBuild;
               _loc8_ = _loc7_ > 1?" minutes":" minute";
               _loc3_ = _loc3_ + ("Takes " + int(_loc6_ / 60) + _loc8_ + " to build");
            }
            if(_loc2_.buildingDefinition.monkeyMoneyCost > 0)
            {
               _loc3_ = _loc3_ + _loc4_.message;
               _loc3_ = _loc3_ + ("<br/><span class=\"green\">Buy for $" + _loc2_.buildingDefinition.monkeyMoneyCost + "</span>");
            }
            _loc2_.overState();
         }
         else
         {
            _loc3_ = _loc3_ + ("Not available:" + _loc4_.notMetMessage);
         }
         if(_loc2_.buildingDefinition.nkCoinCost > 0)
         {
            _loc3_ = _loc3_ + ("<br/><span class=\"yellow\">Requires " + _loc2_.buildingDefinition.nkCoinCost);
            if(Kong.isOnKong())
            {
               _loc3_ = _loc3_ + " Kong Kreds</span>";
            }
            else
            {
               _loc3_ = _loc3_ + " NK Coins</span>";
            }
         }
         var _loc5_:String = "";
         if(_loc2_.buildingDefinition.requiresTerrainProperty != null && _loc2_.buildingDefinition.requiresTerrainProperty != "")
         {
            _loc5_ = TileDefinitions.getInstance().TERRAIN_NAMES_BY_ID[_loc2_.buildingDefinition.requiresTerrainProperty];
            _loc3_ = _loc3_ + ("<br/><span class=\"blue\">Requires " + _loc5_ + " Terrain to build</span>");
         }
         if(_loc2_.buildingDefinition.requiresTerrain != null)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc2_.buildingDefinition.requiresTerrain.length)
            {
               if(_loc2_.buildingDefinition.requiresTerrain[_loc9_] != "")
               {
                  _loc5_ = TileDefinitions.getInstance().TERRAIN_NAMES_BY_ID[_loc2_.buildingDefinition.requiresTerrain[_loc9_]];
                  _loc3_ = _loc3_ + ("<br/><span class=\"blue\">Requires " + _loc5_ + " Terrain to build</span>");
               }
               _loc9_++;
            }
         }
         if(_loc2_.buildingDefinition.nkCoinCost > 0)
         {
            if(_loc2_.buildingDefinition.width !== 1 || _loc2_.buildingDefinition.height !== 1)
            {
               _loc3_ = _loc3_ + ("<br/><span class=\"green\">Requires " + _loc2_.buildingDefinition.width + "x" + _loc2_.buildingDefinition.height + " Tiles</span>");
            }
         }
         if(_loc2_.buildingDefinition.xpGivenForBuilding > 0)
         {
            _loc3_ = _loc3_ + ("<br/><span class=\"green\">Earns " + _loc2_.buildingDefinition.xpGivenForBuilding + " XP</span>");
         }
         _loc3_ = _loc3_ + ("<br/>" + _loc4_.currentBuildingCount + " of " + _loc4_.possibleBuildingCount);
         this._toolTip.message = _loc3_;
         this._toolTip.reveal();
         this._toolTip.activateMouseFollow();
      }
      
      private function buildIconRolloutHandler(param1:ButtonControllerBase) : void
      {
         var _loc2_:BuildPanelItem = BuildPanelItem(param1.data.buildPanelItem);
         _loc2_.outState();
         this._toolTip.hide();
         this._toolTip.deactivateMouseFollow();
      }
      
      private function focusButton(param1:ButtonControllerBase) : void
      {
         if(this._currentFocusedButton)
         {
            this._currentFocusedButton.unlock(0);
         }
         this._currentFocusedButton = param1;
         param1.lock(3);
         this.syncCurrencyIcon();
      }
      
      private function baseBuildingIconClicked(param1:ButtonControllerBase) : void
      {
         var _loc2_:MonkeyTownBuildingDefinition = (param1.data.buildPanelItem as BuildPanelItem).buildingDefinition;
         if(_loc2_.nkCoinCost > 0)
         {
            if(this.canPremiumBuildingBePlaced(_loc2_))
            {
               if(this._targetBuildTile)
               {
                  this.buildingWasSelectedForTileSignal.dispatch(BuildPanelItem(param1.data.buildPanelItem).buildingDefinition,this._targetBuildTile);
               }
               this.buildingWasSelectedSignal.dispatch(_loc2_);
               this.hide();
            }
            else
            {
               this._townUI.confirmPurchasePanel.updateInfoForBuilding(_loc2_);
               this._townUI.confirmPurchasePanel.reveal();
            }
         }
         else
         {
            if(this._targetBuildTile)
            {
               this.buildingWasSelectedForTileSignal.dispatch(BuildPanelItem(param1.data.buildPanelItem).buildingDefinition,this._targetBuildTile);
            }
            this.buildingWasSelectedSignal.dispatch(_loc2_);
            this.hide();
         }
      }
      
      private function onCloseButtonClicked() : void
      {
         this.hide();
         this.buildPanelWasClosedSignal.dispatch();
         PremiumBuildingManager.getInstance().saveLastKnownPremiumBuildings();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this.initView();
         if(this._onNextOpenParams != null)
         {
            if(this._onNextOpenParams.openPanel != undefined)
            {
               if(this._onNextOpenParams.panelLocked != undefined)
               {
                  if(this._onNextOpenParams.panelLocked == true)
                  {
                     this.disablePanels();
                  }
                  else
                  {
                     this.enablePanels();
                  }
               }
               switch(this._onNextOpenParams.openPanel)
               {
                  case TownUI.UPGRADE_BUILDINGS:
                     this.buildUpgradeBuildingsIcons();
                     break;
                  case TownUI.RESOURCE_BUILDINGS:
                     this.buildResourceBuildingsIcons();
                     break;
                  default:
                     this.buildBaseBuildingsIcons();
               }
            }
         }
         else
         {
            this.enablePanels();
            this.buildBaseBuildingsIcons();
         }
         this._onNextOpenParams = null;
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         super.reveal(param1);
      }
      
      public function syncCurrencyIcon() : void
      {
         if(!this._clip.premiumButton.hasOwnProperty("currencyIcon") || this._clip.premiumButton.currencyIcon === null)
         {
            return;
         }
         if(Kong.isOnKong())
         {
            this._clip.premiumButton.currencyIcon.gotoAndStop(2);
         }
         else
         {
            this._clip.premiumButton.currencyIcon.gotoAndStop(1);
         }
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
      
      public function onNextOpen(param1:Object) : void
      {
         this._onNextOpenParams = param1;
      }
      
      public function setTargetBuildTile(param1:Tile) : void
      {
         this._targetBuildTile = param1;
      }
      
      public function canPremiumBuildingBePlaced(param1:MonkeyTownBuildingDefinition) : Boolean
      {
         return this._monkeySystem.city.buildingManager.getBuildingCount(param1.id) < PremiumBuildingManager.getInstance().buildingsBoughtINumbers[param1.id].value;
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         GameSignals.BUILD_PANEL_CLOSED.dispatch();
         this._targetBuildTile = null;
         this._toolTip.deactivateMouseFollow();
         this._toolTip.hide(0.2);
         super.hide(param1);
      }
      
      private function disablePanels() : void
      {
         this._baseBuildingsButton.lock(1);
         this._upgradeBuildingsButton.lock(1);
         this._resourceBuildingsButton.lock(1);
         this._specialBuildingsButton.lock(1);
         this._pvpBuildingsButton.lock(1);
         this._premiumBuildingsButton.lock(1);
         this._currentFocusedButton = null;
      }
      
      private function enablePanels() : void
      {
         this._baseBuildingsButton.unlock();
         this._upgradeBuildingsButton.unlock();
         this._resourceBuildingsButton.unlock();
         this._specialBuildingsButton.unlock();
         this._pvpBuildingsButton.unlock();
         this._premiumBuildingsButton.unlock();
      }
   }
}
