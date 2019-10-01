package ninjakiwi.monkeyTown.town.quests.task.upgrade
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardInfoBox;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   
   public class QuestUpgradeTier extends Quest
   {
       
      
      private var _tier:int = 0;
      
      private var _count:int = 1;
      
      private var _upgrades:Array;
      
      public function QuestUpgradeTier(param1:int = 0, param2:int = 1)
      {
         this._upgrades = new Array();
         super();
         symbolFrame = 8;
         this._tier = param1;
         this._count = param2;
         this._upgrades.push(UpgradeData.getInstance().AERO_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().AGRICULTURAL_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().BOMB_TOWER_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().BOOMERANG_THROWER_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().BUCCANEER_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().DART_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().DARTLING_GUN_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().GLUE_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().ICE_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().MORTAR_TOWER_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().NINJA_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().SNIPER_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().SPIKE_FACTORY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().SUPER_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().TACK_SHOOTER_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().WIZARD_MONKEY_UPGRADES.id);
         this._upgrades.push(UpgradeData.getInstance().ENGINEER_UPGRADES.id);
         AchieveSignal(GameSignals.UPGRADE_WARMUP_COMPLETE);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._upgrades.length)
         {
            if(MonkeySystem.getInstance().city.upgradeTree.getHighestTierLevelForUpgradesPath(new Array(this._upgrades[_loc2_]),1) >= this._tier)
            {
               _loc1_++;
            }
            if(MonkeySystem.getInstance().city.upgradeTree.getHighestTierLevelForUpgradesPath(new Array(this._upgrades[_loc2_]),2) >= this._tier)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ >= this._count)
         {
            return true;
         }
         return false;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(this.checkPreAchieved())
         {
            achieved();
         }
      }
   }
}
