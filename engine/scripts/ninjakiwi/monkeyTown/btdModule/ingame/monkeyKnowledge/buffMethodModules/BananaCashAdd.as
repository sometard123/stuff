package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BananaModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class BananaCashAdd implements IBuffMethodModule
   {
       
      
      public function BananaCashAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:TowerDef = null;
         var _loc5_:int = 0;
         var _loc6_:UpgradeDef = null;
         var _loc7_:UpgradeDef = null;
         var _loc9_:BananaModDef = null;
         var _loc11_:UpgradeDef = null;
         var _loc12_:UpgradeDef = null;
         var _loc14_:BananaModDef = null;
         var _loc16_:BananaEmitter = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc2_:Vector.<TowerDef> = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].behavior != null)
            {
               if(_loc2_[_loc3_].behavior.roundStart != null)
               {
                  if(_loc2_[_loc3_].behavior.roundStart is BananaEmitter)
                  {
                     _loc16_ = _loc2_[_loc3_].behavior.roundStart as BananaEmitter;
                     _loc17_ = _loc16_.cashPerRound / _loc16_.cashPerPacket;
                     _loc18_ = _loc16_.cashPerRound + _loc17_ * param1.buffValue;
                     _loc16_.CashPerRound(_loc18_);
                     _loc16_.CashPerPacket(_loc16_.cashPerPacket + param1.buffValue);
                  }
               }
            }
            _loc3_++;
         }
         _loc4_ = Main.instance.towerFactoryUnmodified.getBaseTower("BananaFarm");
         _loc5_ = _loc4_.behavior.roundStart["cashPerPacket"];
         _loc6_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"More Bananas","BananaFarm");
         _loc7_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"More Bananas","BananaFarm");
         var _loc8_:BananaModDef = _loc6_.add.behavior.bananaMod;
         _loc9_ = _loc7_.add.behavior.bananaMod;
         var _loc10_:int = _loc9_.cashPerRound / _loc5_;
         _loc8_.cashPerRound = _loc8_.cashPerRound + _loc10_ * param1.buffValue;
         _loc11_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Banana Plantation","BananaFarm");
         _loc12_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Banana Plantation","BananaFarm");
         var _loc13_:BananaModDef = _loc11_.add.behavior.bananaMod;
         _loc14_ = _loc12_.add.behavior.bananaMod;
         var _loc15_:int = _loc14_.cashPerRound / _loc5_;
         _loc13_.cashPerRound = _loc13_.cashPerRound + _loc15_ * param1.buffValue;
      }
   }
}
