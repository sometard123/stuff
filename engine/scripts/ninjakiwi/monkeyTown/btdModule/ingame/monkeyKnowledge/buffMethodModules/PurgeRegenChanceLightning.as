package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class PurgeRegenChanceLightning implements IBuffMethodModule
   {
       
      
      public function PurgeRegenChanceLightning()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower(param1.buffPathID);
         if(null == _loc2_)
         {
            return;
         }
         var _loc3_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTower(_loc2_,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_].buffs.push(param1);
            _loc4_++;
         }
      }
   }
}
