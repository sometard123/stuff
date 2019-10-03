package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class LifetimeAddCallToArms implements IBuffMethodModule
   {
       
      
      public function LifetimeAddCallToArms()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("MIBCallToArms");
         _loc2_.buffs.push(param1);
      }
   }
}
