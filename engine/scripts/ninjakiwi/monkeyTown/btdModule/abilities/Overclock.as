package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assets.effects.EngineerAura;
   import assets.effects.EngineerAura2;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.entities.TimedEffect;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasReloadTime;
   
   public class Overclock extends Ability
   {
      
      private static var overclockCombat:UpgradeDef = new UpgradeDef().Id("OverclockCombat").Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(0.5).ReloadTimeAsScale(true)));
      
      private static var overclockPierce:UpgradeDef = new UpgradeDef().Id("OverclockPierce").Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(2).PierceAsScale(true))));
      
      private static var overclockVillage:UpgradeDef = new UpgradeDef().Id("OverclockVillage").Add(new AddDef().RangeOfVisibility(1.25).RangeOfVisibilityAsScale(true));
       
      
      public function Overclock()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc3_:Tower = null;
         var _loc6_:Effect = null;
         var _loc7_:HasReloadTime = null;
         _loc3_ = param1;
         var _loc4_:UpgradeDef = overclockCombat;
         if(param1.def.weapons != null && param1.def.weapons[0] is HasReloadTime)
         {
            _loc7_ = param1.def.weapons[0] as HasReloadTime;
            if(_loc7_.reloadTime <= 1 / 30)
            {
               _loc4_ = overclockPierce;
            }
         }
         if(param1.rootID == "MonkeyVillage")
         {
            _loc4_ = overclockVillage;
         }
         new TempUpgradeInstance(param1,_loc4_,60);
         var _loc5_:TimedEffect = new TimedEffect();
         _loc5_.initialise(EngineerAura2,3,60,_loc3_);
         _loc5_.x = _loc3_.x;
         _loc5_.y = _loc3_.y;
         _loc5_.z = _loc3_.z - 0.001;
         Main.instance.game.level.addEntity(_loc5_);
         _loc6_ = new Effect();
         _loc6_.initialise(EngineerAura,3);
         _loc6_.x = _loc3_.x;
         _loc6_.y = _loc3_.y;
         Main.instance.game.level.addEntity(_loc6_);
         super.execute(param1,param2);
      }
   }
}
