package ninjakiwi.monkeyTown.town.data
{
   public class BankTierData
   {
      
      public static const MAX_BANK_UPGRADE_TIERS:int = 8;
      
      private static var _data:Object;
       
      
      public function BankTierData()
      {
         super();
      }
      
      public static function processData(param1:Object) : void
      {
         _data = param1;
      }
      
      public static function getNameForTier(param1:int) : String
      {
         validateTier(param1,"getNameForTier");
         return _data[param1].name;
      }
      
      public static function getRequiredLevelForTier(param1:int) : int
      {
         validateTier(param1,"getRequiredLevelForTier");
         return _data[param1].requiredLevel;
      }
      
      public static function getCapacityForTier(param1:int) : int
      {
         validateTier(param1,"getCapacityForTier");
         return _data[param1].capacity;
      }
      
      public static function getCostForTier(param1:int) : int
      {
         validateTier(param1,"getCostForTier");
         return _data[param1].cost;
      }
      
      public static function getTimeForTier(param1:int) : int
      {
         validateTier(param1,"getTimeForTier");
         return _data[param1].time;
      }
      
      public static function getXPForTier(param1:int) : int
      {
         validateTier(param1,"getXPForTier");
         return _data[param1].xp;
      }
      
      private static function validateTier(param1:int, param2:String) : void
      {
         if(param1 < 1 || param1 > MAX_BANK_UPGRADE_TIERS)
         {
            throw new Error("BankTierData::" + param2 + "() - tier was out of range: " + param1);
         }
      }
   }
}
