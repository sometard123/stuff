package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.BossBattleAttackPanelClip;
   import assets.ui.BossSupplyDropSelect;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.CachedPreMaintenanceChecker;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossData;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossEventManager;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BossBattleAttackPanel extends HideRevealView
   {
       
      
      private var _bossEventManager:BossEventManager;
      
      private var _clip:BossBattleAttackPanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _attackButton:ButtonControllerBase;
      
      private var _attackButtonCostField:TextField;
      
      private var _bossLongNameField:TextField;
      
      private var _bossLevelField:TextField;
      
      private var _healthBarClip:MovieClip;
      
      private var _countdownClip:MovieClip;
      
      private var _startingCashField:TextField;
      
      private var _timeRemainingMessage:TextField;
      
      private var _bonusCashClip:MovieClip;
      
      private var _crateTickBoxes:BossSupplyDropSelect;
      
      private var _secondTimer:Timer;
      
      private var _bossRewardsSubpanel:BossRewardsSubpanel;
      
      protected var _countdownTimer:CountdownTimer = null;
      
      private const _crateTickboxes:CratesTickBoxes = new CratesTickBoxes(this._clip.crateTickBoxes);
      
      private var _bossData:Object = null;
      
      private var _avatar:MovieClip = null;
      
      protected var _startCashOption:AddStartCashModule;
      
      public function BossBattleAttackPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._bossEventManager = GameEventManager.getInstance().bossEventManager;
         this._clip = new BossBattleAttackPanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._attackButton = new ButtonControllerBase(this._clip.fightButton);
         this._attackButtonCostField = this._clip.fightButton.costField;
         this._bossLongNameField = this._clip.bossLongNameField;
         this._bossLevelField = this._clip.bossInfoPane.bossLevelField;
         this._healthBarClip = this._clip.bossInfoPane.healthBar;
         this._countdownClip = this._clip.countdown;
         this._startingCashField = this._clip.startingCash;
         this._timeRemainingMessage = this._clip.timeRemainingMessage;
         this._bonusCashClip = this._clip.bonusCashClip;
         this._crateTickBoxes = this._clip.crateTickBoxes;
         this._secondTimer = new Timer(1000);
         this._bossRewardsSubpanel = new BossRewardsSubpanel(this._clip.rewardsSubPanel);
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      private function init() : void
      {
         this._cancelButton.setClickFunction(this.hide);
         this._closeButton.setClickFunction(this.hide);
         this._attackButton.setClickFunction(this.onClickedAttack);
         this._startCashOption = new AddStartCashModule(this._clip.bonusCashClip);
         enableDefaultOnResize(this._clip);
         this._startCashOption.enableWarningPanel(this._clip);
         this._startCashOption.changedSignal.add(this.onBonusCashOptionChanged);
         this._secondTimer.addEventListener(TimerEvent.TIMER,this.onTick);
         this.initBeaconListener();
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         var time:Number = param1;
         var superReveal:Function = super.reveal;
         this._bossEventManager.getDataForCurrentEvent(function(param1:Object):void
         {
            syncToEventData(param1);
         });
         this._secondTimer.reset();
         this._secondTimer.start();
         this.syncCrates();
      }
      
      private function syncToEventData(param1:Object) : void
      {
         var _loc7_:String = null;
         super.reveal();
         this._bossData = param1;
         if(this._countdownTimer == null)
         {
            this._countdownTimer = new CountdownTimer(this._clip.countdown.timerField,0);
         }
         var _loc2_:String = param1.name;
         var _loc3_:String = param1.longName;
         this._bossRewardsSubpanel.build(param1.rewards,this._bossEventManager.bossLevel);
         this._bossLongNameField.text = _loc3_.toUpperCase();
         var _loc4_:GameplayEvent = this._bossEventManager.findCurrentEvent();
         this._countdownTimer.setEndTime(_loc4_.endTime);
         this._countdownTimer.start();
         var _loc5_:BossBattleAttackDefinition = this._bossEventManager.getAttackDefinition(_loc4_.dataID,_loc2_,_loc3_);
         var _loc6_:int = Math.ceil(this._bossEventManager.getCostToAttack());
         if(_loc6_ === 0)
         {
            _loc7_ = "FREE!";
         }
         else
         {
            _loc7_ = "$" + _loc6_.toString();
         }
         this._bossLevelField.text = "Level: " + _loc5_.bossLevel;
         this._attackButtonCostField.text = "Cost: " + _loc7_;
         this._startCashOption.reset();
         this.updateStartingCashField();
         var _loc8_:Number = _loc5_.bossHitPoints / _loc5_.bossMaxHitPoints;
         this.setHealthBar(_loc8_);
         this.syncActiveTimeRemaining();
         var _loc9_:Class = BossData.getInstance().getAvatarClass(_loc4_.dataID);
         if(this._avatar === null || false === this._avatar is _loc9_)
         {
            this._avatar = new _loc9_();
            this._clip.bossInfoPane.avatar.removeChildren();
            this._clip.bossInfoPane.avatar.addChild(this._avatar);
         }
         switch(_loc4_.dataID)
         {
            default:
            case "bloonarius":
               this._clip.bossIcon.gotoAndStop(1);
               break;
            case "vortex":
               this._clip.bossIcon.gotoAndStop(2);
               break;
            case "blastapopoulos":
               this._clip.bossIcon.gotoAndStop(3);
               break;
            case "dreadbloon":
               this._clip.bossIcon.gotoAndStop(4);
         }
         this.syncCrates();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         this.syncActiveTimeRemaining();
      }
      
      private function syncActiveTimeRemaining() : void
      {
         var _loc1_:Number = this._bossEventManager.getBossActiveTimeRemaining();
         var _loc2_:int = this._bossEventManager.bossLevel;
         if(_loc2_ > 1 && _loc1_ < 2000)
         {
            this.hide();
            return;
         }
         if(this._bossEventManager.getBossEventTimeRemaining() < 2000)
         {
            this.hide();
            return;
         }
         if(_loc1_ < 1000)
         {
            this._timeRemainingMessage.htmlText = "Destroy " + this._bossData.name + " before" + "<br/>it\'s too late!";
            return;
         }
         var _loc3_:Date = new Date(_loc1_);
         _loc3_.getMinutes();
         _loc3_.getSeconds();
         this._timeRemainingMessage.htmlText = "" + _loc3_.getMinutes() + "min " + _loc3_.getSeconds() + "sec left <br/> to destroy " + this._bossData.name;
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         if(this._countdownTimer !== null)
         {
            this._countdownTimer.stop();
         }
         this._secondTimer.stop();
         this._secondTimer.reset();
      }
      
      private function onBonusCashOptionChanged() : void
      {
         this.updateStartingCashField();
      }
      
      private function updateStartingCashField() : void
      {
         this._startingCashField.text = LocalisationConstants.MONEY_SYMBOL + (this._bossEventManager.getStartingCash() + this._startCashOption.bonusStartingCash);
      }
      
      private function setHealthBar(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         this._healthBarClip.bar.scaleX = param1;
      }
      
      private function initBeaconListener() : void
      {
         if(!BloonBeaconSystem.getInstance().isReady)
         {
            BloonBeaconSystem.getInstance().beaconSystemReadySignal.addOnce(this.initBeaconListener);
         }
      }
      
      private function onClickedAttack() : void
      {
         var bossEventManager:BossEventManager = null;
         var needed:int = 0;
         var ui:TownUI = null;
         bossEventManager = GameEventManager.getInstance().bossEventManager;
         var availableMoney:Number = ResourceStore.getInstance().monkeyMoney;
         var costToAttack:Number = bossEventManager.getCostToAttack();
         if(availableMoney < costToAttack)
         {
            needed = costToAttack - availableMoney;
            TownUI.getInstance().notEnoughCashPanel.setMessage("You need " + needed + " more Cash to do this. Exchange bloonstones to get more cash.");
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().notEnoughCashPanel);
         }
         else
         {
            ui = TownUI.getInstance();
            ui.genericModalSpinner.reveal(1);
            CachedPreMaintenanceChecker.checkPreMaintenance(function(param1:Boolean):void
            {
               var isPreMaintenance:Boolean = param1;
               ui.genericModalSpinner.hide();
               if(isPreMaintenance)
               {
                  ui.maintenanceScheduledMessage.showBossStartPremaintenanceMessage(function(param1:Boolean):void
                  {
                     if(param1)
                     {
                        bossEventManager.launchBossBattle(_crateTickboxes.cratesTickedArray,_startCashOption.bonusStartingCash);
                        _startCashOption.apply();
                     }
                  });
               }
               else
               {
                  bossEventManager.launchBossBattle(_crateTickboxes.cratesTickedArray,_startCashOption.bonusStartingCash);
                  _startCashOption.apply();
               }
            });
         }
      }
      
      private function syncCrates() : void
      {
         var _loc1_:CrateManager = CrateManager.getInstance();
         this._crateTickboxes.setCratesAvailable(_loc1_.cratesAvailable());
         this._crateTickboxes.setCratesTicked(0);
      }
   }
}
