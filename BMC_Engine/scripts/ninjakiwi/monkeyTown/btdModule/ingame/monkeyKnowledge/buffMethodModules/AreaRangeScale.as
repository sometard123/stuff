package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   
   public class AreaRangeScale implements IBuffMethodModule
   {
       
      
      public function AreaRangeScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc5_:AreaEffectDef = null;
         var _loc6_:AreaEffectDef = null;
         var _loc7_:AddDef = null;
         var _loc8_:AddDef = null;
         var _loc9_:Number = NaN;
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower("EnergyBeacon");
         var _loc3_:TowerDef = Main.instance.towerFactoryUnmodified.getBaseTower("EnergyBeacon");
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.areaEffects.length)
         {
            _loc5_ = _loc2_.areaEffects[_loc4_];
            _loc6_ = _loc3_.areaEffects[_loc4_];
            if(_loc5_.upgrade != null)
            {
               if(_loc5_.upgrade.add != null)
               {
                  _loc7_ = _loc5_.upgrade.add;
                  _loc8_ = _loc6_.upgrade.add;
                  if(_loc7_.rangeOfVisibility != 0)
                  {
                     _loc9_ = _loc7_.rangeOfVisibility / _loc8_.rangeOfVisibility - (1 - param1.buffValue);
                     _loc7_.RangeOfVisibility(_loc8_.rangeOfVisibility * _loc9_);
                  }
               }
            }
            _loc4_++;
         }
      }
   }
}
