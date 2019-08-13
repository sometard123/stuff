package ninjakiwi.monkeyTown.net
{
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.utils.ObjectHelper2;
   import ninjakiwi.mynk.Base64;
   
   public class Squeeze
   {
       
      
      public function Squeeze()
      {
         super();
      }
      
      public static function serialiseAndCompress(param1:*, param2:Boolean = true) : String
      {
         if(param1 is String)
         {
            return param1;
         }
         var _loc3_:String = ObjectHelper2.serialize(param1);
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(_loc3_);
         _loc4_.compress();
         _loc4_.position = 0;
         return Base64.encode(_loc4_);
      }
      
      public static function derialiseAndDecompress(param1:String) : *
      {
         var deserialised:Object = null;
         var bytes:ByteArray = null;
         var unwindMultiSerialisedData:Function = null;
         var input:String = param1;
         try
         {
            bytes = Base64.decode(input);
            bytes.uncompress();
            bytes.position = 0;
         }
         catch(e:Error)
         {
            deserialised = {
               "success":false,
               "message":"Failed to Base64 decode the data.",
               "error":e
            };
            return null;
         }
         var serialised:String = String(bytes.readUTFBytes(bytes.length));
         try
         {
            deserialised = ObjectHelper2.deserialize(serialised);
         }
         catch(e:Error)
         {
            deserialised = null;
         }
         if(deserialised === null)
         {
         }
         if(deserialised is String)
         {
            unwindMultiSerialisedData = function(param1:String):Object
            {
               var _loc2_:* = param1;
               var _loc3_:int = 0;
               while(_loc2_ is String)
               {
                  _loc2_ = Squeeze.derialiseAndDecompress(_loc2_);
                  if(_loc3_++ > 100)
                  {
                     return null;
                  }
               }
               return _loc2_;
            };
            deserialised = unwindMultiSerialisedData(deserialised);
         }
         return deserialised;
      }
      
      public static function convertObjectToCompressedJSON(param1:Object, param2:Boolean = true) : String
      {
         var _loc3_:String = JSON.stringify(param1);
         return encodeAndCompressString(_loc3_);
      }
      
      public static function encodeAndCompressString(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.compress();
         _loc2_.position = 0;
         var _loc3_:String = Base64.encode(_loc2_);
         return _loc3_;
      }
      
      public static function decodeCompressedJSON(param1:String) : *
      {
         var bytes:ByteArray = null;
         var input:String = param1;
         var output:Object = null;
         try
         {
            bytes = Base64.decode(input);
            bytes.uncompress();
            bytes.position = 0;
         }
         catch(e:Error)
         {
            throw new Error("Squeeze::decodeCompressedJSON() Failed to decompress the Base64 input string " + e.message);
         }
         var json:String = String(bytes.readUTFBytes(bytes.length));
         try
         {
            output = JSON.parse(json);
         }
         catch(e:Error)
         {
            throw new Error("Squeeze::decodeCompressedJSON() failed to decode json " + e.message);
         }
         return output;
      }
   }
}
