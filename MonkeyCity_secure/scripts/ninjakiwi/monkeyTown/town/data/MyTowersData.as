package ninjakiwi.monkeyTown.town.data
{
   public class MyTowersData
   {
      
      private static var _data:Object;
       
      
      public function MyTowersData()
      {
         super();
      }
      
      public static function setData(param1:Object) : void
      {
         _data = param1;
      }
      
      public static function getDataForTower(param1:String) : Object
      {
         return _data[param1];
      }
      
      public static function get data() : Object
      {
         return _data;
      }
   }
}
