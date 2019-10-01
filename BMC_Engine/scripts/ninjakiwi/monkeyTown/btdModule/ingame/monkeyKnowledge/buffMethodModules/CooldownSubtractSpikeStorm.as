package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class CooldownSubtractSpikeStorm implements IBuffMethodModule
   {
       
      
      public function CooldownSubtractSpikeStorm()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:AbilityDef = BuffMethodModuleSharedFunctions.getAbilityDefInTowerDefFromID("Spike Storm","SpikeStorm",Main.instance.towerFactory);
         _loc2_.cooldown = _loc2_.cooldown - param1.buffValue;
      }
   }
}
