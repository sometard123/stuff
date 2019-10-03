package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import assets.ui.SupplyDropRequestSentPanelClip;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.net.JSONRequest;
   import org.osflash.signals.Signal;
   
   public class BloonBeaconSystem
   {
      
      private static const KNOWLEDGE_PACKS_PER_BEACON_REWARD:int = 1;
      
      private static const BEACON_RESPAWN_TIME:Number = 1000 * 60 * 60 * 6;
      
      private static var instance:BloonBeaconSystem;
       
      
      public var beaconSystemReadySignal:Signal;
      
      public var onBeaconSpawned:Signal;
      
      public var onBeaconCapturedSignal:Signal;
      
      public var onBeaconRecharged:Signal;
      
      public var data:BloonBeaconData = null;
      
      public var tilePicker:BloonBeaconTilePicker = null;
      
      public var spawner:BloonBeaconRespawner = null;
      
      public var beaconSquare:BloonBeaconSquare = null;
      
      public var ui:BloonBeaconUI = null;
      
      public var eventManager:BloonBeaconEventManager;
      
      private var _isReady:Boolean = false;
      
      private var _isEventActive:Boolean = false;
      
      private var _isInitialised:Boolean = false;
      
      private var _isSkuSettingsDataLoaded:Boolean = false;
      
      private var _isPersistentDataLoaded:Boolean = false;
      
      private const _isInitialisedSignal:Signal = new Signal();
      
      public function BloonBeaconSystem(param1:SingletonEnforcer#1575)
      {
         this.beaconSystemReadySignal = new Signal();
         this.onBeaconSpawned = new Signal(Tile);
         this.onBeaconCapturedSignal = new Signal(Tile,Number);
         this.onBeaconRecharged = new Signal(Tile);
         this.eventManager = new BloonBeaconEventManager();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use BloonBeaconSystem.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BloonBeaconSystem
      {
         if(instance == null)
         {
            instance = new BloonBeaconSystem(new SingletonEnforcer#1575());
            if(MonkeySystem.getInstance().serverTimeHasBeenInitialised)
            {
               instance.init();
            }
            else
            {
               MonkeySystem.getInstance().serverTimeHasBeenInitialisedSignal.addOnce(instance.init);
            }
         }
         return instance;
      }
      
      public function init() : void
      {
         if(this._isInitialised)
         {
            return;
         }
         this.data = new BloonBeaconData();
         this.tilePicker = new BloonBeaconTilePicker();
         this.spawner = new BloonBeaconRespawner(getInstance());
         this.beaconSquare = new BloonBeaconSquare();
         this.data.readySignal.addOnce(this.onSkuSettingsDataReady);
         GameSignals.CITY_IS_FINALLY_READY.addOnce(this.onCityLoaded);
         GameSignals.TILE_CAPTURED_SIGNAL.add(this.onTileCaptured);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         GameSignals.LOAD_CITY_BEGIN.add(this.onReset);
         this._isInitialisedSignal.dispatch();
         this._isInitialised = true;
         this.initUI();
         GameSignals.CITY_IS_FINALLY_READY.add(this.setUpBeacon);
      }
      
      private function onCityLoaded(... rest) : void
      {
         var arguments:Array = rest;
         setTimeout(function():void
         {
            BloonBeaconSystem.getInstance().ui.bloonBeaconTutorialPanel.revealIfNeverSeen();
         },2000);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChanged);
      }
      
      public function initUI() : void
      {
         this.ui = new BloonBeaconUI();
      }
      
      private function onReset() : void
      {
         this.spawner.reset();
         this._isReady = false;
         this.beaconSquare.reset();
      }
      
      private function onSkuSettingsDataReady() : void
      {
         this._isSkuSettingsDataLoaded = true;
      }
      
      private function setUpBeacon() : void
      {
         SkuSettingsLoader.getGameEventDataByID("bloonBeacon","defaultData",function(param1:Object):void
         {
            if(ResourceStore.getInstance().townLevel < BloonBeaconEventManager.UNLOCK_LEVEL || false === param1.active)
            {
               return;
            }
            if(eventManager.beaconIsActive)
            {
               if(eventManager.beaconPosition !== null)
               {
                  spawnBeaconAtLocation(new Point(eventManager.beaconPosition.x,eventManager.beaconPosition.y));
               }
               else
               {
                  spawnNewBeacon();
               }
            }
            else
            {
               spawner.countDownToRespawn(eventManager.beaconLastCaptureTime);
            }
            _isReady = true;
            beaconSystemReadySignal.dispatch();
         });
      }
      
      private function onTownLevelChanged(... rest) : void
      {
         if(this._isReady || ResourceStore.getInstance().townLevel < BloonBeaconEventManager.UNLOCK_LEVEL)
         {
            return;
         }
         if(ResourceStore.getInstance().townLevel == 2)
         {
            BloonBeaconSystem.getInstance().ui.bloonBeaconTutorialPanel.revealIfNeverSeen();
         }
         if(ResourceStore.getInstance().townLevel == BloonBeaconEventManager.UNLOCK_LEVEL)
         {
            this.setUpBeacon();
            BloonBeaconSystem.getInstance().ui.bloonBeaconTutorialPanel.revealIfNeverSeen();
         }
      }
      
      public function placeBeaconOnRandomTile() : void
      {
         var _loc1_:MonkeySystem = null;
         _loc1_ = MonkeySystem.getInstance();
         this.removeBeaconFromTile();
         var _loc2_:Tile = _loc1_.map.tileAt(Math.floor((Math.random() / 3 + 0.6666666666) * _loc1_.TOWN_MAP_WIDTH_GRIDSPACE),Math.floor(Math.random() / 3 * _loc1_.TOWN_MAP_HEIGHT_GRIDSPACE));
         this.attachBeaconToTile(_loc2_);
         this.eventManager.beaconIsActive = true;
         this.eventManager.beaconPosition = new Point(_loc2_.positionTilespace.x,_loc2_.positionTilespace.y);
      }
      
      public function spawnNewBeacon() : void
      {
         var _loc1_:Tile = this.tilePicker.pickTile();
         this.attachBeaconToTile(_loc1_);
         this.eventManager.beaconIsActive = true;
         this.eventManager.beaconPosition = new Point(_loc1_.positionTilespace.x,_loc1_.positionTilespace.y);
      }
      
      public function spawnBeaconAtLocation(param1:Point) : void
      {
         var _loc2_:Tile = MonkeySystem.getInstance().map.tileAt(param1.x,param1.y);
         if(false === this.tileIsStillValid(_loc2_))
         {
            this.spawnNewBeacon();
            return;
         }
         this.attachBeaconToTile(_loc2_);
      }
      
      public function tileIsStillValid(param1:Tile) : Boolean
      {
         return !param1.isUnderPvPAttack && !param1.hasTreasureChest && SpecialMissionsManager.getInstance().findSpecialMission(param1) == null && !TileDefinitions.getInstance().isVolcano(param1) && !TileDefinitions.getInstance().isCave(param1) && MonkeySystem.getInstance().map.hasAdjacentConqueredTile(param1.positionTilespace.x,param1.positionTilespace.y);
      }
      
      public function attachBeaconToTile(param1:Tile) : void
      {
         this.beaconSquare.reset();
         this.beaconSquare.setAttachedTile(param1);
         this.beaconSquare.setActive(true);
         WorldView.addOverlayItem(this.beaconSquare);
         this.onBeaconSpawned.dispatch(param1);
      }
      
      public function removeBeaconFromTile() : void
      {
         this.beaconSquare.reset();
         WorldView.removeOverlayItem(this.beaconSquare);
         this.eventManager.beaconIsActive = false;
         this.eventManager.beaconPosition = null;
      }
      
      public function doesTileHaveBeacon(param1:Tile) : Boolean
      {
         if(null == this.beaconSquare.attachedTile)
         {
            return false;
         }
         if(param1 == this.beaconSquare.attachedTile)
         {
            return true;
         }
         return false;
      }
      
      public function onTileCaptured(param1:Tile, param2:TownMap, param3:TileAttackDefinition, param4:Boolean) : void
      {
         if(false == this.doesTileHaveBeacon(param1))
         {
            return;
         }
         this.beaconWasCaptured(param1);
      }
      
      private function beaconWasCaptured(param1:Tile) : void
      {
         this.removeBeaconFromTile();
         this.eventManager.beaconLastCaptureTime = MonkeySystem.getInstance().getSecureTime();
         this.onBeaconCapturedSignal.dispatch(param1,MonkeySystem.getInstance().getSecureTime());
         this.applyRewards();
      }
      
      public function applyRewards() : void
      {
         MonkeyKnowledge.getInstance().unopenedPacks = MonkeyKnowledge.getInstance().unopenedPacks + KNOWLEDGE_PACKS_PER_BEACON_REWARD;
      }
      
      public function viewBeaconOnMap() : void
      {
         if(this.beaconSquare == null || this.beaconSquare.attachedTile == null)
         {
            return;
         }
         MCSound.getInstance().playSound(MCSound.BEACON_CLICK);
         MonkeyCityMain.getInstance().worldView.centerCameraOnTile(this.beaconSquare.attachedTile);
         var _loc1_:BeaconFlashAnimationClip = new BeaconFlashAnimationClip();
         _loc1_.x = this.beaconSquare.x + MonkeySystem.getInstance().TOWN_GRID_UNIT_SIZE * 0.5;
         _loc1_.y = this.beaconSquare.y + MonkeySystem.getInstance().TOWN_GRID_UNIT_SIZE * 0.5 + 1;
         WorldView.addOverlayItem(_loc1_);
      }
      
      public function getModifiedRespawnTime() : Number
      {
         var _loc1_:Number = BEACON_RESPAWN_TIME * GameEventManager.getInstance().beaconModifiers.rechargeTimeModifier * GameEventManager.getInstance().beaconRechargeTimeModifier.modifier;
         return _loc1_;
      }
      
      public function getMaxSpawnTimeModifier() : Number
      {
         var _loc1_:Number = this.getModifiedRespawnTime() / BEACON_RESPAWN_TIME;
         return _loc1_;
      }
      
      public function isTileBeaconSquare(param1:Tile) : Boolean
      {
         if(this.beaconSquare !== null && this.beaconSquare.attachedTile !== null)
         {
            return param1 === this.beaconSquare.attachedTile;
         }
         return false;
      }
      
      public function get isInitialisedSignal() : Signal
      {
         return this._isInitialisedSignal;
      }
      
      public function get isInitialised() : Boolean
      {
         return this._isInitialised;
      }
      
      public function get isEventActive() : Boolean
      {
         return this._isEventActive;
      }
      
      public function get isBeaconActive() : Boolean
      {
         if(ResourceStore.getInstance().townLevel < BloonBeaconEventManager.UNLOCK_LEVEL)
         {
            return false;
         }
         return this.eventManager.beaconIsActive;
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
   }
}

class SingletonEnforcer#1575
{
    
   
   function SingletonEnforcer#1575()
   {
      super();
   }
}
