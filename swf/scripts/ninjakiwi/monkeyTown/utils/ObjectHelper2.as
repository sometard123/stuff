package ninjakiwi.monkeyTown.utils
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.utils.DescribeTypeCache;
   
   public class ObjectHelper2
   {
      
      private static var objectCache:Dictionary = new Dictionary();
      
      private static var objectsByID:Array = [];
      
      private static var idCounter:int = 0;
      
      public static var typeIDMap:Object = null;
      
      private static const OBJECT_ID_KEY:String = "uniqueID___";
      
      private static const OBJECT_TYPE_KEY:String = "objectType___";
       
      
      public function ObjectHelper2()
      {
         super();
      }
      
      public static function serialize(param1:Object, param2:int = 1) : String
      {
         clearDictionary(objectCache);
         objectsByID.length = 0;
         return serializeItem(param1,param2);
      }
      
      public static function deserialize(param1:String, param2:Object = null) : Object
      {
         var data:Object = null;
         var o:String = param1;
         var baseObj:Object = param2;
         clearDictionary(objectCache);
         objectsByID.length = 0;
         try
         {
            data = com.adobe.serialization.json.JSON.decode(o);
         }
         catch(e:Error)
         {
            t.obj(e);
         }
         return deserializeObject(data,baseObj);
      }
      
      public static function deserializeFromDataObject(param1:Object, param2:Object = null) : Object
      {
         clearDictionary(objectCache);
         objectsByID.length = 0;
         return deserializeObject(param1,param2);
      }
      
      private static function getClassID(param1:*) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:String = _loc2_;
         if(typeIDMap !== null)
         {
            _loc4_ = typeIDMap.idsByClass[_loc2_];
            if(_loc4_ !== null)
            {
               _loc3_ = _loc4_;
            }
         }
         return _loc3_;
      }
      
      private static function serializeItem(param1:Object, param2:int = 1) : String
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:XMLList = null;
         var _loc9_:XML = null;
         var _loc10_:XMLList = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc3_:* = "";
         var _loc4_:Boolean = param1 is int || param1 is uint || param1 is Number || param1 is Boolean;
         if(param1 != null && !_loc4_ && objectCache[param1] != undefined)
         {
            _loc5_ = CachedObject(objectCache[param1]).id;
         }
         else
         {
            _loc5_ = idCounter++;
            objectCache[param1] = new CachedObject(param1,_loc5_);
         }
         if(param1 == null)
         {
            _loc3_ = "null";
         }
         else if(_loc4_)
         {
            _loc3_ = param1.toString();
            if(_loc3_ == "NaN")
            {
               _loc3_ = "0";
            }
            if(_loc3_ == "Infinity")
            {
               _loc3_ = "0";
            }
         }
         else
         {
            if(param1 is String)
            {
               _loc3_ = "\"" + replaceAll(replaceAll(replaceAll(param1 as String,"\"","\\\""),"\n","\\n"),"\t","\\t") + "\"";
               return _loc3_;
            }
            if(param1 is Class)
            {
               _loc3_ = "\"class:" + getQualifiedClassName(param1) + "\"";
            }
            else if(getQualifiedClassName(param1).indexOf("Object") == 0)
            {
               _loc3_ = "{\n";
               _loc3_ = _loc3_ + ("\"" + OBJECT_ID_KEY + "\": " + _loc5_ + ",\n" + "\"" + OBJECT_TYPE_KEY + "\": \"" + getClassID(param1) + "\", \n");
               for(_loc6_ in param1)
               {
                  _loc3_ = _loc3_ + ("\"" + _loc6_ + "\" : ");
                  _loc3_ = _loc3_ + (serializeItem(param1[_loc6_],param2 + 1) + ", \n");
               }
               if(_loc3_.lastIndexOf(", \n") != -1)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf(", \n"));
               }
               _loc3_ = _loc3_ + "\n}";
            }
            else if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0 || getQualifiedClassName(param1).indexOf("Array") != -1)
            {
               _loc3_ = "[ \n";
               for each(_loc7_ in param1)
               {
                  _loc3_ = _loc3_ + (serializeItem(_loc7_,param2 + 1) + ", \n");
               }
               if(_loc3_.lastIndexOf(", \n") != -1)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf(", \n"));
               }
               _loc3_ = _loc3_ + "\n ]";
               _loc3_ = _loc3_.split("\n").join("\n\t");
               if(_loc3_.lastIndexOf("\t ]") != -1)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf("\t")) + " ]";
               }
               _loc3_ = "{\n " + "\"" + OBJECT_ID_KEY + "\": " + _loc5_ + ",\n" + "  \"" + OBJECT_TYPE_KEY + "\": \"" + getClassID(param1) + "\", \n\"data\": " + _loc3_ + "\n}";
            }
            else
            {
               _loc3_ = "{\n";
               _loc3_ = _loc3_ + ("\"" + OBJECT_ID_KEY + "\": " + _loc5_ + ",\n" + "\"" + OBJECT_TYPE_KEY + "\": \"" + getClassID(param1) + "\", \n");
               _loc8_ = DescribeTypeCache.describeType(param1).typeDescription.variable;
               for each(_loc9_ in _loc8_)
               {
                  _loc11_ = _loc9_.attribute("name");
                  _loc12_ = serializeItem(param1[_loc11_],param2 + 1);
                  if(_loc12_ != "null")
                  {
                     _loc3_ = _loc3_ + ("\"" + _loc11_ + "\": " + _loc12_ + ", \n");
                  }
               }
               _loc10_ = DescribeTypeCache.describeType(param1).typeDescription.accessor;
               for each(_loc9_ in _loc10_)
               {
                  _loc11_ = _loc9_.attribute("name");
                  _loc12_ = serializeItem(param1[_loc11_],param2 + 1);
                  if(_loc12_ != "null")
                  {
                     _loc3_ = _loc3_ + ("\"" + _loc11_ + "\": " + _loc12_ + ", \n");
                  }
               }
               if(_loc3_.lastIndexOf(", \n") != -1)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf(", \n"));
               }
               _loc3_ = _loc3_ + "\n}";
            }
         }
         if(param2 != 0)
         {
            _loc13_ = "\n\t";
            _loc3_ = _loc3_.split("\n").join(_loc13_);
            if(_loc3_.lastIndexOf("\t}") != -1)
            {
               _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf("\t")) + "}";
            }
         }
         return _loc3_;
      }
      
      private static function deserializeObject(param1:Object, param2:Object = null) : Object
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:* = null;
         if(param1 && param1.hasOwnProperty(OBJECT_ID_KEY))
         {
            _loc3_ = param1[OBJECT_ID_KEY];
            if(objectsByID[_loc3_] != undefined)
            {
               return objectsByID[_loc3_];
            }
         }
         var _loc4_:Boolean = param1 is int || param1 is uint || param1 is Number || param1 is Boolean;
         if(param1 == null)
         {
            return null;
         }
         if(_loc4_)
         {
            return param1;
         }
         if(param1 is String)
         {
            if(param1.indexOf("class:") == 0)
            {
               _loc6_ = param1.substr("class:".length);
               if(!ApplicationDomain.currentDomain.hasDefinition(_loc6_))
               {
                  return null;
               }
               return getDefinitionByName(_loc6_) as Class;
            }
            return replaceAll(replaceAll(replaceAll(param1 as String,"\\\"","\""),"\\n","\n"),"\\t","\t");
         }
         if(param1 is Array)
         {
            _loc7_ = new Array();
            for each(_loc8_ in param1)
            {
               param1.push(deserializeObject(_loc8_));
            }
            return _loc7_;
         }
         if(typeIDMap !== null)
         {
            _loc9_ = param1[OBJECT_TYPE_KEY];
            _loc10_ = typeIDMap.classesById[_loc9_];
            if(_loc10_ !== null)
            {
               param1[OBJECT_TYPE_KEY] = _loc10_;
            }
         }
         if(!ApplicationDomain.currentDomain.hasDefinition(param1[OBJECT_TYPE_KEY]))
         {
            return null;
         }
         var _loc5_:* = null;
         if(param2 == null)
         {
            _loc5_ = new (getDefinitionByName(param1[OBJECT_TYPE_KEY]) as Class)();
         }
         else
         {
            _loc5_ = param2;
         }
         if(getQualifiedClassName(_loc5_).indexOf("__AS3__.vec::Vector.<") == 0 || getQualifiedClassName(_loc5_).indexOf("Array") == 0)
         {
            for each(_loc8_ in param1.data)
            {
               _loc5_.push(deserializeObject(_loc8_));
            }
         }
         else
         {
            for(_loc11_ in param1)
            {
               if(!(_loc11_ == OBJECT_TYPE_KEY || _loc11_ == OBJECT_ID_KEY || !isDynamic(_loc5_) && !(_loc11_ in _loc5_)))
               {
                  try
                  {
                     _loc5_[_loc11_] = deserializeObject(param1[_loc11_]);
                  }
                  catch(e:Error)
                  {
                     continue;
                  }
               }
            }
         }
         objectsByID[_loc3_] = _loc5_;
         return _loc5_;
      }
      
      public static function isDynamic(param1:*) : Boolean
      {
         var _loc2_:XML = DescribeTypeCache.describeType(param1).typeDescription;
         return _loc2_.@isDynamic.toString() == "true";
      }
      
      public static function replaceAll(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function clearDictionary(param1:Dictionary) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            delete param1[_loc2_];
         }
      }
   }
}

class CachedObject
{
    
   
   public var id:int;
   
   public var object;
   
   function CachedObject(param1:*, param2:int)
   {
      super();
      this.object = param1;
      this.id = param2;
   }
}
