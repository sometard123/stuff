package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.net.JSONRequest;
   import ninjakiwi.net.WebAction;
   
   public class PvPClient
   {
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static var autoSender:PvPClientAutoSender = new PvPClientAutoSender();
       
      
      public function PvPClient()
      {
         super();
      }
      
      private static function get userID() : String
      {
         if(_system.nkGatewayUser === null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return "";
         }
         return _system.nkGatewayUser.loginInfo.id;
      }
      
      public static function getCore(param1:Function = null) : void
      {
         var restURL:String = null;
         var webAction:WebAction = null;
         var callback:Function = param1;
         restURL = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/core";
         webAction = new WebAction();
         var jsonRequest:JSONRequest = webAction.load(restURL,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1,{
                  "url":restURL,
                  "sid":webAction.sid,
                  "userID":userID,
                  "cityIndex":_system.city.cityIndex
               });
            }
         });
      }
      
      public static function getCoreUpdates(param1:Function = null) : void
      {
         var restURL:String = null;
         var webAction:WebAction = null;
         var callback:Function = param1;
         restURL = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/core/updates";
         webAction = new WebAction();
         webAction.load(restURL,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1,{
                  "url":restURL,
                  "sid":webAction.sid,
                  "userID":userID,
                  "cityIndex":_system.city.cityIndex
               });
            }
         });
      }
      
      public static function linkAttackToTile(param1:String, param2:Tile, param3:Function = null) : void
      {
         var attackID:String = param1;
         var tile:Tile = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/attacks/" + attackID + "/link";
         var payload:Object = {
            "action":"linkToTile",
            "tileX":tile.positionTilespace.x,
            "tileY":tile.positionTilespace.y
         };
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function sendAttack(param1:PvPAttackDefinition, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Boolean = false, param8:Function = null) : void
      {
         var attackDefinition:PvPAttackDefinition = param1;
         var targetUserID:String = param2;
         var targetUserName:String = param3;
         var targetUserClan:String = param4;
         var targetCityIndex:int = param5;
         var targetCityLevel:int = param6;
         var revengeFlag:Boolean = param7;
         var callback:Function = param8;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/attacks/send";
         var payload:Object = {
            "action":"attack",
            "sender":{
               "name":_system.userName,
               "clan":_system.nkGatewayUser.profileData.clan,
               "cityIndex":_system.city.cityIndex,
               "cityLevel":ResourceStore.getInstance().townLevel,
               "honour":ResourceStore.getInstance().honour,
               "maxCashPillage":attackDefinition.maximumCashPillage
            },
            "target":{
               "userID":targetUserID,
               "name":targetUserName,
               "clan":targetUserClan,
               "cityIndex":targetCityIndex,
               "cityLevel":targetCityLevel,
               "maxCashPillage":0
            },
            "revenge":revengeFlag,
            "isFriend":FriendsManager.getInstance().isUserFriend(targetUserID),
            "quickMatchID":attackDefinition.quickMatchID,
            "attackDefinition":Squeeze.serialiseAndCompress(attackDefinition)
         };
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               if(param1.success == true && param1.attackID != null)
               {
                  PvPSignals.updatePacifistModeUI.dispatch(false);
               }
               callback(param1);
            }
         });
         TimeUntilPacifistTracker.resetTimeUntilPacifist();
      }
      
      public static function sendAttackResult(param1:Object, param2:Object, param3:Function = null, param4:Boolean = false) : Object
      {
         var attackResult:Object = param1;
         var info:Object = param2;
         var callback:Function = param3;
         var expired:Boolean = param4;
         var encodedInfo:String = Squeeze.serialiseAndCompress(info);
         var resolution:String = "";
         if(expired)
         {
            resolution = "expire";
         }
         else if(attackResult.attackSucceeded)
         {
            resolution = "win";
         }
         else
         {
            resolution = "loss";
         }
         if(-1 == PvPMain.instance.recentlyResolvedAttacks.indexOf(attackResult.attackID))
         {
            PvPMain.instance.recentlyResolvedAttacks.push(attackResult.attackID);
         }
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/attacks/" + attackResult.attackID + "/resolve";
         var payload:Object = {
            "action":(expired == true?"expire":"defend"),
            "attackSucceeded":attackResult.attackSucceeded,
            "info":encodedInfo,
            "hardcore":attackResult.wasHardcore,
            "resolution":resolution
         };
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
         return payload;
      }
      
      public static function startDefending(param1:String) : void
      {
         var attackID:String = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/attacks/" + attackID + "/start";
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,null,function(param1:Object):void
         {
         });
      }
      
      public static function extendPacifist(param1:int) : void
      {
         var cityIndex:int = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + cityIndex + "/pacifist";
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,null,function(param1:Object):void
         {
         });
      }
      
      public static function closeAttack(param1:int, param2:String, param3:Function = null) : void
      {
         var cityIndex:int = param1;
         var attackID:String = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + cityIndex + "/attacks/" + attackID + "/close";
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,null,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function getQuickMatch(param1:int, param2:Boolean, param3:Function) : void
      {
         if(_system.nkGatewayUser === null)
         {
            return;
         }
         var _loc4_:String = Constants.KLOUD_HOST + userID + "/" + "pvp/" + param1 + "/quickmatch" + "/" + ResourceStore.getInstance().honour + "/" + ResourceStore.getInstance().townLevel;
         var _loc5_:Object = {
            "broadSearch":param2,
            "honour":ResourceStore.getInstance().honour,
            "cityLevel":ResourceStore.getInstance().townLevel
         };
         var _loc6_:WebAction = WebAction.getActionFor("quickmatch");
         _loc6_.loadWithPayload(_loc4_,_loc5_,param3);
      }
   }
}
