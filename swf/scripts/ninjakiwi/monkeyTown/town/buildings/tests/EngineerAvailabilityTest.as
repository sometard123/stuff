package ninjakiwi.monkeyTown.town.buildings.tests
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   
   public class EngineerAvailabilityTest
   {
      
      private static const UnlockCityIndex:int = 1;
      
      public static var isAvailable:Boolean = false;
      
      public static var isHidden:Boolean = false;
      
      public static var hasUnlockCity:Boolean = false;
       
      
      public function EngineerAvailabilityTest()
      {
         super();
      }
      
      public static function test() : void
      {
         var _loc4_:int = 0;
         var _loc5_:CityCommonDataSlot = null;
         var _loc1_:MonkeySystem = MonkeySystem.getInstance();
         var _loc2_:ResourceStore = ResourceStore.getInstance();
         var _loc3_:CityCommonDataManager = CityCommonDataManager.getInstance();
         if(_loc3_.numberOfCities < UnlockCityIndex + 1)
         {
            isAvailable = false;
            isHidden = true;
            hasUnlockCity = false;
            return;
         }
         if(_loc1_.city.cityIndex == UnlockCityIndex)
         {
            _loc4_ = _loc2_.townLevel;
         }
         else
         {
            _loc5_ = _loc3_.getCitySlotClone(UnlockCityIndex);
            _loc4_ = _loc5_.cityLevel;
         }
         isHidden = false;
         hasUnlockCity = true;
         if(_loc4_ < Constants.ENGINEER_UNLOCK_LEVEL)
         {
            isAvailable = false;
         }
         else
         {
            isAvailable = true;
         }
      }
   }
}
