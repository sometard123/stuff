package com.ninjakiwi.gateway.nk
{
   import com.codecatalyst.promise.Promise;
   import com.ninjakiwi.gateway.login.LoginInfo;
   import com.ninjakiwi.gateway.net.Api;
   import com.ninjakiwi.gateway.save.UserData;
   import org.osflash.signals.Signal;
   
   public class NKGatewayUser
   {
       
      
      public const logOutSignal:Signal = new Signal();
      
      public const gotItemsSignal:Signal = new Signal(Object);
      
      private var api:Api;
      
      private var login:LoginInfo;
      
      private var data:UserData;
      
      public function NKGatewayUser(param1:Object)
      {
         var nkBarUser:Object = param1;
         super();
         this.login = LoginInfo.importFromAnotherApplicationDomain(nkBarUser["loginInfo"]);
         this.api = new Api(nkBarUser);
         this.api.call("logOutSignal.add",function loggedOut():void
         {
            logOutSignal.dispatch();
         });
         this.api.call("gotItemsSignal.add",function gotItem(param1:Object):void
         {
            gotItemsSignal.dispatch(param1);
         });
         this.data = new UserData(this.api.getProperty("saveData"));
      }
      
      public function get loginInfo() : LoginInfo
      {
         return this.login;
      }
      
      public function get saveData() : UserData
      {
         return this.data;
      }
      
      public function get inventory() : Object
      {
         return this.api.getProperty("inventory");
      }
      
      public function get profileData() : Object
      {
         return this.api.getProperty("rawData");
      }
      
      public function get coins() : int
      {
         return this.api.getProperty("coins.value");
      }
      
      public function get awesome() : int
      {
         return this.api.getProperty("awesome.value");
      }
      
      public function get igcAmount() : int
      {
         return this.api.getProperty("igcAmount.value");
      }
      
      public function get igcID() : int
      {
         return this.api.getProperty("igcID.value");
      }
      
      public function save() : Promise
      {
         return Promise.when(this.api.call("save"));
      }
      
      public function showLeaderboard(param1:int) : void
      {
         this.api.call("showLeaderboard",param1);
      }
      
      public function showAchievements() : void
      {
         this.api.call("showAchievements");
      }
      
      public function showItemsToBuy(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_.id is int)
            {
               _loc4_ = [_loc3_.id,!!_loc3_.hasOwnProperty("quantity")?_loc3_.quantity:1,!!_loc3_.hasOwnProperty("maxQuantity")?_loc3_.maxQuantity:0];
               _loc2_.push(_loc4_);
            }
         }
         this.api.call("store.showItems",_loc2_);
      }
      
      public function awardIgc(param1:int, param2:String, param3:String) : Promise
      {
         return Promise.when(this.api.call("awardIgc",param1,param2,param3));
      }
      
      public function buyIgcItem(param1:String, param2:int, param3:String) : Promise
      {
         return Promise.when(this.api.call("buyIgcItem",param1,param2,param3));
      }
      
      public function consumeIgcItem(param1:String) : Promise
      {
         return Promise.when(this.api.call("consumeIgcItem",param1));
      }
      
      public function buyNKCoinsItem(param1:int, param2:String) : Promise
      {
         return Promise.when(this.api.call("buyItem",param1,param2));
      }
      
      public function buyNKCoinsItems(param1:Array) : Promise
      {
         return Promise.when(this.api.call("buyItems",param1));
      }
      
      public function consumeNKCoinsItem(param1:String) : Promise
      {
         return Promise.when(this.api.call("consumeItem",param1));
      }
      
      public function submitScore(param1:Number, param2:int) : Promise
      {
         return Promise.when(this.api.call("submitScore",param1,param2));
      }
      
      public function setAchievement(param1:int, param2:int) : Promise
      {
         return Promise.when(this.api.call("setAchievement",param1,param2));
      }
      
      public function awardAwesome(param1:int) : Promise
      {
         return Promise.when(this.api.call("awardAwesome",param1));
      }
      
      public function remoteTrack(param1:String, param2:String, param3:Number, param4:String, param5:String, param6:String, param7:Boolean = false) : Promise
      {
         return Promise.when(this.api.call("remoteTrack",param1,param2,param3,param4,param5,param6,param7));
      }
      
      public function checkDailyReward(param1:int) : Promise
      {
         return Promise.when(this.api.call("checkDailyReward",param1));
      }
      
      public function claimDailyReward(param1:int) : Promise
      {
         return Promise.when(this.api.call("claimDailyReward",param1));
      }
      
      public function checkAndUpdateConsecutiveDailyLogins(param1:int = 0) : Promise
      {
         return Promise.when(this.api.call("checkAndUpdateConsecutiveDailyLogins",param1));
      }
   }
}
