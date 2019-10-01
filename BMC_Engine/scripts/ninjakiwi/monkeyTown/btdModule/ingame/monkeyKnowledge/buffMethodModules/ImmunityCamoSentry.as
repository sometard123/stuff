package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class ImmunityCamoSentry implements IBuffMethodModule
   {
       
      
      public function ImmunityCamoSentry()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = null;
         var _loc4_:TowerDef = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("Sentry");
         var _loc3_:int = _loc2_.targetMask.indexOf(Bloon.IMMUNITY_NO_DETECTION);
         _loc2_.targetMask.splice(_loc3_,1);
         _loc2_.buffs.push(param1);
         _loc4_ = Main.instance.towerFactory.getBaseTower("SentrySprockets");
         var _loc5_:int = _loc4_.targetMask.indexOf(Bloon.IMMUNITY_NO_DETECTION);
         _loc4_.targetMask.splice(_loc5_,1);
         _loc4_.buffs.push(param1);
      }
   }
}
