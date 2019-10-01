package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class InterestRateAdd implements IBuffMethodModule
   {
       
      
      public function InterestRateAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:BananaEmitter = null;
         var _loc2_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].behavior != null)
            {
               if(_loc2_[_loc3_].behavior.roundStart != null)
               {
                  if(_loc2_[_loc3_].behavior.roundStart is BananaEmitter)
                  {
                     _loc4_ = _loc2_[_loc3_].behavior.roundStart as BananaEmitter;
                     if(_loc4_.intrestMultiplier != 0)
                     {
                        _loc4_.IntrestMultiplier(_loc4_.intrestMultiplier + param1.buffValue);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
   }
}
