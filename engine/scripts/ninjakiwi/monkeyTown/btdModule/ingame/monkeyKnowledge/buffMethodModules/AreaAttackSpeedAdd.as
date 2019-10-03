package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   
   public class AreaAttackSpeedAdd implements IBuffMethodModule
   {
       
      
      public function AreaAttackSpeedAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:AreaEffectDef = null;
         var _loc5_:* = null;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("EnergyBeacon");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.areaEffects.length)
         {
            _loc4_ = _loc2_.areaEffects[_loc3_];
            if(_loc4_.upgrade != null)
            {
               if(_loc4_.upgrade.add != null)
               {
                  if(_loc4_.upgrade.add.weaponMod != null)
                  {
                     _loc5_ = _loc4_.upgrade.add.weaponMod;
                     if(_loc4_.upgrade.add.weaponMod.reloadTime != 0)
                     {
                        _loc5_.ReloadTime(_loc5_.reloadTime - param1.buffValue);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
   }
}
