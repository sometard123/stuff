package ninjakiwi.monkeyTown.utils
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class DateTool
   {
       
      
      public function DateTool()
      {
         super();
      }
      
      public static function dateStringToDate(param1:String) : Date
      {
         var _loc2_:Array = param1.split(" ").join("-").split(":").join("-").split("-");
         return new Date(Date.UTC(Number(_loc2_[0]),_loc2_[1] - 1,_loc2_[2],_loc2_[3],_loc2_[4],_loc2_[5]));
      }
      
      public static function timeIsWithinRange(param1:Number, param2:Number, param3:Number) : Boolean
      {
         return param2 <= param1 && param3 > param1;
      }
      
      public static function dateIsWithinTimeRange(param1:Date, param2:Date, param3:Date) : Boolean
      {
         var _loc4_:Number = param1.getTime();
         var _loc5_:Number = param2.getTime();
         var _loc6_:Number = param3.getTime();
         return timeIsWithinRange(_loc4_,_loc5_,_loc6_);
      }
      
      public static function timeIsInFuture(param1:Number) : Boolean
      {
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         return param1 > _loc2_;
      }
      
      public static function timeRangeIsCurrent(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         return timeIsWithinRange(_loc3_,param1,param2);
      }
      
      public static function dateRangeIsCurrent(param1:Date, param2:Date) : Boolean
      {
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc4_:Date = new Date(_loc3_);
         return dateIsWithinTimeRange(_loc4_,param1,param2);
      }
      
      public static function getTimeString(param1:Number) : String
      {
         var _loc9_:* = null;
         var _loc2_:int = param1 / 1000;
         var _loc3_:Number = _loc2_ % 60;
         var _loc4_:Number = Math.floor(_loc2_ % 3600 / 60);
         var _loc5_:Number = Math.floor(_loc2_ / (60 * 60));
         var _loc6_:String = _loc5_ == 0?"":zeroPad(_loc5_,2);
         var _loc7_:String = zeroPad(_loc4_,2);
         var _loc8_:String = zeroPad(_loc3_,2);
         if(_loc5_ > 0)
         {
            _loc9_ = _loc6_ + "h " + _loc7_ + "m";
         }
         else if(_loc4_ > 0)
         {
            _loc9_ = _loc7_ + ":" + _loc8_;
         }
         else
         {
            _loc9_ = _loc8_ + "s";
         }
         return _loc9_;
      }
      
      public static function getTimeStringFromUnixTime(param1:Number) : String
      {
         if(isNaN(param1))
         {
            return "invalid time";
         }
         if(param1 == 0)
         {
            return "expired";
         }
         if(param1 > 1000 * 60 * 60)
         {
            return getLongFormTimeString(param1);
         }
         return getShortFormTimeString(param1);
      }
      
      private static function getLongFormTimeString(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc3_:* = "";
         var _loc4_:int = _loc2_.dateUTC - 1;
         if(_loc4_ != 0)
         {
            _loc3_ = String(_loc4_);
            if(_loc4_ == 1)
            {
               _loc3_ = _loc3_ + "d ";
            }
            else
            {
               _loc3_ = _loc3_ + "d ";
            }
         }
         var _loc5_:* = "";
         var _loc6_:int = _loc2_.hoursUTC;
         if(_loc6_ != 0)
         {
            _loc5_ = _loc5_ + String(_loc6_);
            if(_loc6_ == 1)
            {
               _loc5_ = _loc5_ + "h ";
            }
            else
            {
               _loc5_ = _loc5_ + "h ";
            }
         }
         var _loc7_:* = "";
         var _loc8_:int = _loc2_.minutesUTC;
         if(_loc8_ != 0)
         {
            _loc7_ = _loc7_ + String(_loc8_);
            _loc7_ = _loc7_ + "m ";
         }
         return _loc3_ + _loc5_ + _loc7_;
      }
      
      private static function getShortFormTimeString(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc3_:* = "";
         var _loc4_:int = _loc2_.dateUTC - 1;
         if(_loc4_ != 0)
         {
            _loc3_ = zeroPad(_loc4_) + ":";
         }
         var _loc5_:String = "";
         var _loc6_:int = _loc2_.hoursUTC;
         if(_loc6_ != 0)
         {
            _loc5_ = _loc5_ + (zeroPad(_loc6_) + ":");
         }
         var _loc7_:String = "";
         var _loc8_:int = _loc2_.minutesUTC;
         if(_loc8_ != 0)
         {
            _loc7_ = _loc7_ + (zeroPad(_loc8_) + ":");
         }
         var _loc9_:String = "";
         var _loc10_:int = _loc2_.secondsUTC;
         _loc9_ = _loc9_ + zeroPad(_loc10_);
         return _loc3_ + _loc5_ + _loc7_ + _loc9_;
      }
      
      public static function zeroPad(param1:int, param2:int = 2) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
   }
}
