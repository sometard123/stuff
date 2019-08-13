package ninjakiwi.monkeyTown.leaderboards
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class LeaderboardManager
   {
      
      public static const HONOR_BOARD:int = 468;
       
      
      public function LeaderboardManager()
      {
         super();
      }
      
      public static function submitScore(param1:int, param2:int) : void
      {
         var _loc3_:NKGatewayUser = MonkeySystem.getInstance().nkGatewayUser;
         if(_loc3_ === null)
         {
            return;
         }
         _loc3_.submitScore(param1,param2);
      }
      
      public static function showLeaderboard(param1:int) : void
      {
         var _loc2_:NKGatewayUser = MonkeySystem.getInstance().nkGatewayUser;
         if(_loc2_ === null)
         {
            return;
         }
         _loc2_.showLeaderboard(param1);
      }
   }
}
