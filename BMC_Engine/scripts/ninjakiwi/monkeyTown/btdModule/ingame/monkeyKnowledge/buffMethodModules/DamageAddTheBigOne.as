package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   
   public class DamageAddTheBigOne implements IBuffMethodModule
   {
       
      
      public function DamageAddTheBigOne()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:FireAtReticle = null;
         var _loc3_:ProjectileDef = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("TheBigOne").weapons[0] as FireAtReticle;
         _loc3_ = _loc2_.projectile;
         var _loc4_:ProjectileDef = _loc3_.behavior.destroy["projectile"];
         _loc4_.damageEffect.damage = _loc4_.damageEffect.damage + param1.buffValue;
      }
   }
}
