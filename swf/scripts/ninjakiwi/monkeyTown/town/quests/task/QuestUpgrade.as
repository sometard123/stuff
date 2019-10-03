package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   
   public class QuestUpgrade extends Quest
   {
       
      
      protected var _upgradeData:UpgradeDefinition = null;
      
      private var _path:int = -1;
      
      private var _tier:int = -1;
      
      private var _upgradeID:String = "";
      
      public function QuestUpgrade(param1:int, param2:int, param3:String, param4:UpgradeDefinition = null)
      {
         super();
         this._path = param1;
         this._tier = param2;
         this._upgradeID = param3;
         this._upgradeData = param4;
         symbolFrame = 10;
         AchieveSignal(GameSignals.UPGRADE_WARMUP_COMPLETE);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         var _loc1_:UpgradeStateDefinition = null;
         var _loc2_:UpgradePathStateDefinition = null;
         if(this._upgradeData != null)
         {
            _loc1_ = MonkeySystem.getInstance().city.upgradeTree.getUpgradeStateDefinition(this._upgradeData.id);
            if(_loc1_ != null)
            {
               if(this._path == 1)
               {
                  _loc2_ = _loc1_.path1;
               }
               else if(this._path == 2)
               {
                  _loc2_ = _loc1_.path2;
               }
               if(_loc2_ != null)
               {
                  if(this._tier != -1 && _loc2_.aquiredTo >= this._tier)
                  {
                     return true;
                  }
               }
            }
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            if(this._path == -1 && this._tier == -1 || UpgradePathTierDefinition(rest[0]).id == this._upgradeID)
            {
               achieved();
            }
         }
      }
   }
}
