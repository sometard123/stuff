package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class SightScaleSentry implements IBuffMethodModule
   {
       
      
      public function SightScaleSentry()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = null;
         var _loc3_:TowerDef = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("Sentry");
         _loc3_ = Main.instance.towerFactoryUnmodified.getBaseTower("Sentry");
         var _loc4_:Number = _loc2_.rangeOfVisibility / _loc3_.rangeOfVisibility - (1 - param1.buffValue);
         _loc2_.RangeOfVisibility(_loc3_.rangeOfVisibility * _loc4_);
      }
   }
}
