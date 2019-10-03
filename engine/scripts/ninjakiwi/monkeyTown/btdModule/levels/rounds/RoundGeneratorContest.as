package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   
   public class RoundGeneratorContest extends RoundGenerator
   {
      
      private static const USE_INCREASED_RBE_CURVE:Boolean = false;
      
      public static var rbeModifier:Number = 1;
       
      
      public function RoundGeneratorContest(param1:Level)
      {
         super(param1);
      }
      
      override protected function generateRBEPerRound(param1:int, param2:int, param3:Object = null) : Array
      {
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc4_:Object = param3 || {};
         var _loc5_:int = getTotalRounds(param2) - extraRounds;
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         var _loc8_:int = int(_loc4_.roundRBE) || int(10 + param2 * 5);
         var _loc9_:Number = Number(_loc4_.roundRBEIncrement) || Number(10 + param2);
         var _loc10_:Number = Number(_loc4_.roundRBEIncrementGrowth) || Number(5 + param2 * 0.9);
         var _loc11_:Number = 5;
         var _loc12_:Number = 1.8;
         var _loc13_:int = 0;
         while(_loc13_ < param1)
         {
            if(_loc13_ == _loc5_)
            {
               _loc10_ = _loc10_ * _loc11_;
               _loc9_ = _loc9_ * _loc12_;
            }
            _loc7_[_loc13_] = Number(_loc8_ * rbeModifier);
            _loc8_ = _loc8_ + _loc9_;
            _loc9_ = _loc9_ + _loc10_;
            _loc13_++;
         }
         _loc8_ = int(_loc4_.roundRBE) || int(10 + param2 * 5);
         _loc9_ = Number(_loc4_.roundRBEIncrement) || Number(10 + param2);
         _loc10_ = Number(_loc4_.roundRBEIncrementGrowth) || Number(5 + param2 * 0.9);
         var _loc14_:int = 0;
         while(_loc14_ < param1)
         {
            _loc6_[_loc14_] = Number(_loc8_ * rbeModifier);
            _loc8_ = _loc8_ + _loc9_;
            _loc9_ = _loc9_ + _loc10_;
            _loc14_++;
         }
         if(SHOW_ROUND_RBE_DATA_GRAPH)
         {
            _loc15_ = 100;
            _loc16_ = _loc6_[_loc15_];
            _debugView.reveal();
            _debugGraph.clear();
            _debugGraph.rangeX = _loc15_;
            _debugGraph.rangeY = _loc16_;
            _debugGraph.drawData(_loc6_,255);
            _debugGraph.drawData(_loc7_,16711935);
         }
         return !!USE_INCREASED_RBE_CURVE?_loc7_:_loc6_;
      }
   }
}
