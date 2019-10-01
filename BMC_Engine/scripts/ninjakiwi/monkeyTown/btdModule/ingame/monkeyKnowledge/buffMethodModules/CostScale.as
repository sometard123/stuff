package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostScale implements IBuffMethodModule
   {
       
      
      public function CostScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vector.<UpgradeDef> = null;
         var _loc7_:Vector.<UpgradeDef> = null;
         var _loc8_:int = 0;
         var _loc9_:UpgradeDef = null;
         var _loc10_:UpgradeDef = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc2_:TowerPickerDef = Main.instance.towerMenuSetUnmodified.getPickerByTowerID(param1.buffPathID);
         var _loc3_:TowerPickerDef = Main.instance.towerMenuSet.getPickerByTowerID(param1.buffPathID);
         if(_loc3_ != null && _loc2_ != null)
         {
            _loc4_ = _loc3_.cost / _loc2_.cost - (1 - param1.buffValue);
            _loc5_ = BuffMethodModuleSharedFunctions.getCappedCostChange(_loc3_.cost,_loc2_.cost,_loc4_,5);
            _loc3_.Cost(_loc5_);
            _loc6_ = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
            _loc7_ = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(param1.buffPathID,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               _loc9_ = _loc6_[_loc8_];
               _loc10_ = _loc7_[_loc8_];
               _loc11_ = _loc9_.cost / _loc10_.cost - (1 - param1.buffValue);
               _loc12_ = BuffMethodModuleSharedFunctions.getCappedCostChange(_loc9_.cost,_loc10_.cost,_loc11_,5);
               _loc9_.Cost(_loc12_);
               _loc8_++;
            }
         }
      }
   }
}
