package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class RoundGeneratorBloonBeacon extends RoundGenerator
   {
       
      
      public function RoundGeneratorBloonBeacon(param1:Level)
      {
         super(param1);
      }
      
      override public function generate(param1:BTDGameRequest) : void
      {
         super.generate(param1);
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = _rounds[_rounds.length - 1];
         var _loc4_:int = 0;
         while(_loc4_ < _rounds.length)
         {
            _loc2_.push(_rounds[_loc4_]);
            _loc4_ = _loc4_ + 2;
         }
         if(_loc2_[_loc2_.length - 1] !== _loc3_)
         {
            _loc2_.push(_loc3_);
         }
         _rounds = _loc2_;
         _totalRounds.value = _rounds.length;
      }
      
      private function analyseMoabContent(param1:Vector.<Round>) : void
      {
         var _loc4_:Round = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BloonSpawnDefinition = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.queuedBloons.length)
            {
               _loc7_ = _loc4_.queuedBloons[_loc6_];
               if(_loc7_.spawnType.type >= Bloon.MOAB)
               {
                  _loc5_++;
               }
               _loc6_++;
            }
            _loc2_[_loc3_] = _loc5_;
            _loc3_++;
         }
      }
   }
}
