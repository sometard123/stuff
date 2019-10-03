package com.ninjakiwi.gateway.login
{
   public class LoginInfo
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var token:String;
      
      public function LoginInfo(param1:String, param2:String, param3:String)
      {
         super();
         this.id = param1;
         this.name = param2;
         this.token = param3;
      }
      
      public static function importFromAnotherApplicationDomain(param1:Object) : LoginInfo
      {
         var _loc2_:LoginInfo = null;
         try
         {
            _loc2_ = new LoginInfo(validString(param1.id),validString(param1.name),validString(param1.token));
         }
         catch(err:Error)
         {
         }
         return _loc2_;
      }
      
      private static function validString(param1:*) : String
      {
         var _loc2_:String = param1 as String;
         if(_loc2_.length == 0)
         {
            throw new VerifyError("invalid");
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "\n";
         var _loc2_:String = "\t";
         return "[Object LoginInfo] : {" + _loc1_ + _loc2_ + "id: " + _loc2_ + this.id + _loc1_ + _loc2_ + "name: " + _loc2_ + this.name + _loc1_ + _loc2_ + "token: " + _loc2_ + this.token + _loc1_ + "}";
      }
      
      public function matches(param1:LoginInfo) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.id == param1.id && this.token == param1.token;
      }
   }
}
