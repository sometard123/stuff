package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import assets.projectile.GrapeShot;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class ProjectileAddGrape implements IBuffMethodModule
   {
       
      
      public function ProjectileAddGrape()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc4_:Object = null;
         var _loc5_:ProjectileDef = null;
         var _loc2_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(!(false == _loc4_.hasOwnProperty("projectile") || _loc4_["projectile"] == null))
            {
               _loc5_ = _loc2_[_loc3_]["projectile"] as ProjectileDef;
               if(_loc5_.display == GrapeShot)
               {
                  _loc4_["count"] = _loc4_["count"] + param1.buffValue;
               }
            }
            _loc3_++;
         }
      }
   }
}
