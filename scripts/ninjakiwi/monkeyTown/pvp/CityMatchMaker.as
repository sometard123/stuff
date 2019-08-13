package ninjakiwi.monkeyTown.pvp
{
   import flash.display.DisplayObjectContainer;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class CityMatchMaker
   {
      
      protected static var _system:MonkeySystem = MonkeySystem.getInstance();
      
      protected static var _resourceStore:ResourceStore = ResourceStore.getInstance();
       
      
      public function CityMatchMaker()
      {
         super();
      }
      
      public static function selectMatchedCity(param1:*) : int
      {
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         if(param1.cities == null || param1.cities.length < 1)
         {
            return -1;
         }
         var _loc2_:int = _resourceStore.townLevel;
         var _loc3_:int = _system.city.cityIndex;
         var _loc4_:int = -1;
         var _loc5_:int = int.MAX_VALUE;
         var _loc6_:int = 0;
         while(_loc6_ < param1.cities.length)
         {
            _loc7_ = param1.cities[_loc6_];
            _loc8_ = Math.abs(_loc2_ - _loc7_.level);
            if(_loc8_ < _loc5_ && _loc7_.level >= Constants.MINIMUM_PVP_LEVEL)
            {
               _loc4_ = _loc7_.cityIndex;
               _loc5_ = _loc8_;
            }
            _loc6_++;
         }
         if(_loc4_ < 0)
         {
            if(param1.cities.length == 1)
            {
               _loc4_ = param1.cities[0].cityIndex;
            }
         }
         return _loc4_;
      }
   }
}
