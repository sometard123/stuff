package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import assets.projectile.GrilledPineappleBomb;
   import assets.projectile.PineappleBomb;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class PineappleSurpriseGrill implements IBuffMethodModule
   {
       
      
      public function PineappleSurpriseGrill()
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
               if(_loc5_.display == PineappleBomb || _loc5_.display == GrilledPineappleBomb)
               {
                  _loc4_["reloadTime"] = param1.buffValue;
                  _loc5_.Display(GrilledPineappleBomb);
               }
            }
            _loc3_++;
         }
      }
   }
}
