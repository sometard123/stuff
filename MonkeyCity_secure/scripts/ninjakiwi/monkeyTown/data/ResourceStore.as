package ninjakiwi.monkeyTown.data
{
   import com.lgrey.signal.SignalHub;
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.leaderboards.LeaderboardManager;
   import ninjakiwi.monkeyTown.premiums.SecureBloonstones;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.BankManager;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.MonkeyTownXPLevelData;
   import ninjakiwi.monkeyTown.town.data.definitions.CityResourcesSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.ResourceStoreSaveDefinition;
   import ninjakiwi.monkeyTown.town.ui.LevelUpPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelGroups;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class ResourceStore
   {
      
      public static var setXPNoAwardSignal:Signal = new Signal();
      
      private static var instance:ResourceStore;
       
      
      private var _bloonstones:INumber;
      
      private var _redHotSpikes:INumber;
      
      private var _monkeyBoosts:INumber;
      
      private var _monkeyMoney:INumber;
      
      private var _bloontonium:INumber;
      
      private var _townLevel:INumber;
      
      private var _bossChills:INumber;
      
      private var _bossBanes:INumber;
      
      private var _bossBlasts:INumber;
      
      private var _bossWeakens:INumber;
      
      private var _honour:INumber;
      
      private var _bonusBankCapacity:INumber;
      
      private var _honourVisual:int = 0;
      
      private var _hasBeenInitialised:Boolean = false;
      
      private var _cuedPurchases:Object;
      
      private const _hubResources:SignalHub = SignalHub.getHub("resources");
      
      public var resourceStoreLoadedSignal:Signal;
      
      public var resourceStoreChangedSignal:Signal;
      
      public var globalResourcesChangedSignal:Signal;
      
      public var cityResourcesChangedSignal:Signal;
      
      public var bloonstonesChangedDiffSignal:Signal;
      
      public var monkeyMoneyChangedDiffSignal:PrioritySignal;
      
      public var townLevelChangedDiffSignal:PrioritySignal;
      
      public var xpChangedDiffSignal:Signal;
      
      public var xpDebtChangedSignal:Signal;
      
      public var bloontoniumChangedDiffSignal:Signal;
      
      public var bloontoniumChangedSignal:Signal;
      
      public var honourChangedDiffSignal:Signal;
      
      public var honourPlayEffectSignal:Signal;
      
      public var banksAreFullSignal:Signal;
      
      public var bloontoniumTanksAreFullSignal:Signal;
      
      private var _monkeyTownXPLevelData:MonkeyTownXPLevelData;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var metacheatEnabled:Boolean = false;
      
      private var _rewardedMoney:int = 0;
      
      private var _rewardedBS:int = 0;
      
      private var _tmpOverage:INumber;
      
      public const getStartingCashSignal:Signal = new Signal(Function);
      
      public function ResourceStore(param1:SingletonEnforcer#1312)
      {
         this._bloonstones = DancingShadows.getOne();
         this._redHotSpikes = DancingShadows.getOne();
         this._monkeyBoosts = DancingShadows.getOne();
         this._monkeyMoney = DancingShadows.getOne();
         this._bloontonium = DancingShadows.getOne();
         this._townLevel = DancingShadows.getOne();
         this._bossChills = DancingShadows.getOne();
         this._bossBanes = DancingShadows.getOne();
         this._bossBlasts = DancingShadows.getOne();
         this._bossWeakens = DancingShadows.getOne();
         this._honour = DancingShadows.getOne();
         this._bonusBankCapacity = DancingShadows.getOne();
         this._cuedPurchases = {};
         this.resourceStoreLoadedSignal = new Signal();
         this.resourceStoreChangedSignal = new Signal();
         this.globalResourcesChangedSignal = new Signal();
         this.cityResourcesChangedSignal = new Signal();
         this.bloonstonesChangedDiffSignal = new Signal();
         this.monkeyMoneyChangedDiffSignal = new PrioritySignal(int);
         this.townLevelChangedDiffSignal = new PrioritySignal();
         this.xpChangedDiffSignal = new Signal();
         this.xpDebtChangedSignal = new Signal();
         this.bloontoniumChangedDiffSignal = new Signal();
         this.bloontoniumChangedSignal = new Signal();
         this.honourChangedDiffSignal = new Signal();
         this.honourPlayEffectSignal = new Signal();
         this.banksAreFullSignal = new Signal();
         this.bloontoniumTanksAreFullSignal = new Signal();
         this._monkeyTownXPLevelData = MonkeyTownXPLevelData.getInstance();
         this._tmpOverage = DancingShadows.getOne();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use ResourceStore.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : ResourceStore
      {
         if(instance == null)
         {
            instance = new ResourceStore(new SingletonEnforcer#1312());
         }
         return instance;
      }
      
      private function init() : void
      {
         this._townLevel.value = 0;
         Building.buildingWasDemolishedSignal.add(this.onBuildingWasDemolished);
         this.bloonstonesChangedDiffSignal.add(this.rebroadcastBloonstonesChanged);
      }
      
      private function rebroadcastBloonstonesChanged(param1:int) : void
      {
         Constants.BLOONSTONES_CHANGED_SIGNAL.dispatch(this._bloonstones.value);
      }
      
      private function onBuildingWasDemolished(param1:Building, param2:Boolean) : void
      {
         if(param2)
         {
            this.xpDebt = this.xpDebt + param1.getTotalXPEarned();
            this.xpDebtChangedSignal.dispatch();
         }
         City.cityInfoChanged.dispatch();
      }
      
      public function getGlobalResourcesSaveDefinition() : ResourceStoreSaveDefinition
      {
         var _loc1_:ResourceStoreSaveDefinition = new ResourceStoreSaveDefinition();
         _loc1_.bloonstones = this._bloonstones.value;
         _loc1_.redHotSpikes = this._redHotSpikes.value;
         _loc1_.monkeyBoosts = this._monkeyBoosts.value;
         _loc1_.bossChills = this._bossChills.value;
         _loc1_.bossBanes = this._bossBanes.value;
         _loc1_.bossBlasts = this._bossBlasts.value;
         _loc1_.bossWeakens = this._bossWeakens.value;
         return _loc1_;
      }
      
      public function getCityResourcesSaveDefinition() : CityResourcesSaveDefinition
      {
         var _loc1_:CityResourcesSaveDefinition = new CityResourcesSaveDefinition();
         _loc1_.bloontonium = this._bloontonium.value;
         _loc1_.monkeyMoney = this._monkeyMoney.value;
         _loc1_.maxCashPillage = this._system.city.bankManager.getMaximumPillage();
         return _loc1_;
      }
      
      public function populateGlobalResourcesFromSaveDefinition(param1:ResourceStoreSaveDefinition) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         MCSound.enabled = false;
         if(param1 != null)
         {
            _loc2_ = this._system.nkGatewayUser.igcAmount;
            if(int(param1.bloonstones) !== int(_loc2_))
            {
               _loc3_ = param1.bloonstones - _loc2_;
               AnalyticsUtil.track("bloonstones_discrepancy",_loc3_.toString(),param1.bloonstones,_loc2_.toString());
               if(_loc2_ > param1.bloonstones)
               {
                  param1.bloonstones = _loc2_;
               }
            }
            this._bloonstones.value = param1.bloonstones;
            this._redHotSpikes.value = param1.redHotSpikes;
            this._monkeyBoosts.value = param1.monkeyBoosts;
            this._bossChills.value = param1.bossChills;
            this._bossBanes.value = param1.bossBanes;
            this._bossBlasts.value = param1.bossBlasts;
            this._bossWeakens.value = param1.bossWeakens;
            this.processCuedPurchases();
         }
         MCSound.enabled = true;
      }
      
      public function populateCityResourcesFromSaveDefinition(param1:CityResourcesSaveDefinition) : void
      {
         MCSound.enabled = false;
         if(param1 != null)
         {
            this._monkeyMoney.value = param1.monkeyMoney;
            this._bloontonium.value = param1.bloontonium;
         }
         this._hasBeenInitialised = true;
         this.resourceStoreLoadedSignal.dispatch();
         MCSound.enabled = true;
      }
      
      public function setBonusBankCapacity(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         this._bonusBankCapacity.value = param1;
         BankManager.bankCapacityChangedSignal.dispatch();
      }
      
      private function processCuedPurchases() : void
      {
         if(this._cuedPurchases.hasOwnProperty("bloonstones"))
         {
            this.bloonstonesDirect = this.bloonstonesDirect + this._cuedPurchases.bloonstones;
         }
         this._cuedPurchases = {};
      }
      
      public function get bloonstones() : int
      {
         return this._bloonstones.value;
      }
      
      public function set bloonstones(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         SecureBloonstones.bloonstonesChanging(this._bloonstones.value,param1);
         var _loc2_:INumber = DancingShadows.getOne();
         _loc2_.value = param1 - this._bloonstones.value;
         this._bloonstones.value = param1;
         if(_loc2_.value != 0)
         {
            this.bloonstonesChangedDiffSignal.dispatch(_loc2_.value);
         }
         this.globalResourcesChangedSignal.dispatch();
         this.resourceStoreChangedSignal.dispatch();
         DancingShadows.returnOne(_loc2_);
      }
      
      public function set bloonstonesDirect(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(!this._hasBeenInitialised)
         {
            if(false === this._cuedPurchases.hasOwnProperty("bloonstones"))
            {
               this._cuedPurchases.bloonstones = 0;
            }
            this._cuedPurchases.bloonstones = this._cuedPurchases.bloonstones + param1;
            return;
         }
         var _loc2_:INumber = DancingShadows.getOne();
         _loc2_.value = param1 - this._bloonstones.value;
         this._bloonstones.value = param1;
         if(_loc2_.value != 0)
         {
            this.bloonstonesChangedDiffSignal.dispatch(_loc2_.value);
         }
         this.cityResourcesChangedSignal.dispatch();
         this.resourceStoreChangedSignal.dispatch();
         DancingShadows.returnOne(_loc2_);
      }
      
      public function get bloonstonesDirect() : int
      {
         return this.bloonstones;
      }
      
      public function get monkeyMoney() : int
      {
         return this._monkeyMoney.value;
      }
      
      public function addMoneyWithoutSaving(param1:int) : void
      {
         this._monkeyMoney.value = this._monkeyMoney.value + param1;
         this.monkeyMoneyChangedDiffSignal.dispatch(param1);
      }
      
      public function get spendableMonkeyMoney() : int
      {
         return this._monkeyMoney.value;
      }
      
      public function set monkeyMoney(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         this.setMonkeyMoney(param1,true);
      }
      
      public function setMonkeyMoney(param1:*, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc4_:INumber = DancingShadows.getOne();
         _loc4_.value = param1 - this._monkeyMoney.value;
         this._monkeyMoney.value = param1;
         if(_loc4_.value != 0)
         {
            this.monkeyMoneyChangedDiffSignal.dispatch(_loc4_.value,param3);
            this.cityResourcesChangedSignal.dispatch();
            if(param2)
            {
               this.resourceStoreChangedSignal.dispatch();
            }
         }
         DancingShadows.returnOne(_loc4_);
      }
      
      public function depositMoneyWithRemainder(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = this._monkeyMoney.value + param1;
         var _loc4_:Number = Math.max(this.monkeyMoney,this.bankCapacity);
         if(_loc3_ > _loc4_)
         {
            _loc2_ = _loc3_ - _loc4_;
            this.monkeyMoney = _loc4_;
            this.banksAreFullSignal.dispatch();
         }
         else
         {
            this.monkeyMoney = _loc3_;
         }
         if(_loc2_ > param1)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function depositBloontoniumWithRemainder(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:int = this._bloontonium.value + this.getTempOverage();
         var _loc4_:Number = _loc3_ + param1;
         var _loc5_:Number = Math.max(_loc3_,this.bloontoniumCapacity);
         if(_loc4_ > _loc5_)
         {
            _loc2_ = _loc4_ - _loc5_;
            this.bloontonium = this.bloontonium + (_loc5_ - _loc3_);
            this.bloontoniumTanksAreFullSignal.dispatch();
         }
         else
         {
            this.bloontonium = this.bloontonium + param1;
         }
         if(_loc2_ > param1)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function set monkeyBoosts(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._monkeyBoosts.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get monkeyBoosts() : int
      {
         return this._monkeyBoosts.value;
      }
      
      public function set redHotSpikes(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._redHotSpikes.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get redHotSpikes() : int
      {
         return this._redHotSpikes.value;
      }
      
      public function set bossChills(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._bossChills.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get bossChills() : int
      {
         return this._bossChills.value;
      }
      
      public function set bossBanes(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._bossBanes.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get bossBanes() : int
      {
         return this._bossBanes.value;
      }
      
      public function set bossBlasts(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._bossBlasts.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get bossBlasts() : int
      {
         return this._bossBlasts.value;
      }
      
      public function set bossWeakens(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._bossWeakens.value = param1;
         this.globalResourcesChangedSignal.dispatch();
      }
      
      public function get bossWeakens() : int
      {
         return this._bossWeakens.value;
      }
      
      public function get townLevel() : int
      {
         if(this._townLevel.value > Constants.MAX_CITY_LEVEL)
         {
            this._townLevel.value = Constants.MAX_CITY_LEVEL;
         }
         return this._townLevel.value;
      }
      
      private function setTownLevel(param1:*, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc6_:LevelUpPanel = null;
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         var _loc3_:int = this._townLevel.value;
         if(this._townLevel.value > Constants.MAX_CITY_LEVEL)
         {
            param1 = Constants.MAX_CITY_LEVEL;
         }
         this._townLevel.value = param1;
         var _loc4_:Boolean = false;
         if(param1 > _loc3_)
         {
            this._rewardedMoney = 0;
            this._rewardedBS = 0;
            _loc5_ = _loc3_;
            while(_loc5_ < param1)
            {
               this._rewardedMoney = this._rewardedMoney + this._monkeyTownXPLevelData.levelingRewardMonkeyMoney[_loc5_];
               this._rewardedBS = this._rewardedBS + this._monkeyTownXPLevelData.levelingRewardBloonstones[_loc5_];
               _loc5_++;
            }
            _loc6_ = new LevelUpPanel(TownUI.getInstance().popupLayer);
            if(_loc6_.reload())
            {
               TownUI.getInstance().informationBar.lockDisplay();
               PanelManager.getInstance().showPanel(_loc6_,PanelGroups.LEVEL_UP_PANELS);
               TownUI.getInstance().informationBar.addRewardDisplay(_loc6_.hideStartSignal,0,0,GameMods.awardCash(this._rewardedMoney),0,0,GameMods.awardBloonstones(this._rewardedBS));
               _loc4_ = true;
               TownUI.getInstance().informationBar.unlockDisplay();
            }
         }
         if(param1 - _loc3_ != 0)
         {
            this.townLevelChangedDiffSignal.dispatch(param1 - _loc3_);
         }
         if(param2)
         {
            this.cityResourcesChangedSignal.dispatch();
            this.resourceStoreChangedSignal.dispatch();
         }
      }
      
      public function get rewardedMoney() : int
      {
         return this._rewardedMoney;
      }
      
      public function get rewardedBS() : int
      {
         return this._rewardedBS;
      }
      
      public function get xp() : int
      {
         return this._system.city.xp;
      }
      
      public function set xp(param1:*) : void
      {
         var _loc3_:int = 0;
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:int = param1 - this._system.city.xp;
         if(_loc2_ === 0)
         {
            return;
         }
         if(this.xpDebt > 0 && _loc2_ > 0)
         {
            this.xpDebt = this.xpDebt - _loc2_;
            if(this.xpDebt < 0)
            {
               _loc3_ = Math.abs(this.xpDebt);
               this._system.city.xp = this._system.city.xp + _loc3_;
               this.xpDebt = 0;
               this.xpChangedDiffSignal.dispatch(_loc3_);
            }
            this.xpDebtChangedSignal.dispatch();
         }
         else
         {
            this._system.city.xp = param1;
            this.setTownLevel(this._monkeyTownXPLevelData.getTownLevelFromXP(param1),true);
            this.xpChangedDiffSignal.dispatch(_loc2_);
         }
         if(this.xp !== 0)
         {
            City.cityInfoChanged.dispatch();
         }
      }
      
      public function setXPNoAward(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         this._system.city.xp = param1;
         this.setTownLevel(this._monkeyTownXPLevelData.getTownLevelFromXP(param1),false);
         setXPNoAwardSignal.dispatch();
      }
      
      public function get totalPower() : int
      {
         return this._system.city.powerSourceManager.totalPowerGenerated;
      }
      
      public function get totalPowerUsed() : int
      {
         return this._system.city.buildingManager.powerUsed;
      }
      
      public function get availablePower() : int
      {
         return this.totalPower - this.totalPowerUsed;
      }
      
      public function get bloontonium() : int
      {
         return this._bloontonium.value;
      }
      
      public function set bloontonium(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:Number = this._bloontonium.value;
         this._bloontonium.value = param1;
         if(this._bloontonium.value != _loc2_)
         {
            this.bloontoniumChangedDiffSignal.dispatch(this._bloontonium.value - _loc2_);
            this.bloontoniumChangedSignal.dispatch(this._bloontonium.value);
         }
         this.cityResourcesChangedSignal.dispatch();
         this.resourceStoreChangedSignal.dispatch();
      }
      
      public function isBloontoniumMax() : Boolean
      {
         if(this.bloontoniumCapacity > 0 && this._bloontonium.value + this._tmpOverage.value >= this.bloontoniumCapacity)
         {
            return true;
         }
         return false;
      }
      
      public function get bloontoniumStorageCapacity() : int
      {
         return this._system.city.bloontoniumStorageTankManager.capacity;
      }
      
      public function addBloontoniumWithTempOverage(param1:int) : void
      {
         this._tmpOverage.value = this._tmpOverage.value + param1;
         this.bloontoniumChangedDiffSignal.dispatch(param1);
      }
      
      public function getTempOverage() : int
      {
         return this._tmpOverage.value;
      }
      
      public function spendTempOverage(param1:int) : void
      {
         if(param1 >= this._tmpOverage.value)
         {
            this._tmpOverage.value = this._tmpOverage.value - param1;
            this.bloontoniumChangedDiffSignal.dispatch(-param1);
         }
      }
      
      public function discardBloontoniumOverage() : void
      {
         var _loc1_:int = this._tmpOverage.value;
         this._tmpOverage.value = 0;
         if(_loc1_ <= 0)
         {
            return;
         }
         this.bloontoniumChangedDiffSignal.dispatch(-_loc1_);
         var _loc2_:int = _loc1_ + this.bloontonium;
         if(this.bloontonium <= this.bloontoniumCapacity)
         {
            if(_loc2_ > this.bloontoniumCapacity)
            {
               this.bloontonium = this.bloontoniumCapacity;
            }
            else
            {
               this.bloontonium = this.bloontonium + _loc1_;
            }
         }
      }
      
      public function get honour() : int
      {
         return this._honour.value;
      }
      
      public function setHonour(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         if(param4)
         {
            this.honour = param1;
         }
         else
         {
            this._honour.value = param1;
         }
         if(param2)
         {
            this.setHonourVisual(param1,param3);
         }
      }
      
      public function set honour(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         if(this._honour.value < 0)
         {
            this._honour.value = 0;
         }
         var _loc2_:int = param1 - this._honour.value;
         this._honour.value = param1;
         City.cityInfoChanged.dispatch();
         this.honourChangedDiffSignal.dispatch(_loc2_);
         if(_loc2_ !== 0)
         {
            LeaderboardManager.submitScore(this._honour.value,LeaderboardManager.HONOR_BOARD);
         }
      }
      
      public function setHonourVisual(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = param1 - this._honourVisual;
         if(_loc3_ == 0)
         {
            return;
         }
         this._honourVisual = param1;
         this.honourPlayEffectSignal.dispatch(this._honourVisual,_loc3_,param2);
      }
      
      public function get bloontoniumCapacity() : int
      {
         return this._system.city.bloontoniumStorageTankManager.capacity;
      }
      
      public function get bankCapacity() : int
      {
         return this._system.city.bankManager.capacity + this._bonusBankCapacity.value;
      }
      
      public function get btdStartingMoney() : int
      {
         return this.getBTDStartingMoneyForLevel(this.townLevel);
      }
      
      public function get btdBonusStartingMoney() : int
      {
         var bonus:int = 0;
         bonus = 0;
         this.getStartingCashSignal.dispatch(function(param1:int):void
         {
            bonus = bonus + param1;
         });
         return bonus;
      }
      
      public function getBTDStartingMoneyForLevel(param1:int = -1) : int
      {
         return 350 + (param1 - 1) * 100;
      }
      
      public function get btdStartingLives() : int
      {
         return LGMathUtil.getInstance().clamp(20 + 5 * (this.townLevel - 1),0,300);
      }
      
      public function get xpDebt() : int
      {
         return this._system.city.xpDebt;
      }
      
      public function set xpDebt(param1:*) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         param1 = int(param1);
         this._system.city.xpDebt = param1;
      }
      
      public function getBonusStartingCash() : int
      {
         return 200;
      }
      
      public function clearCityResources() : void
      {
         this._monkeyMoney.value = 0;
         this._bloontonium.value = 0;
         this._honour.value = 0;
         this._townLevel.value = 0;
         this._tmpOverage.value = 0;
      }
      
      public function reset() : void
      {
         this._hasBeenInitialised = false;
         this._cuedPurchases = {};
         this._bloonstones.value = 0;
         this._monkeyMoney.value = 0;
         this._bloontonium.value = 0;
         this._townLevel.value = 0;
         this._tmpOverage.value = 0;
         this.setHonour(0,false,false);
      }
   }
}

class SingletonEnforcer#1312
{
    
   
   function SingletonEnforcer#1312()
   {
      super();
   }
}
