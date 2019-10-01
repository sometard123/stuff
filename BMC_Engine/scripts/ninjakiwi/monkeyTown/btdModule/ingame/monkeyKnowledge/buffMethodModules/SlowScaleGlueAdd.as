package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class SlowScaleGlueAdd implements IBuffMethodModule
   {
       
      
      public function SlowScaleGlueAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:* = null;
         var _loc5_:GlueEffectDef = null;
         var _loc6_:BehaviorDef = null;
         var _loc7_:ProjectileDef = null;
         var _loc2_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc2_[_loc3_]["projectile"]["glueEffect"];
            _loc5_.speedScale = _loc5_.speedScale - param1.buffValue;
            _loc6_ = _loc4_["projectile"].behavior;
            if(_loc6_ != null)
            {
               _loc7_ = _loc6_.collision["projectile"] as ProjectileDef;
               _loc5_.speedScale = _loc5_.speedScale - param1.buffValue;
            }
            _loc3_++;
         }
      }
   }
}
