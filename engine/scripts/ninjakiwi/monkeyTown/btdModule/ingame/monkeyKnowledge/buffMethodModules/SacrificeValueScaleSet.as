package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class SacrificeValueScaleSet implements IBuffMethodModule
   {
       
      
      public function SacrificeValueScaleSet()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("TempleOfTheMonkeyGod");
         _loc2_.buffs.push(param1);
      }
   }
}
