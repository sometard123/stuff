package com.ninjakiwi.gateway.save
{
   import com.ninjakiwi.gateway.net.Api;
   
   public class UserData
   {
       
      
      private var api:Api;
      
      public function UserData(param1:Object)
      {
         super();
         this.api = new Api(param1);
      }
      
      public function get xp() : Number
      {
         return this.api.getProperty("xp");
      }
      
      public function set xp(param1:Number) : void
      {
         this.api.setProperty("xp",param1);
      }
      
      public function get cash() : int
      {
         return this.api.getProperty("cash");
      }
      
      public function set cash(param1:int) : void
      {
         this.api.setProperty("cash",param1);
      }
      
      public function get level() : int
      {
         return this.api.getProperty("level");
      }
      
      public function set level(param1:int) : void
      {
         this.api.setProperty("level",param1);
      }
      
      public function get number() : Number
      {
         return this.api.getProperty("number");
      }
      
      public function set number(param1:Number) : void
      {
         this.api.setProperty("number",param1);
      }
      
      public function get stuff() : Object
      {
         return this.api.getProperty("stuff");
      }
      
      public function set stuff(param1:Object) : void
      {
         this.api.setProperty("stuff",param1);
      }
   }
}
