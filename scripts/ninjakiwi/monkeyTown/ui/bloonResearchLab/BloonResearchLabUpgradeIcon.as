package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import ninjakiwi.monkeyTown.ui.UpgradeIcon;
   
   public class BloonResearchLabUpgradeIcon extends UpgradeIcon
   {
       
      
      private var _upgrade:BloonResearchLabUpgrade;
      
      private var _system:MonkeySystem;
      
      public var availabilityReport:BloonResearchLabUpgradeAvailabilityReport;
      
      public function BloonResearchLabUpgradeIcon(param1:String)
      {
         this._system = MonkeySystem.getInstance();
         super(param1);
      }
      
      public function syncToUpgrade(param1:BloonResearchLabUpgrade) : void
      {
         this._upgrade = param1;
         var _loc2_:UpgradeTree = this._system.city.upgradeTree;
         var _loc3_:int = BloonResearchLabState.currentTier;
         var _loc4_:* = _loc3_ >= this._upgrade.tier;
         setOwned(_loc4_);
         setLocked(param1.tier > _loc3_ + 1);
         this.availabilityReport = new BloonResearchLabUpgradeAvailabilityReport(param1);
         if(!_loc4_)
         {
            setTintOn(!this.availabilityReport.available);
         }
         if(!_loc4_)
         {
            if(this.availabilityReport.available && _loc3_ + 1 == this._upgrade.tier && this._upgrade !== BloonResearchLabState.currentWarmingUpgrade)
            {
               enableClick();
            }
         }
         else
         {
            disableClick();
         }
      }
      
      public function update() : void
      {
         if(this._upgrade === null)
         {
         }
         this.syncToUpgrade(this._upgrade);
      }
      
      public function get upgrade() : BloonResearchLabUpgrade
      {
         return this._upgrade;
      }
   }
}
