package ninjakiwi.monkeyTown.btdModule.towers
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   
   public class CostRoundUtil
   {
       
      
      public function CostRoundUtil()
      {
         super();
      }
      
      public static function calculateCost(param1:Object) : void
      {
         var _loc2_:TowerPickerDef = null;
         var _loc3_:UpgradePathDef = null;
         var _loc4_:UpgradeDef = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         for(_loc5_ in param1)
         {
            _loc2_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc5_);
            if(_loc2_ != null)
            {
               _loc2_.Cost(getRoundedCost(_loc2_.cost));
            }
            _loc3_ = Main.instance.towerFactory.getUpgrades(_loc5_);
            if(_loc3_ != null && _loc3_.upgrades != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc3_.upgrades.length)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc3_.upgrades[_loc6_].length)
                  {
                     _loc4_ = _loc3_.upgrades[_loc6_][_loc7_];
                     _loc4_.Cost(getRoundedCost(_loc4_.cost));
                     _loc7_++;
                  }
                  _loc6_++;
               }
               continue;
            }
         }
      }
      
      public static function getRoundedCost(param1:int) : int
      {
         var _loc2_:Number = param1 * 2 * 0.1;
         var _loc3_:Number = Math.round(_loc2_);
         return int(_loc3_ * 10 * 0.5);
      }
   }
}
