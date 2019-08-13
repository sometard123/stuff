package
{
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   
   public class t
   {
      
      private static var __FlashTracer_DoNotBroadcast:Boolean = false;
      
      private static var __FlashTracer_DoNotTrace:Boolean = false;
      
      private static var _localConnection:LocalConnection = null;
       
      
      public function t()
      {
         super();
      }
      
      public static function get DoNotBroadcast() : Boolean
      {
         return __FlashTracer_DoNotBroadcast;
      }
      
      public static function set DoNotBroadcast(param1:Boolean) : void
      {
         __FlashTracer_DoNotBroadcast = param1;
      }
      
      public static function get DoNotTrace() : Boolean
      {
         return __FlashTracer_DoNotTrace;
      }
      
      public static function set DoNotTrace(param1:Boolean) : void
      {
         __FlashTracer_DoNotTrace = param1;
      }
      
      public static function get stack() : String
      {
         var limiter:String = null;
         var stack:String = null;
         var frames:Array = null;
         var str:String = "";
         try
         {
            throw new Error();
         }
         catch(e:Error)
         {
            limiter = "\n";
            stack = e.getStackTrace();
            frames = stack.split("\n\tat");
            frames.shift();
            frames.shift();
            str = frames.join(limiter);
         }
         return str;
      }
      
      public static function str(... rest) : void
      {
         var _loc2_:String = rest.join(" | ");
         if(__FlashTracer_DoNotTrace)
         {
         }
         if(!__FlashTracer_DoNotBroadcast)
         {
            dispatch(_loc2_);
         }
      }
      
      public static function lev(... rest) : String
      {
         var _loc2_:Object = rest.length > 0?rest[0]:null;
         var _loc3_:Number = rest.length > 1?Number(Number(rest[1])):Number(Tracer.MAX_NUMBER_LEVELS);
         var _loc4_:String = "";
         if(isNaN(_loc3_))
         {
            _loc4_ = rest[1];
            _loc3_ = Tracer.MAX_NUMBER_LEVELS;
         }
         _loc4_ = _loc4_ + (rest.length > 2?rest[2]:"");
         var _loc5_:Number = 3;
         while(_loc5_ < rest.length)
         {
            _loc4_ = _loc4_ + (" | " + rest[_loc5_]);
            _loc5_++;
         }
         var _loc6_:Tracer = new Tracer(_loc2_,_loc4_,__FlashTracer_DoNotTrace,_loc3_);
         var _loc7_:String = _loc6_.getInfo();
         if(!__FlashTracer_DoNotBroadcast)
         {
            dispatch(_loc7_);
         }
         return _loc7_;
      }
      
      public static function obj(... rest) : String
      {
         var _loc2_:Object = rest.length > 0?rest[0]:null;
         var _loc3_:String = rest.length > 1?rest[1]:"";
         var _loc4_:Number = 2;
         while(_loc4_ < rest.length)
         {
            _loc3_ = _loc3_ + (" | " + rest[_loc4_]);
            _loc4_++;
         }
         var _loc5_:Tracer = new Tracer(_loc2_,_loc3_,__FlashTracer_DoNotTrace,Tracer.MAX_NUMBER_LEVELS);
         var _loc6_:String = _loc5_.getInfo();
         if(!__FlashTracer_DoNotBroadcast)
         {
            dispatch(_loc6_);
         }
         return _loc6_;
      }
      
      private static function dispatch(param1:String) : void
      {
         localConnection.send("__FlashTracer","Add",param1);
      }
      
      private static function get localConnection() : LocalConnection
      {
         if(_localConnection === null)
         {
            _localConnection = new LocalConnection();
            _localConnection.addEventListener(StatusEvent.STATUS,function(param1:Object):void
            {
            });
         }
         return _localConnection;
      }
   }
}

import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

class Tracer
{
   
   public static const MAX_NUMBER_LEVELS:Number = 255;
   
   public static var indentCache:Object = new Object();
   
   private static const PRIMITIVES:Array = ["String","Number","Boolean","Date","int","uint"];
   
   private static const INDENT_CHAR:String = "\t";
    
   
   private var _object:Object = null;
   
   private var _title:String;
   
   private var _supressTrace:Boolean;
   
   private var _allowedDepth:Number;
   
   private var _info:StringBuilder;
   
   private var _infoArray:Array;
   
   private var _indent:Number = 0;
   
