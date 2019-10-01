package ninjakiwi.monkeyTown.town.upgrades
{
   import com.lgrey.signal.SignalHub;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class UpgradeSignals
   {
      
      private static const _hubUpgrades:SignalHub = SignalHub.getHub("upgrades");
      
      private static const maxUpgradeTierHub:SignalHub = SignalHub.getHub("maxUpgradeTierHub");
      
      public static const bloonResearchLabUpgradePurchased:Signal = _hubUpgrades.defineSignal("bloonResearchLabUpgradePurchased");
      
      public static const purchasedBloonResearchLabSkipWarmup:PrioritySignal = _hubUpgrades.defineSignal("purchasedBloonResearchLabSkipWarmup",BloonResearchLabUpgrade,int);
      
      public static const bloonResearchLabUpgradeComplete:PrioritySignal = _hubUpgrades.defineSignal("bloonResearchLabUpgradeComplete");
      
      public static const upgradePurchased:Signal = _hubUpgrades.defineSignal("upgradePurchased");
      
      public static const upgradeComplete:Signal = _hubUpgrades.defineSignal("upgradeComplete");
      
      public static const requestSkipPathWarmup:Signal = _hubUpgrades.defineSignal("requestSkipPathWarmup",UpgradePathStateDefinition);
      
      public static const requestBloonResearchLabSkip:Signal = _hubUpgrades.defineSignal("requestBloonResearchLabSkip",BloonResearchLabUpgrade,int);
      
      public static const purchasedSkipPathWarmup:PrioritySignal = _hubUpgrades.defineSignal("purchasedSkipPathWarmup",UpgradePathStateDefinition,int,int,int);
      
      public static const pathWarmupComplete:Signal = _hubUpgrades.defineSignal("pathWarmupComplete",UpgradePathStateDefinition);
      
      public static var passiveUpgradeClockClicked:Signal = _hubUpgrades.defineSignal("passiveUpgradeClockClicked",UpgradePathStateDefinition);
       
      
      public function UpgradeSignals()
      {
         super();
      }
   }
}
