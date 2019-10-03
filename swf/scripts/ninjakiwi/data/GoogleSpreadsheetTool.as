package ninjakiwi.data
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   
   public class GoogleSpreadsheetTool
   {
      
      public static const NAMED_ITEMS:int = 0;
      
      public static const NAMED_ITEMS_WITH_SUPPLIED_TYPES:int = 1;
      
      public static const TABLE:int = 2;
      
      public static const TABLE_WITH_SUPPLIED_TYPES:int = 3;
      
      private static const DOT:int = ".".charCodeAt(0);
      
      private static const MINUS_SIGN:int = "-".charCodeAt(0);
       
      
      public function GoogleSpreadsheetTool()
      {
         super();
      }
      
      public static function loadData(param1:String, param2:Function, param3:int = 0, param4:Class = null) : void
      {
         var _loc5_:URLLoaderExtra = new URLLoaderExtra();
         _loc5_.addEventListener(Event.COMPLETE,onLoaded);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
         _loc5_.callback = param2;
         _loc5_.format = param3;
         _loc5_.coerceType = param4;
         _loc5_.load(new URLRequest(param1));
      }
      
      private static function onIoError(param1:IOErrorEvent) : void
      {
      }
      
      protected static function onLoaded(param1:Event) : void
      {
         switch(param1.target.format)
         {
            case TABLE:
               processAsTable(param1.target.data,param1.target.callback,param1.target.coerceType);
               break;
            case TABLE_WITH_SUPPLIED_TYPES:
               processAsTableWithSuppliedTypes(param1.target.data,param1.target.callback,param1.target.coerceType);
               break;
            case NAMED_ITEMS:
               processAsNamedItems(param1.target.data,param1.target.callback,param1.target.coerceType);
               break;
            case NAMED_ITEMS_WITH_SUPPLIED_TYPES:
               processAsNamedItemsWithSuppliedTypes(param1.target.data,param1.target.callback,param1.target.coerceType);
         }
      }
      
      public static function processAsTable(param1:String, param2:Function, param3:Class = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc4_:Array = param1.split("\n");
         var _loc7_:Object = {};
         var _loc8_:Array = removeLineReturnsFromArray(csvSplit(_loc4_[0]));
         _loc5_ = 1;
         while(_loc5_ < _loc4_.length)
         {
            _loc9_ = csvSplit(_loc4_[_loc5_]);
            _loc6_ = 0;
            while(_loc6_ < _loc9_.length)
            {
               _loc10_ = _loc8_[_loc6_];
               if(_loc7_[_loc10_] == undefined)
               {
                  _loc7_[_loc10_] = [];
               }
               _loc7_[_loc10_].push(coerceValue(_loc9_[_loc6_],param3));
               _loc6_++;
            }
            _loc5_++;
         }
         param2(_loc7_);
      }
      
      public static function processAsTableWithSuppliedTypes(param1:String, param2:Function, param3:Class = null) : void
      {
         var i:int = 0;
         var j:int = 0;
         var type:Class = null;
         var row:Array = null;
         var columnKey:String = null;
         var dataString:String = param1;
         var callback:Function = param2;
         var coerceType:Class = param3;
         var rowStrings:Array = dataString.split("\n");
         var data:Object = {};
         var keys:Array = removeLineReturnsFromArray(csvSplit(rowStrings[0]));
         var typeNames:Array = removeLineReturnsFromArray(csvSplit(rowStrings[1]));
         var coerceTypes:Array = [];
         var isKeyFlags:Array = [];
         i = 0;
         while(i < typeNames.length)
         {
            if(typeNames[i] == "Key")
            {
               typeNames[i] = "String";
               isKeyFlags[i] = true;
            }
            else
            {
               isKeyFlags[i] = false;
            }
            if(typeNames[i] == "")
            {
               typeNames[i] = "String";
            }
            if(typeNames[i] == "JSON")
            {
               typeNames[i] = "String";
            }
            if(typeNames[i] == "float")
            {
               typeNames[i] = "Number";
            }
            try
            {
               type = getDefinitionByName(typeNames[i]) as Class;
            }
            catch(e:Error)
            {
               type = String;
            }
            coerceTypes[i] = type;
            i++;
         }
         i = 2;
         while(i < rowStrings.length)
         {
            row = csvSplit(rowStrings[i]);
            j = 0;
            while(j < row.length)
            {
               columnKey = keys[j];
               if(data[columnKey] == undefined)
               {
                  data[columnKey] = [];
               }
               data[columnKey].push(coerceValue(row[j],coerceTypes[j]));
               j++;
            }
            i++;
         }
         callback(data);
      }
      
      public static function processAsNamedItems(param1:String, param2:Function, param3:Class = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc4_:Array = param1.split("\n");
         var _loc7_:Object = {};
         var _loc8_:Array = removeLineReturnsFromArray(csvSplit(_loc4_[0]).splice(1));
         var _loc9_:Array = [];
         var _loc10_:Array = [];
         _loc5_ = 1;
         while(_loc5_ < _loc4_.length)
         {
            _loc11_ = csvSplit(_loc4_[_loc5_]);
            _loc10_.push(_loc11_[0]);
            _loc9_[_loc5_ - 1] = _loc11_.splice(1);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc10_.length)
         {
            _loc12_ = _loc7_[_loc10_[_loc5_]] = {};
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc12_[_loc8_[_loc6_]] = coerceValue(_loc9_[_loc5_][_loc6_],param3);
               _loc6_++;
            }
            _loc5_++;
         }
         param2(_loc7_);
      }
      
      public static function processAsNamedItemsWithSuppliedTypes(param1:String, param2:Function, param3:Class = null) : void
      {
         var i:int = 0;
         var j:int = 0;
         var type:Class = null;
         var row:Array = null;
         var key:String = null;
         var item:Object = null;
         var dataString:String = param1;
         var callback:Function = param2;
         var coerceType:Class = param3;
         var rowStrings:Array = dataString.split("\n");
         var data:Object = {};
         var parameterNames:Array = removeLineReturnsFromArray(csvSplit(rowStrings[0]).splice(1));
         var typeNames:Array = removeLineReturnsFromArray(csvSplit(rowStrings[1]));
         var coerceTypes:Array = [];
         var rowData:Array = [];
         var itemKeys:Array = [];
         var isKeyFlags:Array = [];
         var firstColumnIsKeyType:Boolean = typeNames[0] == "Key";
         typeNames = typeNames.splice(1);
         i = 0;
         while(i < typeNames.length)
         {
            if(typeNames[i] == "Key")
            {
               typeNames[i] = "String";
               isKeyFlags[i] = true;
            }
            else
            {
               isKeyFlags[i] = false;
            }
            if(typeNames[i] == "")
            {
               typeNames[i] = "String";
            }
            if(typeNames[i] == "JSON")
            {
               typeNames[i] = "String";
            }
            if(typeNames[i] == "float")
            {
               typeNames[i] = "Number";
            }
            try
            {
               type = getDefinitionByName(typeNames[i]) as Class;
            }
            catch(e:Error)
            {
               type = String;
            }
            coerceTypes[i] = type;
            i++;
         }
         i = 2;
         while(i < rowStrings.length)
         {
            row = csvSplit(rowStrings[i]);
            key = !!firstColumnIsKeyType?removeWhiteSpace(row[0]):row[0];
            itemKeys.push(key);
            rowData.push(row.splice(1));
            i++;
         }
         i = 0;
         while(i < itemKeys.length)
         {
            item = data[itemKeys[i]] = {};
            j = 0;
            while(j < parameterNames.length)
            {
               if(isKeyFlags[j])
               {
                  item[parameterNames[j]] = coerceValue(removeWhiteSpace(rowData[i][j]),coerceTypes[j]);
               }
               else
               {
                  item[parameterNames[j]] = coerceValue(rowData[i][j],coerceTypes[j]);
               }
               j++;
            }
            i++;
         }
         callback(data);
      }
      
      public static function removeLineReturnsFromArray(param1:Array) : Array
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] is String)
            {
               param1[_loc2_] = param1[_loc2_].replace(/(\r\n|\n|\r)/gm,"");
            }
            _loc2_++;
         }
         return param1;
      }
      
      public static function csvSplit(param1:String) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = param1.split(/,(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))/g);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.charAt(0) == "\"")
            {
               _loc3_ = _loc3_.substr(1);
            }
            if(_loc3_.charAt(_loc3_.length - 1) == "\"")
            {
               _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
            }
            _loc2_[_loc4_] = _loc3_;
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function removeWhiteSpace(param1:String) : String
      {
         return param1.replace(/ /g,"");
      }
      
      public static function coerceValue(param1:String, param2:Class) : *
      {
         var _loc3_:* = undefined;
         if(param2 != null)
         {
            if(param2 == int || param2 == Number)
            {
               _loc3_ = param2(removeNonNumericChars(param1));
            }
            else
            {
               _loc3_ = param2(param1);
            }
         }
         else
         {
            _loc3_ = param1;
         }
         return _loc3_;
      }
      
      public static function removeNonNumericChars(param1:String) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc3_);
            if(_loc4_ >= 48 && _loc4_ <= 57 || _loc4_ == DOT || _loc4_ == MINUS_SIGN)
            {
               _loc2_ = _loc2_ + param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

import flash.net.URLLoader;

class URLLoaderExtra extends URLLoader
{
    
   
   public var callback:Function;
   
   public var format:int;
   
   public var coerceType:Class = null;
   
   function URLLoaderExtra()
   {
      super();
   }
}
