package ninjakiwi.monkeyTown.town.ui.bloontoniumGenerator
{
   import assets.town.BloontoniumStatsClip;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloontoniumGenerator;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.ISimulateClickable;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class BloontoniumStats extends Sprite implements ISimulateClickable
   {
       
      
      private var _bloontoniumGenerator:BloontoniumGenerator;
      
      public var timeLastUpdated:Number = -1;
      
      private var _clip:BloontoniumStatsClip;
      
      private var _collectBox:MovieClip;
      
      private var _upgradeButton:ButtonControllerBase = null;
      
      private var _moveButton:ButtonControllerBase = null;
      
      private var _pulsationTarget:MovieClip;
      
      private var _statsField:TextField;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _stage:Stage;
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      private const _configData:ConfigData = ConfigData.getInstance();
      
      private var _active:Boolean = true;
      
      private var _isFull:Boolean = false;
      
      private var _gameEventManager:GameEventManager;
      
      public var requestUpgradeSignal:Signal;
      
      public const BLOONTONIUM_AT_TIER_1:int = this._configData.bloontoniumGeneratorCapacityTier1;
      
      public const BLOONTONIUM_AT_TIER_2:int = this._configData.bloontoniumGeneratorCapacityTier2;
      
      public const BLOONTONIUM_PER_MINUTE_TIER_1:Number = Number(this._upgradeData.getBuildingUpgradeByBuildingID(this._buildingData.BLOONTONIUM_GENERATOR.id).tier1) / 60;
      
      public const BLOONTONIUM_PER_MINUTE_TIER_2:Number = Number(this._upgradeData.getBuildingUpgradeByBuildingID(this._buildingData.BLOONTONIUM_GENERATOR.id).tier2) / 60;
      
      public function BloontoniumStats(param1:BloontoniumGenerator)
      {
         this._clip = new BloontoniumStatsClip();
         this._collectBox = this._clip.collectBox;
         this._pulsationTarget = this._clip.fieldWrapper;
         this._statsField = this._clip.fieldWrapper.statsField;
         this._gameEventManager = GameEventManager.getInstance();
         this.requestUpgradeSignal = new Signal();
         super();
         this._bloontoniumGenerator = param1;
         this.init();
         MonkeyCityMain.globalResetSignal.add(this.tidy);
      }
      
      public function tidy() : void
      {
         MonkeyCityMain.globalResetSignal.remove(this.tidy);
         this._clip.collectHit.removeEventListener(MouseEvent.CLICK,this.onCollectHitClickedHandler);
         this._clip.collectHit.removeEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler);
         this._clip.removeEventListener(MouseEvent.ROLL_OUT,this.onRolloutHandler);
         this._clip.removeEventListener("burst_complete",this.burstCompleteHandler);
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._statsField.htmlText = "0";
         this.timeLastUpdated = this._system.getSecureTime();
         this._clip.collectHit.addEventListener(MouseEvent.CLICK,this.onCollectHitClickedHandler);
         this._clip.collectHit.addEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRolloutHandler);
         this._upgradeButton = new ButtonControllerBase(this._collectBox.upgradeButton);
         this._upgradeButton.setClickFunction(this.onUpgradeButtonClicked);
         this.hideCollectBox(0);
         this._clip.addEventListener("burst_complete",this.burstCompleteHandler);
         this.setIsFull(false);
         this._moveButton = new ButtonControllerBase(this._collectBox.moveButton);
         this._moveButton.setClickFunction(this.onMoveButtonClicked);
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
      }
      
      private function addPulsation() : void
      {
      }
      
      private function removePulsation() : void
      {
         this._pulsationTarget.filters = [];
      }
      
      public function updatePulsation() : void
      {
         if(this._isFull)
         {
            this.addPulsation();
         }
         else
         {
            this.removePulsation();
         }
      }
      
      private function onMoveButtonClicked() : void
      {
         if(ResourceStore.getInstance().monkeyMoney >= 50)
         {
            this._bloontoniumGenerator.beginMoving();
            this.hideCollectBox();
         }
      }
      
      private function onUpgradeButtonClicked() : void
      {
         this.requestUpgradeSignal.dispatch();
      }
      
      private function onRolloverHandler(param1:MouseEvent) : void
      {
         this.revealCollectBox();
         if(parent && parent.contains(this))
         {
            parent.addChild(this);
         }
         Building.mouseOverBuildingOverlayItem.dispatch(this._bloontoniumGenerator);
      }
      
      private function onRolloutHandler(param1:MouseEvent) : void
      {
         this.hideCollectBox();
      }
      
      private function onCollectHitClickedHandler(param1:MouseEvent) : void
      {
         if(this.retrieveBloontonium())
         {
            this.hideCollectBoxExpand();
         }
         GameSignals.BLOONTONIUM_GENERATOR_CLICKED.dispatch();
      }
      
      private function revealCollectBox(param1:Number = 0.2) : void
      {
         this._collectBox.visible = true;
         this._collectBox.alpha = 1;
         if(this._system.city.buildingManager.getCompletedBuilding(this._buildingData.BLOONTONIUM_STORAGE_TANK.id).length <= 0)
         {
            this._collectBox.collectTxt.text = "Build Tank";
         }
         else
         {
            this._collectBox.collectTxt.text = "Collect";
         }
         TweenLite.killTweensOf(this._collectBox);
         TweenLite.to(this._collectBox,param1,{
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function hideCollectBox(param1:Number = 0.2) : void
      {
         var time:Number = param1;
         TweenLite.killTweensOf(this._collectBox);
         TweenLite.to(this._collectBox,time,{
            "scaleX":0,
            "scaleY":0,
            "onComplete":function():void
            {
               _collectBox.visible = false;
            }
         });
      }
      
      private function hideCollectBoxExpand(param1:Number = 0.2) : void
      {
         var time:Number = param1;
         TweenLite.killTweensOf(this._collectBox);
         TweenLite.to(this._collectBox,time,{
            "scaleX":1.2,
            "scaleY":1.2,
            "alpha":0,
            "onComplete":function():void
            {
               _collectBox.visible = false;
               _collectBox.alpha = 1;
               _collectBox.scaleX = _collectBox.scaleY = 0;
            }
         });
      }
      
      public function simulateClick() : void
      {
         this.retrieveBloontonium();
      }
      
      public function retrieveBloontonium() : Boolean
      {
         var _loc1_:Number = this.bloontonium;
         if(_loc1_ < 1)
         {
            return false;
         }
         var _loc2_:Number = ResourceStore.getInstance().depositBloontoniumWithRemainder(this._bloontoniumGenerator.bloontonium);
         this.bloontonium = _loc2_;
         if(_loc1_ > this.bloontonium)
         {
            this.spawnCollectionAnimation();
            this.update(this._system.getSecureTime());
            this.setIsFull(false);
         }
         if(_loc1_ !== _loc2_)
         {
            Tile.tileChangedSignal.dispatch(this._bloontoniumGenerator.homeTile);
         }
         return true;
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = Number(param1 - this.timeLastUpdated) / 1000;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(!this._active)
         {
            this.timeLastUpdated = param1;
            return;
         }
         this.bloontonium = this.bloontonium + _loc2_ * this.bloontoniumPerSecond * GameMods.getModifier(GameModConstants.BLOONTONIUM_GENERATOR_SPEED_MOD) * this._gameEventManager.bloontoniumRateModifier.modifier;
         this.timeLastUpdated = param1;
         if(this.bloontonium === this.maxBloontonium)
         {
            this.setIsFull(true);
         }
      }
      
      public function get bloontonium() : Number
      {
         return this._bloontoniumGenerator.bloontonium;
      }
      
      public function set bloontonium(param1:Number) : void
      {
         if(param1 > this.maxBloontonium)
         {
            param1 = this.maxBloontonium;
         }
         this._bloontoniumGenerator.bloontonium = param1;
         this._statsField.htmlText = int(param1).toString();
      }
      
      public function get maxBloontonium() : int
      {
         var _loc1_:int = 0;
         switch(this._bloontoniumGenerator.tier)
         {
            case 2:
               _loc1_ = this.BLOONTONIUM_AT_TIER_2;
               break;
            default:
               _loc1_ = this.BLOONTONIUM_AT_TIER_1;
         }
         return _loc1_;
      }
      
      public function get bloontoniumPerSecond() : Number
      {
         var _loc1_:Number = NaN;
         switch(this._bloontoniumGenerator.tier)
         {
            case 2:
               _loc1_ = this.BLOONTONIUM_PER_MINUTE_TIER_2 / 60;
               break;
            default:
               _loc1_ = this.BLOONTONIUM_PER_MINUTE_TIER_1 / 60;
         }
         return _loc1_;
      }
      
      public function deactivate() : void
      {
         this._active = false;
         this._clip.visible = false;
      }
      
      public function activate() : void
      {
         this._active = true;
         this._clip.visible = true;
      }
      
      private function setIsFull(param1:Boolean) : void
      {
         this._clip.StillBloon.visible = !param1;
         this._clip.GlowBloon.visible = param1;
         this._isFull = param1;
         if(param1)
         {
            this.addPulsation();
         }
         else
         {
            this.removePulsation();
         }
      }
      
      private function spawnCollectionAnimation() : void
      {
         this._clip.gotoAndPlay("CoinBurst");
         this._clip.StillBloon.visible = false;
         this._clip.GlowBloon.visible = false;
      }
      
      private function burstCompleteHandler(param1:Event) : void
      {
         this.setIsFull(false);
      }
      
      public function get isFull() : Boolean
      {
         return this._isFull;
      }
   }
}
