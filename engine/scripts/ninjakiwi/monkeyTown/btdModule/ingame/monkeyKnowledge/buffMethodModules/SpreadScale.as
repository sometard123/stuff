package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class SpreadScale implements IBuffMethodModule
   {
       
      
      public function SpreadScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Number = NaN;
         var _loc11_:WeaponModDef = null;
         var _loc12_:WeaponModDef = null;
         var _loc13_:Number = NaN;
         var _loc2_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc8_ = _loc2_[_loc4_];
            _loc9_ = _loc3_[_loc4_];
            if("Spread" in _loc8_)
            {
               _loc10_ = _loc8_.spread / _loc9_.spread - (1 - param1.buffValue);
               _loc8_.Spread(_loc9_.spread * _loc10_);
            }
            _loc4_++;
         }
         var _loc5_:Vector.<UpgradeDef> = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc6_:Vector.<UpgradeDef> = BuffMethodModuleSharedFunctions.getUpgradeDefsForTowerID(param1.buffPathID,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            if(_loc5_[_loc7_].hasOwnProperty("add") && _loc5_[_loc7_].add != null)
            {
               if(_loc5_[_loc7_].add.hasOwnProperty("weaponMod") && _loc5_[_loc7_].add.weaponMod != null)
               {
                  _loc11_ = _loc5_[_loc7_].add.weaponMod;
                  _loc12_ = _loc6_[_loc7_].add.weaponMod;
                  if(0 != _loc11_.spread)
                  {
                     _loc13_ = _loc11_.spread / _loc12_.spread - (1 - param1.buffValue);
                     _loc11_.Spread(_loc12_.spread * _loc13_);
                  }
               }
            }
            _loc7_++;
         }
      }
   }
}
