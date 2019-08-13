package ninjakiwi.monkeyTown.smallEvents.monkeyMerchant
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   
   public class MonkeyMerchantWare extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["price","hasItem","specialItemID"];
       
      
      public var price:int = 0;
      
      public var hasItem:Boolean = false;
      
      public var specialItemID:String = "";
      
      public function MonkeyMerchantWare()
      {
         super();
      }
      
      public function Price(param1:int) : MonkeyMerchantWare
      {
         this.price = param1;
         return this;
      }
      
      public function HasItem(param1:Boolean) : MonkeyMerchantWare
      {
         this.hasItem = param1;
         return this;
      }
      
      public function SpecialItemID(param1:String) : MonkeyMerchantWare
      {
         this.specialItemID = param1;
         return this;
      }
   }
}
