package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.InformationBarClip;
   import flash.display.Stage;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.informationBar.BloonstonesDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.BloontoniumDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.HonourDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.InformationNumber;
   import ninjakiwi.monkeyTown.town.ui.informationBar.LevelDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.LockedElement;
   import ninjakiwi.monkeyTown.town.ui.informationBar.MonkeyMoneyDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.PowerDisplay;
   import ninjakiwi.monkeyTown.town.ui.informationBar.XPDisplay;
   import org.osflash.signals.Signal;
   
   public class InformationBar
   {
       
      
      public var clip:InformationBarClip;
      
      private var _stage:Stage;
      
      private var _lockCount:int = 0;
      
      private var _preventUpdate:Boolean = false;
      
      private var _monkeyMoney:MonkeyMoneyDisplay;
      
      private var _power:PowerDisplay;
      
      private var _level:LevelDisplay;
      
      private var _xp:XPDisplay;
      
      private var _bloontonium:BloontoniumDisplay;
      
      private var _bloonstones:BloonstonesDisplay;
      
      private var _honour:HonourDisplay;
      
      private var _numbers:Vector.<InformationNumber>;
      
      private var _queue:Vector.<LockedElement>;
      
      private var _buttonsAreEnabled:Boolean = false;
      
      public function InformationBar(param1:InformationBarClip)
      {
         this._numbers = new Vector.<InformationNumber>();
         this._queue = new Vector.<LockedElement>();
         super();
         this.clip = param1;
         this._monkeyMoney = new MonkeyMoneyDisplay(param1.monkeyMoneyField,param1.burstCash,param1.cashButton);
         this._power = new PowerDisplay(param1.powerField,param1.burstPower,param1.powerButton);
         this._level = new LevelDisplay(param1.townLevelField,param1.burstLevel,param1.cityLevelButton);
         this._xp = new XPDisplay(param1.xpField,param1.burstXP,param1.xpButton,param1.townXPProgressBar);
         this._bloontonium = new BloontoniumDisplay(param1.bloontoniumField,param1.burstBloontonium,param1.bloontoniumButton);
         this._bloonstones = new BloonstonesDisplay(param1.bloonstonesField,param1.burstBloonstones,param1.bloonstonesButton);
         this._honour = new HonourDisplay(param1.honourSymbol,param1.honourField,param1.burstHonor,param1.cityHonorButton);
         this._numbers.push(this._monkeyMoney);
         this._numbers.push(this._power);
         this._numbers.push(this._level);
         this._numbers.push(this._xp);
         this._numbers.push(this._bloontonium);
         this._numbers.push(this._bloonstones);
         this._numbers.push(this._honour);
         this.init();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.addOnce(this.enableButtons);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalResetHandler);
         WorldViewSignals.buildWorldStartSignal.add(this.onBuildWorldStart);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
      }
      
      private function onBuildWorldStart() : void
      {
         this.onGlobalResetHandler();
         this._preventUpdate = true;
         this._power.lock();
      }
      
      private function onBuildWorldEnd() : void
      {
         this._preventUpdate = false;
         this._power.unlock();
         this._power.sync();
         this.syncAll();
      }
      
      private function onGlobalResetHandler() : void
      {
         var _loc1_:InformationNumber = null;
         var _loc2_:LockedElement = null;
         GameSignals.TUTORIAL_ENABLE_BUTTONS.remove(this.enableButtons);
         GameSignals.TUTORIAL_ENABLE_BUTTONS.addOnce(this.enableButtons);
         this._buttonsAreEnabled = false;
         this._lockCount = 0;
         for each(_loc1_ in this._numbers)
         {
            _loc1_.reset();
         }
         for each(_loc2_ in this._queue)
         {
            _loc2_.reset();
         }
         this._queue.length = 0;
      }
      
      private function init() : void
      {
         if(this.clip.stage)
         {
            this.onAddedToStage();
         }
         else
         {
            this.clip.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         ResourceStore.getInstance().resourceStoreLoadedSignal.add(this.syncToResourceStore);
         City.cityInfoLoaded.add(this.syncToCityInfo);
      }
      
      private function enableButtons(... rest) : void
      {
         var _loc2_:InformationNumber = null;
         if(this._buttonsAreEnabled)
         {
            return;
         }
         for each(_loc2_ in this._numbers)
         {
            _loc2_.enableRefillButton();
         }
         this._buttonsAreEnabled = true;
      }
      
      public function onActiveCityChange(param1:City) : void
      {
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         this.clip.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = this.clip.stage;
      }
      
      public function syncAll() : void
      {
         if(this._preventUpdate)
         {
            return;
         }
         this.syncToCityInfo();
         this.syncToResourceStore();
      }
      
      private function syncToResourceStore() : void
      {
         if(this._preventUpdate)
         {
            return;
         }
         this._monkeyMoney.sync();
         this._level.sync();
         this._bloontonium.sync();
         this._bloonstones.sync();
         this._honour.sync();
      }
      
      private function syncToCityInfo() : void
      {
         this._xp.sync();
      }
      
      public function addRewardDisplay(param1:Signal, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         if(param8 > 0)
         {
         }
         var _loc9_:LockedElement = new LockedElement(param1);
         _loc9_.addNumber(this._xp,param2);
         _loc9_.addNumber(this._level,param3);
         _loc9_.addNumber(this._monkeyMoney,param4);
         _loc9_.addNumber(this._power,param5);
         _loc9_.addNumber(this._bloontonium,param6);
         _loc9_.addNumber(this._bloonstones,param7);
         _loc9_.addNumber(this._honour,param8);
         this._queue.push(_loc9_);
      }
      
      public function lockDisplay() : void
      {
         var _loc1_:InformationNumber = null;
         this._lockCount++;
         for each(_loc1_ in this._numbers)
         {
            _loc1_.lock();
         }
      }
      
      public function unlockDisplay() : void
      {
         var _loc1_:InformationNumber = null;
         this._lockCount--;
         if(this._lockCount > 0)
         {
            return;
         }
         for each(_loc1_ in this._numbers)
         {
            _loc1_.unlock();
         }
      }
   }
}
