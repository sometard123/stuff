package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class SightScaleLongerCannons implements IBuffMethodModule
   {
       
      
      public function SightScaleLongerCannons()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc3_:UpgradeDef = null;
         var _loc4_:Number = NaN;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Longer Cannons",param1.buffPathID);
         _loc3_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Longer Cannons",param1.buffPathID);
         _loc4_ = _loc2_.add.rangeOfVisibility / _loc3_.add.rangeOfVisibility - (1 - param1.buffValue);
         var _loc5_:Number = _loc3_.add.rangeOfVisibility * _loc4_ - _loc3_.add.rangeOfVisibility;
         _loc2_.add.RangeOfVisibility(_loc3_.add.rangeOfVisibility + _loc5_);
         var _loc6_:TowerDef = Main.instance.towerFactory.getBaseTower("Destroyer");
         _loc6_.RangeOfVisibility(_loc6_.rangeOfVisibility + _loc5_);
      }
   }
}