   private var _prevIndent:Number = -1;
   
   private var _usedObjects:Array;
   
   function Tracer(param1:Object, param2:String = "", param3:Boolean = false, param4:Number = 255)
   {
      super();
      this._object = param1;
      this._title = param2;
      this._supressTrace = param3;
      this._allowedDepth = param4;
      this._info = new StringBuilder();
      this._usedObjects = new Array();
      this.parse(this._object);
   }
   
   private static function isPrimitive(param1:Object) : Boolean
   {
      var _loc3_:String = null;
      var _loc2_:String = getQualifiedClassName(param1);
      for each(_loc3_ in PRIMITIVES)
      {
         if(_loc2_ === _loc3_)
         {
            return true;
         }
      }
      return false;
   }
   
   private static function isCollectionObject(param1:Object) : Boolean
   {
      return param1 is Array;
   }
   
   private static function hasProperties(param1:Object) : Boolean
   {
      var _loc2_:* = undefined;
      var _loc3_:XML = null;
      return true;
   }
   
   private static function objectToString(param1:Object) : String
   {
      if(param1 is String)
      {
         return "\"" + param1.toString().split("\"").join("\\\"") + "\"";
      }
      if(param1 is Date)
      {
         return "Date.parse(\"" + param1 + "\")";
      }
      return param1.toString();
   }
   
   private function parse(param1:Object, param2:String = "", param3:Boolean = false) : void
   {
      if(Tracer.isPrimitive(param1))
      {
         this.parseLiteral(param1,param2,param3);
      }
      else if(Tracer.isCollectionObject(param1))
      {
         this.parseHierarchicalStructure(param1,param2,true,param3);
      }
      else if(Tracer.hasProperties(param1))
      {
         this.parseHierarchicalStructure(param1,param2,false,param3);
      }
      else
      {
         this.parseLiteral(param1,param2,param3);
      }
   }
   
   private function parseLiteral(param1:Object, param2:String, param3:Boolean = false) : void
   {
      if(param1 == null)
      {
         this.appendString(this.generatePropertyName(param2) + "null");
      }
      else
      {
         this.appendString(this.generatePropertyName(param2,param3) + Tracer.objectToString(param1));
      }
   }
   
   private function generatePropertyName(param1:String, param2:Boolean = false) : String
   {
      if(param1 == "")
      {
         return "";
      }
      if(param2)
      {
         return "/*" + param1 + "*/";
      }
      return param1 + ": ";
   }
   
   private function getStartLimiter(param1:Boolean) : String
   {
      return !!param1?"[":"{";
   }
   
   private function getEndLimiter(param1:Boolean) : String
   {
      return !!param1?"]":"}";
   }
   
   private function addObjectToUsed(param1:Object) : void
   {
      this._usedObjects.push(param1);
   }
   
   private function isUsed(param1:Object) : Boolean
   {
      var _loc2_:* = undefined;
      for each(_loc2_ in this._usedObjects)
      {
         if(param1 === _loc2_)
         {
            return true;
         }
      }
      return false;
   }
   
   private function parseHierarchicalStructure(param1:Object, param2:String, param3:Boolean, param4:Boolean) : void
   {
      if(param1 == null)
      {
         this.parseLiteral(param1,param2);
         return;
      }
      this.appendString(this.generatePropertyName(param2,param4) + this.getStartLimiter(param3));
      this._indent++;
      if(this._indent < this._allowedDepth)
      {
         if(!this.isUsed(param1))
         {
            this.addObjectToUsed(param1);
            if(param3)
            {
               this.parseCollection(param1);
            }
            else
            {
               this.parseProperties(param1);
            }
         }
         else
         {
            this.appendString("/*!!!-Recursion - call to already traced object \'" + param1 + "\' !!!*/");
         }
      }
      else
      {
         this.appendString("/*!!!-The maximum limit of " + this._indent + " levels to trace has been reached-!!!*/");
      }
      this._indent--;
      this.appendString(this.getEndLimiter(param3));
   }
   
   private function parseCollection(param1:Object) : void
   {
      var _loc3_:* = undefined;
      var _loc2_:Number = 0;
      for each(_loc3_ in param1)
      {
         this.parse(_loc3_,(_loc2_++).toString(),true);
      }
      if(_loc2_ === 0)
      {
         this._prevIndent++;
      }
   }
   
