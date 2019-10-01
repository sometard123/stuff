package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileModDef;
   
   public class AreaPopCashScaleAdd implements IBuffMethodModule
   {
       
      
      public function AreaPopCashScaleAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:AreaEffectDef = null;
         var _loc5_:AddDef = null;
         var _loc6_:ProjectileModDef = null;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("EnergyBeacon");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.areaEffects.length)
         {
            _loc4_ = _loc2_.areaEffects[_loc3_];
            if(_loc4_.upgrade != null)
            {
               if(_loc4_.upgrade.add != null)
               {
                  _loc5_ = _loc4_.upgrade.add;
                  if(_loc5_.weaponMod != null)
                  {
                     _loc6_ = _loc5_.weaponMod.projectileMod;
                     if(_loc6_ != null)
                     {
                        if(_loc6_.popCashScale != 0)
                        {
                           _loc6_.PopCashScale(_loc6_.popCashScale + param1.buffValue);
                        }
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
   }
}
