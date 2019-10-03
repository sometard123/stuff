package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class RoundGeneratorDryAsABone extends RoundGenerator
   {
       
      
      public function RoundGeneratorDryAsABone(param1:Level)
      {
         super(param1);
      }
      
      override public function generate(param1:BTDGameRequest) : void
      {
         var _loc2_:Round = null;
         var _loc3_:BloonSpawnDefinition = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.generate(param1);
         var _loc4_:int = _rounds.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _rounds[_loc5_];
            _loc6_ = _loc2_.queuedBloons.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc3_ = _loc2_.queuedBloons[_loc7_];
               if(_loc3_.spawnType.type < Bloon.DDT)
               {
                  _loc3_.spawnType.typeModifier = 1;
               }
               _loc7_++;
            }
            _loc5_++;
         }
      }
   }
}
