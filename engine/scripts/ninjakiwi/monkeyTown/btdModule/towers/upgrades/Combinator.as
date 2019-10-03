package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import assets.projectile.FragShard;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.BehaviorCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.CollisionSpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.SpawnSpreadCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.BehaviorDestroy;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.BurnEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.StunEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.WindEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.BloonchipperStore;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDisplayMod;
   import ninjakiwi.monkeyTown.btdModule.utils.ObjectHelper;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasChildWeapons;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasPower;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasProjectile;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasRange;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasReloadTime;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.LaunchAircraft;
   import ninjakiwi.monkeyTown.btdModule.weapons.Spread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class Combinator
   {
      
      public static var cache:Vector.<Cache> = new Vector.<Cache>();
       
      
      public function Combinator()
      {
         super();
      }
      
      public static function areUpgradesEqual(param1:Vector.<UpgradeDef>, param2:Vector.<UpgradeDef>) : Boolean
      {
         var _loc3_:UpgradeDef = null;
         if(param1.length != param2.length)
         {
            return false;
         }
         for each(_loc3_ in param1)
         {
            if(param2.indexOf(_loc3_) == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function detailLevel(param1:String, param2:Class) : int
      {
         var _loc5_:Vector.<UpgradeDef> = null;
         var _loc6_:int = 0;
         var _loc7_:UpgradeDef = null;
         var _loc3_:Vector.<Vector.<UpgradeDef>> = Main.instance.towerFactory.getUpgrades(param1).upgrades;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc6_];
               if(_loc7_.add && _loc7_.add.detail == param2)
               {
                  return _loc6_ + 1;
               }
               if(_loc7_.assign && _loc7_.assign.detail == param2)
               {
                  return _loc6_ + 1;
               }
               _loc6_++;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public static function combine(param1:TowerDef, param2:Vector.<UpgradeDef>) : TowerDef
      {
         var _loc4_:UpgradeDef = null;
         var _loc5_:Vector.<UpgradeDef> = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:Cache = null;
         var _loc10_:TowerDef = null;
         var _loc11_:UpgradeDef = null;
         var _loc12_:Boolean = false;
         var _loc13_:UpgradeDef = null;
         var _loc14_:UpgradeDef = null;
         var _loc15_:UpgradeDef = null;
         var _loc16_:AddDef = null;
         var _loc17_:Weapon = null;
         var _loc18_:WeaponReplaceDef = null;
         var _loc19_:Weapon = null;
         var _loc20_:Weapon = null;
         var _loc21_:SwapForProjectile = null;
         var _loc22_:TowerDisplayMod = null;
         var _loc23_:BananaEmitter = null;
         var _loc24_:BloonchipperStore = null;
         var _loc25_:DeployMonkeyAce = null;
         var _loc26_:TowerDisplayMod = null;
         var _loc27_:DisplayAddonDef = null;
         var _loc28_:TowerDisplayMod = null;
         var _loc29_:AreaEffectDef = null;
         var _loc30_:AbilityDef = null;
         var _loc31_:AbilityModDef = null;
         var _loc32_:AbilityDef = null;
         var _loc33_:WeaponModDef = null;
         var _loc34_:Vector.<Weapon> = null;
         var _loc35_:LaunchAircraft = null;
         var _loc36_:HasRange = null;
         var _loc37_:HasReloadTime = null;
         var _loc38_:HasPower = null;
         var _loc39_:HasSpread = null;
         var _loc40_:Spread = null;
         var _loc41_:HasChildWeapons = null;
         var _loc42_:Weapon = null;
         var _loc43_:Vector.<ProjectileDef> = null;
         var _loc44_:HasProjectile = null;
         var _loc45_:HasChildWeapons = null;
         var _loc46_:ProjectileDef = null;
         var _loc47_:SpawnProjectile = null;
         var _loc48_:CollisionSpawnProjectile = null;
         var _loc49_:SpawnSpreadCollision = null;
         var _loc50_:SpawnProjectile = null;
         var _loc51_:HasProjectile = null;
         var _loc52_:HasProjectile = null;
         var _loc53_:ProjectileBehaviorModDef = null;
         var _loc54_:ProjectileDisplayMod = null;
         var _loc55_:SpawnProjectile = null;
         var _loc56_:Boolean = false;
         var _loc57_:SpawnSpreadCollision = null;
         var _loc58_:int = 0;
         var _loc59_:int = 0;
         var _loc3_:Vector.<UpgradeDef> = new Vector.<UpgradeDef>();
         for each(_loc4_ in param2)
         {
            _loc12_ = true;
            for each(_loc13_ in _loc3_)
            {
               if(_loc13_.id != null && _loc13_.id == _loc4_.id)
               {
                  _loc12_ = false;
                  break;
               }
            }
            if(_loc12_)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc5_ = new Vector.<UpgradeDef>();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.id != null && _loc4_.id.indexOf("Specialty") != -1)
            {
               _loc5_.push(_loc4_);
            }
         }
         for each(_loc4_ in _loc5_)
         {
            _loc3_.splice(_loc3_.indexOf(_loc4_),1);
         }
         _loc3_ = _loc3_.concat(_loc5_);
         _loc6_ = false;
         _loc7_ = false;
         _loc8_ = 0;
         while(_loc8_ < _loc3_.length)
         {
            if(_loc6_ == false && _loc3_[_loc8_].id == "OverclockCombat")
            {
               _loc14_ = _loc3_[_loc8_];
               _loc3_.splice(_loc8_,1);
               _loc3_.push(_loc14_);
               _loc6_ = true;
            }
            if(_loc7_ == false && _loc3_[_loc8_].id == "MonkeyBoost")
            {
               _loc15_ = _loc3_[_loc8_];
               _loc3_.splice(_loc8_,1);
               _loc3_.push(_loc15_);
               _loc7_ = true;
            }
            _loc8_++;
         }
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return param1;
         }
         for each(_loc9_ in cache)
         {
            if(_loc9_.tower != param1)
            {
               continue;
            }
            if(!areUpgradesEqual(_loc3_,_loc9_.upgrades))
            {
               continue;
            }
            return _loc9_.result;
         }
         _loc10_ = ObjectHelper.clone(param1) as TowerDef;
         for each(_loc11_ in _loc3_)
         {
            _loc16_ = _loc11_.add;
            if(_loc16_ != null)
            {
               if(_loc16_.weapons)
               {
                  for each(_loc17_ in _loc16_.weapons)
                  {
                     if(_loc10_.weapons == null)
                     {
                        _loc10_.weapons = new Vector.<Weapon>();
                     }
                     _loc10_.weapons.push(ObjectHelper.clone(_loc17_));
                  }
               }
               if(_loc16_.replaceWeapons)
               {
                  for each(_loc18_ in _loc16_.replaceWeapons)
                  {
                     for each(_loc19_ in _loc10_.weapons)
                     {
                        if(_loc18_.replaceWeaponID == _loc19_.id)
                        {
                           _loc20_ = ObjectHelper.clone(_loc18_.withWeapon) as Weapon;
                           _loc10_.weapons.splice(_loc10_.weapons.indexOf(_loc19_),1,_loc20_);
                        }
                     }
                  }
               }
            }
         }
         for each(_loc11_ in _loc3_)
         {
            _loc16_ = _loc11_.add;
            if(_loc16_ != null)
            {
               if(_loc10_ != null)
               {
                  if(_loc10_.behavior != null && _loc10_.behavior.roundStart != null && _loc16_.weaponMod != null && _loc16_.weaponMod.projectileMod != null)
                  {
                     _loc21_ = _loc10_.behavior.roundStart as SwapForProjectile;
                     if(_loc21_ != null)
                     {
                        if(!_loc16_.weaponMod.projectileMod.pierceAsScale)
                        {
                           _loc21_.projectile.pierce = _loc21_.projectile.pierce + _loc16_.weaponMod.projectileMod.pierce;
                        }
                        else
                        {
                           _loc21_.projectile.pierce = _loc21_.projectile.pierce * _loc16_.weaponMod.projectileMod.pierce;
                        }
                     }
                  }
                  if(_loc16_.detail != null)
                  {
                     if(detailLevel(param1.id,_loc16_.detail) >= detailLevel(param1.id,_loc10_.detail))
                     {
                        _loc10_.detail = _loc16_.detail;
                     }
                     if(_loc16_.detailSmall != null)
                     {
                        if(detailLevel(param1.id,_loc16_.detail) >= detailLevel(param1.id,_loc10_.detail))
                        {
                           _loc10_.detailSmall = _loc16_.detailSmall;
                        }
                     }
                  }
                  if(!_loc16_.rangeOfVisibilityAsScale)
                  {
                     _loc10_.rangeOfVisibility = _loc10_.rangeOfVisibility + _loc16_.rangeOfVisibility;
                  }
                  else
                  {
                     _loc10_.rangeOfVisibility = _loc10_.rangeOfVisibility * _loc16_.rangeOfVisibility;
                  }
                  if(_loc16_.display != null)
                  {
                     for each(_loc22_ in _loc16_.display)
                     {
                        if(_loc22_.useFor == _loc10_.display)
                        {
                           _loc10_.display = _loc22_.display;
                           if(_loc22_.weaponOffsets != null)
                           {
                              _loc10_.weaponOffsets = _loc22_.weaponOffsets;
                           }
                        }
                     }
                  }
                  if(_loc16_.behavior != null)
                  {
                     if(_loc16_.behavior.behaviorSet)
                     {
                        if(_loc10_.behavior == null)
                        {
                           _loc10_.behavior = new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef();
                        }
                        if(_loc16_.behavior.behaviorSet.process)
                        {
                           _loc10_.behavior.process = _loc16_.behavior.behaviorSet.process;
                        }
                        if(_loc16_.behavior.behaviorSet.initialise)
                        {
                           _loc10_.behavior.initialise = _loc16_.behavior.behaviorSet.initialise;
                        }
                        if(_loc16_.behavior.behaviorSet.roundStart)
                        {
                           _loc10_.behavior.roundStart = _loc16_.behavior.behaviorSet.roundStart;
                        }
                        if(_loc16_.behavior.behaviorSet.roundOver)
                        {
                           _loc10_.behavior.roundOver = _loc16_.behavior.behaviorSet.roundOver;
                        }
                        if(_loc16_.behavior.behaviorSet.destroy)
                        {
                           _loc10_.behavior.destroy = _loc16_.behavior.behaviorSet.destroy;
                        }
                     }
                     if(_loc16_.behavior.bananaMod && _loc10_.behavior && _loc10_.behavior.roundStart is BananaEmitter)
                     {
                        _loc23_ = _loc10_.behavior.roundStart as BananaEmitter;
                        _loc23_.cashPerPacket = _loc23_.cashPerPacket + _loc16_.behavior.bananaMod.cashPerPacket;
                        _loc23_.cashPerRound = _loc23_.cashPerRound + _loc16_.behavior.bananaMod.cashPerRound;
                        _loc23_.lifespan = _loc23_.lifespan + _loc16_.behavior.bananaMod.lifespan;
                        _loc23_.cashScale = _loc23_.cashScale + _loc16_.behavior.bananaMod.cashScale;
                     }
                     if(_loc16_.behavior.bloonchipperStoreMod && _loc10_.behavior && _loc10_.behavior.process is BloonchipperStore)
                     {
                        _loc24_ = _loc10_.behavior.process as BloonchipperStore;
                        _loc24_.chipTime = _loc24_.chipTime + _loc16_.behavior.bloonchipperStoreMod.chipTime;
                     }
                     if(_loc16_.behavior.display && _loc10_.behavior && _loc10_.behavior.roundStart is DeployMonkeyAce)
                     {
                        _loc25_ = _loc10_.behavior.roundStart as DeployMonkeyAce;
                        for each(_loc26_ in _loc16_.behavior.display)
                        {
                           if(_loc26_.useFor == _loc25_.display)
                           {
                              _loc25_.display = _loc26_.display;
                           }
                        }
                     }
                  }
                  if(_loc16_.displayAddons)
                  {
                     if(_loc10_.displayAddons == null)
                     {
                        _loc10_.displayAddons = new Vector.<DisplayAddonDef>();
                     }
                     for each(_loc27_ in _loc16_.displayAddons)
                     {
                        _loc10_.displayAddons.push(_loc27_);
                     }
                  }
                  if(_loc16_.displayAddonMods)
                  {
                     for each(_loc28_ in _loc16_.displayAddonMods)
                     {
                        for each(_loc27_ in _loc10_.displayAddons)
                        {
                           if(_loc27_.clip == _loc28_.useFor)
                           {
                              _loc27_.clip = _loc28_.display;
                           }
                        }
                     }
                  }
                  if(_loc16_.removeFromTargetMask != null && _loc10_.targetMask != null)
                  {
                     for each(_loc58_ in _loc16_.removeFromTargetMask)
                     {
                        _loc59_ = _loc10_.targetMask.indexOf(_loc58_);
                        if(_loc59_ != -1)
                        {
                           _loc10_.targetMask.splice(_loc59_,1);
                        }
                     }
                  }
                  if(_loc16_.areaEffects)
                  {
                     if(_loc10_.areaEffects == null)
                     {
                        _loc10_.areaEffects = new Vector.<AreaEffectDef>();
                     }
                     for each(_loc29_ in _loc16_.areaEffects)
                     {
                        _loc10_.areaEffects.push(_loc29_);
                     }
                  }
                  if(_loc16_.abilities)
                  {
                     if(_loc10_.abilities == null)
                     {
                        _loc10_.abilities = new Vector.<AbilityDef>();
                     }
                     for each(_loc30_ in _loc16_.abilities)
                     {
                        _loc10_.abilities.push(ObjectHelper.clone(_loc30_));
                     }
                  }
                  if(_loc16_.abilityMod)
                  {
                     _loc31_ = _loc16_.abilityMod;
                     for each(_loc32_ in _loc10_.abilities)
                     {
                        if(!_loc31_.cooldownAsScale)
                        {
                           _loc32_.cooldown = _loc32_.cooldown + _loc31_.cooldown;
                        }
                        else
                        {
                           _loc32_.cooldown = _loc32_.cooldown * _loc31_.cooldown;
                        }
                     }
                  }
                  if(_loc16_.weaponMod)
                  {
                     _loc33_ = _loc16_.weaponMod;
                     _loc34_ = null;
                     if(_loc10_.weapons == null)
                     {
                        _loc34_ = new Vector.<Weapon>();
                     }
                     else
                     {
                        _loc34_ = _loc10_.weapons.concat();
                     }
                     for each(_loc17_ in _loc34_)
                     {
                        _loc35_ = _loc17_ as LaunchAircraft;
                        if(_loc35_ != null)
                        {
                           _loc34_ = _loc34_.concat(_loc35_.aircraftWeapon);
                        }
                     }
                     for each(_loc17_ in _loc34_)
                     {
                        if(!(_loc33_.specific != null && _loc33_.specific != _loc17_.id))
                        {
                           _loc36_ = _loc17_ as HasRange;
                           if(_loc36_)
                           {
                              if(!_loc33_.rangeAsScale)
                              {
                                 _loc36_.range = _loc36_.range + _loc33_.range;
                              }
                              else
                              {
                                 _loc36_.range = _loc36_.range * _loc33_.range;
                              }
                           }
                           _loc37_ = _loc17_ as HasReloadTime;
                           if(_loc37_)
                           {
                              if(!_loc33_.reloadTimeAsScale)
                              {
                                 _loc37_.reloadTime = _loc37_.reloadTime + _loc33_.reloadTime;
                                 if(_loc37_.reloadTime < 1 / 30)
                                 {
                                    _loc37_.reloadTime = 1 / 30;
                                 }
                              }
                              else
                              {
                                 _loc37_.reloadTime = _loc37_.reloadTime * _loc33_.reloadTime;
                                 if(_loc37_.reloadTime < 1 / 30)
                                 {
                                    _loc37_.reloadTime = 1 / 30;
                                 }
                              }
                           }
                           _loc38_ = _loc17_ as HasPower;
                           if(_loc38_)
                           {
                              _loc38_.power = _loc38_.power + _loc33_.power;
                           }
                           _loc39_ = _loc17_ as HasSpread;
                           if(_loc39_)
                           {
                              _loc39_.spread = _loc39_.spread + _loc33_.spread;
                           }
                           _loc40_ = _loc17_ as Spread;
                           if(_loc40_)
                           {
                              _loc40_.count = _loc40_.count + _loc33_.count;
                           }
                           if(_loc33_.addChild)
                           {
                              _loc41_ = _loc17_ as HasChildWeapons;
                              if(_loc41_)
                              {
                                 if(_loc41_.childWeapons == null)
                                 {
                                    _loc41_.childWeapons = new Vector.<Weapon>();
                                 }
                                 _loc41_.childWeapons.push(_loc33_.addChild);
                              }
                           }
                           if(_loc33_.removeChild != null)
                           {
                              _loc41_ = _loc17_ as HasChildWeapons;
                              if(_loc41_ && _loc41_.childWeapons != null)
                              {
                                 for each(_loc42_ in _loc41_.childWeapons)
                                 {
                                    if(_loc33_.removeChild.id == _loc42_.id)
                                    {
                                       _loc41_.childWeapons.splice(_loc41_.childWeapons.indexOf(_loc42_),1);
                                       break;
                                    }
                                 }
                              }
                           }
                           if(_loc33_.projectileMod)
                           {
                              _loc43_ = new Vector.<ProjectileDef>();
                              _loc44_ = _loc17_ as HasProjectile;
                              if(_loc44_ && _loc44_.projectile)
                              {
                                 _loc43_.push(_loc44_.projectile);
                                 if(_loc44_.projectile.behavior && _loc44_.projectile.behavior.destroy)
                                 {
                                    _loc47_ = _loc44_.projectile.behavior.destroy as SpawnProjectile;
                                    if(_loc47_ && _loc47_.projectile)
                                    {
                                       _loc43_.push(_loc47_.projectile);
                                    }
                                 }
                                 if(_loc44_.projectile.behavior && _loc44_.projectile.behavior.collision)
                                 {
                                    _loc48_ = _loc44_.projectile.behavior.collision as CollisionSpawnProjectile;
                                    if(_loc48_ && _loc48_.projectile)
                                    {
                                       _loc43_.push(_loc48_.projectile);
                                       if(_loc48_.next)
                                       {
                                          _loc49_ = _loc48_.next as SpawnSpreadCollision;
                                          if(_loc49_)
                                          {
                                             _loc43_.push(_loc49_.projectile);
                                             if(_loc49_.projectile.behavior && _loc49_.projectile.behavior.destroy)
                                             {
                                                _loc50_ = _loc49_.projectile.behavior.destroy as SpawnProjectile;
                                                if(_loc50_)
                                                {
                                                   _loc43_.push(_loc50_.projectile);
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                              _loc45_ = _loc17_ as HasChildWeapons;
                              if(_loc45_)
                              {
                                 for each(_loc51_ in _loc45_.childWeapons)
                                 {
                                    _loc52_ = _loc51_ as HasProjectile;
                                    if(_loc52_ != null)
                                    {
                                       _loc43_.push(_loc52_.projectile);
                                       if(_loc52_.projectile.behavior && _loc52_.projectile.behavior.destroy)
                                       {
                                          _loc47_ = _loc52_.projectile.behavior.destroy as SpawnProjectile;
                                          if(_loc47_ && _loc47_.projectile)
                                          {
                                             _loc43_.push(_loc47_.projectile);
                                          }
                                       }
                                       if(_loc52_.projectile.behavior && _loc52_.projectile.behavior.collision)
                                       {
                                          _loc48_ = _loc52_.projectile.behavior.collision as CollisionSpawnProjectile;
                                          if(_loc48_ && _loc48_.projectile)
                                          {
                                             _loc43_.push(_loc48_.projectile);
                                          }
                                       }
                                    }
                                 }
                              }
                              for each(_loc46_ in _loc43_)
                              {
                                 if(_loc46_ != null)
                                 {
                                    if(!_loc33_.projectileMod.pierceAsScale)
                                    {
                                       _loc46_.pierce = _loc46_.pierce + _loc33_.projectileMod.pierce;
                                    }
                                    else
                                    {
                                       _loc46_.pierce = _loc46_.pierce * _loc33_.projectileMod.pierce;
                                    }
                                    _loc46_.radius = _loc46_.radius + _loc33_.projectileMod.radius;
                                    if(_loc33_.projectileMod.display != null)
                                    {
                                       for each(_loc54_ in _loc33_.projectileMod.display)
                                       {
                                          if(_loc54_.useFor == _loc46_.display)
                                          {
                                             _loc46_.display = _loc54_.display;
                                             _loc46_.additiveBlend = _loc54_.additiveBlend;
                                          }
                                       }
                                    }
                                    if(_loc46_.behavior && _loc46_.behavior.destroy)
                                    {
                                       _loc47_ = _loc46_.behavior.destroy as SpawnProjectile;
                                       if(_loc47_ && _loc47_.projectile && _loc47_.projectile.display != null)
                                       {
                                          for each(_loc54_ in _loc33_.projectileMod.display)
                                          {
                                             if(_loc54_.useFor == _loc47_.projectile.display)
                                             {
                                                _loc47_.projectile.display = _loc54_.display;
                                             }
                                          }
                                       }
                                    }
                                    if(_loc33_.projectileMod.popCashScale)
                                    {
                                       _loc46_.popCashScale = _loc46_.popCashScale + _loc33_.projectileMod.popCashScale;
                                    }
                                    _loc53_ = _loc33_.projectileMod.behaviorMod;
                                    if(_loc53_)
                                    {
                                       if(_loc53_.setProcess)
                                       {
                                          if(!_loc46_.behavior)
                                          {
                                             _loc46_.behavior = new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef();
                                          }
                                          _loc46_.behavior.process = _loc53_.setProcess;
                                       }
                                       if(_loc53_.addDestroy)
                                       {
                                          if(_loc46_.behavior && _loc46_.behavior.destroy)
                                          {
                                             _loc46_.behavior.destroy.next = ObjectHelper.clone(_loc53_.addDestroy) as BehaviorDestroy;
                                          }
                                          else
                                          {
                                             if(!_loc46_.behavior)
                                             {
                                                _loc46_.behavior = new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef();
                                             }
                                             _loc46_.behavior.destroy = ObjectHelper.clone(_loc53_.addDestroy) as BehaviorDestroy;
                                             _loc55_ = _loc46_.behavior.destroy as SpawnProjectile;
                                             if(_loc55_)
                                             {
                                                if(_loc46_.glueEffect && _loc46_.glueEffect.soak)
                                                {
                                                   if(_loc55_.projectile.glueEffect == null)
                                                   {
                                                      _loc55_.projectile.glueEffect = new GlueEffectDef();
                                                   }
                                                   _loc55_.projectile.glueEffect.soak = _loc46_.glueEffect.soak;
                                                   _loc55_.projectile.glueEffect.corosionInterval = _loc46_.glueEffect.corosionInterval;
                                                   _loc46_.glueEffect.lifespan = _loc46_.glueEffect.lifespan;
                                                }
                                             }
                                          }
                                       }
                                       if(_loc53_.addCollision)
                                       {
                                          if(_loc46_.behavior && _loc46_.behavior.collision)
                                          {
                                             _loc46_.behavior.collision.next = ObjectHelper.clone(_loc53_.addCollision) as BehaviorCollision;
                                          }
                                          else
                                          {
                                             _loc56_ = true;
                                             _loc57_ = _loc53_.addCollision as SpawnSpreadCollision;
                                             if(_loc57_ && _loc57_.projectile.display == FragShard)
                                             {
                                                _loc56_ = false;
                                             }
                                             if(_loc56_)
                                             {
                                                if(!_loc46_.behavior)
                                                {
                                                   _loc46_.behavior = new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef();
                                                }
                                                _loc46_.behavior.collision = ObjectHelper.clone(_loc53_.addCollision) as BehaviorCollision;
                                                _loc55_ = _loc46_.behavior.collision as SpawnProjectile;
                                                if(_loc55_)
                                                {
                                                   if(_loc46_.glueEffect && _loc46_.glueEffect.soak)
                                                   {
                                                      if(_loc55_.projectile.glueEffect == null)
                                                      {
                                                         _loc55_.projectile.glueEffect = new GlueEffectDef();
                                                      }
                                                      _loc55_.projectile.glueEffect.soak = _loc46_.glueEffect.soak;
                                                      _loc55_.projectile.glueEffect.corosionInterval = _loc46_.glueEffect.corosionInterval;
                                                      _loc46_.glueEffect.lifespan = _loc46_.glueEffect.lifespan;
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                    if(_loc33_.projectileMod.iceEffectMod)
                                    {
                                       if(!_loc33_.projectileMod.iceEffectMod.lifespanAsScale)
                                       {
                                          _loc46_.iceEffect.lifespan = _loc46_.iceEffect.lifespan + _loc33_.projectileMod.iceEffectMod.lifespan;
                                       }
                                       else
                                       {
                                          _loc46_.iceEffect.lifespan = _loc46_.iceEffect.lifespan * _loc33_.projectileMod.iceEffectMod.lifespan;
                                       }
                                       _loc46_.iceEffect.freezeLayers = _loc46_.iceEffect.freezeLayers + _loc33_.projectileMod.iceEffectMod.freezeLayers;
                                       _loc46_.iceEffect.permafrost = _loc46_.iceEffect.permafrost + _loc33_.projectileMod.iceEffectMod.permafrost;
                                    }
                                    if(_loc33_.projectileMod.glueEffectMod)
                                    {
                                       if(_loc33_.projectileMod.glueEffectMod.soak)
                                       {
                                          _loc46_.glueEffect.soak = _loc33_.projectileMod.glueEffectMod.soak;
                                       }
                                       _loc46_.glueEffect.corosionInterval = _loc46_.glueEffect.corosionInterval + _loc33_.projectileMod.glueEffectMod.corosionInterval;
                                       _loc46_.glueEffect.lifespan = _loc46_.glueEffect.lifespan + _loc33_.projectileMod.glueEffectMod.lifespan;
                                       if(_loc33_.projectileMod.glueEffectMod.speedScaleAsScale)
                                       {
                                          _loc46_.glueEffect.speedScale = _loc46_.glueEffect.speedScale * _loc33_.projectileMod.glueEffectMod.speedScale;
                                       }
                                       else
                                       {
                                          _loc46_.glueEffect.speedScale = _loc46_.glueEffect.speedScale + _loc33_.projectileMod.glueEffectMod.speedScale;
                                       }
                                    }
                                    if(_loc33_.projectileMod.stunEffectMod)
                                    {
                                       if(_loc46_.stunEffect == null)
                                       {
                                          _loc46_.stunEffect = new StunEffectDef();
                                       }
                                       if(_loc33_.projectileMod.stunEffectMod.lifespanAsScale)
                                       {
                                          _loc46_.stunEffect.lifespan = _loc46_.stunEffect.lifespan * _loc33_.projectileMod.stunEffectMod.lifespan;
                                       }
                                       else
                                       {
                                          _loc46_.stunEffect.lifespan = _loc46_.stunEffect.lifespan + _loc33_.projectileMod.stunEffectMod.lifespan;
                                       }
                                       _loc46_.stunEffect.cantEffect = _loc33_.projectileMod.stunEffectMod.cantEffect;
                                    }
                                    if(_loc33_.projectileMod.burnEffectMod)
                                    {
                                       if(_loc46_.burnEffect == null)
                                       {
                                          _loc46_.burnEffect = new BurnEffectDef();
                                       }
                                       _loc46_.burnEffect.lifespan = _loc46_.burnEffect.lifespan + _loc33_.projectileMod.burnEffectMod.lifespan;
                                       _loc46_.burnEffect.burnInterval = _loc46_.burnEffect.burnInterval + _loc33_.projectileMod.burnEffectMod.burnInterval;
                                    }
                                    if(_loc33_.projectileMod.windeffectMod)
                                    {
                                       if(_loc46_.windEffect == null)
                                       {
                                          _loc46_.windEffect = new WindEffectDef();
                                       }
                                       _loc46_.windEffect.chance = _loc46_.windEffect.chance + _loc33_.projectileMod.windeffectMod.chance;
                                    }
                                    if(_loc33_.projectileMod.removeFromEffectMask != null && _loc46_.effectMask != null)
                                    {
                                       for each(_loc58_ in _loc33_.projectileMod.removeFromEffectMask)
                                       {
                                          _loc59_ = _loc46_.effectMask.indexOf(_loc58_);
                                          if(_loc59_ != -1)
                                          {
                                             _loc46_.effectMask.splice(_loc59_,1);
                                          }
                                       }
                                    }
                                    if(_loc33_.projectileMod.damageEffectMod)
                                    {
                                       if(_loc46_.damageEffect == null)
                                       {
                                          _loc46_.damageEffect = new DamageEffectDef();
                                       }
                                       _loc46_.damageEffect.damage = _loc46_.damageEffect.damage + _loc33_.projectileMod.damageEffectMod.damage;
                                       if(_loc33_.projectileMod.damageEffectMod.canBreakIce)
                                       {
                                          _loc46_.damageEffect.canBreakIce = true;
                                       }
                                       if(_loc33_.projectileMod.damageEffectMod.removeFromCantBreak != null && _loc46_.damageEffect != null && _loc46_.damageEffect.cantBreak != null)
                                       {
                                          for each(_loc58_ in _loc33_.projectileMod.damageEffectMod.removeFromCantBreak)
                                          {
                                             _loc59_ = _loc46_.damageEffect.cantBreak.indexOf(_loc58_);
                                             if(_loc59_ != -1)
                                             {
                                                _loc46_.damageEffect.cantBreak.splice(_loc59_,1);
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc9_ = new Cache();
         _loc9_.tower = param1;
         _loc9_.upgrades = _loc3_;
         _loc9_.result = _loc10_;
         cache.push(_loc9_);
         return _loc10_;
      }
   }
}
