package ninjakiwi.monkeyTown.pvp
{
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class InviteUser
   {
      
      private static const invitedUsers:Object = {};
       
      
      public function InviteUser()
      {
         super();
      }
      
      public static function invite(param1:String) : void
      {
         if(Kong.isOnKong())
         {
            inviteKong(param1);
         }
         else
         {
            inviteNK(param1);
         }
      }
      
      public static function inviteKong(param1:String) : void
      {
         Kong.inviteUser(null);
      }
      
      public static function inviteNK(param1:String) : void
      {
         var _loc2_:String = "https://ninjakiwi.com/api/v2/activities";
         var _loc3_:String = MonkeySystem.getInstance().userName;
         var _loc4_:MonkeySystem = MonkeySystem.getInstance();
         var _loc5_:URLRequest = new URLRequest(_loc2_);
         _loc5_.method = URLRequestMethod.POST;
         invitedUsers[param1] = 1;
         var _loc6_:URLVariables = new URLVariables();
         _loc6_.invitor = _loc3_;
         _loc6_.invitee = param1;
         _loc6_.model_type = "Achievement";
         _loc6_.title = "Game Invite";
         _loc6_.message = _loc3_ + " has invited you to play <a href=\'https://ninjakiwi.com/Games/Tower-Defense/Play/Bloons-Monkey-City.html\' class=\'read-more\'>Bloons Monkey City</a>. Join them now, and start building your epic Monkey City of awesomeness today!";
         _loc6_.message_alt = _loc3_ + " has invited " + param1 + " to play <a href=\'https://ninjakiwi.com/Games/Tower-Defense/Play/Bloons-Monkey-City.html\' class=\'read-more\'>Bloons Monkey City</a>.";
         _loc6_.email = "yes";
         _loc5_.data = _loc6_;
         var _loc7_:URLLoader = new URLLoader(_loc5_);
         _loc7_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc7_.addEventListener(Event.COMPLETE,onComplete);
         _loc7_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         _loc7_.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
         _loc7_.load(_loc5_);
      }
      
      public static function userHasBeenInvited(param1:String) : Boolean
      {
         return invitedUsers[param1] === 1;
      }
      
      private static function ioErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private static function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
      }
      
      private static function onComplete(param1:Event) : void
      {
      }
   }
}