   private function parseProperties(param1:Object) : void
   {
      var name:String = null;
      var xmlAccs:XML = null;
      var xmlVar:XML = null;
      var nameAttribute:String = null;
      var object:Object = param1;
      for(name in object)
      {
         try
         {
            this.parse(object[name],name);
         }
         catch(e:Error)
         {
            this.appendString(nameAttribute + ": null /*!!!-" + e + "-!!!*/");
            continue;
         }
      }
      for each(xmlAccs in describeType(object).accessor)
      {
         nameAttribute = xmlAccs.@name;
         try
         {
            if(object[nameAttribute] == null || object[nameAttribute] == undefined || !object[nameAttribute].propertyIsEnumerable())
            {
               this.parse(object[nameAttribute],nameAttribute);
            }
         }
         catch(e:Error)
         {
            this.appendString(nameAttribute + ": null /*!!!-" + e + "-!!!*/");
            continue;
         }
      }
      for each(xmlVar in describeType(object).variable)
      {
         try
         {
            if(object[xmlVar.@name] == null || object[xmlVar.@name] == undefined || !object[xmlVar.@name].propertyIsEnumerable())
            {
               this.parse(object[xmlVar.@name],xmlVar.@name);
            }
         }
         catch(e:Error)
         {
            this.appendString(nameAttribute + ": null /*!!!-" + e + "-!!!*/");
            continue;
         }
      }
   }
   
   private function traceInfo(param1:String) : void
   {
   }
   
   private function appendString(param1:Object) : void
   {
      this._info.append(this.getIndent() + param1);
   }
   
   private function getIndent() : String
   {
      var _loc2_:StringBuilder = null;
      var _loc3_:uint = 0;
      if(Tracer.indentCache[this._indent] == undefined)
      {
         _loc2_ = new StringBuilder();
         _loc3_ = 0;
         while(_loc3_ < this._indent)
         {
            _loc2_.append(Tracer.INDENT_CHAR);
            _loc3_++;
         }
         Tracer.indentCache[this._indent] = "\n" + _loc2_.toString();
      }
      var _loc1_:* = this._prevIndent == this._indent;
      this._prevIndent = this._indent;
      return (!!_loc1_?",":"") + Tracer.indentCache[this._indent];
   }
   
   public function getInfo() : String
   {
      var _loc1_:String = this.infoToString();
      if(!this._supressTrace)
      {
         this.traceInfo(_loc1_);
      }
      return _loc1_;
   }
   
   private function infoToString() : String
   {
      var _loc1_:StringBuilder = new StringBuilder();
      _loc1_.append("-------------------------");
      if(this._title != null && this._title != "")
      {
         _loc1_.append("\n" + this._title);
      }
      _loc1_.append("\nObject type is: [" + getQualifiedClassName(this._object) + "]");
      _loc1_.append("\nObject content is: ");
      _loc1_.append(this._info.toString());
      _loc1_.append("\n-------------------------\n");
      return _loc1_.toString();
   }
}

class StringBuilder
{
    
   
   private var _array:Array;
   
   function StringBuilder()
   {
      super();
      this._array = [];
   }
   
   public static function formatString(... rest) : String
   {
      var _loc4_:Array = null;
      var _loc6_:uint = 0;
      var _loc2_:int = rest.length;
      if(_loc2_ == 0)
      {
         return "";
      }
      if(_loc2_ == 1)
      {
         return rest[0];
      }
      var _loc3_:String = rest[0];
      if(typeof rest[1] == "object")
      {
         _loc4_ = rest[1];
      }
      else
      {
         _loc4_ = new Array();
         _loc6_ = 1;
         while(_loc6_ < rest.length)
         {
            _loc4_.push(rest[_loc6_]);
            _loc6_++;
         }
      }
      var _loc5_:uint = 0;
      while(_loc5_ < _loc4_.length)
      {
         _loc3_ = _loc3_.split("{" + _loc5_ + "}").join(_loc4_[_loc5_]);
         _loc5_++;
      }
      return _loc3_;
   }
   
   public function append(param1:String) : StringBuilder
   {
      this._array.push(param1);
      return this;
   }
   
   public function appendFormat(param1:String, ... rest) : StringBuilder
   {
      this._array.push(StringBuilder.formatString(param1,rest));
      return this;
   }
   
   public function toString() : String
   {
      return this._array.join("");
   }
}
