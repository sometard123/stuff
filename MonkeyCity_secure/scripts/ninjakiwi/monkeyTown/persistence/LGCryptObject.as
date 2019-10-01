package ninjakiwi.monkeyTown.persistence
{
   import flash.utils.ByteArray;
   
   public class LGCryptObject
   {
       
      
      private var _encryptedSaveData:ByteArray;
      
      private var _offset:int;
      
      public function LGCryptObject(param1:Object = null)
      {
         this._encryptedSaveData = new ByteArray();
         super();
         if(param1)
         {
            this.setData(param1);
         }
      }
      
      public function setData(param1:Object) : void
      {
         this.encryptData(param1);
      }
      
      public function modify(param1:Function, param2:* = null) : void
      {
         var _loc3_:Object = this.getDecrypted();
         var _loc4_:Object = null;
         if(param2 != null)
         {
            _loc4_ = param1.call(param2,_loc3_);
         }
         else
         {
            _loc4_ = param1(_loc3_);
         }
         if(_loc4_ && _loc4_ is Object)
         {
            _loc3_ = _loc4_;
         }
         this.encryptData(_loc3_);
      }
      
      public function get value() : Object
      {
         return this.getDecrypted();
      }
      
      private function getDecrypted() : Object
      {
         var result:Object = null;
         try
         {
            this._encryptedSaveData.position = this._offset;
            result = this._encryptedSaveData.readObject();
         }
         catch(e:Error)
         {
            result = {};
         }
         return result;
      }
      
      private function encryptData(param1:Object) : void
      {
         var result:String = null;
         var s:Object = param1;
         this._offset = int(Math.random() * 32);
         try
         {
            this._encryptedSaveData.length = 0;
            this._encryptedSaveData.position = this._offset;
            this._encryptedSaveData.writeObject(s);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
