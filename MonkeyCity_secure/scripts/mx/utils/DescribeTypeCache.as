package mx.utils
{
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class DescribeTypeCache
   {
      
      private static var typeCache:Object = {};
      
      private static var cacheHandlers:Object = {};
      
      {
         registerCacheHandler("bindabilityInfo",bindabilityInfoHandler);
      }
      
      public function DescribeTypeCache()
      {
         super();
      }
      
      public static function describeType(param1:*) : DescribeTypeCacheRecord
      {
         var _loc2_:String = null;
         var _loc3_:XML = null;
         var _loc4_:DescribeTypeCacheRecord = null;
         if(param1 is String)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = getQualifiedClassName(param1);
         }
         if(_loc2_ in typeCache)
         {
            return typeCache[_loc2_];
         }
         if(param1 is String)
         {
            param1 = getDefinitionByName(param1);
         }
         _loc3_ = describeType(param1);
         _loc4_ = new DescribeTypeCacheRecord();
         _loc4_.typeDescription = _loc3_;
         _loc4_.typeName = _loc2_;
         typeCache[_loc2_] = _loc4_;
         return _loc4_;
      }
      
      public static function registerCacheHandler(param1:String, param2:Function) : void
      {
         cacheHandlers[param1] = param2;
      }
      
      static function extractValue(param1:String, param2:DescribeTypeCacheRecord) : *
      {
         if(param1 in cacheHandlers)
         {
            return cacheHandlers[param1](param2);
         }
         return undefined;
      }
      
      private static function bindabilityInfoHandler(param1:DescribeTypeCacheRecord) : *
      {
         var BindabilityInfo:Class = null;
         var record:DescribeTypeCacheRecord = param1;
         try
         {
            BindabilityInfo = getDefinitionByName("mx.binding::BindabilityInfo") as Class;
            return new BindabilityInfo(record.typeDescription);
         }
         catch(e:Error)
         {
            return false;
         }
      }
   }
}
