package ninjakiwi.monkeyTown.btdModule.towers
{
   import assests.effects.MonkeyGodDark;
   import assets.projectile.SunBallDark;
   import assets.towers.DarkMonkeyGodHead;
   import assets.towers.DarkTempleOfTheMonkeyGod;
   import assets.upgrades.DarkSunAvatar;
   import assets.upgrades.DarkTempleoftheMonkeyGod;
   import ninjakiwi.monkeyTown.btdModule.abilities.AntiCamoDust;
   import ninjakiwi.monkeyTown.btdModule.abilities.CuddlyBear;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.Sacrifice;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   
   public class SpecialAbilityManager
   {
      
      private static var _instance:SpecialAbilityManager = null;
       
      
      private var _specialAbilities:Object;
      
      public function SpecialAbilityManager()
      {
         super();
      }
      
      public static function getInstance() : SpecialAbilityManager
      {
         if(_instance == null)
         {
            _instance = new SpecialAbilityManager();
         }
         return _instance;
      }
      
      private function reset() : void
      {
      }
      
      public function applyAbilities(param1:Object) : void
      {
         var item:Object = null;
         var towerPicker:TowerPickerDef = null;
         var tower:TowerDef = null;
         var upgradePath:UpgradePathDef = null;
         var upgrade:UpgradeDef = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var iMax:int = 0;
         var jMax:int = 0;
         var kMax:int = 0;
         var key:String = null;
         var freeCount:int = 0;
         var f:int = 0;
         var pathIndex:int = 0;
         var tierIndex:int = 0;
         var refreshTierMax:Boolean = false;
         var addValue:int = 0;
         var specialAbilities:Object = param1;
         this.reset();
         this._specialAbilities = specialAbilities;
         for(key in specialAbilities)
         {
            item = specialAbilities[key];
            towerPicker = Main.instance.towerMenuSet.getPickerByTowerID(key);
            if(towerPicker != null)
            {
               if(item["cost"] != null)
               {
                  towerPicker.Cost(int(item["cost"]));
               }
               if(item["costByPercentage"] != null)
               {
                  towerPicker.Cost(towerPicker.cost * Number(item["costByPercentage"]));
               }
               if(item["freeCount"] != null)
               {
                  freeCount = int(item["freeCount"]);
                  f = 0;
                  while(f < freeCount)
                  {
                     TowerAvailabilityManager.instance.addFreeTower(key);
                     f++;
                  }
               }
            }
            tower = Main.instance.towerFactory.getBaseTower(key);
            upgradePath = Main.instance.towerFactory.getUpgrades(key);
            if(tower != null)
            {
               if(item["attackRangeByPercentage"] != null)
               {
                  tower.RangeOfVisibility(tower.rangeOfVisibility * Number(item["attackRangeByPercentage"]));
               }
               if(item["reloadTimeByPercentage"] != null)
               {
                  if(tower.weapons != null)
                  {
                     i = 0;
                     while(i < tower.weapons.length)
                     {
                        try
                        {
                           (tower.weapons[i] as Object).reloadTime = (tower.weapons[i] as Object).reloadTime * Number(item["reloadTimeByPercentage"]);
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                  }
               }
               if(item["addPierce"] != null)
               {
                  if(tower.weapons != null)
                  {
                     i = 0;
                     while(i < tower.weapons.length)
                     {
                        try
                        {
                           if((tower.weapons[i] as Object).projectile != null)
                           {
                              (tower.weapons[i] as Object).projectile.pierce = (tower.weapons[i] as Object).projectile.pierce + Number(item["addPierce"]);
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                  }
               }
               if(item["iceEffectLifespanByPercentage"] != null)
               {
                  if(tower.weapons != null)
                  {
                     i = 0;
                     while(i < tower.weapons.length)
                     {
                        try
                        {
                           if((tower.weapons[i] as Object).projectile != null)
                           {
                              if((tower.weapons[i] as Object).projectile.iceEffect != null)
                              {
                                 (tower.weapons[i] as Object).projectile.iceEffect.lifespan = (tower.weapons[i] as Object).projectile.iceEffect.lifespan * Number(item["iceEffectLifespanByPercentage"]);
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                  }
               }
               if(item["glueEffectLifespanByPercentage"] != null)
               {
                  if(tower.weapons != null)
                  {
                     i = 0;
                     while(i < tower.weapons.length)
                     {
                        try
                        {
                           if((tower.weapons[i] as Object).projectile != null)
                           {
                              if((tower.weapons[i] as Object).projectile.glueEffect != null)
                              {
                                 (tower.weapons[i] as Object).projectile.glueEffect.lifespan = (tower.weapons[i] as Object).projectile.glueEffect.lifespan * Number(item["glueEffectLifespanByPercentage"]);
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                  }
               }
               if(item["glueEffectSpeedScale"] != null)
               {
                  if(tower.weapons != null)
                  {
                     i = 0;
                     while(i < tower.weapons.length)
                     {
                        try
                        {
                           if((tower.weapons[i] as Object).projectile != null)
                           {
                              if((tower.weapons[i] as Object).projectile.glueEffect != null)
                              {
                                 (tower.weapons[i] as Object).projectile.glueEffect.speedScale = (tower.weapons[i] as Object).projectile.glueEffect.speedScale + Number(item["glueEffectSpeedScale"]);
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                  }
               }
               if(item["dark"] != null && item["dark"] == true)
               {
                  if(tower.id == TowerFactory.TOWER_SUPER)
                  {
                     if(upgradePath != null && upgradePath.upgrades)
                     {
                        if(upgradePath.upgrades.length > 0 && upgradePath.upgrades[0].length > 3)
                        {
                           upgrade = upgradePath.upgrades[0][3];
                           upgrade.Label("Temple of the Vengeful Monkey");
                           upgrade.Description("The Temple demands sacrifice. Its arsenal of unstoppable bloon destruction is enhanced and modified by the types of tower sacrificed. Use at your own peril.");
                           upgrade.assign.Label("Temple of the Vengeful Monkey");
                           upgrade.assign.Display(DarkTempleOfTheMonkeyGod);
                           upgrade.assign.DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(DarkMonkeyGodHead)]));
                           upgrade.Thumb(DarkTempleoftheMonkeyGod);
                           upgrade.assign.Detail(DarkSunAvatar);
                           upgrade.assign.DetailSmall(DarkSunAvatar);
                           try
                           {
                              Sacrifice.plasmaDart.Display(SunBallDark);
                              Sacrifice.effectClass = MonkeyGodDark;
                           }
                           catch(e:Error)
                           {
                           }
                        }
                     }
                  }
               }
               if(upgradePath != null && upgradePath.upgrades && item["upgrade"] != null)
               {
                  pathIndex = 0;
                  tierIndex = 0;
                  refreshTierMax = false;
                  if(item["upgrade"]["path"] != null && item["upgrade"]["tier"] != null)
                  {
                     pathIndex = int(item["upgrade"]["path"]) - 1;
                     tierIndex = int(item["upgrade"]["tier"]) - 1;
                     if(pathIndex >= 0 && pathIndex < upgradePath.upgrades.length && tierIndex >= 0 && tierIndex < upgradePath.upgrades[pathIndex].length)
                     {
                        iMax = pathIndex + 1;
                        jMax = tierIndex + 1;
                     }
                     else
                     {
                        pathIndex = tierIndex = iMax = jMax = 0;
                     }
                  }
                  else
                  {
                     iMax = upgradePath.upgrades.length;
                     refreshTierMax = true;
                  }
                  i = pathIndex;
                  while(i < iMax)
                  {
                     if(refreshTierMax)
                     {
                        jMax = upgradePath.upgrades[i].length;
                     }
                     j = tierIndex;
                     while(j < jMax)
                     {
                        upgrade = upgradePath.upgrades[i][j];
                        if(upgrade != null)
                        {
                           if(item["upgrade"]["extraAttackRangeByPercentage"] != null)
                           {
                              addValue = tower.rangeOfVisibility * Number(item["upgrade"]["extraAttackRangeByPercentage"]);
                              if(upgrade.add != null)
                              {
                                 upgrade.add.RangeOfVisibility(upgrade.add.rangeOfVisibility + addValue);
                              }
                           }
                           if(item["upgrade"]["iceEffectLifespanByPercentage"] != null)
                           {
                              if(upgrade.add != null)
                              {
                                 if(upgrade.add.weaponMod != null)
                                 {
                                    if(upgrade.add.weaponMod.projectileMod != null)
                                    {
                                       if(upgrade.add.weaponMod.projectileMod.iceEffectMod != null)
                                       {
                                          upgrade.add.weaponMod.projectileMod.iceEffectMod.lifespan = upgrade.add.weaponMod.projectileMod.iceEffectMod.lifespan * Number(item["upgrade"]["iceEffectLifespanByPercentage"]);
                                       }
                                    }
                                 }
                              }
                           }
                           if(item["upgrade"]["reloadTimeByPercentage"] != null)
                           {
                              if(upgrade.add != null)
                              {
                                 if(upgrade.add.weaponMod != null)
                                 {
                                    upgrade.add.weaponMod.reloadTime = upgrade.add.weaponMod.reloadTime + Number(item["upgrade"]["reloadTimeByPercentage"]);
                                 }
                              }
                           }
                           if(item["upgrade"]["costByPercentage"] != null)
                           {
                              upgrade.cost = upgrade.cost * Number(item["upgrade"]["costByPercentage"]);
                           }
                        }
                        j++;
                     }
                     i++;
                  }
               }
            }
            if(key === "CuddlyBear")
            {
               CuddlyBear.add();
            }
            if(key === "AntiCamoDust")
            {
               AntiCamoDust.add();
            }
         }
      }
   }
}
