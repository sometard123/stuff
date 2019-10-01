package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.BurnEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BurnEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   
   public class BurnyStuffDurationAdd implements IBuffMethodModule
   {
       
      
      public function BurnyStuffDurationAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc4_:TowerDef = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Burny Stuff",param1.buffPathID);
         var _loc3_:BurnEffectModDef = _loc2_.add.weaponMod.projectileMod.burnEffectMod;
         _loc3_.Lifespan(_loc3_.lifespan * param1.buffValue);
         _loc4_ = Main.instance.towerFactory.getBaseTower("ArtilleryBattery");
         var _loc5_:BurnEffectDef = (_loc4_.weapons[0] as FireAtReticle).projectile.behavior.destroy["projectile"].burnEffect;
         _loc5_.Lifespan(_loc5_.lifespan + param1.buffValue);
      }
   }
}
