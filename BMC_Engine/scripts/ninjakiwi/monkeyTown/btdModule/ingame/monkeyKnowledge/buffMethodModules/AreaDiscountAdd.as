package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class AreaDiscountAdd implements IBuffMethodModule
   {
       
      
      public function AreaDiscountAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:AreaEffectDef = null;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("MonkeyVillage");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.areaEffects.length)
         {
            _loc4_ = _loc2_.areaEffects[_loc3_];
            _loc4_.CostScale(_loc4_.costScale - param1.buffValue);
            _loc3_++;
         }
      }
   }
}
