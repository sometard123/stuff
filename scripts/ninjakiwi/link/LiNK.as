package ninjakiwi.link
{
   import com.adobe.crypto.MD5;
   import com.codecatalyst.promise.Promise;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class LiNK
   {
      
      public static var APPID:int = 0;
      
      public static var SKUID:int = 0;
      
      public static var SIGNATURE:String = null;
      
      public static var HOST_STAGING:String = "https://api-staging.ninjakiwi.com/";
      
      public static var HOST_PRODUCTION:String = "https://api.ninjakiwi.com/";
      
      public static var HOST:String = HOST_PRODUCTION;
       
      
      public function LiNK()
      {
         super();
      }
      
      public static function leaderboardNeighbours(param1:String, param2:String, param3:int) : Promise
      {
         return post("leaderboard/anon/neighbours",{
            "userID":param1,
            "leaderboardID":param2,
            "limit":param3
         });
      }
      
      public static function leaderboardScores(param1:String, param2:String, param3:Array) : Promise
      {
         if(param3.length == 0)
         {
            throw new Error("Error if checking with zero users");
         }
         return post("leaderboard/anon/scores",{
            "userID":param1,
            "leaderboardID":param2,
            "userIDs":param3
         });
      }
      
      public static function leaderboardRank(param1:String, param2:String) : Promise
      {
         return post("leaderboard/anon/rank",{
            "userID":param1,
            "leaderboardID":param2
         });
      }
      
      public static function leaderboardRanks(param1:Array, param2:String) : Promise
      {
         return post("leaderboard/anon/ranks",{
            "userIDs":param1,
            "leaderboardID":param2
         });
      }
      
      public static function leaderboardTop(param1:String, param2:String, param3:int) : Promise
      {
         return post("leaderboard/anon/top",{
            "userID":param1,
            "leaderboardID":param2,
            "limit":param3
         });
      }
      
      public static function leaderboardSet(param1:String, param2:String, param3:int, param4:String, param5:Number) : Promise
      {
         param5 = Math.floor(param5);
         return post("leaderboard/anon/set",{
            "userID":param1,
            "leaderboardID":param2,
            "score":param3,
            "metadata":param4,
            "expiresIn":param5
         });
      }
      
      private static function errorCheck(param1:Error) : void
      {
         throw param1;
      }
      
      private static function getKongUser(param1:String) : Promise
      {
         var request:URLRequest = null;
         var userID:String = param1;
         userID = userID.substr("kong_".length);
         request = new URLRequest("https://api.kongregate.com/api/user_info.json?user_ids=" + userID);
         var loader:URLLoaderPromise = new URLLoaderPromise(request);
         return loader.load().then(function(param1:*):User
         {
            param1 = JSON.parse(param1);
            if(param1.hasOwnProperty("error"))
            {
               throw new Error("No such user");
            }
            var _loc2_:* = param1.users[0];
            return new User(parseInt(userID),_loc2_.username,null,-1,"Kong",null,true,null);
         },errorCheck);
      }
      
      private static function getNkUser(param1:String) : Promise
      {
         var urlRequest:URLRequest = null;
         var userID:String = param1;
         urlRequest = new URLRequest("https://ninjakiwi.com/api/v1/users/" + userID);
         var loader:URLLoaderPromise = new URLLoaderPromise(urlRequest);
         return loader.load().then(function(param1:*):User
         {
            param1 = JSON.parse(param1);
            if(param1.hasOwnProperty("error"))
            {
               throw new Error("No such user");
            }
            return new User(param1.user_id,param1.username,param1.avatar,param1.clan_id,param1.clan_name,param1.clan_logo,false,null);
         },errorCheck);
      }
      
      public static function isKongUser(param1:String) : Boolean
      {
         return param1.indexOf("kong_") == 0;
      }
      
      public static function getUser(param1:String) : Promise
      {
         if(isKongUser(param1))
         {
            return getKongUser(param1);
         }
         return getNkUser(param1);
      }
      
      public static function post(param1:String, param2:Object) : Promise
      {
         var command:String = param1;
         var body:Object = param2;
         var auth:Object = {
            "session":null,
            "appID":APPID,
            "skuID":SKUID
         };
         var bodyString:String = JSON.stringify(body);
         var md5:String = MD5.hash(SIGNATURE + bodyString);
         var postBody:Object = {
            "data":bodyString,
            "auth":auth,
            "sig":md5
         };
         var urlRequest:URLRequest = new URLRequest(HOST + command);
         var loader:URLLoaderPromise = new URLLoaderPromise(urlRequest);
         urlRequest.method = URLRequestMethod.POST;
         urlRequest.contentType = "application/json";
         urlRequest.data = JSON.stringify(postBody);
         return loader.load().then(function(param1:String):Object
         {
            var _loc2_:* = JSON.parse(param1);
            if(_loc2_.hasOwnProperty("error") && _loc2_.error !== null)
            {
               throw new Error(_loc2_.error);
            }
            return JSON.parse(_loc2_.data);
         },errorCheck);
      }
      
      private static function cacheBust() : String
      {
         return "";
      }
      
      public static function leaderboardCompileInitBody(param1:String, param2:String, param3:int = 2147483647) : Object
      {
         var _loc4_:Object = {
            "userID":param1,
            "target":param2,
            "frequency":param3,
            "rules":[]
         };
         return _loc4_;
      }
      
      public static function leaderboardCompileAddRule(param1:Object, param2:Boolean, param3:String, param4:int = 1) : void
      {
         param1.rules.push({
            "primary":param2,
            "source":param3,
            "type":"ADD",
            "data":{"multiplier":param4}
         });
      }
      
      public static function leaderboardCompilePercentRule(param1:Object, param2:Boolean, param3:String, param4:Vector.<Number>, param5:Vector.<int>) : void
      {
         var _loc10_:Object = null;
         var _loc6_:Array = param1.rules;
         var _loc7_:Object = {
            "primary":param2,
            "source":param3,
            "type":"PERCENT"
         };
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < param4.length)
         {
            _loc10_ = {
               "percent":Math.ceil(param4[_loc9_] * 100) as int,
               "score":param5[_loc9_]
            };
            _loc8_.push(_loc10_);
            _loc9_++;
         }
         _loc7_.data = _loc8_;
         _loc6_.push(_loc7_);
      }
      
      public static function leaderboardCompileRankRule(param1:Object, param2:Boolean, param3:String, param4:Vector.<int>, param5:Vector.<int>) : void
      {
         var _loc10_:Object = null;
         var _loc6_:Array = param1.rules;
         var _loc7_:Object = {
            "primary":param2,
            "source":param3,
            "type":"RANK"
         };
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < param4.length)
         {
            _loc10_ = {};
            _loc10_.rank = param4[_loc9_];
            _loc10_.score = param5[_loc9_];
            _loc8_.push(_loc10_);
            _loc9_++;
         }
         _loc7_.data = _loc8_;
         _loc6_.push(_loc7_);
      }
      
      public static function leaderboardCompile(param1:Object) : Promise
      {
         return post("leaderboard/anon/compile",param1);
      }
   }
}
