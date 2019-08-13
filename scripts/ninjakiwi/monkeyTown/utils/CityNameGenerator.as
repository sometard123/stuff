package ninjakiwi.monkeyTown.utils
{
   public class CityNameGenerator
   {
      
      private static var _mainNames:Array = ["monkey","monk","banana","bana","dart","furr","furry","furri","fuzzy","fuzz","simian","simia","glaive","dartling","super","popping","pop","poppa","peanut","barrel","pineapple","juicy","awesome","kiwi","nana","jungle","forest","happy","green","bomb","bomba","ace","flame","frosty","storm","sharp","bloon","boom"];
      
      private static var _suffixList:Array = ["opolis","city","ton","town","toun","fort","ville","berg","burg","burgh","borough","boro","bury","ham","onia","wich","port","mont","ford","vale","topia","land","crest","pines","grove","hill","tron","tay","berry","cote","cott","duff","holm","kirk","mere","minster","stead","wick","wyke","worth","dale","haven"];
       
      
      public function CityNameGenerator()
      {
         super();
      }
      
      public static function createCityName() : String
      {
         var _loc1_:String = _mainNames[int(Math.random() * _mainNames.length)] + _suffixList[int(Math.random() * _suffixList.length)];
         _loc1_ = _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1,_loc1_.length);
         return _loc1_;
      }
   }
}
