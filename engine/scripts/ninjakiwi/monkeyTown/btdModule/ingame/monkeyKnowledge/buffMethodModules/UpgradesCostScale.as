package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class UpgradesCostScale implements IBuffMethodModule
   {
       
      
      public function UpgradesCostScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:* = null;
         var _loc3_:TowerPickerDef = null;
         var _loc4_:Vector.<UpgradeDef> = null;
         var _loc5_:Vector.<UpgradeDef> = null;
         var _loc6_:int = 0;
         var _loc7_:UpgradeDef = null;
         var _loc8_:UpgradeDef = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         for(_loc2_ in Main.instance.game.gameRequest.availableTowers)
         {
            _loc3_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc2_);
            if(_loc3_ != null)
            {
               _loc4_ = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(_loc2_,Main.instance.towerFactory,Main.instance.towerMenuSet);
               _loc5_ = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(_loc2_,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length)
               {
                  _loc7_ = _loc4_[_loc6_];
                  _loc8_ = _loc5_[_loc6_];
                  _loc9_ = _loc7_.cost / _loc8_.cost - (1 - param1.buffValue);
                  _loc10_ = BuffMethodModuleSharedFunctions.getCappedCostChange(_loc7_.cost,_loc8_.cost,_loc9_,5);
                  _loc7_.Cost(_loc10_);
                  _loc6_++;
               }
               continue;
            }
         }
      }
   }
}
