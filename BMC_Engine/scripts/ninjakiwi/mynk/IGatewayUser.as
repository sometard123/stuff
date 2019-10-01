package ninjakiwi.mynk
{
   import ninjakiwi.mynk.save.SaveBoss;
   import ninjakiwi.mynk.save.UserData;
   
   public interface IGatewayUser
   {
       
      
      function get name() : String;
      
      function get id() : String;
      
      function isLoggedIn() : Boolean;
      
      function enforceLogin() : void;
      
      function get data() : UserData;
      
      function set data(param1:UserData) : void;
      
      function saveData(param1:Boolean) : void;
      
      function get dataWasChanged() : Boolean;
      
      function get saveBoss() : SaveBoss;
      
      function track(param1:String, param2:String, param3:Number, param4:String, param5:String, param6:Boolean = false) : void;
      
      function saveScore(param1:Number, param2:Function, param3:Boolean, param4:int) : void;
      
      function showLeaderboard(param1:*) : void;
      
      function setAchievement(param1:int, param2:int) : void;
      
      function showAchievements() : void;
      
      function addAwesome(param1:int) : void;
      
      function checkReward(param1:String) : void;
      
      function claimReward(param1:String) : void;
      
      function redeemCode(param1:String) : void;
      
      function getConsecutiveLoginDaysCount() : void;
      
      function get currencyBalance() : int;
      
      function updateCurrencyBalance() : void;
      
      function buyCurrencyItems(param1:Array) : void;
      
      function getCurrency(param1:int, param2:int, param3:String) : void;
      
      function getCurrencyInventory() : void;
   }
}
