package ninjakiwi.data
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class DGData
   {
      
      private static var header:String = "DGDATA";
      
      private static var headerLength:int = 14;
      
      private static var crcOffet:int = 6;
      
      private static var crcLength:int = 8;
       
      
      public function DGData()
      {
         super();
      }
      
      public static function test() : void
      {
         var urlLoader:URLLoader = null;
         var request:URLRequest = null;
         urlLoader = new URLLoader();
         var onLoaded:Function = function(param1:Event):void
         {
            var stuffObject:Object = null;
            var data:Object = null;
            var e:Event = param1;
            var bytes:ByteArray = urlLoader.data;
            var stuff:String = decrypt(bytes);
            bytes = encrypt(stuff);
            stuff = decrypt(bytes);
            try
            {
               stuffObject = JSON.parse(stuff);
               data = JSON.parse(stuffObject.data);
               return;
            }
            catch(e:Error)
            {
               return;
            }
         };
         urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         urlLoader.addEventListener(Event.COMPLETE,onLoaded);
         request = new URLRequest("https://static-api-staging.ninjakiwi.com/nkapi/skusettings/ce3b0d79915e9bde2309606f904f0ea3.json?v=" + new Date().time.toString());
         urlLoader.load(request);
      }
      
      public static function decrypt(param1:ByteArray) : String
      {
         var _loc8_:uint = 0;
         var _loc2_:String = "";
         var _loc3_:int = headerLength;
         while(_loc3_ < param1.length)
         {
            _loc8_ = param1[_loc3_];
            param1[_loc3_] = param1[_loc3_] - 21;
            param1[_loc3_] = param1[_loc3_] - (_loc3_ - headerLength) % 6;
            _loc3_++;
         }
         param1.position = 0;
         var _loc4_:String = param1.readUTFBytes(param1.length);
         var _loc5_:String = _loc4_.substr(crcOffet,crcLength);
         var _loc6_:String = _loc4_.substring(headerLength);
         var _loc7_:String = GetCRCFromData(_loc6_);
         if(_loc5_ == _loc7_)
         {
            return _loc6_;
         }
         return null;
      }
      
      public static function encrypt(param1:String) : ByteArray
      {
         var _loc6_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         var _loc3_:String = header + GetCRCFromData(param1);
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_.writeByte(_loc3_.charCodeAt(_loc5_));
            _loc5_++;
         }
         _loc2_.position = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc6_ = _loc6_ + 21;
            _loc6_ = _loc6_ + _loc5_ % 6;
            _loc6_ = _loc6_ % 256;
            _loc4_.writeByte(_loc6_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private static function CalcCRC(param1:int) : int
      {
         var _loc4_:uint = 0;
         var _loc2_:uint = 3988292384;
         var _loc3_:uint = param1;
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            if(_loc3_ & 1)
            {
               _loc3_ = _loc3_ >> 1;
               _loc3_ = _loc3_ ^ _loc2_;
            }
            else
            {
               _loc3_ = _loc3_ >> 1;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function GetCRCFromData(param1:String) : String
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1.charCodeAt(_loc4_);
            _loc7_ = (_loc2_ ^ _loc6_) & 255;
            _loc2_ = _loc2_ >> 8 & 16777215 ^ CalcCRC(_loc7_);
            _loc4_++;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 4294967295 + _loc2_ + 1;
         }
         var _loc5_:String = _loc2_.toString(16);
         while(_loc5_.length < 8)
         {
            _loc5_ = "0" + _loc5_;
         }
         return _loc5_;
      }
   }
}
