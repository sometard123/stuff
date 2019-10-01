package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import com.lgrey.signal.SignalHub;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloonResearchLab;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockManager;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import org.osflash.signals.Signal;
   
   public class BloonResearchLabState
   {
      
      public static var currentTier:int = 0;
      
      public static var isUpgrading:Boolean = false;
      
      public static var currentWarmingUpgrade:BloonResearchLabUpgrade = null;
      
      public static var clockManager:ClockManager = new ClockManager(new MovieClip());
      
      public static var clock:BloonResearchLabUpgradeClock;
      
      private static var _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static var _upgradeTree:UpgradeTree = _system.city.upgradeTree;
      
      private static var _hubUpgrades:SignalHub = SignalHub.getHub("upgrades");
      
      private static var _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private static var _bloonResearchLab:BloonResearchLab;
      
      public static const upgradeCompleteSignal:Signal = new Signal();
      
      public static const TOTAL_TIERS:int = 10;
      
      {
         init();
      }
      
      public function BloonResearchLabState()
      {
         super();
      }
      
      public static function tick() : void
      {
         clockManager.process();
      }
      
      private static function init() : void
      {
         _hubUpgrades.getSignal("purchasedBloonResearchLabSkipWarmup").add(onPurchasedSkipUpgrade);
         BloonResearchLab.labPlacedSignal.add(onBloonResearchLabCreatedSignal);
         MonkeyCityMain.globalResetSignal.add(reset);
      }
      
      public static function startUpgrade(param1:BloonResearchLabUpgrade) : BloonResearchLabUpgradeClock
      {
         if(!isUpgrading)
         {
         }
         currentWarmingUpgrade = param1;
         clock = new BloonResearchLabUpgradeClock(clockManager,onUpgradeComplete,null,param1.time,param1);
         _bloonResearchLab.addUpgradeSecondaryClock(clock);
         isUpgrading = true;
         UpgradeSignals.bloonResearchLabUpgradePurchased.dispatch();
         return clock;
      }
      
      private static function onPurchasedSkipUpgrade(param1:BloonResearchLabUpgrade, ... rest) : void
      {
         if(param1 !== currentWarmingUpgrade)
         {
            return;
         }
         clock.skip();
      }
      
      private static function onUpgradeComplete(param1:Number) : void
      {
         isUpgrading = false;
         clock = null;
         upgradeCompleteSignal.dispatch();
         GameMods.awardXP(currentWarmingUpgrade.xpGiven);
         UpgradeSignals.bloonResearchLabUpgradeComplete.dispatch();
         currentWarmingUpgrade = null;
      }
      
      public static function resetState() : void
      {
         currentTier = 0;
         isUpgrading = false;
         UpgradeSignals.bloonResearchLabUpgradeComplete.dispatch();
      }
      
      public static function getSaveDefinition() : BloonResearchLabSaveDefinition
      {
         var _loc1_:ClockSaveDefinition = clock !== null?clock.getSaveDefinition():null;
         return new BloonResearchLabSaveDefinition().CurrentTier(currentTier).IsUpgrading(isUpgrading).ClockSave(_loc1_);
      }
      
      public static function populateFromSaveDefinition(param1:BloonResearchLabSaveDefinition) : void
      {
         if(param1 === null)
         {
            return;
         }
         currentTier = param1.currentTier;
         isUpgrading = param1.isUpgrading;
         if(isUpgrading)
         {
            currentWarmingUpgrade = BloonResearchLabUpgrades.getUpgradeByTier(currentTier + 1);
            clock = new BloonResearchLabUpgradeClock(clockManager,onUpgradeComplete,null,currentWarmingUpgrade.time,currentWarmingUpgrade);
            clock.populateFromSaveDefinition(param1.clockSave);
         }
      }
      
      private static function onBloonResearchLabCreatedSignal(param1:BloonResearchLab) : void
      {
         _bloonResearchLab = param1;
         if(isUpgrading)
         {
            _bloonResearchLab.addUpgradeSecondaryClock(clock);
         }
      }
      
      public static function hasUpgrade(param1:String) : Boolean
      {
         var _loc2_:BloonResearchLabUpgrade = BloonResearchLabUpgrades.getUpgradeByID(param1);
         return _loc2_.tier <= currentTier;
      }
      
      public static function reset() : void
      {
         currentTier = 0;
         isUpgrading = false;
         currentWarmingUpgrade = null;
         clock = null;
         clockManager.clear();
      }
   }
}
