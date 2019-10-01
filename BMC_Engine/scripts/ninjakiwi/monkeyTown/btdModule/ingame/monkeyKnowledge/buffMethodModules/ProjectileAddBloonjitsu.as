package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class ProjectileAddBloonjitsu implements IBuffMethodModule
   {
       
      
      public function ProjectileAddBloonjitsu()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         Main.instance.towerFactory.getBaseTower("Bloonjitsu").buffs.push(param1);
      }
   }
}
