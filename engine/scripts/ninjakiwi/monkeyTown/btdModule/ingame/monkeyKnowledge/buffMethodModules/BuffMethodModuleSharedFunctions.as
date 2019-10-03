package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerMenuSet;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class BuffMethodModuleSharedFunctions
   {
       
      
      public function BuffMethodModuleSharedFunctions()
      {
         super();
      }
      
      public static function findUpgrade(param1:TowerFactory, param2:TowerMenuSet, param3:String, param4:String) : UpgradeDef
      {
         var _loc5_:Vector.<UpgradeDef> = getUpgradeDefsForTowerID(param4,param1,param2);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_].label == param3)
            {
               return _loc5_[_loc6_];
            }
            _loc6_++;
         }
         return null;
      }
      
      public static function getUpgradeDefsForTowerID(param1:String, param2:TowerFactory, param3:TowerMenuSet) : Vector.<UpgradeDef>
      {
         var _loc4_:TowerDef = param2.getBaseTower(param1);
         return getUpgradeDefsForTowerDef(_loc4_,param2,param3);
      }
      
      public static function getUpgradeDefsForTowerDef(param1:TowerDef, param2:TowerFactory, param3:TowerMenuSet) : Vector.<UpgradeDef>
      {
         var _loc4_:TowerPickerDef = null;
         var _loc5_:UpgradePathDef = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc4_ = param3.getPickerByTowerID(param1.id);
         var _loc6_:Vector.<UpgradeDef> = new Vector.<UpgradeDef>();
         if(_loc4_ != null)
         {
            _loc5_ = param2.getUpgrades(param1.id);
            if(_loc5_ != null && _loc5_.upgrades != null)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc5_.upgrades.length)
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc5_.upgrades[_loc7_].length)
                  {
                     _loc6_.push(_loc5_.upgrades[_loc7_][_loc8_]);
                     _loc8_++;
                  }
                  _loc7_++;
               }
            }
         }
         return _loc6_;
      }
      
      public static function getTowerDefStatesFromBaseTowerID(param1:String, param2:TowerFactory, param3:TowerMenuSet) : Vector.<TowerDef>
      {
         var _loc4_:TowerDef = param2.getBaseTower(param1);
         return getTowerDefStatesFromBaseTower(_loc4_,param2,param3);
      }
      
      public static function getTowerDefStatesFromBaseTower(param1:TowerDef, param2:TowerFactory, param3:TowerMenuSet) : Vector.<TowerDef>
      {
         var _loc4_:Vector.<TowerDef> = new Vector.<TowerDef>();
         _loc4_.push(param1);
         var _loc5_:Vector.<UpgradeDef> = getUpgradeDefsForTowerDef(param1,param2,param3);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_].assign != null)
            {
               _loc4_.push(_loc5_[_loc6_].assign);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function getAllPossibleWeaponsFromBaseTowerID(param1:String, param2:TowerFactory, param3:TowerMenuSet) : Vector.<Weapon>
      {
         var _loc4_:TowerDef = param2.getBaseTower(param1);
         return getAllPossibleWeaponsFromBaseTower(_loc4_,param2,param3);
      }
      
      public static function getAllPossibleWeaponsFromBaseTower(param1:TowerDef, param2:TowerFactory, param3:TowerMenuSet) : Vector.<Weapon>
      {
         var _loc8_:Vector.<Weapon> = null;
         var _loc9_:int = 0;
         var _loc10_:Vector.<Weapon> = null;
         var _loc11_:int = 0;
         var _loc4_:Vector.<UpgradeDef> = getUpgradeDefsForTowerDef(param1,param2,param3);
         var _loc5_:Vector.<Weapon> = new Vector.<Weapon>();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = getWeaponsInUpgradeDef(_loc4_[_loc6_],_loc5_);
            _loc9_ = 0;
            while(_loc9_ < _loc8_.length)
            {
               _loc5_.push(_loc8_[_loc9_]);
               _loc9_++;
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < param1.weapons.length)
         {
            _loc10_ = getWeaponsInWeapon(param1.weapons[_loc7_],true,false,_loc5_);
            _loc11_ = 0;
            while(_loc11_ < _loc10_.length)
            {
               _loc5_.push(_loc10_[_loc11_]);
               _loc11_++;
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      public static function getWeaponsInUpgradeDef(param1:UpgradeDef, param2:Vector.<Weapon> = null) : Vector.<Weapon>
      {
         var _loc7_:Vector.<Weapon> = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vector.<Weapon> = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:Vector.<Weapon> = new Vector.<Weapon>();
         var _loc4_:Vector.<Weapon> = null;
         var _loc5_:Vector.<Weapon> = new Vector.<Weapon>();
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_.push(param2[_loc6_]);
            _loc6_++;
         }
         if(param1.assign != null)
         {
            _loc7_ = param1.assign.weapons;
            if(null != param1.assign.weapons)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc4_ = getWeaponsInWeapon(_loc7_[_loc8_],true,false,_loc5_);
                  _loc9_ = 0;
                  while(_loc9_ < _loc4_.length)
                  {
                     _loc3_.push(_loc4_[_loc9_]);
                     _loc5_.push(_loc4_[_loc9_]);
                     _loc9_++;
                  }
                  _loc8_++;
               }
            }
         }
         if(null != param1.add && null != param1.add.weapons)
         {
            _loc10_ = param1.add.weapons;
            _loc11_ = 0;
            while(_loc11_ < _loc10_.length)
            {
               _loc4_ = getWeaponsInWeapon(_loc10_[_loc11_],true,false,_loc5_);
               _loc12_ = 0;
               while(_loc12_ < _loc4_.length)
               {
                  _loc3_.push(_loc4_[_loc12_]);
                  _loc5_.push(_loc4_[_loc12_]);
                  _loc12_++;
               }
               _loc11_++;
            }
         }
         return _loc3_;
      }
      
      public static function getWeaponsInWeapon(param1:Weapon, param2:Boolean = true, param3:Boolean = false, param4:Vector.<Weapon> = null) : Vector.<Weapon>
      {
         var _loc7_:Vector.<Weapon> = null;
         var _loc8_:int = 0;
         var _loc9_:Weapon = null;
         var _loc5_:Vector.<Weapon> = new Vector.<Weapon>();
         if(param2)
         {
            if(param4 != null && -1 == param4.indexOf(param1))
            {
               _loc5_.push(param1);
            }
         }
         var _loc6_:Object = param1;
         if(_loc6_.hasOwnProperty("childWeapons"))
         {
            _loc7_ = _loc6_.childWeapons;
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc9_ = _loc7_[_loc8_];
               if(!(false == param3 && -1 != _loc5_.indexOf(_loc9_)))
               {
                  if(!(param4 != null && -1 != param4.indexOf(_loc9_)))
                  {
                     _loc5_.push(_loc9_);
                  }
               }
               _loc8_++;
            }
         }
         return _loc5_;
      }
      
      public static function getAbilityDefInTowerDefFromID(param1:String, param2:String, param3:TowerFactory) : AbilityDef
      {
         var _loc4_:TowerDef = param3.getBaseTower(param2);
         return getAbilityDefInTowerDef(param1,_loc4_);
      }
      
      public static function getAbilityDefInTowerDef(param1:String, param2:TowerDef) : AbilityDef
      {
         var _loc4_:AbilityDef = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.abilities.length)
         {
            _loc4_ = param2.abilities[_loc3_];
            if(_loc4_.label == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function getCappedCostChange(param1:Number, param2:Number, param3:Number, param4:Number = 5) : Number
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = 0;
         _loc6_ = param1;
         _loc7_ = param2 * param3;
         var _loc8_:Number = _loc6_ - _loc7_;
         if(Math.abs(_loc8_) < 5)
         {
            _loc5_ = _loc6_ - 5;
         }
         else
         {
            _loc5_ = _loc6_ - _loc8_;
         }
         return _loc5_;
      }
   }
}
