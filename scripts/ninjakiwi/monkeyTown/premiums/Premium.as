package ninjakiwi.monkeyTown.premiums
{
   import flash.geom.Point;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.PrioritySignal;
   
   public class Premium
   {
      
      public static const BLOONSTONES250:int = 619;
      
      public static const BLOONSTONES550:int = 620;
      
      public static const BLOONSTONES1200:int = 621;
      
      public static const BLOONSTONES3250:int = 622;
      
      public static const ALL_CONSUMABLE_ITEM_STRINGS:Array = [BLOONSTONES250.toString(),BLOONSTONES550.toString(),BLOONSTONES1200.toString(),BLOONSTONES3250.toString(),STARTER_PACK_ID.toString()];
      
      public static const STARTER_PACK_ID:int = 624;
      
      public static const PILE_OF_BLOONSTONES_QUANTITY:int = 250;
      
      public static const BASKET_OF_BLOONSTONES_QUANTITY:int = 550;
      
      public static const CHEST_OF_BLOONSTONES_QUANTITY:int = 1200;
      
      public static const MOUNTAIN_OF_BLOONSTONES_QUANTITY:int = 3250;
      
      public static const PILE_OF_BLOONSTONES_ID:int = 619;
      
      public static const BASKET_OF_BLOONSTONES_ID:int = 620;
      
      public static const CHEST_OF_BLOONSTONES_ID:int = 621;
      
      public static const MOUNTAIN_OF_BLOONSTONES_ID:int = 622;
      
      public static const premiumItemPurchasedKongSignal:PrioritySignal = new PrioritySignal(int,int,String);
      
      public static const premiumItemPurchasedSignal:PrioritySignal = new PrioritySignal(int,int,String);
      
      public static const openedStoreSignal:PrioritySignal = new PrioritySignal();
      
      public static const openedStoreKongSignal:PrioritySignal = new PrioritySignal();
      
      public static const showInGameBloonstonesPanel:PrioritySignal = new PrioritySignal();
       
      
      public function Premium(param1:SingletonBlocker#1902)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use Premium.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : IPremiumsManager
      {
         if(Kong.isOnKong())
         {
            return PremiumsManagerKong.getInstance();
         }
         return PremiumsManagerNK.getInstance();
      }
   }
}

class SingletonBlocker#1902
{
    
   
   function SingletonBlocker#1902()
   {
      super();
   }
}
