package ninjakiwi.monkeyTown.utils
{
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class Calculator
   {
      
      private static const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      public static var globalXPModifier:Number = 1;
      
      public static var globalCashModifier:Number = 1;
       
      
      public function Calculator()
      {
         super();
      }
      
      public static function getXPFromAttack(param1:TownMap, param2:int, param3:int) : int
      {
         var _loc4_:Number = param1.getXPModifierForDifficultyRank(LGMath.clamp(param3,0,int.MAX_VALUE));
         var _loc5_:int = 10 * param2 * _loc4_ * globalXPModifier;
         _loc5_ = LGMath.clamp(_loc5_,0,500);
         return _loc5_;
      }
      
      public static function getCashFromAttack(param1:int, param2:int = 0) : int
      {
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc3_:int = 100 + 10 * param1 + param2;
         return _loc3_ * globalCashModifier;
      }
      
      public static function getBloonstoneFromVolcano(param1:int) : int
      {
         return int(5 + param1 * 0.5);
      }
      
      public static function getCashFromCave(param1:int) : int
      {
         return int(200 + param1 * 25);
      }
      
      public static function getBloonstoneFromCave(param1:int) : int
      {
         return int(5 + param1 * 0.2);
      }
   }
}
