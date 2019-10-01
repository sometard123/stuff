package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerMenuSet;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BananaModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class BananasInRoundAddBananaPlantation implements IBuffMethodModule
   {
       
      
      public function BananasInRoundAddBananaPlantation()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerFactory = null;
         var _loc3_:TowerMenuSet = null;
         var _loc4_:TowerDef = null;
         var _loc5_:int = 0;
         var _loc6_:UpgradeDef = null;
         var _loc7_:BananaModDef = null;
         var _loc9_:TowerDef = null;
         var _loc10_:BananaEmitter = null;
         var _loc12_:TowerDef = null;
         var _loc13_:BananaEmitter = null;
         _loc2_ = Main.instance.towerFactory;
         _loc3_ = Main.instance.towerMenuSet;
         _loc4_ = Main.instance.towerFactory.getBaseTower("BananaFarm");
         _loc5_ = (_loc4_.behavior.roundStart as BananaEmitter).cashPerPacket;
         _loc6_ = BuffMethodModuleSharedFunctions.findUpgrade(_loc2_,_loc3_,"Banana Plantation","BananaFarm");
         _loc7_ = _loc6_.add.behavior.bananaMod;
         var _loc8_:int = _loc7_.cashPerRound + param1.buffValue * _loc5_;
         _loc7_.CashPerRound(_loc8_);
         _loc9_ = _loc2_.getBaseTower("BananaRepublic");
         _loc10_ = _loc9_.behavior.roundStart as BananaEmitter;
         var _loc11_:int = _loc10_.cashPerRound + param1.buffValue * _loc10_.cashPerPacket;
         _loc10_.CashPerRound(_loc11_);
         _loc12_ = _loc2_.getBaseTower("BananaResearchFacility");
         _loc13_ = _loc12_.behavior.roundStart as BananaEmitter;
         var _loc14_:int = _loc13_.cashPerRound + param1.buffValue * _loc13_.cashPerPacket;
         _loc13_.CashPerRound(_loc14_);
      }
   }
}
