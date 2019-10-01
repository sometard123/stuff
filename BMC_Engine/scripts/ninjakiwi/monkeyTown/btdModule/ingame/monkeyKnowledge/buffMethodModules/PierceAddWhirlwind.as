package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class PierceAddWhirlwind implements IBuffMethodModule
   {
       
      
      public function PierceAddWhirlwind()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("SummonWhirlwind");
         if(null == _loc2_)
         {
            return;
         }
         _loc2_.buffs.push(param1);
      }
   }
}
