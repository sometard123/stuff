package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BananaModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class BananaCashScale implements IBuffMethodModule
   {
       
      
      public function BananaCashScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = null;
         var _loc3_:TowerDef = null;
         var _loc13_:UpgradeDef = null;
         var _loc15_:BananaModDef = null;
         var _loc17_:UpgradeDef = null;
         var _loc19_:BananaModDef = null;
         var _loc21_:BananaEmitter = null;
         var _loc22_:BananaEmitter = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         _loc2_ = Main.instance.towerFactory.getBaseTower("BananaFarm");
         _loc3_ = Main.instance.towerFactoryUnmodified.getBaseTower("BananaFarm");
         var _loc4_:BananaEmitter = _loc2_.behavior.roundStart as BananaEmitter;
         var _loc5_:BananaEmitter = _loc3_.behavior.roundStart as BananaEmitter;
         var _loc6_:int = _loc2_.behavior.roundStart["cashPerPacket"];
         var _loc7_:int = _loc3_.behavior.roundStart["cashPerPacket"];
         var _loc8_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID("BananaFarm",Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc9_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID("BananaFarm",Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_.length)
         {
            if(_loc8_[_loc10_].behavior != null)
            {
               if(_loc8_[_loc10_].behavior.roundStart != null)
               {
                  if(_loc8_[_loc10_].behavior.roundStart is BananaEmitter)
                  {
                     _loc21_ = _loc8_[_loc10_].behavior.roundStart as BananaEmitter;
                     _loc22_ = _loc9_[_loc10_].behavior.roundStart as BananaEmitter;
                     _loc23_ = _loc22_.cashPerPacket * (param1.buffValue - 1);
                     if(_loc23_ <= 0)
                     {
                        _loc23_ = 1;
                     }
                     _loc24_ = _loc21_.cashPerPacket + _loc23_;
                     _loc25_ = _loc21_.cashPerRound / _loc21_.cashPerPacket;
                     _loc26_ = _loc25_ * _loc24_;
                     _loc21_.CashPerRound(_loc26_);
                     _loc21_.CashPerPacket(_loc24_);
                  }
               }
            }
            _loc10_++;
         }
         var _loc11_:int = (param1.buffValue - 1) * _loc7_;
         if(_loc11_ <= 0)
         {
            _loc11_ = 1;
         }
         var _loc12_:int = _loc6_ + _loc11_;
         _loc13_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"More Bananas","BananaFarm");
         var _loc14_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"More Bananas","BananaFarm");
         _loc15_ = _loc13_.add.behavior.bananaMod;
         var _loc16_:int = _loc15_.cashPerRound / _loc6_;
         _loc15_.cashPerRound = _loc16_ * _loc12_;
         _loc17_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Banana Plantation","BananaFarm");
         var _loc18_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Banana Plantation","BananaFarm");
         _loc19_ = _loc17_.add.behavior.bananaMod;
         var _loc20_:int = _loc19_.cashPerRound / _loc6_;
         _loc19_.cashPerRound = _loc20_ * _loc12_;
      }
   }
}
