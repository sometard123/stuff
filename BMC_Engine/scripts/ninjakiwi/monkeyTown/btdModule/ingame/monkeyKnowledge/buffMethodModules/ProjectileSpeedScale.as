package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class ProjectileSpeedScale implements IBuffMethodModule
   {
       
      
      public function ProjectileSpeedScale()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Number = NaN;
         var _loc2_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactory,Main.instance.towerMenuSet);
         var _loc3_:Vector.<Weapon> = BuffMethodModuleSharedFunctions.getAllPossibleWeaponsFromBaseTowerID(param1.buffPathID,Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = _loc3_[_loc4_];
            if("Power" in _loc5_)
            {
               _loc7_ = _loc5_.power / _loc6_.power - (1 - param1.buffValue);
               _loc5_.Power(_loc6_.power * _loc7_);
            }
            _loc4_++;
         }
      }
   }
}
