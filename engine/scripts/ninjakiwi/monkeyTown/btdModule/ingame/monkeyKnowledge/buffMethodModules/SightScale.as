package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class SightScale implements IBuffMethodModule
   {
       
      
      public function SightScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc6_:TowerDef = null;
         var _loc7_:TowerDef = null;
         var _loc8_:Number = NaN;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower(param1.buffPathID);
         if(null == _loc2_)
         {
            return;
         }
         var _loc3_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc4_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(param1.buffPathID,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = _loc4_[_loc5_];
            _loc8_ = _loc6_.rangeOfVisibility / _loc7_.rangeOfVisibility - (1 - param1.buffValue);
            _loc6_.RangeOfVisibility(_loc7_.rangeOfVisibility * _loc8_);
            _loc5_++;
         }
      }
   }
}
