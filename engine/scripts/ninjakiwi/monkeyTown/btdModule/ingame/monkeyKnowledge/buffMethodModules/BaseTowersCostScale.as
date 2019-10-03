package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class BaseTowersCostScale implements IBuffMethodModule
   {
       
      
      public function BaseTowersCostScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:* = null;
         var _loc3_:TowerPickerDef = null;
         var _loc4_:TowerPickerDef = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         for(_loc2_ in Main.instance.game.gameRequest.availableTowers)
         {
            _loc3_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc2_);
            _loc4_ = Main.instance.towerMenuSetUnmodified.getPickerByTowerID(_loc2_);
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_.cost / _loc4_.cost - (1 - param1.buffValue);
               _loc6_ = BuffMethodModuleSharedFunctions.getCappedCostChange(_loc3_.cost,_loc4_.cost,_loc5_,5);
               _loc3_.Cost(_loc6_);
            }
         }
      }
   }
}
