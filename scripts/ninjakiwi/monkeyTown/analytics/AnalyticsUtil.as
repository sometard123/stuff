package ninjakiwi.monkeyTown.analytics
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   
   public class AnalyticsUtil
   {
      
      private static var _nkGatewayUser:NKGatewayUser = null;
      
      private static const _types:Array = [String,String,Number,String,String,String,Boolean];
       
      
      public function AnalyticsUtil()
      {
         super();
      }
      
      public static function setUser(param1:NKGatewayUser) : void
      {
         _nkGatewayUser = param1;
      }
      
      public static function track(param1:String = "", param2:String = "", param3:Number = -1, param4:String = "", param5:String = "", param6:String = "", param7:Boolean = true) : void
      {
         var a:String = param1;
         var b:String = param2;
         var c:Number = param3;
         var d:String = param4;
         var e:String = param5;
         var clan:String = param6;
         var f:Boolean = param7;
         if(_nkGatewayUser === null)
         {
            return;
         }
         clan = _nkGatewayUser.profileData.clan;
         _nkGatewayUser.remoteTrack(a,b,c,d,e,clan,f).then(function success(param1:Object):void
         {
         },function fail(param1:Object):void
         {
         });
      }
   }
}
