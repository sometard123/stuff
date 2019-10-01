package ninjakiwi.monkeyTown.town.ui.bananaFarm
{
   import assets.town.BananaFarmStatsClip;
   import assets.ui.CashCollectBox;
   import com.greensock.TweenLite;
   import com.lgrey.vectors.LGVector2D;
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
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BananaFarmBuilding;
   import ninjakiwi.monkeyTown.town.data.BananaFarmData;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemBananaReplicator;
   import ninjakiwi.monkeyTown.town.ui.ISimulateClickable;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class BananaFarmStats extends Sprite implements ISimulateClickable
   {
      
      public static const BANANA_FARM_INIT:Signal = new Signal(BananaFarmStats);
       
      
      public var timeLastUpdated:Number = -1;
      
      public var requestUpgradeSignal:Signal;
      
      private var _stage:Stage;
      
      private var _active:Boolean = true;
      
      private var _farm:BananaFarmBuilding;
      
      private var _clip:BananaFarmStatsClip;
      
      private var _collectBox:CashCollectBox;
      
      private var _statsField:TextField;
      
      private var _upgradeButton:ButtonControllerBase = null;
      
      private var _moveButton:ButtonControllerBase = null;
      
      private var _previousMoney:Number = 0;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private const _configData:ConfigData = ConfigData.getInstance();
      
      private const _gameEventManger:GameEventManager = GameEventManager.getInstance();
      
      private var _isFull:Boolean = false;
      
      private var _expandMoney:int = 0;
      
      public function BananaFarmStats(param1:BananaFarmBuilding)
      {
         this.requestUpgradeSignal = new Signal();
         this._clip = new BananaFarmStatsClip();
         this._collectBox = this._clip.collectBox;
         super();
         this._farm = param1;
         this.init();
         MonkeyCityMain.globalResetSignal.add(this.tidy);
      }
      
      public function tidy() : void
      {
         ResourceStore.getInstance().banksAreFullSignal.remove(this.displayBanksFullAnimation);
         MonkeyCityMain.globalResetSignal.remove(this.tidy);
         this._clip.removeEventListener("burst_complete",this.burstCompleteHandler);
         this._clip.collectHit.removeEventListener(MouseEvent.CLICK,this.onCollectHitClickedHandler);
         this._clip.collectHit.removeEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler);
         this._clip.removeEventListener(MouseEvent.ROLL_OUT,this.onRolloutHandler);
      }
      
      private function init() : void
      {
         BANANA_FARM_INIT.dispatch(this);
         addChild(this._clip);
         this._clip.gotoAndStop(1);
         this._statsField = this._clip.statsField;
         this._statsField.htmlText = "0";
         this.timeLastUpdated = this._system.getSecureTime();
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,true);
         }
         ResourceStore.getInstance().banksAreFullSignal.add(this.displayBanksFullAnimation);
         this._clip.addEventListener("burst_complete",this.burstCompleteHandler);
         this._clip.stillCoin.visible = true;
         this._clip.spinningCoin.visible = false;
         this._clip.collectHit.addEventListener(MouseEvent.CLICK,this.onCollectHitClickedHandler);
         this._clip.collectHit.addEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRolloutHandler);
         this._upgradeButton = new ButtonControllerBase(this._collectBox.upgradeButton);
         this._upgradeButton.setClickFunction(this.onUpgradeButtonClicked);
         this._moveButton = new ButtonControllerBase(this._collectBox.moveButton);
         this._moveButton.setClickFunction(this.onMoveButtonClicked);
         this.hideCollectBox(0);
      }
      
      private function onUpgradeButtonClicked() : void
      {
         this.requestUpgradeSignal.dispatch();
      }
      
      private function onMoveButtonClicked() : void
      {
         if(ResourceStore.getInstance().monkeyMoney >= 50)
         {
            this._farm.beginMoving();
            this.hideCollectBox();
         }
      }
      
      private function onRolloverHandler(param1:MouseEvent) : void
      {
         if(!Building.infoEnabled)
         {
            return;
         }
         this.revealCollectBox();
         Building.mouseOverBuildingOverlayItem.dispatch(this._farm);
      }
      
      private function onRolloutHandler(param1:MouseEvent) : void
      {
         this.hideCollectBox();
      }
      
      private function revealCollectBox(param1:Number = 0.2) : void
      {
         this._collectBox.visible = true;
         this._collectBox.alpha = 1;
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
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
      }
      
      private function onCollectHitClickedHandler(param1:MouseEvent) : void
      {
         if(this.retrieveMoney())
         {
            this.hideCollectBoxExpand();
         }
      }
      
      public function simulateClick() : void
      {
         this.retrieveMoney();
      }
      
      public function retrieveMoney() : Boolean
      {
         var _loc1_:LGVector2D = new LGVector2D(this.x,this.y);
         var _loc2_:Number = this.money;
         if(_loc2_ < 1)
         {
            return false;
         }
         var _loc3_:Number = ResourceStore.getInstance().depositMoneyWithRemainder(this._farm.monkeyMoney);
         this.money = _loc3_;
         if(int(_loc2_) > int(this.money))
         {
            BananaFarmSignals.moneyCollected.dispatch(_loc1_,int(_loc2_ - _loc3_));
            this.setIsFull(false);
            this.spawnCollectionAnimation(_loc2_);
            this.update(this._system.getSecureTime());
         }
         if(int(_loc2_) !== int(_loc3_))
         {
            Tile.tileChangedSignal.dispatch(this._farm.homeTile);
         }
         return true;
      }
      
      private function displayBanksFullAnimation() : void
      {
         GameSignals.BANKS_FULL_ANIMATION.dispatch(this._farm.x,this._farm.y);
      }
      
      public function setIsFull(param1:Boolean) : void
      {
         this._clip.stillCoin.visible = !param1;
         this._clip.spinningCoin.visible = param1;
         this._isFull = param1;
      }
      
      private function spawnCollectionAnimation(param1:int) : void
      {
         this._clip.gotoAndPlay("CoinBurst");
         this._clip.stillCoin.visible = false;
         this._clip.spinningCoin.visible = false;
      }
      
      private function burstCompleteHandler(param1:Event) : void
      {
         this.setIsFull(false);
      }
      
      public function catchUpEarningsAfterUpgrade(param1:int) : void
      {
         var _loc2_:Number = this._system.getSecureTime();
         var _loc3_:Number = Number(_loc2_ - this.timeLastUpdated) / 1000;
         var _loc4_:Number = param1 / 1000;
         var _loc5_:Number = _loc3_ - _loc4_;
         var _loc6_:int = this._farm.tier - 1;
         var _loc7_:Number = _loc3_ * this.getMoneyPerSecond(_loc6_);
         _loc7_ = _loc7_ + _loc4_ * this.getMoneyPerSecond(this._farm.tier);
         this.money = this.money + _loc7_;
         this.timeLastUpdated = _loc2_;
      }
      
      private function selectGraphicsState() : void
      {
         var _loc1_:int = BananaFarmData.getCapacityForTier(this._farm.tier);
         var _loc2_:int = _loc1_ / 3;
         var _loc3_:int = Math.floor(this._farm.monkeyMoney / _loc2_) + 1;
         this._farm.setPlayStateOfAllClips(false,_loc3_);
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
            return;
         }
         this.money = this.money + _loc2_ * this.getMoneyPerSecond(this._farm.tier) * GameMods.getModifier(GameModConstants.FARM_SPEED_MOD) * this._gameEventManger.bananaFarmRateModifer.modifier;
         this.selectGraphicsState();
         this._previousMoney = this.money;
         this.timeLastUpdated = param1;
         if(this._farm.monkeyMoney === this.maxMoney)
         {
            this.setIsFull(true);
         }
      }
      
      public function get money() : Number
      {
         return this._farm.monkeyMoney;
      }
      
      public function set money(param1:Number) : void
      {
         if(param1 > this.maxMoney)
         {
            param1 = this.maxMoney;
         }
         this._farm.monkeyMoney = param1;
         this._statsField.text = int(param1).toString();
      }
      
      public function expandMaxMoney(param1:int) : void
      {
         this._expandMoney = param1;
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
         this.timeLastUpdated = this._system.getSecureTime();
      }
      
      public function get maxMoney() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = SpecialItemBananaReplicator.HAS_REPLICATOR;
         var _loc3_:* = this._farm.buildOrderForType == 0;
         var _loc4_:int = _loc3_ && _loc2_?int(SpecialItemBananaReplicator.BONUS_CAPACITY):0;
         _loc1_ = BananaFarmData.getCapacityForTier(this._farm.tier);
         return _loc1_ + _loc4_;
      }
      
      public function getMoneyPerSecond(param1:int) : Number
      {
         return BananaFarmData.getCashPerSecond(param1);
      }
      
      public function get building() : BananaFarmBuilding
      {
         return this._farm;
      }
      
      public function get isFull() : Boolean
      {
         return this._isFull;
      }
   }
}
