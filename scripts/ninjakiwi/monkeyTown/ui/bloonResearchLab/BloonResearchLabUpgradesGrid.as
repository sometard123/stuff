package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   
   public class BloonResearchLabUpgradesGrid extends MovieClip
   {
       
      
      private var _tooltip:ToolTip;
      
      private var _clip:MovieClip;
      
      private var _iconContainer:MovieClip;
      
      private var _upgrades:Array;
      
      private var _system:MonkeySystem;
      
      private var _resourceStore:ResourceStore;
      
      private var _icons:Array;
      
      private var _stage:Stage;
      
      private var _upgradeTree:UpgradeTree;
      
      private var _currentHoveredIcon:BloonResearchLabUpgradeIcon = null;
      
      public function BloonResearchLabUpgradesGrid(param1:MovieClip)
      {
         this._tooltip = new ToolTip();
         this._upgrades = BloonResearchLabUpgrades.UPGRADES;
         this._system = MonkeySystem.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         this._icons = [];
         this._upgradeTree = this._system.city.upgradeTree;
         super();
         this._clip = param1;
         this._clip.title.visible = false;
         this._iconContainer = this._clip.iconContainer;
         BloonResearchLabState.upgradeCompleteSignal.add(this.onUpgradeComplete);
         this._resourceStore.resourceStoreChangedSignal.add(this.onResourceStoreUpdate);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalReset);
      }
      
      private function onResourceStoreUpdate() : void
      {
         if(this._clip.stage)
         {
            this.syncView();
         }
      }
      
      public function buildView() : void
      {
         var _loc1_:BloonResearchLabUpgrade = null;
         var _loc2_:BloonResearchLabUpgradeIcon = null;
         this._icons.length = 0;
         while(this._iconContainer.numChildren > 0)
         {
            this._iconContainer.removeChildAt(0);
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._upgrades.length)
         {
            _loc1_ = this._upgrades[_loc3_];
            _loc2_ = new BloonResearchLabUpgradeIcon("assets.icons." + _loc1_.iconClassName);
            _loc2_.syncToUpgrade(_loc1_);
            _loc2_.clickSignal.add(this.onIconClicked);
            _loc2_.rolloverSignal.add(this.onIconRollover);
            _loc2_.rolloutSignal.add(this.onIconRollout);
            this._icons.push(_loc2_);
            this._iconContainer.addChild(_loc2_);
            _loc3_++;
         }
         var _loc4_:int = 88;
         var _loc5_:int = 81;
         var _loc6_:int = 44;
         this._icons[0].x = 0;
         this._icons[0].y = 0;
         this._icons[1].x = _loc4_;
         this._icons[1].y = 0;
         this._icons[2].x = _loc4_ * 2;
         this._icons[2].y = 0;
         this._icons[3].x = _loc4_ * 3;
         this._icons[3].y = 0;
         this._icons[4].x = _loc6_;
         this._icons[4].y = _loc5_;
         this._icons[5].x = _loc4_ + _loc6_;
         this._icons[5].y = _loc5_;
         this._icons[6].x = _loc4_ * 2 + _loc6_;
         this._icons[6].y = _loc5_;
         this._icons[7].x = 0;
         this._icons[7].y = _loc5_ * 2;
         this._icons[8].x = _loc4_;
         this._icons[8].y = _loc5_ * 2;
         this._icons[9].x = _loc4_ * 2;
         this._icons[9].y = _loc5_ * 2;
         this._icons[10].x = _loc4_ * 3;
         this._icons[10].y = _loc5_ * 2;
         this.syncView();
      }
      
      public function syncView() : void
      {
         var _loc2_:BloonResearchLabUpgradeIcon = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._icons.length)
         {
            _loc2_ = this._icons[_loc1_];
            _loc2_.update();
            if(BloonResearchLabState.isUpgrading && BloonResearchLabState.currentWarmingUpgrade != null && BloonResearchLabState.currentWarmingUpgrade.tier === _loc2_.upgrade.tier)
            {
               this.addClockToIcon(BloonResearchLabState.clock,_loc2_);
            }
            _loc1_++;
         }
         if(this._currentHoveredIcon !== null)
         {
            this.onIconRollover(this._currentHoveredIcon);
         }
      }
      
      public function on() : void
      {
         this._tooltip.activateMouseFollow();
         if(this._stage != null)
         {
            this._stage.addChild(this._tooltip);
         }
      }
      
      public function off() : void
      {
         this._tooltip.deactivateMouseFollow();
         if(this._stage != null && this._stage.contains(this._tooltip))
         {
            this._stage.removeChild(this._tooltip);
         }
      }
      
      private function onIconRollover(param1:BloonResearchLabUpgradeIcon) : void
      {
         param1.availabilityReport.update();
         this._currentHoveredIcon = param1;
         var _loc2_:* = "<span class = \"title\">" + param1.upgrade.name + "</span><br/>" + param1.upgrade.description + "<br/>";
         if(!param1.availabilityReport.isOwned)
         {
            _loc2_ = _loc2_ + param1.availabilityReport.reportDescription;
         }
         if(param1.availabilityReport.isWarmingUp)
         {
            _loc2_ = _loc2_ + "Researching...";
         }
         else if(param1.availabilityReport.available && !param1.availabilityReport.isOwned && !param1.availabilityReport.isWarmingUp)
         {
            _loc2_ = _loc2_ + "<br/>CLICK TO BUY";
         }
         else if(param1.availabilityReport.isOwned)
         {
            _loc2_ = _loc2_ + "<span class = \'green\'>Purchased</span>";
         }
         this._tooltip.message = _loc2_;
         this._tooltip.reveal();
      }
      
      private function onIconRollout(param1:BloonResearchLabUpgradeIcon) : void
      {
         this._tooltip.hide();
      }
      
      private function onIconClicked(param1:BloonResearchLabUpgradeIcon) : void
      {
         BloonResearchLabState.currentWarmingUpgrade = param1.upgrade;
         var _loc2_:BloonResearchLabUpgradeClock = BloonResearchLabState.startUpgrade(param1.upgrade);
         this.addClockToIcon(_loc2_,param1);
         param1.disableClick();
         this._resourceStore.monkeyMoney = this._resourceStore.monkeyMoney - param1.upgrade.cashCost;
         this._resourceStore.bloonstones = this._resourceStore.bloonstones - param1.upgrade.bloonstoneCost;
         this.onIconRollover(param1);
      }
      
      private function addClockToIcon(param1:BloonResearchLabUpgradeClock, param2:BloonResearchLabUpgradeIcon) : void
      {
         param1.x = 30;
         param1.y = 27;
         param2.addChild(param1);
      }
      
      private function onUpgradeComplete() : void
      {
         this.currentTier = BloonResearchLabState.currentWarmingUpgrade.tier;
         this.syncView();
      }
      
      private function onGlobalReset() : void
      {
         if(BloonResearchLabState.clock && BloonResearchLabState.clock.parent && BloonResearchLabState.clock.parent.contains(BloonResearchLabState.clock))
         {
            BloonResearchLabState.clock.parent.removeChild(BloonResearchLabState.clock);
         }
      }
      
      public function set stage(param1:Stage) : void
      {
         this._stage = param1;
         this._tooltip.stage = param1;
         this._stage.addChild(this._tooltip);
      }
      
      public function get currentTier() : int
      {
         return BloonResearchLabState.currentTier;
      }
      
      public function set currentTier(param1:int) : void
      {
         BloonResearchLabState.currentTier = param1;
      }
   }
}
