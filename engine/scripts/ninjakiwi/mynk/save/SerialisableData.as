package ninjakiwi.mynk.save
{
   import flash.utils.ByteArray;
   import ninjakiwi.mynk.Base64;
   
   public class SerialisableData
   {
       
      
      private var properties:Vector.<EncodingDef>;
      
      public function SerialisableData(param1:Vector.<EncodingDef>, param2:Object = null)
      {
         super();
         this.properties = param1;
         if(param2 != null)
         {
            this.readObject(param2);
         }
      }
      
      function writeObject() : Object
      {
         var _loc2_:EncodingDef = null;
         var _loc1_:Object = {};
         for each(_loc2_ in this.properties)
         {
            if(_loc2_.needsEncoding)
            {
               _loc1_[_loc2_.encodedName] = this.encodeObject(this[_loc2_.decodedName]);
            }
            else
            {
               _loc1_[_loc2_.encodedName] = this[_loc2_.decodedName];
            }
         }
         return _loc1_;
      }
      
      function readObject(param1:Object) : void
      {
         var _loc2_:EncodingDef = null;
         for each(_loc2_ in this.properties)
         {
            if(_loc2_.encodedName in param1)
            {
               if(_loc2_.needsEncoding)
               {
                  try
                  {
                     this[_loc2_.decodedName] = this.decodeObject(param1[_loc2_.encodedName]);
                  }
                  catch(err:Error)
                  {
                  }
               }
               else
               {
                  this[_loc2_.decodedName] = param1[_loc2_.encodedName];
               }
            }
         }
      }
      
      private function encodeObject(param1:Object) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.compress();
         _loc2_.position = 0;
         return Base64.encode(_loc2_);
      }
      
      private function decodeObject(param1:String) : Object
      {
         var _loc2_:ByteArray = Base64.decode(param1);
         _loc2_.uncompress();
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      function equals(param1:SerialisableData) : Boolean
      {
         var _loc2_:EncodingDef = null;
         if(String(this) != String(param1))
         {
            return false;
         }
         for each(_loc2_ in this.properties)
         {
            if(!this.objectEquals(this[_loc2_.decodedName],param1[_loc2_.decodedName]))
            {
               return false;
            }
         }
         return true;
      }
      
      private function objectEquals(param1:Object, param2:Object) : Boolean
      {
         if(param1 != param1)
         {
            return param2 != param2;
         }
         if(param1 == null)
         {
            return param2 == null;
         }
         if(param1 is int || param1 is Number || param1 is String || param1 is Boolean)
         {
            return param1 === param2;
         }
         if(param1 is Array)
         {
            return param2 is Array && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         if(param1 is Vector.<int>)
         {
            return param2 is Vector.<int> && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         if(param1 is Vector.<uint>)
         {
            return param2 is Vector.<uint> && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         if(param1 is Vector.<Number>)
         {
            return param2 is Vector.<Number> && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         if(param1 is Vector.<*>)
         {
            return param2 is Vector.<*> && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         if(String(param1) == "[object Object]")
         {
            return String(param2) == "[object Object]" && this.objectIsSubset(param1,param2) && this.objectIsSubset(param2,param1);
         }
         return false;
      }
      
      private function objectIsSubset(param1:Object, param2:Object) : Boolean
      {
         var key:* = undefined;
         var a:Object = param1;
         var b:Object = param2;
         try
         {
            for(key in a)
            {
               if(!this.objectEquals(a[key],b[key]))
               {
                  return false;
               }
            }
         }
         catch(err:Error)
         {
            return false;
         }
         return true;
      }
   }
}
