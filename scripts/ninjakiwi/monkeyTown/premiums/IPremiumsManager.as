package ninjakiwi.monkeyTown.premiums
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   
   public interface IPremiumsManager
   {
       
      
      function initForUser(param1:NKGatewayUser) : void;
      
      function reset() : void;
      
      function depositBloonstones(param1:int, param2:int, param3:int, param4:String) : void;
      
      function isStarterPackPurchased() : Boolean;
      
      function showStore(param1:Array) : void;
      
      function showStoreForBloonstones(param1:int = 0) : void;
      
      function processInventory(param1:NKGatewayUser) : void;
   }
}
