package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class AbilityCooldownsScale implements IBuffMethodModule
   {
       
      
      public function AbilityCooldownsScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:* = null;
         var _loc3_:Vector.<TowerDef> = null;
         var _loc4_:Vector.<TowerDef> = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<AbilityDef> = null;
         var _loc7_:Vector.<AbilityDef> = null;
         var _loc8_:int = 0;
         var _loc9_:AbilityDef = null;
         var _loc10_:AbilityDef = null;
         var _loc11_:Number = NaN;
         for(_loc2_ in Main.instance.game.gameRequest.availableTowers)
         {
            _loc3_ = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(_loc2_,Main.instance.towerFactory,Main.instance.towerMenuSet);
            _loc4_ = BuffMethodModuleSharedFunctions.getTowerDefStatesFromBaseTowerID(_loc2_,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = _loc3_[_loc5_].abilities;
               _loc7_ = _loc4_[_loc5_].abilities;
               if(_loc6_ != null)
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc6_.length)
                  {
                     _loc9_ = _loc6_[_loc8_];
                     _loc10_ = _loc7_[_loc8_];
                     _loc11_ = _loc9_.cooldown / _loc10_.cooldown - (1 - param1.buffValue);
                     _loc9_.cooldown = _loc10_.cooldown * _loc11_;
                     _loc8_++;
                  }
               }
               _loc5_++;
            }
         }
         ActiveAbilityEmpower.instance.abilityCooldownScale = ActiveAbilityEmpower.instance.abilityCooldownScale - (1 - param1.buffValue);
      }
   }
}
