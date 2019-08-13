package ninjakiwi.monkeyTown.town.city
{
   import ninjakiwi.monkeyTown.persistence.Persistence;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.BuildProgressBar;
   import ninjakiwi.mynk.save.TrafficGate;
   
   public class CityLoader
   {
       
      
      public function CityLoader()
      {
         super();
      }
      
      public static function loadCity(param1:CityCommonDataSlot) : void
      {
         var slot:CityCommonDataSlot = param1;
         TrafficGate.flushAll();
         GameSignals.LOAD_CITY_BEGIN.dispatch();
         MonkeyCityMain.getInstance().worldView.prepareForCityTransition();
         BuildProgressBar.instance.reveal();
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Loading " + slot.name);
         MonkeySystem.getInstance().map.selectTerrainGeneratorForCity(slot.bucketID);
         Persistence.getInstance().loadCity(slot,function():void
         {
         });
         Persistence.cityLoadEndSignal.addOnce(function():void
         {
         });
      }
   }
}
