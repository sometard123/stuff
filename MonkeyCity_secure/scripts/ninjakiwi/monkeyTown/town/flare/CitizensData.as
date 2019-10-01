package ninjakiwi.monkeyTown.town.flare
{
   public class CitizensData
   {
       
      
      public function CitizensData()
      {
         super();
      }
      
      public static function getCitizenClassnameGrass() : String
      {
         var _loc1_:int = 3;
         var _loc2_:int = Math.floor(Math.random() * _loc1_);
         var _loc3_:String = "assets.tiles.MonkeysAroundFire";
         switch(_loc2_)
         {
            case 0:
               _loc3_ = "assets.tiles.MonkeysAroundFire";
               break;
            case 1:
               _loc3_ = "assets.tiles.MonkeyCitizen1";
               break;
            case 2:
               _loc3_ = "assets.tiles.FrisbeeMonkeys";
         }
         return _loc3_;
      }
      
      public static function getCitizenClassnameWater() : String
      {
         var _loc1_:int = 2;
         var _loc2_:int = Math.floor(Math.random() * _loc1_);
         var _loc3_:String = "assets.tiles.SnorkelMonkey";
         switch(_loc2_)
         {
            case 0:
               _loc3_ = "assets.tiles.SnorkelMonkey";
               break;
            case 1:
               _loc3_ = "assets.tiles.FishingMonkey";
         }
         return _loc3_;
      }
      
      public static function getCitizenClassnameVolcano() : String
      {
         return "assets.tiles.VolcanoMonkeys";
      }
      
      public static function getCitizenClassnameForest() : String
      {
         return "assets.tiles.LumberjackMonkey";
      }
      
      public static function getCitizenClassnameDesert() : String
      {
         return "assets.tiles.DesertMonkey";
      }
      
      public static function getCitizenClassnameSnow() : String
      {
         return "assets.tiles.SnowMonkey";
      }
      
      public static function getCitizenClassnameMountains() : String
      {
         return "assets.tiles.MountainMonkey";
      }
      
      public static function getCitizenClassnameRiver() : String
      {
         return "assets.tiles.KayakingMonkey";
      }
      
      public static function getCitizenClassnameJungle() : String
      {
         return "assets.tiles.JungleMonkey";
      }
   }
}
