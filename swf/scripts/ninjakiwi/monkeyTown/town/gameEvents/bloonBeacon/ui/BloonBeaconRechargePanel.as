package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui
{
   import assets.ui.BloonBeaconRechargePanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.NotEnoughBloonstonesPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class BloonBeaconRechargePanel extends HideRevealViewPopup
   {
      
      protected static const BLOONSTONE_COST_RECHARGE_MAX_BASE:int = 50;
       
      
      protected var _clip:MovieClip;
      
      protected var _rechargeButton:ButtonControllerBase;
      
      protected var _cancelButton:ButtonControllerBase;
      
      protected var _closeButton:ButtonControllerBase;
      
      protected var _costDescriptionText:TextField;
      
      protected var _costButtonText:TextField;
      
      protected var _notEnoughBloonstonesPanel:NotEnoughBloonstonesPanel = null;
      
      protected var _countdownTimer:CountdownTimer;
      
      private var _checkForChargedTimer:Timer;
      
      public var onCancelSignal:Signal;
      
      public function BloonBeaconRechargePanel(param1:DisplayObjectContainer, param2:* = null, param3:Boolean = true)
      {
         this._checkForChargedTimer = new Timer(500);
         this.onCancelSignal = new Signal();
         super(param1,param2);
         if(param3)
         {
            this._clip = new BloonBeaconRechargePanelClip() as MovieClip;
            this.init(param1);
         }
      }
      
      protected function init(param1:DisplayObjectContainer) : void
      {
         addChild(this._clip);
         this._rechargeButton = new ButtonControllerBase(this._clip.rechargeButton);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._costDescriptionText = this._clip.bloonStones_txt_desc;
         this._costButtonText = this._clip.rechargeButton.bloonStones_txt;
         this._countdownTimer = new CountdownTimer(this._clip.timer.timerField,0);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._rechargeButton.setClickFunction(this.onRecharge);
         this._closeButton.setClickFunction(this.onCancelClick);
         this._cancelButton.setClickFunction(this.onCancelClick);
         this._notEnoughBloonstonesPanel = new NotEnoughBloonstonesPanel(param1);
      }
      
      protected function onCancelClick() : void
      {
         this.hide();
         this.onCancelSignal.dispatch();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         var _loc2_:Number = BloonBeaconSystem.getInstance().eventManager.beaconLastCaptureTime + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         this._countdownTimer.setEndTime(_loc2_);
         this._countdownTimer.start();
         this._checkForChargedTimer.addEventListener(TimerEvent.TIMER,this.checkRecharged);
         this._checkForChargedTimer.reset();
         this._checkForChargedTimer.start();
         this.updateCost();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this._countdownTimer.stop();
         this._checkForChargedTimer.removeEventListener(TimerEvent.TIMER,this.checkRecharged);
         this._checkForChargedTimer.stop();
      }
      
      private function checkRecharged(param1:TimerEvent) : void
      {
         var _loc2_:Number = BloonBeaconSystem.getInstance().eventManager.beaconLastCaptureTime + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         if(_loc3_ > _loc2_ - 2000)
         {
            this.hide();
         }
         this.updateCost();
      }
      
      protected function onRecharge() : void
      {
         var resourceStore:ResourceStore = ResourceStore.getInstance();
         var currentCost:int = this.getCurrentCost();
         if(resourceStore.bloonstones < currentCost)
         {
            this._notEnoughBloonstonesPanel.setRequiredBloonstones(currentCost - ResourceStore.getInstance().bloonstones,"to recharge the Beacon");
            this._clip.visible = false;
            this._notEnoughBloonstonesPanel.onHideSignal.addOnce(function(... rest):void
            {
               _clip.visible = true;
            });
            PanelManager.getInstance().showPanelOverlay(this._notEnoughBloonstonesPanel);
            return;
         }
         AnalyticsUtil.track("recharge_beacon",JSON.stringify({
            "cityLevel":resourceStore.townLevel,
            "remainingBS":resourceStore.bloonstones
         }));
         resourceStore.bloonstones = resourceStore.bloonstones - currentCost;
         MonkeyCityMain.getInstance().bloonBeaconSystem.spawnNewBeacon();
         MonkeyCityMain.getInstance().bloonBeaconSystem.viewBeaconOnMap();
         this.hide();
      }
      
      protected function updateCost() : void
      {
         var _loc1_:int = this.getCurrentCost();
         this._costDescriptionText.text = LocalisationConstants.BEACON_BLOONSTONES.split("<bloonstones>").join(_loc1_.toString());
         this._costButtonText.text = _loc1_.toString();
      }
      
      private function getCurrentCost() : int
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:int = int(BLOONSTONE_COST_RECHARGE_MAX_BASE * GameEventManager.getInstance().beaconModifiers.rechargeCostModifier * GameEventManager.getInstance().beaconRechargeCostModifier.modifier);
         var _loc2_:Number = BloonBeaconSystem.getInstance().getMaxSpawnTimeModifier();
         _loc3_ = BloonBeaconSystem.getInstance().eventManager.beaconLastCaptureTime + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         _loc4_ = MonkeySystem.getInstance().getSecureTime();
         _loc5_ = _loc3_ - _loc4_;
         var _loc6_:Number = _loc5_ / BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         var _loc7_:int = int(_loc6_ * _loc1_ * _loc2_);
         _loc7_ = _loc7_ + 1;
         if(0 == _loc7_)
         {
            _loc7_ = 1;
         }
         return _loc7_;
      }
   }
}
