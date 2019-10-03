package ninjakiwi.monkeyTown.town.buildings
{
   import assets.flare.DemolishEffectClip;
   import assets.flare.DemolishEffectWithoutXPClip;
   import com.lgrey.signal.SignalHub;
   import fl.motion.AdjustColor;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.utils.clearTimeout;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.PopulationData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.TerrainDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.spam.XPSpam;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.ColorTransformConstants;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.clock.BuildClock;
   import ninjakiwi.monkeyTown.town.ui.clock.DamageClock;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class Building
   {
      
      public static const HOVER:String = "_hover";
      
      public static const FLOATING:String = "_floating";
      
      public static const FLOATING_BAD:String = "_floating_bad";
      
      public static const DEFAULT_ANIMATION:String = "";
      
      public static const buildingWasCompletedSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static const buildingWasCompletedForFirstTimeSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static const buildingWasPlacedSignal:PrioritySignal = new PrioritySignal(Building);
      
      public static const buildingWasDemolishedSignal:Signal = new Signal(Building,Boolean);
      
      public static const buildingWasKilledSignal:Signal = new Signal(Building);
      
      public static const mouseOverBuildingOverlayItem:Signal = new Signal(Building);
      
      public static const FLOATING_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1.1,1.1,1.1,0.9);
      
      public static const FLOATING_BAD_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.5,0.5,0.5,0.75,155);
      
      private static var HOVER_BAD_COLOR_MATRIX_FILTER:ColorMatrixFilter = null;
      
      private static const MINIMUM_DAMAGE_DURATION:Number = 15;
      
      public static var demolishEnabled:Boolean = true;
      
      public static var buildFromTerrainInfoPanelEnabled:Boolean = true;
      
      public static var infoEnabled:Boolean = true;
      
      public static const requestMoveSignal:Signal = new Signal(Building);
       
      
      public var x:int;
      
      public var y:int;
      
      public var definition:MonkeyTownBuildingDefinition;
      
      public var clips:Vector.<BitClipCustom>;
      
      public var groundClips:Vector.<BitClipCustom>;
      
      public var mapCoordinates:IntPoint2D;
      
      public var buildClock:BuildClock = null;
      
      public var damageClock:DamageClock = null;
      
      public var homeTile:Tile;
      
      public var currentState:int = 0;
      
      public var buildingClass:String;
      
      public var timeCreated:Number;
      
      public var playOnComplete:Boolean = true;
      
      public var map:TownMap;
      
      public var buildOrderForType:int = -1;
      
      private var _upgradeData:UpgradeData;
      
      private var tileDefinitions:TileDefinitions;
      
      private var _buildComplete:Boolean = false;
      
      public var isDamaged:Boolean = false;
      
      private var _animationDelayTimeoutID:uint;
      
      protected const _buildingData:BuildingData = BuildingData.getInstance();
      
      protected const _system:MonkeySystem = MonkeySystem.getInstance();
      
      protected const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public const buildCompleteSignal:Signal = new Signal(Building);
      
      private const _populationData:PopulationData = PopulationData.getInstance();
      
      protected var _city:City = null;
      
      private var hubListenersInitialised:Boolean = false;
      
      public function Building(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         this.clips = new Vector.<BitClipCustom>();
         this.groundClips = new Vector.<BitClipCustom>();
         this.mapCoordinates = new IntPoint2D(-1,-1);
         this._upgradeData = UpgradeData.getInstance();
         this.tileDefinitions = TileDefinitions.getInstance();
         super();
         this.definition = param1;
         if(param2 == null)
         {
            this._city = this._system.city;
         }
         else
         {
            this._city = param2;
         }
         this.init();
      }
      
      private function init() : void
      {
         if(HOVER_BAD_COLOR_MATRIX_FILTER == null)
         {
            this.initColorTransforms();
         }
         this.timeCreated = this._system.getSecureTime();
         if(this.definition.buildingCategory == this._buildingData.BASE_BUILDING)
         {
            this.syncGraphicWithUpgradeTree();
            this.initUpgradeHubListeners();
         }
      }
      
      private function initUpgradeHubListeners() : void
      {
         var _loc2_:String = null;
         if(this.hubListenersInitialised)
         {
            return;
         }
         var _loc1_:SignalHub = SignalHub.getHub("maxUpgradeTierHub");
         if(this.definition.upgrades == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.definition.upgrades.length)
         {
            _loc2_ = this.definition.upgrades[_loc3_];
            _loc1_.add(_loc2_,this.onUpgradeBuildingReachedMaxTier);
            _loc3_++;
         }
         this.hubListenersInitialised = true;
      }
      
      private function removeUpgradeHubListeners() : void
      {
         var _loc2_:String = null;
         var _loc1_:SignalHub = SignalHub.getHub("maxUpgradeTierHub");
         _loc1_.removeAllObservers();
      }
      
      public function upgrade() : void
      {
      }
      
      private function onUpgradeBuildingReachedMaxTier(param1:Boolean = false) : void
      {
         this.unloadAssetsForState(this.currentState);
         if(param1)
         {
            this.setGraphicsState(2);
         }
         else
         {
            this.setGraphicsState(1);
         }
      }
      
      public function canBePlacedOnMap(param1:TownMap) : Boolean
      {
         var _loc2_:Tile = null;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:IntPoint2D = new IntPoint2D();
         var _loc5_:Boolean = true;
         var _loc6_:Boolean = true;
         var _loc7_:Vector.<Tile> = new Vector.<Tile>();
         var _loc8_:int = 0;
         while(_loc8_ < this.definition.height)
         {
            _loc9_ = 0;
            while(_loc9_ < this.definition.width)
            {
               _loc4_.set(this.x + _loc9_,this.y + _loc8_);
               _loc2_ = param1.tileAt(_loc4_.x,_loc4_.y);
               if(_loc2_ == null)
               {
                  return false;
               }
               _loc7_.push(_loc2_);
               if(!_loc2_.isCaptured)
               {
                  _loc6_ = false;
               }
               if(_loc2_.building != null)
               {
                  _loc3_ = false;
               }
               _loc5_ = this.isValidTerrainType(_loc2_.terrainDefinition);
               if(!_loc5_)
               {
                  return false;
               }
               _loc9_++;
            }
            _loc8_++;
         }
         if(_loc5_ && this.definition.requiresTerrainProperty != null && this.definition.requiresTerrainProperty.length > 0)
         {
            _loc10_ = false;
            _loc5_ = false;
            _loc12_ = 0;
            while(_loc12_ < _loc7_.length)
            {
               if(_loc7_[_loc12_].terrainSpecialProperty)
               {
                  _loc11_ = _loc7_[_loc12_].terrainSpecialProperty.id;
                  if(_loc11_ != null && this.definition.requiresTerrainProperty == _loc11_)
                  {
                     _loc5_ = true;
                  }
               }
               _loc12_++;
            }
         }
         _loc7_.length = 0;
         return _loc3_ && _loc5_ && _loc6_;
      }
      
      public function isValidTerrainType(param1:TerrainDefinition) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = param1.id;
         _loc3_ = false;
         if(this.definition.requiresTerrain !== null)
         {
            _loc4_ = 0;
            while(_loc4_ < this.definition.requiresTerrain.length)
            {
               if(this.definition.requiresTerrain[_loc4_] == _loc2_)
               {
                  _loc3_ = true;
               }
               if(this.definition.requiresTerrain[_loc4_] === Constants.WATER_EDGE)
               {
                  if(this.isNextToWater())
                  {
                     _loc3_ = true;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < this.definition.disallowTerrain.length)
            {
               if(this.definition.disallowTerrain[_loc4_] == _loc2_)
               {
                  _loc3_ = false;
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      private function isNextToWater() : Boolean
      {
         var _loc1_:Tile = null;
         var _loc2_:Tile = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = this.y;
         while(_loc3_ < this.y + this.definition.height)
         {
            _loc4_ = this.x;
            while(_loc4_ < this.x + this.definition.width)
            {
               _loc1_ = this.map.tileAt(_loc4_,_loc3_,true);
               _loc5_ = 0;
               while(_loc5_ < _loc1_.surroundingTiles.length)
               {
                  _loc2_ = _loc1_.surroundingTiles[_loc5_];
                  if(_loc2_ !== null)
                  {
                     if(_loc2_.type === Constants.TERRAIN_RIVER || _loc2_.type === Constants.TERRAIN_LAKE)
                     {
                        return true;
                     }
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function unfloatFromMap(param1:TownMap) : Building
      {
         var _loc2_:Tile = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.definition.height)
         {
            _loc4_ = 0;
            while(_loc4_ < this.definition.width)
            {
               _loc2_ = param1.tileAt(this.x + _loc4_,this.y + _loc3_,true);
               _loc2_.clearLayersOfType(Tile.ALT_PROPS_LAYER);
               _loc2_.unhover();
               _loc4_++;
            }
            _loc3_++;
         }
         return this;
      }
      
      public function floatOnMap(param1:TownMap) : Building
      {
         var _loc8_:int = 0;
         this.map = param1;
         var _loc2_:Tile = param1.hoveredTile;
         var _loc3_:IntPoint2D = new IntPoint2D(param1.hoveredTile.positionTilespace.x,param1.hoveredTile.positionTilespace.y);
         this.x = _loc3_.x;
         this.y = _loc3_.y;
         var _loc4_:int = 0;
         var _loc5_:Boolean = true;
         var _loc6_:int = this.definition.width * this.definition.height;
         var _loc7_:int = 0;
         while(_loc7_ < this.definition.height)
         {
            _loc8_ = 0;
            while(_loc8_ < this.definition.width)
            {
               _loc2_ = param1.tileAt(_loc3_.x + _loc8_,_loc3_.y + _loc7_,true);
               _loc2_.addLayerClip(Tile.ALT_PROPS_LAYER,this.clips[_loc4_++ + _loc6_ * this.currentState],true);
               _loc8_++;
            }
            _loc7_++;
         }
         if(this.canBePlacedOnMap(param1))
         {
            this.selectAnimationState(FLOATING);
         }
         else
         {
            this.selectAnimationState(FLOATING_BAD);
         }
         return this;
      }
      
      public function placeOnTile(param1:Tile, param2:TownMap, param3:Boolean = true, param4:Boolean = true) : Building
      {
         this.map = param2;
         this.mapCoordinates.set(param1.x / this._system.TOWN_GRID_UNIT_SIZE,param1.y / this._system.TOWN_GRID_UNIT_SIZE);
         this.x = this.mapCoordinates.x;
         this.y = this.mapCoordinates.y;
         this.placeOnMap(param2,param3,param4);
         return this;
      }
      
      public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         var _loc5_:Tile = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:BitClipCustom = null;
         if(param1 == null)
         {
            return this;
         }
         this.map = param1;
         var _loc6_:int = 0;
         this.mapCoordinates.set(this.x,this.y);
         this.homeTile = param1.tileAt(this.x,this.y);
         var _loc7_:int = this.definition.width * this.definition.height;
         var _loc8_:int = 0;
         while(_loc8_ < this.definition.height)
         {
            _loc9_ = 0;
            while(_loc9_ < this.definition.width)
            {
               _loc5_ = param1.tileAt(this.x + _loc9_,this.y + _loc8_);
               _loc5_.clearLayersOfType(Tile.ALT_PROPS_LAYER);
               _loc5_.retainPropsLayers();
               _loc5_.retainGroundLayers();
               _loc5_.clearLayersOfType(Tile.PROPS_LAYER);
               _loc5_.clearLayersOfType(Tile.BUILDING_LAYER);
               if(this.groundClips.length > 0)
               {
                  _loc5_.addLayerClip(Tile.GROUND_LAYER,this.groundClips[_loc6_],true,true);
               }
               _loc10_ = _loc6_ + _loc7_ * this.currentState;
               _loc11_ = this.clips[_loc10_];
               _loc5_.addLayerClip(Tile.BUILDING_LAYER,_loc11_,true,true);
               _loc5_.selectDefaultAnimation();
               _loc5_.building = this;
               _loc5_.isCaptured = true;
               if(param3)
               {
                  param1.fenceBuilder.updateFenceAroundLocation(this.x + _loc9_,this.y + _loc8_);
               }
               if(_loc11_.animationDelayMax > 0)
               {
                  _loc11_.startAnimationDelayBehaviour();
               }
               _loc6_++;
               _loc9_++;
            }
            _loc8_++;
         }
         if(param2)
         {
            this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney - this.definition.monkeyMoneyCost;
         }
         if(!param4)
         {
            this._city.buildingManager.register(this);
            Building.buildingWasPlacedSignal.dispatch(this);
         }
         return this;
      }
      
      private function initColorTransforms() : void
      {
         var _loc1_:AdjustColor = new AdjustColor();
         var _loc2_:Array = [];
         _loc1_.hue = 0;
         _loc1_.saturation = -70;
         _loc1_.brightness = 0;
         _loc1_.contrast = 0;
         _loc2_ = _loc1_.CalculateFinalFlatArray();
         HOVER_BAD_COLOR_MATRIX_FILTER = new ColorMatrixFilter(_loc2_);
      }
      
      public function addClipByClassName(param1:String, param2:Boolean = false, param3:Number = -1) : BitClipCustom
      {
         var _loc4_:BitClipCustom = this.makeClipByClassName(param1,param2,param3);
         this.clips.push(_loc4_);
         return _loc4_;
      }
      
      public function addGroundClipByClassName(param1:String, param2:Boolean = false) : BitClipCustom
      {
         var _loc3_:BitClipCustom = this.makeClipByClassName(param1,param2);
         this.groundClips.push(_loc3_);
         return _loc3_;
      }
      
      private function makeClipByClassName(param1:String, param2:Boolean = false, param3:Number = -1) : BitClipCustom
      {
         var _loc4_:BitClipCustom = new BitClipCustom();
         _loc4_.graphicsClassName = param1;
         _loc4_.addAnimation(param1,param1,1,false,false,true);
         _loc4_.animationDelayMax = param3;
         if(param2 && _loc4_.totalFrames > 1)
         {
            _loc4_.gotoAndPlay(int(Math.random() * _loc4_.totalFrames) + 1);
         }
         return _loc4_;
      }
      
      public function cancelLoopDelayFunctionAndPlay() : void
      {
         clearTimeout(this._animationDelayTimeoutID);
         this.setPlayStateOfAllClips(true);
      }
      
      public function selectAnimationState(param1:String) : Building
      {
         var _loc4_:BitClipCustom = null;
         var _loc2_:ColorTransform = null;
         var _loc3_:Array = [];
         switch(param1)
         {
            case HOVER:
               _loc2_ = ColorTransformConstants.HOVER_COLOR_TRANSFORM;
               break;
            case FLOATING:
               _loc2_ = FLOATING_COLOR_TRANSFORM;
               break;
            case FLOATING_BAD:
               _loc2_ = FLOATING_BAD_COLOR_TRANSFORM;
               _loc3_ = [HOVER_BAD_COLOR_MATRIX_FILTER];
               break;
            case DEFAULT_ANIMATION:
            default:
               _loc2_ = null;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.clips.length)
         {
            _loc4_ = this.clips[_loc5_];
            _loc4_.colorTransform = _loc2_;
            _loc4_.filters = _loc3_;
            _loc5_++;
         }
         return this;
      }
      
      public function setPosition(param1:int, param2:int) : Building
      {
         this.x = param1;
         this.y = param2;
         return this;
      }
      
      public function setPositionIntPoint2D(param1:IntPoint2D) : Building
      {
         this.x = param1.x;
         this.y = param1.y;
         return this;
      }
      
      public function setPlayStateOfAllClips(param1:Boolean, param2:int = -1, param3:Boolean = false) : Building
      {
         var _loc4_:BitClipCustom = null;
         var _loc5_:int = 0;
         while(_loc5_ < this.clips.length)
         {
            _loc4_ = this.clips[_loc5_];
            if(param1)
            {
               if(param2 > 0)
               {
                  _loc4_.gotoAndPlay(param2);
               }
               else if(param3)
               {
                  _loc4_.gotoAndPlay(Math.ceil(Math.random() * _loc4_.totalFrames));
               }
               else
               {
                  _loc4_.play();
               }
            }
            else if(param2 > 0)
            {
               _loc4_.gotoAndStop(param2);
            }
            else if(param3)
            {
               _loc4_.gotoAndStop(Math.ceil(Math.random() * _loc4_.totalFrames));
            }
            else
            {
               _loc4_.stop();
            }
            _loc5_++;
         }
         return this;
      }
      
      public function initialiseBuildClock() : void
      {
         this.setPlayStateOfAllClips(false);
         if(this.definition.nkCoinCost > 0)
         {
            this.onBuildComplete(0,false);
         }
         else
         {
            this.buildClock = new BuildClock(this._city.buildClockManager,this.onBuildComplete,this,this.definition.timeToBuild);
         }
      }
      
      public function initialiseDamageClock() : void
      {
         var _loc1_:Number = this.definition.timeToBuild;
         if(_loc1_ < MINIMUM_DAMAGE_DURATION)
         {
            _loc1_ = MINIMUM_DAMAGE_DURATION;
         }
         this.damageClock = new DamageClock(this._city.damageClockManager,this.onRepairComplete,this,_loc1_);
         this.isDamaged = true;
      }
      
      public function skipBuildClock() : void
      {
         if(this.buildClock)
         {
            this._city.buildClockManager.killClock(this.buildClock);
         }
         this.onBuildComplete(0,false);
      }
      
      public function completeBuilding() : void
      {
         if(this.buildClock)
         {
            this._city.buildClockManager.killClock(this.buildClock);
         }
         this.onBuildComplete(0);
      }
      
      public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         this._buildComplete = true;
         this.buildClock = null;
         if(this.playOnComplete === false)
         {
         }
         if(this.playOnComplete)
         {
            this.setPlayStateOfAllClips(true);
         }
         else
         {
            this.setPlayStateOfAllClips(false);
         }
         if(param2)
         {
            if(this.definition.xpGivenForBuilding != 0)
            {
               GameMods.awardXP(this.definition.xpGivenForBuilding);
               this.spawnXPSpam(this.definition.xpGivenForBuilding);
            }
            buildingWasCompletedForFirstTimeSignal.dispatch(this);
         }
         buildingWasCompletedSignal.dispatch(this);
         this.buildCompleteSignal.dispatch(this);
         if(this.homeTile != null)
         {
            this.homeTile.addFacadeAnimation("assets.animations.BuildCompletePuff",true);
         }
      }
      
      public function onClick() : void
      {
      }
      
      public function tidy() : void
      {
         this.removeUpgradeHubListeners();
         this.buildClock = null;
         this.damageClock = null;
         this.homeTile = null;
         clearTimeout(this._animationDelayTimeoutID);
      }
      
      public function die() : void
      {
         this._city.buildingManager.deregister(this);
         buildingWasKilledSignal.dispatch(this);
         this.tidy();
      }
      
      public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:BuildingSaveDefinition = new BuildingSaveDefinition();
         this.populateSaveDefinition(_loc1_);
         return _loc1_;
      }
      
      protected function populateSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         param1.id = this.definition.id;
         param1.mapCoordinates = this.mapCoordinates;
         param1.buildComplete = this.buildComplete;
         if(this.buildClock !== null)
         {
            param1.clockSaveDefinition = this.buildClock.getSaveDefinition();
         }
         if(this.damageClock !== null)
         {
            param1.damageClockSaveDefinition = this.damageClock.getSaveDefinition();
         }
         param1.timeCreated = this.timeCreated;
      }
      
      public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         this.x = param1.mapCoordinates.x;
         this.y = param1.mapCoordinates.y;
         this.timeCreated = param1.timeCreated;
         this.mapCoordinates.set(param1.mapCoordinates.x,param1.mapCoordinates.y);
         this._buildComplete = param1.buildComplete;
         if(!this._buildComplete)
         {
            if(param1.clockSaveDefinition)
            {
               this.initialiseBuildClock();
               this.buildClock.populateFromSaveDefinition(param1.clockSaveDefinition);
            }
         }
         else
         {
            this.onBuildComplete(0,false);
         }
         if(param1.damageClockSaveDefinition)
         {
            this.initialiseDamageClock();
            this.damageClock.populateFromSaveDefinition(param1.damageClockSaveDefinition);
         }
         if(!this.buildComplete && !param1.clockSaveDefinition)
         {
            this.initialiseBuildClock();
            this.buildClock.totalSeconds = 0;
         }
         if(!this.buildComplete && !param1.clockSaveDefinition)
         {
            this.initialiseBuildClock();
            this.buildClock.totalSeconds = 0;
         }
      }
      
      public function getInformation() : String
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc1_:String = "";
         var _loc2_:int = this._city.buildingManager.getBuildingCount(this.definition.id);
         var _loc3_:String = _loc2_ > 1?"s":"";
         _loc1_ = _loc1_ + ("Power Used: " + this.definition.powerUsed + "<br/>");
         if(this.definition.populationType != "" && this._buildComplete && !this is UpgradeableBuilding)
         {
            _loc5_ = this._city.buildingManager.getCompletedBuildingCount(this.definition.id);
            _loc1_ = _loc1_ + ("" + _loc5_.complete + " " + this._populationData.getDefinitionByID(this.definition.populationType).name + _loc3_ + " available<br/>");
            if(_loc5_.incomplete > 0)
            {
               _loc1_ = _loc1_ + (_loc5_.incomplete + " under construction<br/>");
            }
         }
         return _loc1_;
      }
      
      public function setHover(param1:Boolean, param2:TownMap) : void
      {
         var _loc3_:Tile = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.definition.height)
         {
            _loc5_ = 0;
            while(_loc5_ < this.definition.width)
            {
               _loc3_ = param2.tileAt(this.x + _loc5_,this.y + _loc4_);
               if(param1)
               {
                  _loc3_.hover();
                  if(this._buildComplete)
                  {
                     this.cancelLoopDelayFunctionAndPlay();
                  }
               }
               else
               {
                  _loc3_.unhover();
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function syncGraphicWithUpgradeTree() : void
      {
         var _loc1_:int = this._city.upgradeTree.getBuildingUpgradeIndex(this.definition.upgrades);
         this.setGraphicsState(_loc1_);
      }
      
      public function setGraphicByMaxUpgradeTechLevel() : void
      {
         if(this.definition.id === "MonkeyDartHall")
         {
         }
         this.unloadAssetsForState(this.currentState);
         var _loc1_:int = this._city.upgradeTree.getHighestTierLevelForUpgrades(this.definition.upgrades);
         if(_loc1_ == UpgradeTree.MAX_TIERS)
         {
            this.setGraphicsState(1);
         }
      }
      
      public function setGraphicsState(param1:int) : void
      {
         var _loc3_:BitClipCustom = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(this.currentState === param1)
         {
            return;
         }
         var _loc2_:int = this.definition.width * this.definition.height;
         if(this.definition.graphicsClasses.length <= _loc2_ * param1)
         {
            return;
         }
         var _loc5_:int = param1 * _loc2_;
         if(this.clips.length >= _loc5_ + _loc2_)
         {
            _loc6_ = _loc5_;
            while(_loc6_ < _loc5_ + _loc2_)
            {
               _loc3_ = this.clips[_loc6_];
               _loc4_ = "assets.tiles." + this.definition.graphicsClasses[_loc6_];
               _loc3_.addAnimation(_loc4_,null,1,false,false,true);
               _loc6_++;
            }
         }
         this.currentState = param1;
         this.redrawGraphicsState();
      }
      
      public function redrawGraphicsState() : void
      {
         this.placeOnMap(this.map,false,false,true);
      }
      
      public function unloadAssetsForState(param1:int) : void
      {
      }
      
      public function demolish(param1:Boolean = true, param2:Boolean = true) : void
      {
         Building.buildingWasDemolishedSignal.dispatch(this,param1);
         Tile.tileChangedSignal.dispatch(this.homeTile);
         this.setHover(false,this.map);
         this.clearLandBeneathFootprint();
         if(param2)
         {
            this.demolishRefund();
         }
         if(param1)
         {
            this.createDemolishEffect();
         }
         else
         {
            this.createDemolishEffectWithoutXP();
         }
         this._city.damageClockManager.killClock(this.damageClock);
         this.isDamaged = false;
         this.damageClock = null;
         this.die();
      }
      
      private function createDemolishEffect() : void
      {
         var _loc1_:DemolishEffectClip = new DemolishEffectClip();
         _loc1_.x = this.homeTile.x;
         _loc1_.y = this.homeTile.y;
         _loc1_.x = _loc1_.x + (this.definition.width - 1) * 32;
         _loc1_.y = _loc1_.y + (this.definition.height - 1) * 32;
         _loc1_.gotoAndPlay(1);
         WorldView.addOverlayItem(_loc1_);
      }
      
      private function createDemolishEffectWithoutXP() : void
      {
         var _loc1_:DemolishEffectWithoutXPClip = new DemolishEffectWithoutXPClip();
         _loc1_.x = this.homeTile.x;
         _loc1_.y = this.homeTile.y;
         _loc1_.x = _loc1_.x + (this.definition.width - 1) * 32;
         _loc1_.y = _loc1_.y + (this.definition.height - 1) * 32;
         _loc1_.gotoAndPlay(1);
         WorldView.addOverlayItem(_loc1_);
      }
      
      protected function demolishRefund() : void
      {
         this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney + int(this.definition.monkeyMoneyCost * Constants.DEMOLISH_REFUND);
      }
      
      public function getTotalXPEarned() : int
      {
         return this.definition.xpGivenForBuilding;
      }
      
      public function spawnXPSpam(param1:int) : void
      {
         var _loc2_:XPSpam = new XPSpam(param1,this.mapCoordinates.x * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_GRID_UNIT_SIZE * 0.5,this.mapCoordinates.y * this._system.TOWN_GRID_UNIT_SIZE + this._system.TOWN_GRID_UNIT_SIZE * 0.5);
      }
      
      public function clearLandBeneathFootprint() : void
      {
         var _loc1_:Tile = null;
         var _loc4_:int = 0;
         var _loc2_:IntPoint2D = new IntPoint2D();
         var _loc3_:int = 0;
         while(_loc3_ < this.definition.height)
         {
            _loc4_ = 0;
            while(_loc4_ < this.definition.width)
            {
               _loc2_.set(this.x + _loc4_,this.y + _loc3_);
               _loc1_ = this.map.tileAt(_loc2_.x,_loc2_.y);
               _loc1_.restoreToVirginState();
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function damage() : void
      {
         var _loc1_:Number = this.definition.timeToBuild;
         if(_loc1_ < MINIMUM_DAMAGE_DURATION)
         {
            _loc1_ = MINIMUM_DAMAGE_DURATION;
         }
         this.damageClock = new DamageClock(this._city.damageClockManager,this.onRepairComplete,this,_loc1_);
         this.isDamaged = true;
         Tile.tileChangedSignal.dispatch(this.homeTile);
      }
      
      public function onRepairComplete(param1:Number = 0) : void
      {
         this.isDamaged = false;
         this.damageClock = null;
         Tile.tileChangedSignal.dispatch(this.homeTile);
      }
      
      public function isInsideInitialVillage() : Boolean
      {
         if(!demolishEnabled)
         {
            return true;
         }
         return TownMap.isPointInsideInitialVillage(this.x,this.y);
      }
      
      public function get buildComplete() : Boolean
      {
         return this._buildComplete;
      }
      
      public function isDemolishable() : Boolean
      {
         if(this.definition.buildingCategory == this._buildingData.SPECIAL_BUILDING || this.definition.buildingCategory == this._buildingData.UPGRADE_BUILDING)
         {
            return false;
         }
         if(this.definition.buildingCategory == this._buildingData.PVP_BUILDING && this.definition.id != this._buildingData.BLOONTONIUM_STORAGE_TANK.id && this.definition.id != this._buildingData.BLOONTONIUM_GENERATOR.id)
         {
            return false;
         }
         return true;
      }
      
      public function beginMoving() : void
      {
         Building.requestMoveSignal.dispatch(this);
      }
      
      public function finishMoving() : void
      {
      }
      
      public function hasActiveClock() : Boolean
      {
         return this.buildClock !== null || this.damageClock !== null;
      }
   }
}
