package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   
   public class SignalFlareRemoveRegenCount implements IBuffMethodModule
   {
       
      
      public function SignalFlareRemoveRegenCount()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = null;
         var _loc3_:FireAtReticle = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("SignalFlare");
         _loc3_ = _loc2_.weapons[0] as FireAtReticle;
         var _loc4_:ProjectileDef = _loc3_.projectile.behavior.destroy["projectile"];
         if(_loc4_.numOfRegenBloonsPurged < param1.buffValue)
         {
            _loc4_.NumOfRegenBloonsPurged(param1.buffValue);
         }
      }
   }
}
