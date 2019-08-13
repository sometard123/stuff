package ninjakiwi.link
{
   import flash.utils.Dictionary;
   
   public class User
   {
       
      
      public var id:int = 0;
      
      public var name:String = null;
      
      public var avatar:String = null;
      
      public var clan:int = 0;
      
      public var clanName:String = null;
      
      public var clanLogo:String = null;
      
      public var isKongUser:Boolean;
      
      public var badges:Dictionary = null;
      
      public function User(param1:int, param2:String, param3:String, param4:int, param5:String, param6:String, param7:Boolean, param8:Dictionary)
      {
         super();
         this.id = param1;
         this.name = param2;
         this.avatar = param3;
         this.clan = param4;
         this.clanName = param5;
         this.clanLogo = param6;
         this.isKongUser = param7;
      }
      
      public function getFullUserID() : String
      {
         if(this.isKongUser)
         {
            return "kong_" + this.id.toString();
         }
         return this.id.toString();
      }
   }
}
