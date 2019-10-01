package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import assets.towers.Bubbles1;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class CooldownSubtractFoam implements IBuffMethodModule
   {
       
      
      public function CooldownSubtractFoam()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:SpikeSpread = null;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("CleansingFoam");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.weapons.length)
         {
            if(_loc2_.weapons[_loc3_]["projectile"] != null)
            {
               if(_loc2_.weapons[_loc3_]["projectile"]["display"] == Bubbles1)
               {
                  _loc4_ = _loc2_.weapons[_loc3_] as SpikeSpread;
                  _loc4_.ReloadTime(_loc4_.reloadTime - param1.buffValue);
               }
            }
            _loc3_++;
         }
      }
   }
}
