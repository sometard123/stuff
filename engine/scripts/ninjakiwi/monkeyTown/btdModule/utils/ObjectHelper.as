package ninjakiwi.monkeyTown.btdModule.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectHelper
   {
      
      private static var urlRequests:Dictionary = new Dictionary();
       
      
      public function ObjectHelper()
      {
         super();
      }
      
      public static function clone(param1:Object, param2:int = 0) : Object
      {
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         if(!param1)
         {
            return param1;
         }
         if(param1 is int || param1 is uint || param1 is Number || param1 is String || param1 is Boolean || param1 is Class)
         {
            return param1;
         }
         var _loc3_:Object = new (getDefinitionByName(getQualifiedClassName(param1)) as Class)();
         if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0 || getQualifiedClassName(param1).indexOf("Array") != -1)
         {
            for each(_loc4_ in param1)
            {
               _loc3_.push(clone(_loc4_,1));
            }
         }
         else
         {
            for each(_loc5_ in describeType(param1).variable)
            {
               _loc6_ = _loc5_.attribute("name");
               _loc3_[_loc6_] = clone(param1[_loc6_],1);
            }
            for each(_loc5_ in describeType(param1).accessor)
            {
               _loc6_ = _loc5_.attribute("name");
               _loc3_[_loc6_] = clone(param1[_loc6_],1);
            }
         }
         return _loc3_;
      }
      
      public static function cloneFromPool(param1:Object, param2:int = 0) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         if(!param1)
         {
            return param1;
         }
         if(param1 is int || param1 is uint || param1 is Number || param1 is String || param1 is Boolean || param1 is Class)
         {
            return param1;
         }
         if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0 || getQualifiedClassName(param1).indexOf("Array") != -1)
         {
            _loc3_ = new (getDefinitionByName(getQualifiedClassName(param1)) as Class)();
            for each(_loc4_ in param1)
            {
               _loc3_.push(clone(_loc4_,1));
            }
         }
         else
         {
            _loc3_ = Pool.get(getDefinitionByName(getQualifiedClassName(param1)) as Class);
            for each(_loc5_ in describeType(param1).variable)
            {
               _loc6_ = _loc5_.attribute("name");
               _loc3_[_loc6_] = clone(param1[_loc6_],1);
            }
         }
         return _loc3_;
      }
      
      public static function serializeToAS3(param1:Object, param2:int = 1) : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc3_:* = "";
         if(param1 == null)
         {
            _loc3_ = "null";
         }
         else if(param1 is int || param1 is uint || param1 is Number || param1 is Boolean)
         {
            _loc3_ = param1.toString();
         }
         else if(param1 is String)
         {
            _loc3_ = "\"" + param1 + "\"";
         }
         else if(param1 is Class)
         {
            _loc3_ = getQualifiedClassName(param1);
         }
         else if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0)
         {
            _loc4_ = getQualifiedClassName(param1);
            _loc5_ = _loc4_.substring(_loc4_.indexOf("<") + 1,_loc4_.lastIndexOf(">"));
            _loc3_ = "Vector.<" + _loc5_.replace("::",".") + ">([\n";
            _loc6_ = 0;
            for each(_loc7_ in param1)
            {
               if(param2 == 1)
               {
                  _loc3_ = _loc3_ + ("//" + ++_loc6_ + "\n");
               }
               _loc3_ = _loc3_ + (serializeToAS3(_loc7_,param2 + 1) + ", \n");
            }
            if(_loc3_.lastIndexOf(", \n") != -1)
            {
               _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf(", \n"));
            }
            _loc3_ = _loc3_ + "\n])";
         }
         else
         {
            _loc3_ = "new " + getQualifiedClassName(param1).replace("::",".") + "()";
            for each(_loc8_ in describeType(param1).accessor)
            {
               _loc3_ = _loc3_ + serializeToAS3Item(param1,_loc8_,param2);
            }
            for each(_loc8_ in describeType(param1).variable)
            {
               _loc3_ = _loc3_ + serializeToAS3Item(param1,_loc8_,param2);
            }
         }
         if(param2 != 0)
         {
            _loc9_ = "\n\t";
            _loc3_ = _loc3_.split("\n").join(_loc9_);
         }
         _loc3_.replace("\t]))","]))");
         return _loc3_;
      }
      
      public static function serializeToAS3Item(param1:Object, param2:XML, param3:int = 1) : String
      {
         var _loc4_:String = param2.attribute("name");
         var _loc5_:* = serializeToAS3(param1[_loc4_],param3 + 1);
         if(_loc5_.charAt(_loc5_.length - 1) == ")")
         {
            if(_loc5_.indexOf("])") != -1)
            {
               _loc5_.replace("])","\n])");
            }
            else
            {
               _loc5_ = _loc5_ + "\n";
            }
         }
         return "\n." + _loc4_.substr(0,1).toUpperCase() + _loc4_.substr(1) + "(" + _loc5_ + ")";
      }
      
      public static function replaceAll(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function serialize(param1:Object, param2:int = 1) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:* = "";
         if(param1 == null)
         {
            _loc3_ = "null";
         }
         else if(param1 is int || param1 is uint || param1 is Number || param1 is Boolean)
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
            else if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0 || getQualifiedClassName(param1).indexOf("Array") != -1)
            {
               _loc3_ = "[\n";
               for each(_loc4_ in param1)
               {
                  _loc3_ = _loc3_ + (serialize(_loc4_,param2 + 1) + ", \n");
               }
               if(_loc3_.lastIndexOf(", \n") != -1)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf(", \n"));
               }
               _loc3_ = _loc3_ + "\n]";
               if(getQualifiedClassName(param1).indexOf("Array") == -1)
               {
                  _loc3_ = _loc3_.split("\n").join("\n\t");
                  if(_loc3_.lastIndexOf("\t]") != -1)
                  {
                     _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf("\t")) + "]";
                  }
                  _loc3_ = "{\n\"objectType\": \"" + getQualifiedClassName(param1) + "\", \n\"data\": " + _loc3_ + "\n}";
               }
            }
            else
            {
               _loc3_ = "{\n";
               _loc3_ = _loc3_ + ("\"objectType\": \"" + getQualifiedClassName(param1) + "\", \n");
               for each(_loc5_ in describeType(param1).variable)
               {
                  _loc6_ = _loc5_.attribute("name");
                  if(_loc6_ != "pathBez")
                  {
                     _loc7_ = serialize(param1[_loc6_],param2 + 1);
                     if(_loc7_ != "null")
                     {
                        _loc3_ = _loc3_ + ("\"" + _loc6_ + "\": " + _loc7_ + ", \n");
                     }
                  }
               }
               for each(_loc5_ in describeType(param1).accessor)
               {
                  _loc6_ = _loc5_.attribute("name");
                  if(_loc6_ != "pathBez")
                  {
                     _loc7_ = serialize(param1[_loc6_],param2 + 1);
                     if(_loc7_ != "null")
                     {
                        _loc3_ = _loc3_ + ("\"" + _loc6_ + "\": " + _loc7_ + ", \n");
                     }
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
            _loc8_ = "\n\t";
            _loc3_ = _loc3_.split("\n").join(_loc8_);
            if(_loc3_.lastIndexOf("\t}") != -1)
            {
               _loc3_ = _loc3_.substr(0,_loc3_.lastIndexOf("\t")) + "}";
            }
         }
         return _loc3_;
      }
      
      public static function deserialize(param1:String, param2:Object = null) : Object
      {
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(param1);
         return deserializeObject(_loc3_,param2);
      }
      
      public static function deserializeFromURL(param1:String, param2:Function) : void
      {
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:URLLoader = new URLLoader();
         urlRequests[_loc4_] = param2;
         _loc4_.addEventListener(Event.COMPLETE,loadedFromURL);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,ioError);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,ioError);
         _loc4_.load(_loc3_);
      }
      
      private static function loadedFromURL(param1:Event) : void
      {
         var _loc2_:String = (param1.target as URLLoader).data;
         var _loc3_:Object = deserialize(_loc2_);
         urlRequests[param1.target as URLLoader](_loc3_);
      }
      
      private static function ioError(param1:Event) : void
      {
      }
      
      public static function deserializeObject(param1:Object, param2:Object = null) : Object
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:* = undefined;
         var _loc7_:* = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1 is int || param1 is uint || param1 is Number || param1 is Boolean)
         {
            return param1;
         }
         if(param1 is String)
         {
            if(param1.indexOf("class:") == 0)
            {
               _loc4_ = param1.substr("class:".length);
               if(!ApplicationDomain.currentDomain.hasDefinition(_loc4_))
               {
                  return null;
               }
               if(Main.instance.appDomain.hasDefinition(_loc4_))
               {
                  return Main.instance.appDomain.getDefinition(_loc4_) as Class;
               }
               return getDefinitionByName(_loc4_) as Class;
            }
            return replaceAll(replaceAll(replaceAll(param1 as String,"\\\"","\""),"\\n","\n"),"\\t","\t");
         }
         if(param1 is Array)
         {
            _loc5_ = new Array();
            for each(_loc6_ in param1)
            {
               param1.push(deserializeObject(_loc6_));
            }
            return _loc5_;
         }
         if(!ApplicationDomain.currentDomain.hasDefinition(param1.objectType))
         {
            return null;
         }
         var _loc3_:Object = null;
         if(param2 == null)
         {
            _loc3_ = new (getDefinitionByName(param1.objectType) as Class)();
         }
         else
         {
            _loc3_ = param2;
         }
         if(Main.instance.appDomain.hasDefinition(param1.objectType))
         {
            _loc3_ = new (Main.instance.appDomain.getDefinition(param1.objectType) as Class)();
         }
         if(getQualifiedClassName(_loc3_).indexOf("__AS3__.vec::Vector.<") == 0)
         {
            for each(_loc6_ in param1.data)
            {
               _loc3_.push(deserializeObject(_loc6_));
            }
         }
         else
         {
            for(_loc7_ in param1)
            {
               if(!(_loc7_ == "objectType" || !(_loc7_ in _loc3_)))
               {
                  _loc3_[_loc7_] = deserializeObject(param1[_loc7_]);
               }
            }
         }
         return _loc3_;
      }
      
      public static function cammelConvert(param1:String) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.charCodeAt(_loc3_) < 90)
            {
               _loc2_ = _loc2_ + " ";
            }
            if(_loc3_ == 0)
            {
               _loc2_ = _loc2_ + param1.charAt(_loc3_).toUpperCase();
            }
            else
            {
               _loc2_ = _loc2_ + param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function addDeepListener(param1:Object, param2:String, param3:Function) : void
      {
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:EventDispatcher = param1 as EventDispatcher;
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(param2,param3);
         }
         for each(_loc5_ in describeType(param1).variable)
         {
            if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0)
            {
               for each(_loc6_ in param1)
               {
                  addDeepListener(_loc6_,param2,param3);
               }
            }
            else
            {
               _loc7_ = _loc5_.attribute("name");
               addDeepListener(param1[_loc7_],param2,param3);
            }
         }
         for each(_loc5_ in describeType(param1).accessor)
         {
            if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0)
            {
               for each(_loc6_ in param1)
               {
                  addDeepListener(_loc6_,param2,param3);
               }
            }
            else
            {
               _loc7_ = _loc5_.attribute("name");
               addDeepListener(param1[_loc7_],param2,param3);
            }
         }
      }
      
      public static function removeDeepListener(param1:Object, param2:String, param3:Function) : void
      {
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:EventDispatcher = param1 as EventDispatcher;
         if(_loc4_ != null)
         {
            _loc4_.removeEventListener(param2,param3);
         }
         for each(_loc5_ in describeType(param1).variable)
         {
            if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0)
            {
               for each(_loc6_ in param1)
               {
                  removeDeepListener(_loc6_,param2,param3);
               }
            }
            else
            {
               _loc7_ = _loc5_.attribute("name");
               removeDeepListener(param1[_loc7_],param2,param3);
            }
         }
         for each(_loc5_ in describeType(param1).accessor)
         {
            if(getQualifiedClassName(param1).indexOf("__AS3__.vec::Vector.<") == 0)
            {
               for each(_loc6_ in param1)
               {
                  removeDeepListener(_loc6_,param2,param3);
               }
            }
            else
            {
               _loc7_ = _loc5_.attribute("name");
               removeDeepListener(param1[_loc7_],param2,param3);
            }
         }
      }
      
      public static function scaleEffects(param1:DisplayObject, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DropShadowFilter = null;
         var _loc6_:BlurFilter = null;
         var _loc7_:GlowFilter = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc3_:Array = clone(param1.filters) as Array;
         _loc4_ = 0;
         while(_loc4_ < param1.filters.length)
         {
            if(param1.filters[_loc4_] is DropShadowFilter)
            {
               _loc5_ = _loc3_[_loc4_] as DropShadowFilter;
               _loc5_.blurX = _loc5_.blurX * param2;
               _loc5_.blurY = _loc5_.blurY * param2;
               _loc5_.distance = _loc5_.distance * param2;
            }
            else if(param1.filters[_loc4_] is BlurFilter)
            {
               _loc6_ = _loc3_[_loc4_] as BlurFilter;
               _loc6_.blurX = _loc6_.blurX * param2;
               _loc6_.blurY = _loc6_.blurY * param2;
            }
            else if(param1.filters[_loc4_] is GlowFilter)
            {
               _loc7_ = _loc3_[_loc4_] as GlowFilter;
               _loc7_.blurX = _loc7_.blurX * param2;
               _loc7_.blurY = _loc7_.blurY * param2;
            }
            _loc4_++;
         }
         if(param1.filters.length > 0)
         {
            param1.filters = _loc3_;
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc8_ = param1 as DisplayObjectContainer;
            _loc4_ = 0;
            while(_loc4_ < _loc8_.numChildren)
            {
               scaleEffects(_loc8_.getChildAt(_loc4_),param2);
               _loc4_++;
            }
         }
      }
   }
}
