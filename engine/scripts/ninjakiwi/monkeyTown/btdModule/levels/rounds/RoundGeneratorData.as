package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   public class RoundGeneratorData
   {
      
      private static var _isHardcore:Boolean = false;
      
      public static const SPACING_NORMAL:String = "normalSpacing";
      
      public static const SPACING_CLOSE:String = "closeSpacing";
      
      public static const SPACING_SUPER_CLOSE:String = "superCloseSpacing";
      
      public static const SPACING_ULTRA_CLOSE:String = "superCloseSpacing";
      
      public static const SPACING_LOOSE:String = "looseSpacing";
      
      public static const SPACING_NORMAL_PROBABILITY:Number = 0.45;
      
      public static const SPACING_CLOSE_PROBABILITY:Number = 0.2;
      
      public static const SPACING_SUPER_CLOSE_PROBABILITY:Number = 0.12;
      
      public static const SPACING_ULTRA_CLOSE_PROBABILITY:Number = 0.08;
      
      public static const SPACING_LOOSE_PROBABILITY:Number = 0.15;
      
      public static const SPACING_NORMAL_MOD:Number = 1;
      
      public static const SPACING_CLOSE_MOD:Number = 1.25;
      
      public static const SPACING_SUPER_CLOSE_MOD:Number = 1.5;
      
      public static const SPACING_ULTRA_CLOSE_MOD:Number = 1.75;
      
      public static const SPACING_LOOSE_MOD:Number = 0.85;
      
      public static const MORE_LEAD_PROBABILITY:Number = 0.3;
      
      private static const REGEN_PROBABILITY_NORMAL:Number = 0.15;
      
      private static const REGEN_PROBABILITY_HARDCORE:Number = 0.2;
      
      private static const CAMO_PROBABILITY_NORMAL:Number = 0.05;
      
      private static const CAMO_PROBABILITY_HARDCORE:Number = 0.05;
      
      private static const REGEN_MOD_NORMAL:Number = 2;
      
      private static const REGEN_MOD_HARDCORE:Number = 1.7;
      
      private static const CAMO_MOD_NORMAL:Number = 2;
      
      private static const CAMO_MOD_HARDCORE:Number = 2;
      
      public static const CAMO_TILE_CAMO_MOD:Number = 1.1;
      
      public static const REGEN_TILE_REGEN_MOD:Number = 1.05;
      
      private static const CAMO_TILE_PROBABILITY_MODIFIER_NORMAL:Number = 8.5;
      
      private static const CAMO_TILE_PROBABILITY_MODIFIER_HARDCORE:Number = 8.5;
      
      private static const REGEN_TILE_PROBABILITY_MODIFIER_NORMAL:Number = 3;
      
      private static const REGEN_TILE_PROBABILITY_MODIFIER_HARDCORE:Number = 3.4;
      
      private static const MAX_DIFFICULTY_FOR_EASY_MONEY_NORMAL:Number = 30;
      
      private static const MAX_DIFFICULTY_FOR_EASY_MONEY_HARDCORE:Number = 20;
      
      private static const EASY_MONEY_DROPOFF_START_NORMAL:int = 20;
      
      private static const EASY_MONEY_DROPOFF_START_HARDCORE:int = 15;
      
      public static const ROUND_REQUIRED_BEFORE_REGEN:int = 3;
      
      public static const ROUND_REQUIRED_BEFORE_CAMO:int = 6;
      
      public static const ROUND_REQUIRED_BEFORE_MOAB:int = 20;
      
      public static const rbeByType:Array = [1,2,3,4,5,11,11,23,23,47,104,616,3164,16656];
      
      public static const rbeByTypeRegularBloons:Array = [1,2,3,4,5,11,11,23,23,47,104];
      
      public static const rbeByTypeMoabClass:Array = [616,3164,16656];
      
      public static const rbeByTypeMoabActualUse:Array = [616,616 * 3,3164];
      
      public static const rbeByTypeMOABAffordCost:Array = [616,3164,16656 / 2];
       
      
      public function RoundGeneratorData()
      {
         super();
      }
      
      public static function setIsHardcore(param1:Boolean) : void
      {
         _isHardcore = param1;
      }
      
      public static function get isHardcore() : Boolean
      {
         return _isHardcore;
      }
      
      public static function get REGEN_PROBABILITY() : Number
      {
         return !!_isHardcore?Number(REGEN_PROBABILITY_HARDCORE):Number(REGEN_PROBABILITY_NORMAL);
      }
      
      public static function get CAMO_PROBABILITY() : Number
      {
         return !!_isHardcore?Number(CAMO_PROBABILITY_HARDCORE):Number(CAMO_PROBABILITY_NORMAL);
      }
      
      public static function get REGEN_MOD() : Number
      {
         return !!_isHardcore?Number(REGEN_MOD_HARDCORE):Number(REGEN_MOD_NORMAL);
      }
      
      public static function get CAMO_MOD() : Number
      {
         return !!_isHardcore?Number(CAMO_MOD_HARDCORE):Number(CAMO_MOD_NORMAL);
      }
      
      public static function get CAMO_TILE_PROBABILITY_MODIFIER() : Number
      {
         return !!_isHardcore?Number(CAMO_TILE_PROBABILITY_MODIFIER_HARDCORE):Number(CAMO_TILE_PROBABILITY_MODIFIER_NORMAL);
      }
      
      public static function get REGEN_TILE_PROBABILITY_MODIFIER() : Number
      {
         return !!_isHardcore?Number(REGEN_TILE_PROBABILITY_MODIFIER_HARDCORE):Number(REGEN_TILE_PROBABILITY_MODIFIER_NORMAL);
      }
      
      public static function get MAX_DIFFICULTY_FOR_EASY_MONEY() : Number
      {
         return !!_isHardcore?Number(MAX_DIFFICULTY_FOR_EASY_MONEY_HARDCORE):Number(MAX_DIFFICULTY_FOR_EASY_MONEY_NORMAL);
      }
      
      public static function get EASY_MONEY_DROPOFF_START() : int
      {
         return !!_isHardcore?int(EASY_MONEY_DROPOFF_START_HARDCORE):int(EASY_MONEY_DROPOFF_START_NORMAL);
      }
      
      public static function getRBEByType(param1:int) : int
      {
         if(!rbeByType[param1])
         {
            return 0;
         }
         return rbeByType[param1];
      }
      
      public static function getBiggestBloonTypeUsingRBE(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < rbeByType.length)
         {
            if(rbeByType[_loc3_] > param1)
            {
               return _loc2_;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return -1;
      }
      
      public static function howManyCanIMake(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < rbeByType.length)
         {
            _loc4_ = Math.floor(param1 / rbeByType[_loc3_]);
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function howManyMOABSCanIMake(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < rbeByTypeMOABAffordCost.length)
         {
            _loc4_ = Math.floor(param1 / rbeByTypeMOABAffordCost[_loc3_]);
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
