package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class BananasInRoundAdd implements IBuffMethodModule
   {
       
      
      public function BananasInRoundAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:BananaEmitter = null;
         var _loc5_:int = 0;
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
                     _loc5_ = _loc4_.cashPerRound + param1.buffValue * _loc4_.cashPerPacket;
                     _loc4_.CashPerRound(_loc5_);
                  }
               }
            }
            _loc3_++;
         }
      }
   }
}
