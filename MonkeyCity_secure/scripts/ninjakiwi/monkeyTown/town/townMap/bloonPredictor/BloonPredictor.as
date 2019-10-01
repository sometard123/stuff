package ninjakiwi.monkeyTown.town.townMap.bloonPredictor
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   
   public class BloonPredictor
   {
      
      public static const numberOfZOMGAlternates:int = 3;
      
      public static const meanestBloonThresholds:Object = {
         Constants.RED_BLOON.valueOf():1,
         Constants.BLUE_BLOON.valueOf():2,
         Constants.GREEN_BLOON.valueOf():3,
         Constants.YELLOW_BLOON.valueOf():4,
         Constants.PINK_BLOON.valueOf():5,
         Constants.BLACK_BLOON.valueOf():9,
         Constants.WHITE_BLOON.valueOf():10,
         Constants.LEAD_BLOON.valueOf():11,
         Constants.ZEBRA_BLOON.valueOf():12,
         Constants.RAINBOW_BLOON.valueOf():13,
         Constants.CERAMIC_BLOON.valueOf():15,
         Constants.MOAB_BLOON.valueOf():20,
         Constants.BFB_BLOON.valueOf():25,
         Constants.BOSS_BLOON.valueOf():30,
         Constants.DDT_BLOON.valueOf():30
      };
       
      
      public function BloonPredictor()
      {
         super();
      }
      
      public static function getWeightsDefinition(param1:int, param2:Boolean = false, param3:uint = 0) : BloonWeightsDefinition
      {
         var _loc4_:BloonWeightsDefinition = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         _loc4_ = new BloonWeightsDefinition();
         var _loc5_:Array = Constants.ALL_BLOON_TYPES;
         var _loc6_:Array = Constants.ALL_BLOON_IDS;
         var _loc9_:int = _loc5_.lastIndexOf(Constants.BOSS_BLOON) + 1;
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            _loc7_ = _loc5_[_loc10_];
            _loc8_ = meanestBloonThresholds[_loc7_];
            if(param1 >= _loc8_)
            {
               _loc4_.strongestBloonType = _loc7_;
               _loc4_.strongestBloonID = _loc6_[_loc10_];
            }
            if(param2 && _loc4_.strongestBloonType === Constants.BOSS_BLOON)
            {
               _loc11_ = param3 % (numberOfZOMGAlternates + 1);
               switch(_loc11_)
               {
                  case 0:
                     _loc4_.strongestBloonType = Constants.MOAB_CLUSTER;
                     _loc4_.strongestBloonID = Constants.MOAB_CLUSTER_ID;
                     break;
                  case 1:
                     _loc4_.strongestBloonType = Constants.BFB_CLUSTER;
                     _loc4_.strongestBloonID = Constants.BFB_CLUSTER_ID;
                     break;
                  case 2:
                     _loc4_.strongestBloonType = Constants.DDT_BLOON;
                     _loc4_.strongestBloonID = Constants.DDT_ID;
               }
            }
            _loc10_++;
         }
         return _loc4_;
      }
      
      public static function getWeightsDefinitionByUserDefinedStrongestBloonType(param1:String) : BloonWeightsDefinition
      {
         var _loc2_:BloonWeightsDefinition = new BloonWeightsDefinition();
         if(param1 != null && param1 != "")
         {
            _loc2_.strongestBloonType = param1;
            _loc2_.strongestBloonID = Constants.ALL_BLOON_IDS[Constants.ALL_BLOON_TYPES.indexOf(param1)];
         }
         return _loc2_;
      }
   }
}
