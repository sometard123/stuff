package ninjakiwi.monkeyTown.town.city
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.buildings.buildingManagers.BankManager;
   import ninjakiwi.monkeyTown.utils.SignalAlias;
   
   public class ActiveCitySignals
   {
      
      private static var _city:ActiveCity;
      
      public static var buildingWasRegisteredSignal:SignalAlias = new SignalAlias();
      
      public static var buildingWasDeregisteredSignal:SignalAlias = new SignalAlias();
      
      public static var maximumMoneyChangedSignal:SignalAlias = new SignalAlias();
      
      public static var monkeyMoneyChangedDiffSignal:SignalAlias = new SignalAlias();
      
      public static var bankCapacityChangedSignal:SignalAlias = new SignalAlias();
      
      public static var bankCheckingSignal:SignalAlias = new SignalAlias();
      
      public static var totalPowerChangedSignal:SignalAlias = new SignalAlias();
      
      public static var bloontoniumChangedDiffSignal:SignalAlias = new SignalAlias(int);
      
      public static var maximumBloontoniumChangedSignal:SignalAlias = new SignalAlias(int);
       
      
      public function ActiveCitySignals()
      {
         super();
      }
      
      public static function setTargetCity(param1:ActiveCity) : void
      {
         _city = param1;
         initListeners();
      }
      
      private static function initListeners() : void
      {
         var _loc1_:ResourceStore = ResourceStore.getInstance();
         buildingWasRegisteredSignal.setTargetSignal(_city.buildingManager.buildingWasRegisteredSignal);
         buildingWasDeregisteredSignal.setTargetSignal(_city.buildingManager.buildingWasDeregisteredSignal);
         maximumMoneyChangedSignal.setTargetSignal(_city.bankManager.maximumMoneyChangedSignal);
         monkeyMoneyChangedDiffSignal.setTargetSignal(_loc1_.monkeyMoneyChangedDiffSignal);
         bankCapacityChangedSignal.setTargetSignal(BankManager.bankCapacityChangedSignal);
         bankCheckingSignal.setTargetSignal(BankManager.bankCheckingSignal);
         totalPowerChangedSignal.setTargetSignal(_city.powerSourceManager.totalPowerChangedSignal);
         maximumBloontoniumChangedSignal.setTargetSignal(_city.bloontoniumStorageTankManager.maximumBloontoniumChangedSignal);
         bloontoniumChangedDiffSignal.setTargetSignal(_loc1_.bloontoniumChangedDiffSignal);
      }
      
      private static function removeListeners() : void
      {
         buildingWasRegisteredSignal.clear();
         buildingWasDeregisteredSignal.clear();
         maximumMoneyChangedSignal.clear();
         monkeyMoneyChangedDiffSignal.clear();
         bankCapacityChangedSignal.clear();
         bankCheckingSignal.clear();
         totalPowerChangedSignal.clear();
         maximumBloontoniumChangedSignal.clear();
         bloontoniumChangedDiffSignal.clear();
      }
      
      public static function clear() : void
      {
         removeListeners();
         _city = null;
      }
   }
}
