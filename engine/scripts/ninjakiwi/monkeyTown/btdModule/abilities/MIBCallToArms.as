package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LifetimeAddCallToArms;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   
   public class MIBCallToArms extends Ability
   {
      
      private static var upgrade:UpgradeDef = new UpgradeDef().Id("MIB").Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(0.5).ReloadTimeAsScale(true).ProjectileMod(new ProjectileModDef().Pierce(2).PierceAsScale(true))));
       
      
      public function MIBCallToArms()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc4_:Tower = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Buff = null;
         var _loc3_:Vector.<Tower> = param1.level.getTowersInRange(param1.x,param1.y,param1.def.rangeOfVisibility);
         for each(_loc4_ in _loc3_)
         {
            if(!(_loc4_ == param1 || _loc4_.def == null || _loc4_.def.areaEffects != null))
            {
               _loc5_ = 10;
               _loc6_ = 0;
               while(_loc6_ < param1.buffs.length)
               {
                  _loc7_ = param1.buffs[_loc6_];
                  if(_loc7_.buffMethodModuleClass == LifetimeAddCallToArms)
                  {
                     _loc5_ = _loc5_ + _loc7_.buffValue;
                  }
                  _loc6_++;
               }
               new TempUpgradeInstance(_loc4_,upgrade,_loc5_);
            }
         }
         super.execute(param1,param2);
      }
   }
}
