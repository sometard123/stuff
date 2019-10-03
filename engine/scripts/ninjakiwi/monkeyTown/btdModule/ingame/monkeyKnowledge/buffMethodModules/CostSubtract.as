package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostSubtract implements IBuffMethodModule
   {
       
      
      public function CostSubtract()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerPickerDef = null;
         var _loc3_:Vector.<UpgradeDef> = null;
         var _loc4_:int = 0;
         var _loc5_:UpgradeDef = null;
         _loc2_ = Main.instance.towerMenuSet.getPickerByTowerID(param1.buffPathID);
         if(_loc2_ != null)
         {
            _loc2_.Cost(_loc2_.cost - param1.buffValue);
            _loc3_ = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               _loc5_.cost = _loc5_.cost - param1.buffValue;
               _loc4_++;
            }
         }
      }
   }
}
