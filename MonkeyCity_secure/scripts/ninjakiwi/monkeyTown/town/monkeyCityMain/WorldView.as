package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import assets.town.BanksFullWordAnimation;
   import assets.town.LoseWordAnimation;
   import assets.town.NoMoneyAnimation;
   import assets.town.TanksFullWordAnimation;
   import assets.town.WinWordAnimation;
   import assets.ui.BuildingMoveButtonClip;
   import assets.ui.UpgradeArrowButton;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.lgrey.input.Key;
   import com.lgrey.signal.SignalHub;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Camera;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.interfaces.Resettable;
   import ninjakiwi.monkeyTown.mouseManager.MouseManager;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.persistence.AutoSaver;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.city.ActiveCity;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.flare.FlareManager;
   import ninjakiwi.monkeyTown.town.fogOfWar.FogOfWar;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSquare;
   import ninjakiwi.monkeyTown.town.quests.QuestManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TileReporter;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.ISimulateClickable;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.cursor.MonkeyCityCursorManager;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.Signal;
   
   public class WorldView extends Sprite implements Resettable
   {
      
      public static var overlayContainer:Sprite = new Sprite();
      
      public static var overlayContainerFlash:Sprite = new Sprite();
      
      public static var onlySimulateClickEnabled:Boolean = false;
      
      public static var mouseEnableAfterInit:Boolean = true;
      
      public static var enableOneTile:IntPoint2D = null;
      
      public static const discountAttackCostByPercentage:Signal = new Signal(Function);
      
      public static var paused:Boolean = false;
      
      private static const RENDER_OVERLAY_TO_BITMAPDATA:Boolean = true;
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      var _tileDefinitions:TileDefinitions;
      
      public var camera:Camera;
      
      public var map:TownMap;
      
      var _requireFullRedraw:Boolean = true;
      
      private var _configData:ConfigData;
      
      private var _buildingData:BuildingData;
      
      private var _config:ConfigData;
      
      private var _resourceStore:ResourceStore;
      
      var _buildingPlacer:BuildingPlacer;
      
      private var _flareManager:FlareManager;
      
      private var _mouseManager:MouseManager;
      
      private var _dragStartCameraPosition:LGVector2D;
      
      private var _mousePositionInTileSpace:IntPoint2D;
      
      private var _monkeyCityMainSignals:MonkeyCityMainSignals;
      
      public var currentMousePositionInTileSpace:IntPoint2D;
      
      private var _tileReporter:TileReporter;
      
      private var _cursorManager:MonkeyCityCursorManager;
      
      private var _hubUI:SignalHub;
      
      private var _fogOfWar:FogOfWar;
      
      private var _buildingMoveButtonClip:BuildingMoveButtonClip;
      
      private var _buildingMoveButton:ButtonControllerBase;
      
      private var _buildingUpgradeButtonClip:UpgradeArrowButton;
      
      private var _buildingUpgradeButton:ButtonControllerBase;
      
      private var _timeHoveredTile:Number = 0;
      
      private var _currentHoveredTile:Tile = null;
      
      private var _isHoveringBuilding:Boolean = false;
      
      private var _delayedHoverActionReached:Boolean = false;
      
      private var _timeOfCurrentTick:Number;
      
      private var _timeOfLastTick:Number;
      
      private var _ultraTimeUnit:UltraTimeUnit;
      
      private const winAnimation:WinWordAnimation = new WinWordAnimation();
      
      private const loseAnimation:LoseWordAnimation = new LoseWordAnimation();
      
      private var fogIsActive:Boolean = true;
      
      public function WorldView(param1:MouseManager, param2:MonkeyCityCursorManager)
      {
         this._tileDefinitions = TileDefinitions.getInstance();
         this.camera = new Camera();
         this._configData = ConfigData.getInstance();
         this._buildingData = BuildingData.getInstance();
         this._config = ConfigData.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         this._dragStartCameraPosition = new LGVector2D();
         this._mousePositionInTileSpace = new IntPoint2D();
         this.currentMousePositionInTileSpace = new IntPoint2D(-1,-1);
         this._tileReporter = new TileReporter();
         this._hubUI = SignalHub.getHub("ui");
         this._buildingMoveButtonClip = new BuildingMoveButtonClip();
         this._buildingMoveButton = new ButtonControllerBase(this._buildingMoveButtonClip);
         this._buildingUpgradeButtonClip = new UpgradeArrowButton();
         this._buildingUpgradeButton = new ButtonControllerBase(this._buildingUpgradeButtonClip);
         this._timeOfCurrentTick = getTimer();
         this._timeOfLastTick = getTimer();
         super();
         this._mouseManager = param1;
         this._cursorManager = param2;
         this.init();
      }
      
      public static function sortOverlayContainerOnY(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_.push(param1.getChildAt(_loc3_));
            _loc3_++;
         }
         _loc2_.sortOn("y",Array.NUMERIC | Array.DESCENDING);
         var _loc4_:uint = _loc2_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            param1.addChild(_loc2_[_loc5_]);
            _loc5_++;
         }
      }
      
      public static function addOverlayItem(param1:DisplayObject) : void
      {
         overlayContainer.addChild(param1);
         sortOverlayContainerOnY(overlayContainer);
      }
      
      public static function removeOverlayItem(param1:DisplayObject) : void
      {
         if(overlayContainer.contains(param1))
         {
            overlayContainer.removeChild(param1);
            sortOverlayContainerOnY(overlayContainer);
         }
      }
      
      public static function stopOverlayItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(overlayContainer != null)
         {
            _loc1_ = 0;
            while(_loc1_ < overlayContainer.numChildren)
            {
               _loc2_ = overlayContainer.getChildAt(_loc1_);
               if(_loc2_ is MovieClip)
               {
                  (_loc2_ as MovieClip).stop();
               }
               _loc1_++;
            }
         }
      }
      
      public static function resumeOverlayItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(overlayContainer != null)
         {
            _loc1_ = 0;
            while(_loc1_ < overlayContainer.numChildren)
            {
               _loc2_ = overlayContainer.getChildAt(_loc1_);
               if(_loc2_ is MovieClip)
               {
                  (_loc2_ as MovieClip).play();
               }
               _loc1_++;
            }
         }
      }
      
      public static function removeAllOverlayItems() : void
      {
         if(overlayContainer != null)
         {
            while(overlayContainer.numChildren > 0)
            {
               overlayContainer.removeChildAt(0);
            }
         }
      }
      
      public static function addOverlayFlashItems(param1:DisplayObject) : void
      {
         overlayContainerFlash.addChild(param1);
         overlayContainerFlash.name = "overlayFlash";
         sortOverlayContainerOnY(overlayContainerFlash);
      }
      
      public static function removeOverlayFlashItem(param1:DisplayObject) : void
      {
         if(overlayContainerFlash.contains(param1))
         {
            overlayContainerFlash.removeChild(param1);
            sortOverlayContainerOnY(overlayContainerFlash);
         }
      }
      
      public static function stopOverlayFlashItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(overlayContainerFlash != null)
         {
            _loc1_ = 0;
            while(_loc1_ < overlayContainerFlash.numChildren)
            {
               _loc2_ = overlayContainerFlash.getChildAt(_loc1_);
               if(_loc2_ is MovieClip)
               {
                  (_loc2_ as MovieClip).stop();
               }
               _loc1_++;
            }
         }
      }
      
      public static function resumeOverlayFlashItmes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(overlayContainerFlash != null)
         {
            _loc1_ = 0;
            while(_loc1_ < overlayContainerFlash.numChildren)
            {
               _loc2_ = overlayContainerFlash.getChildAt(_loc1_);
               if(_loc2_ is MovieClip)
               {
                  (_loc2_ as MovieClip).play();
               }
               _loc1_++;
            }
         }
      }
      
      public static function removeAllOverlayFlashItem() : void
      {
         if(overlayContainerFlash != null)
         {
            while(overlayContainerFlash.numChildren > 0)
            {
               overlayContainerFlash.removeChildAt(0);
            }
         }
      }
      
      public function init() : void
      {
         this._system.city = new ActiveCity(overlayContainer,0);
         overlayContainer.mouseChildren = true;
         overlayContainer.mouseEnabled = true;
         this.map = new TownMap(this._system.TOWN_MAP_WIDTH_GRIDSPACE,this._system.TOWN_MAP_HEIGHT_GRIDSPACE,this._system.TOWN_GRID_UNIT_SIZE,this._system.TOWN_GRID_UNIT_SIZE);
         this._system.map = this.map;
         CityCommonDataManager.getInstance().setMap(this.map);
         this._buildingPlacer = new BuildingPlacer(this,this.map,this._mouseManager);
         this._flareManager = new FlareManager(this.map,this.camera);
         this.map.centerCameraOnVillage(this.camera,0,-100);
         this.camera.width = this._system.RENDER_SURFACE_WIDTH;
         this.camera.height = this._system.RENDER_SURFACE_HEIGHT;
         this._system.resizeSignal.add(this.onResize);
         this._mouseManager.setMouseActive(false);
         this._mouseManager.lock();
         this.syncOverlay();
         this._fogOfWar = new FogOfWar(this._system.TOWN_MAP_WIDTH_GRIDSPACE,this._system.TOWN_MAP_HEIGHT_GRIDSPACE,this.map);
         this.map.signals.beginBuildingFromSaveDefinition.add(this.onBeginBuildFromSaveSignal);
         this.map.signals.territoryFlagsSet.add(this.onTerritoryFlagsSetSignal);
         HideRevealView.panelRevealBeginSignal.add(this.autoUnHoverOnUIReveal);
         if(!RENDER_OVERLAY_TO_BITMAPDATA)
         {
            addChild(overlayContainer);
            overlayContainer.mouseEnabled = false;
            overlayContainer.mouseChildren = false;
         }
         this._buildingMoveButton.setClickFunction(this.onBuildingMoveButtonClick);
         this._buildingUpgradeButton.setClickFunction(this.onUpgradeButtonClick);
         overlayContainerFlash.addEventListener(MouseEvent.ROLL_OUT,this.onOverlayLayerMouseOut);
         addChild(overlayContainerFlash);
         TownUI.globalMouseOverSignal.add(this.onUIMouseOverSignal);
         this._ultraTimeUnit = new UltraTimeUnit(Main.instance.mainBitmap);
         addChild(this._ultraTimeUnit);
      }
      
      private function onUIMouseOverSignal() : void
      {
         this._mouseManager.endDrag(false);
      }
      
      private function onBeginBuildFromSaveSignal() : void
      {
         this._fogOfWar.setFullFog();
      }
      
      private function onTerritoryFlagsSetSignal() : void
      {
         this.updateFogOfWar();
      }
      
      public function initSignals(param1:MonkeyCityMainSignals) : void
      {
         this._monkeyCityMainSignals = param1;
         WorldViewSignals.buildWorldProgressSignal.setTargetSignal(this.map.signals.buildProgress);
         WorldViewSignals.buildingWasPlacedSignal.setTargetSignal(BuildingPlacer.buildingWasPlacedSignal);
         WorldViewSignals.buildingWasPlacedWithoutShiftSignal.setTargetSignal(BuildingPlacer.buildingWasPlacedWithoutShiftSignal);
         this.initSignalListeners();
      }
      
      public function tick() : void
      {
         if(!this.map.worldIsReady || paused)
         {
            return;
         }
         this._timeOfCurrentTick = getTimer();
         this._system.city.tick();
         this._flareManager.tick();
         this.updateKeyActions();
         this.updateTileHoverDelayedActions();
         this._timeOfLastTick = getTimer();
      }
      
      public function render(param1:BitmapData) : void
      {
         var _loc3_:Matrix = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(paused)
         {
            return;
         }
         if(param1.rect.width > 0 && param1.rect.height > 0)
         {
            param1.fillRect(param1.rect,0);
         }
         this._flareManager.renderBack(param1,this.camera);
         this.map.render(param1,this.camera,false);
         var _loc2_:Matrix = overlayContainer.transform.matrix;
         if(RENDER_OVERLAY_TO_BITMAPDATA)
         {
            _loc2_ = overlayContainer.transform.matrix;
            _loc5_ = 0;
            while(_loc5_ < overlayContainer.numChildren)
            {
               _loc4_ = overlayContainer.getChildAt(_loc5_);
               _loc3_ = _loc2_.clone();
               _loc3_.concat(_loc4_.transform.matrix);
               param1.draw(_loc4_,_loc3_);
               _loc5_++;
            }
         }
         if(this._mouseManager.isDragging || this._mouseManager.dragIntertiaEnabled)
         {
            _loc2_ = overlayContainerFlash.transform.matrix;
            _loc5_ = 0;
            while(_loc5_ < overlayContainerFlash.numChildren)
            {
               _loc4_ = overlayContainerFlash.getChildAt(_loc5_);
               _loc3_ = _loc2_.clone();
               _loc3_.concat(_loc4_.transform.matrix);
               param1.draw(_loc4_,_loc3_);
               _loc5_++;
            }
         }
         this._flareManager.renderFront(param1,this.camera);
         this._fogOfWar.render(param1,this.camera);
         this._requireFullRedraw = false;
      }
      
      public function set ultraPause(param1:Boolean) : void
      {
         if(param1)
         {
            this._ultraTimeUnit.activate();
            overlayContainerFlash.visible = false;
            MonkeyCityMain.getInstance().ui.hideHUD(0.1);
            paused = true;
         }
         else
         {
            this._ultraTimeUnit.deactivate();
            overlayContainerFlash.visible = true;
            MonkeyCityMain.getInstance().ui.revealHud(0.1);
            paused = false;
         }
      }
      
      public function get ultraPause() : Boolean
      {
         return this._ultraTimeUnit.active;
      }
      
      private function initSignalListeners() : void
      {
         this._mouseManager.signals.dragStartSignal.add(this.onStartDrag);
         this._mouseManager.signals.dragEndSignal.add(this.onEndDrag);
         this._mouseManager.signals.dragUpdateSignal.add(this.onUpdateDrag);
         this._mouseManager.signals.mouseMoveSignal.add(this.onMouseMove);
         this._mouseManager.signals.validClickSignal.add(this.onValidClick);
         this._monkeyCityMainSignals.beginPlacingBuildingSignal.add(this._buildingPlacer.beginPlacingBuilding);
         this._monkeyCityMainSignals.cancelPlacingBuildingSignal.add(this._buildingPlacer.cancelPlacingBuilding);
         this._monkeyCityMainSignals.cancelMovingBuildingSignal.add(this._buildingPlacer.cancelPlacingBuilding);
         this._monkeyCityMainSignals.buildingWasSelectedSignal.add(this._buildingPlacer.beginPlacingBuilding);
         this._monkeyCityMainSignals.buildingWasSelectedForTileSignal.add(this._buildingPlacer.placeBuildingOnTile);
         GameSignals.BANKS_FULL_ANIMATION.add(this.addBanksFullAnimation);
         GameSignals.TANKS_FULL_ANIMATION.add(this.addTanksFullAnimation);
         WorldViewSignals.clearWorldCompleteSignal.add(this.onBuildWorldStartSignal);
         WorldViewSignals.buildWorldStartSignal.add(this.onBuildWorldStartSignal);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEndSignal);
         Building.mouseOverBuildingOverlayItem.add(this.onMouseOverBuildingOverlayItem);
         this._buildingPlacer.beginFloatingBuildingSignal.add(this.onBeginFloatingBuildingSignal);
         this._buildingPlacer.endFloatingBuildingSignal.add(this.onEndFloatingBuildingSignal);
      }
      
      private function onBeginFloatingBuildingSignal() : void
      {
         overlayContainerFlash.mouseEnabled = false;
         overlayContainerFlash.mouseChildren = false;
      }
      
      private function onEndFloatingBuildingSignal() : void
      {
         overlayContainerFlash.mouseEnabled = true;
         overlayContainerFlash.mouseChildren = true;
      }
      
      private function onBuildWorldStartSignal() : void
      {
         overlayContainerFlash.visible = false;
         overlayContainerFlash.alpha = 0;
      }
      
      private function onBuildWorldEndSignal() : void
      {
         overlayContainerFlash.alpha = 0;
         overlayContainerFlash.visible = true;
         TweenLite.to(overlayContainerFlash,1,{"alpha":1});
      }
      
      public function onStartDrag(param1:Number, param2:Number) : void
      {
         this._dragStartCameraPosition.set(this.camera.x,this.camera.y);
         this.tweenOutButton(this._buildingMoveButton.target);
         this.tweenOutButton(this._buildingUpgradeButton.target);
         if(this.contains(overlayContainerFlash))
         {
            removeChild(overlayContainerFlash);
         }
      }
      
      public function onEndDrag(param1:Number, param2:Number) : void
      {
         this._timeHoveredTile = 0;
         addChild(overlayContainerFlash);
      }
      
      public function onMouseMove(param1:Number, param2:Number) : void
      {
         if(!this.map.worldIsReady)
         {
            return;
         }
         this._mousePositionInTileSpace = this.mousePositionInTileSpace();
         var _loc3_:IntPoint2D = this.mousePositionInTileSpace();
         this.map.mouseHint.x = (param1 + this.camera.x) / this._system.TOWN_GRID_UNIT_SIZE - _loc3_.x;
         this.map.mouseHint.y = (param2 + this.camera.y) / this._system.TOWN_GRID_UNIT_SIZE - _loc3_.y;
         var _loc4_:Boolean = this.map.updateSingleHoverWithBuildings(param1,param2,this.camera,this._buildingPlacer.buildingBeingPlaced == null?false:true);
         if(_loc4_)
         {
            this.onMouseEnterNewTile();
         }
         this._buildingPlacer.update(param1,param2);
         this.currentMousePositionInTileSpace = _loc3_;
      }
      
      public function onUpdateDrag(param1:Number, param2:Number) : void
      {
         this.camera.x = int(this._dragStartCameraPosition.x - param1);
         this.camera.y = int(this._dragStartCameraPosition.y - param2);
         this.camera.clamp();
         this._requireFullRedraw = true;
         this.syncOverlay();
         this._system.city.buildClockManager.updateClockPositions();
      }
      
      private function updateKeyActions() : void
      {
         if(FirstTimeTriggerManager.tutorialIsActive)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:Number = 10;
         if(Key.isDown(Keyboard.LEFT))
         {
            this.moveCameraByOffset(-_loc2_,0);
            _loc1_ = true;
         }
         else if(Key.isDown(Keyboard.RIGHT))
         {
            this.moveCameraByOffset(_loc2_,0);
            _loc1_ = true;
         }
         if(Key.isDown(Keyboard.UP))
         {
            this.moveCameraByOffset(0,-_loc2_);
            _loc1_ = true;
         }
         else if(Key.isDown(Keyboard.DOWN))
         {
            this.moveCameraByOffset(0,_loc2_);
            _loc1_ = true;
         }
         if(_loc1_)
         {
            this.onMouseMove(this._mouseManager.currentMousePosition.x,this._mouseManager.currentMousePosition.y);
         }
      }
      
      private function moveCameraByOffset(param1:Number, param2:Number) : void
      {
         this.camera.x = this.camera.x + param1;
         this.camera.y = this.camera.y + param2;
         this.camera.clamp();
         this._requireFullRedraw = true;
         this.syncOverlay();
         this._system.city.buildClockManager.updateClockPositions();
      }
      
      private function autoUnHoverOnUIReveal() : void
      {
         if(this._currentHoveredTile !== null)
         {
            this._currentHoveredTile.unhover();
         }
      }
      
      private function onMouseEnterNewTile() : void
      {
         if(!this.map.worldIsReady)
         {
            return;
         }
         var _loc1_:IntPoint2D = this.mousePositionInTileSpace();
         var _loc2_:Tile = this.map.tileAtPoint(_loc1_);
         if(this._currentHoveredTile === _loc2_)
         {
            return;
         }
         var _loc3_:String = this._tileReporter.getTileReport(_loc2_,this.map);
         WorldViewSignals.reportOnMouseEnterNewTile.dispatch(_loc3_);
         if(this._currentHoveredTile !== null && (this._currentHoveredTile.building === null || this._currentHoveredTile.building !== _loc2_.building))
         {
            this._currentHoveredTile.unhover();
         }
         PvPAttackSquare.unhover();
         BloonBeaconSquare.unhover();
         if(!this._buildingPlacer.placingBuilding)
         {
            if(_loc2_.isUnderPvPAttack)
            {
               if(_loc2_.pvpAttackSquare != null)
               {
                  _loc2_.pvpAttackSquare.hover();
               }
            }
            this._isHoveringBuilding = _loc2_.building !== null;
            if(this._isHoveringBuilding)
            {
               WorldViewSignals.mouseHoveredBuilding.dispatch(_loc2_.building);
            }
            this._timeHoveredTile = 0;
            this._delayedHoverActionReached = false;
            this._currentHoveredTile = _loc2_;
         }
         this.tweenOutButton(this._buildingMoveButton.target);
         this.tweenOutButton(this._buildingUpgradeButton.target);
      }
      
      private function updateTileHoverDelayedActions() : void
      {
         var _loc2_:Building = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._mouseManager.isDragging || this._buildingPlacer.movingBuilding)
         {
            return;
         }
         var _loc1_:Number = this._timeOfCurrentTick - this._timeOfLastTick;
         this._timeHoveredTile = this._timeHoveredTile + _loc1_;
         if(!this._delayedHoverActionReached && this._timeHoveredTile > 1000)
         {
            this._delayedHoverActionReached = true;
            if(this._currentHoveredTile && this._currentHoveredTile.building !== null)
            {
               _loc2_ = this._currentHoveredTile.building;
               if(_loc2_.definition.id === this._buildingData.BANANA_FARM.id || _loc2_.definition.id === this._buildingData.BLOONTONIUM_GENERATOR.id || _loc2_.hasActiveClock() || this._resourceStore.monkeyMoney < Constants.COST_TO_MOVE_BUILDING)
               {
                  return;
               }
               _loc3_ = this._system.TOWN_GRID_UNIT_SIZE * 0.5;
               _loc4_ = this._system.TOWN_GRID_UNIT_SIZE * 0.3;
               if(_loc2_ is UpgradeableBuilding)
               {
                  if(!UpgradeableBuilding(_loc2_).isUpgrading)
                  {
                     this._buildingMoveButton.target.x = _loc2_.homeTile.x + int(_loc2_.definition.width * _loc3_) - _loc4_;
                     this._buildingMoveButton.target.y = _loc2_.homeTile.y + int(_loc2_.definition.height * _loc3_) - _loc4_;
                     this._buildingUpgradeButton.target.x = _loc2_.homeTile.x + int(_loc2_.definition.width * _loc3_) + _loc4_;
                     this._buildingUpgradeButton.target.y = _loc2_.homeTile.y + int(_loc2_.definition.height * _loc3_) - _loc4_;
                     this.tweenInButton(this._buildingUpgradeButton.target);
                  }
               }
               else
               {
                  this._buildingMoveButton.target.x = _loc2_.homeTile.x + int(_loc2_.definition.width * this._system.TOWN_GRID_UNIT_SIZE * 0.5);
                  this._buildingMoveButton.target.y = _loc2_.homeTile.y + int(_loc2_.definition.height * this._system.TOWN_GRID_UNIT_SIZE * 0.5) - this._system.TOWN_GRID_UNIT_SIZE * 0.25;
               }
               if(!Building.infoEnabled)
               {
                  return;
               }
               if(_loc2_.definition === this._buildingData.BLOON_RESEARCH_LAB)
               {
                  if(BloonResearchLabState.isUpgrading)
                  {
                     return;
                  }
               }
               this.tweenInButton(this._buildingMoveButton.target);
            }
         }
      }
      
      private function onBuildingMoveButtonClick() : void
      {
         if(this._currentHoveredTile && this._currentHoveredTile.building !== null)
         {
            this._currentHoveredTile.building.beginMoving();
            this.tweenOutButton(this._buildingMoveButton.target);
            this.tweenOutButton(this._buildingUpgradeButton.target);
         }
      }
      
      private function onUpgradeButtonClick() : void
      {
         if(this._currentHoveredTile && this._currentHoveredTile.building !== null)
         {
            WorldViewSignals.userClickedTileSignal.dispatch(this._currentHoveredTile);
         }
      }
      
      private function tweenOutButton(param1:MovieClip) : void
      {
         var target:MovieClip = param1;
         TweenLite.killTweensOf(target);
         TweenLite.to(target,0.1,{
            "scaleX":0,
            "scaleY":0,
            "onComplete":function():void
            {
               if(overlayContainerFlash.contains(target))
               {
                  overlayContainerFlash.removeChild(target);
               }
            }
         });
      }
      
      private function tweenInButton(param1:MovieClip) : void
      {
         overlayContainerFlash.addChild(param1);
         this._buildingMoveButton.target.scaleX = param1.scaleY = 0;
         TweenLite.killTweensOf(param1);
         TweenLite.to(param1,0.3,{
            "ease":Back.easeOut,
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function simulateOverlayClick(param1:MouseEvent = null) : Boolean
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:Point = new Point(mouseX,mouseY);
         var _loc3_:Array = overlayContainer.getObjectsUnderPoint(_loc2_);
         var _loc5_:ISimulateClickable = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc8_];
            while(_loc4_)
            {
               if(_loc4_ is ISimulateClickable)
               {
                  _loc7_ = _loc4_.parent.getChildIndex(_loc4_);
                  if(_loc7_ >= _loc6_)
                  {
                     _loc5_ = ISimulateClickable(_loc4_);
                     _loc6_ = _loc7_;
                  }
                  break;
               }
               _loc4_ = _loc4_.parent;
            }
            _loc8_++;
         }
         if(_loc5_)
         {
            _loc5_.simulateClick();
            return true;
         }
         return false;
      }
      
      private function onMouseOverBuildingOverlayItem(param1:Building) : void
      {
         if(this._currentHoveredTile !== null)
         {
            this._currentHoveredTile.unhover();
            this.map.clearDifficultyPips();
            if(this._currentHoveredTile.building !== null)
            {
               this._currentHoveredTile.building.setHover(false,this.map);
            }
         }
         param1.setHover(true,this.map);
         this._currentHoveredTile = param1.homeTile;
      }
      
      private function onOverlayLayerMouseOut(param1:MouseEvent) : void
      {
      }
      
      function onValidClick(param1:Number, param2:Number) : void
      {
         var _loc3_:Tile = this.getTileUnderMouse();
         if(_loc3_ !== null)
         {
            this.clickTile(_loc3_);
         }
      }
      
      public function clickTile(param1:Tile, param2:Boolean = true) : void
      {
         var _loc3_:IntPoint2D = null;
         var _loc4_:Boolean = false;
         if(!this.map.worldIsReady)
         {
            return;
         }
         if(!this._mouseManager.state)
         {
            return;
         }
         if(param2 && this.simulateOverlayClick())
         {
            return;
         }
         if(onlySimulateClickEnabled)
         {
            return;
         }
         if(enableOneTile != null && enableOneTile.isSameAs(this._mousePositionInTileSpace) == false)
         {
            return;
         }
         this.onMouseMove(this._mouseManager.currentMousePosition.x,this._mouseManager.currentMousePosition.y);
         if(this._buildingPlacer.placingBuilding)
         {
            this._buildingPlacer.placeBuilding(param1.positionTilespace.x,param1.positionTilespace.y);
         }
         else if(this.map.isValidAttackTarget(this._mousePositionInTileSpace.x,this._mousePositionInTileSpace.y))
         {
            this.attackTile(param1);
         }
         else
         {
            _loc3_ = param1.positionTilespace;
            _loc4_ = this._fogOfWar.locationIsVisible(_loc3_.x,_loc3_.y);
            if(_loc4_)
            {
               WorldViewSignals.userClickedTileSignal.dispatch(param1);
            }
         }
      }
      
      public function attackTile(param1:Tile) : void
      {
         var _loc2_:Number = this.map.getDifficultyAtTile(param1);
         var _loc3_:int = this.map.getRank(param1);
         var _loc4_:String = this.map.getDifficultyDescriptionByRank(_loc3_);
         var _loc5_:* = "Terrain: " + this._tileDefinitions.terrainDefinitionsByID[param1.type].name + "<br/>";
         _loc5_ = _loc5_ + ("Difficulty: " + _loc4_ + "<br/>");
         var _loc6_:String = param1.getBaseTerrainType();
         var _loc7_:TileAttackDefinition = new TileAttackDefinition().TerrainType(_loc6_).MonkeyTownLevel(this._resourceStore.townLevel).DifficultyLevel(_loc2_).DifficultyRankRelativeToMTL(_loc3_).DifficultyDescription(_loc4_).AttackAtLocation(param1.positionTilespace).Message(_loc5_).CostToAttack(0);
         if(MonkeyCityMain.getInstance().bloonBeaconSystem.doesTileHaveBeacon(param1))
         {
            _loc7_.isBloonBeacon = true;
            WorldViewSignals.requestBeaconGameSignal.dispatch(_loc7_);
         }
         else
         {
            WorldViewSignals.requestBTDGameSignal.dispatch(_loc7_);
         }
      }
      
      public function clear() : void
      {
         this._system.city.clear();
         MCSound.enabled = false;
         this.map.clear();
         this.map.centerCameraOnVillage(this.camera);
         this.syncOverlay();
         this._flareManager.clear();
         WorldViewSignals.clearWorldCompleteSignal.dispatch();
         removeAllOverlayItems();
         removeAllOverlayFlashItem();
         PvPAttackSquare.resetAttacks();
         PanelManager.getInstance().reset();
         MonkeyCityMain.globalResetSignal.dispatch();
         this._mouseManager.setMouseActive(false);
         this._mouseManager.lock();
         this._resourceStore.clearCityResources();
         MCSound.enabled = true;
      }
      
      public function prepareForCityTransition() : void
      {
         MonkeySystem.getInstance().map.cityIsReady = false;
         QuestManager.getInstance().deactivateQuests();
         removeAllOverlayItems();
         removeAllOverlayFlashItem();
         PvPAttackSquare.resetAttacks();
         PanelManager.getInstance().reset();
         this._resourceStore.clearCityResources();
      }
      
      private function onResize(param1:int, param2:int) : void
      {
         this.camera.width = param1;
         this.camera.height = param2;
         this.camera.clamp();
         this.syncOverlay();
      }
      
      function syncOverlay() : void
      {
         overlayContainer.x = int(overlayContainerFlash.x = -this.camera.x);
         overlayContainer.y = int(overlayContainerFlash.y = -this.camera.y);
      }
      
      private function cameraTweenTo(param1:int, param2:int, param3:Number = 2) : void
      {
         TweenLite.to(this.camera,param3,{
            "x":param1,
            "y":param2
         });
      }
      
      public function invokeCreateNewCity(param1:String) : void
      {
         var cityCommonDataManager:CityCommonDataManager = null;
         var slot:CityCommonDataSlot = null;
         var cityName:String = param1;
         AutoSaver.getInstance().off();
         this._mouseManager.setMouseActive(false);
         this._mouseManager.lock();
         this._system.city.setIsActive(false);
         cityCommonDataManager = CityCommonDataManager.getInstance();
         slot = cityCommonDataManager.createNewCityCommonSlot(cityName);
         this.prepareForCityTransition();
         this.setCameraForTutorial();
         this._system.city.clear();
         this._system.city.clearUpgradeTree();
         this._system.city.name = cityName;
         this._system.city.cityIndex = slot.bucketID;
         QuestManager.getInstance().deactivateQuests();
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Summoning monkey demiurge...");
         this._system.map.selectTerrainGeneratorForCity(slot.bucketID);
         this.invokeGenerateTerrain(cityName,function():void
         {
            WorldViewSignals.worldIsNowVisibleSignal.dispatch();
            _system.city.setIsActive(true);
            _system.city.cityIndex = slot.bucketID;
            _resourceStore.setXPNoAward(0);
            if(cityCommonDataManager.numberOfCities === 1)
            {
               GameSignals.CREATED_CAPITAL_CITY.dispatch();
               initResources();
            }
            else
            {
               GameSignals.CREATED_SECONDARY_CITY.dispatch();
            }
            CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.RESOURCES_KEY,_resourceStore.getGlobalResourcesSaveDefinition());
            Kloud.saveNewCity(_system.city.getCityInfoSaveDefinition(),map.worldSeed,map.getCompressedTerrainJSON(),map.getTileSaveDefinitions(),_system.city.upgradeTree.getSaveData(),ResourceStore.getInstance().getCityResourcesSaveDefinition(),QuestManager.getInstance().getSaveData(),function():void
            {
            });
            TrackManager.getInstance().loadAllTracks();
            TownUI.getInstance().informationBar.syncAll();
            _fogOfWar.update();
            AutoSaver.getInstance().on();
         });
      }
      
      private function initResources() : void
      {
         this._resourceStore.monkeyMoney = this._configData.startingMoney;
         this._resourceStore.bloonstones = this._configData.startingBloonstones;
         this._resourceStore.bloontonium = 0;
      }
      
      public function invokeGenerateTerrain(param1:String, param2:Function = null) : void
      {
         var cityName:String = param1;
         var callback:Function = param2;
         WorldViewSignals.buildWorldWithNameStartSignal.dispatch(cityName);
         WorldViewSignals.buildWorldStartSignal.dispatch();
         this.map.generateTerrain(function():void
         {
            WorldViewSignals.buildWorldEndSignal.dispatch();
            WorldViewSignals.generateNewWorldCompleteSignal.dispatch();
            _flareManager.generate();
            if(callback != null)
            {
               callback();
            }
         });
      }
      
      private function onWorldBuildComplete() : void
      {
         this.syncOverlay();
         this._flareManager.generate();
         this._fogOfWar.update();
         this.map.terrainGenerator.correctBadlyPlacedSpecialTerrainProperties();
         WorldViewSignals.buildWorldEndSignal.dispatch();
      }
      
      public function populateFromSaveDefinition(param1:TownMapSaveDefinition) : void
      {
         var definition:TownMapSaveDefinition = param1;
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Reticulating splines...");
         WorldViewSignals.buildWorldStartSignal.dispatch();
         WorldViewSignals.buildWorldWithNameStartSignal.dispatch(this._system.city.name);
         this._system.yield(function():void
         {
            map.populateFromSaveDefinition(definition);
         },[],this);
         this.map.signals.populateFromSaveDefinitionComplete.addOnce(this.onWorldBuildComplete);
         this.centerCameraOnVillage(true);
      }
      
      public function getTownMapSaveDefinition() : TownMapSaveDefinition
      {
         return this.map.getTownMapSaveDefinition();
      }
      
      public function addGameResultAnimation(param1:Boolean, param2:Number, param3:Number, param4:Number = 0) : void
      {
         var _loc5_:MovieClip = null;
         if(param1)
         {
            _loc5_ = this.winAnimation;
            MCSound.getInstance().playDelayedSound(MCSound.VICTORY_TILE_GRAPHIC,1,param4);
         }
         else
         {
            _loc5_ = this.loseAnimation;
            MCSound.getInstance().playDelayedSound(MCSound.LOSE_TILE_GRAPHIC,1,param4);
         }
         _loc5_.x = param2;
         _loc5_.y = param3;
         _loc5_.gotoAndPlay(1);
         overlayContainer.addChild(_loc5_);
      }
      
      public function addNoMoneyAnimation(param1:Number, param2:Number) : void
      {
         var _loc3_:NoMoneyAnimation = new NoMoneyAnimation();
         _loc3_.x = param1;
         _loc3_.y = param2;
         overlayContainer.addChild(_loc3_);
      }
      
      public function addBanksFullAnimation(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_GRID_UNIT_SIZE;
         var _loc4_:Number = param2 * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_GRID_UNIT_SIZE;
         var _loc5_:BanksFullWordAnimation = new BanksFullWordAnimation();
         _loc5_.x = _loc3_;
         _loc5_.y = _loc4_;
         overlayContainer.addChild(_loc5_);
      }
      
      public function addTanksFullAnimation(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_GRID_UNIT_SIZE * 0.5;
         var _loc4_:Number = param2 * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_MAP_HEIGHT_GRIDSPACE * 0.5;
         var _loc5_:TanksFullWordAnimation = new TanksFullWordAnimation();
         _loc5_.x = _loc3_;
         _loc5_.y = _loc4_;
         overlayContainer.addChild(_loc5_);
      }
      
      public function get ready() : Boolean
      {
         return this.map.worldIsReady;
      }
      
      private function saveDataToFileIOErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function mousePositionInTileSpace() : IntPoint2D
      {
         return new IntPoint2D(Number(Math.floor(this._mouseManager.currentMousePosition.x + this.camera.x)) / this._system.TOWN_GRID_UNIT_SIZE,Number(Math.floor(this._mouseManager.currentMousePosition.y + this.camera.y)) / this._system.TOWN_GRID_UNIT_SIZE);
      }
      
      public function getTileUnderMouse() : Tile
      {
         var _loc1_:IntPoint2D = this.mousePositionInTileSpace();
         return this.map.tileAtPoint(_loc1_);
      }
      
      public function updateFogOfWar() : void
      {
         this._fogOfWar.update();
         this.map.recalculateTileVisibilityByFog(this.camera);
      }
      
      public function updateFogOfWarForLocation(param1:int, param2:int) : void
      {
         this._fogOfWar.clearFogAroundLocation(param1,param2);
         this.map.recalculateTileVisibilityByFog(this.camera);
      }
      
      public function toggleFog() : void
      {
         this._fogOfWar.active = this.fogIsActive = !this.fogIsActive;
         this.map.recalculateTileVisibilityByFog(this.camera);
      }
      
      public function setCameraForTutorial(param1:Boolean = false, param2:Number = 0, param3:Number = 0) : void
      {
         this.centerCameraOnVillage(true);
         this.onStartDrag(0,0);
         this.onUpdateDrag(-40 + param2,80 + param3);
      }
      
      public function centerCameraOnVillage(param1:Boolean = false) : void
      {
         if(this._mouseManager.draggable || param1)
         {
            this.map.centerCameraOnVillage(this.camera,0,0);
            this.syncOverlay();
         }
      }
      
      public function centerCameraOnTile(param1:Tile) : void
      {
         this.map.centerCameraOnTile(this.camera,param1);
         this.syncOverlay();
      }
      
      public function reset() : void
      {
         overlayContainerFlash.mouseEnabled = true;
         overlayContainerFlash.mouseChildren = true;
      }
      
      public function testMoveConsecrated() : void
      {
         this.map.terrainGenerator.testMoveConsecrated();
      }
   }
}
