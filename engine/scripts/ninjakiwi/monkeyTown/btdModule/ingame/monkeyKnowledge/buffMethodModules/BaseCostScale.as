package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class BaseCostScale implements IBuffMethodModule
   {
       
      
      public function BaseCostScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:TowerPickerDef = Main.instance.towerMenuSet.getPickerByTowerID(param1.buffPathID);
         var _loc3_:TowerPickerDef = Main.instance.towerMenuSetUnmodified.getPickerByTowerID(param1.buffPathID);
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.cost / _loc3_.cost - (1 - param1.buffValue);
            _loc5_ = BuffMethodModuleSharedFunctions.getCappedCostChange(_loc2_.cost,_loc3_.cost,_loc4_,5);
            _loc2_.Cost(_loc5_);
         }
      }
   }
}
