package ninjakiwi.monkeyTown.premiums
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   import ninjakiwi.monkeyTown.analytics.StatsData;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.HandShake;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.CrateStruct;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.net.JSONRequest;
   
   public class PremiumsManagerKong implements IPremiumsManager
   {
      
      private static var _instance:PremiumsManagerKong;
       
      
      public function PremiumsManagerKong(param1:SingletonBlocker#1000)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use PremiumsManagerKong.getInstance() instead of new.");
         }
         HandShake.sessionInitialisedSignal.add(this.onSessionInitialised);
         Constants.OPEN_STORE_SIGNAL.add(this.onShowStoreSignal);
      }
      
      public static function getInstance() : PremiumsManagerKong
      {
         if(_instance == null)
         {
            _instance = new PremiumsManagerKong(new SingletonBlocker#1000());
         }
         return _instance;
      }
      
      private function onShowStoreSignal() : void
      {
         ErrorReporter.externalLog("PremiumsManagerKong::onShowStoreSignal( )");
         this.showStoreForBloonstones();
      }
      
      public function initForUser(param1:NKGatewayUser) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function depositBloonstones(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:ResourceStore = ResourceStore.getInstance();
         var _loc6_:Number = GameMods.getModifier(GameModConstants.BLOONSTONES_EARN_MOD);
         _loc5_.bloonstones = _loc5_.bloonstones + param3 * _loc6_;
         Premium.premiumItemPurchasedKongSignal.dispatch(param1,param2,param4);
      }
      
      public function isStarterPackPurchased() : Boolean
      {
         var _loc1_:* = StatsData.getInstance().hasPurchasedStarterPack.value > 0;
         return _loc1_;
      }
      
      public function showStore(param1:Array) : void
      {
         Premium.openedStoreKongSignal.dispatch();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_].toString());
            _loc3_++;
         }
         this.launchStoreAction(_loc2_);
      }
      
      public function showStoreForBloonstones(param1:int = 0) : void
      {
         ErrorReporter.externalLog("PremiumsManagerKong::showStoreForBloonstones( )");
         Premium.showInGameBloonstonesPanel.dispatch();
      }
      
      private function onSessionInitialised() : void
      {
         this.consumeInventory();
      }
      
      public function processInventory(param1:NKGatewayUser) : void
      {
      }
      
      public function consumeInventory() : void
      {
         Kong.getInventory(function onUserItems(param1:Object):void
         {
            var _loc2_:int = 0;
            var _loc3_:Object = null;
            t.obj(param1);
            if(param1.success)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.data.length)
               {
                  _loc3_ = param1.data[_loc2_];
                  if(_loc3_.remaining_uses > 0 && isValidConsumable(_loc3_.identifier))
                  {
                     consumeItem(_loc3_.identifier,_loc3_.id);
                  }
                  _loc2_++;
               }
            }
         });
      }
      
      private function isValidConsumable(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < Premium.ALL_CONSUMABLE_ITEM_STRINGS.length)
         {
            if(param1 === Premium.ALL_CONSUMABLE_ITEM_STRINGS[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function launchStoreAction(param1:Array) : void
      {
         var _loc2_:KongStoreAction = new KongStoreAction(param1,this.onStoreActionComplete);
      }
      
      private function onStoreActionComplete(param1:KongStoreAction) : void
      {
         t.obj(param1);
         this.consumeInventory();
      }
      
      private function consumeItem(param1:String, param2:Number) : void
      {
         var item:String = param1;
         var id:Number = param2;
         Kong.useItem(id,function(param1:*):void
         {
            t.obj(param1);
            if(param1.success)
            {
               applyItemByID(item);
            }
         });
      }
      
      private function applyItemByID(param1:String) : void
      {
         switch(param1)
         {
            case Premium.BLOONSTONES250.toString():
               this.depositBloonstones(Premium.BLOONSTONES250,1,Premium.PILE_OF_BLOONSTONES_QUANTITY,"pile_of_bloonstones");
               break;
            case Premium.BLOONSTONES550.toString():
               this.depositBloonstones(Premium.BLOONSTONES550,1,Premium.BASKET_OF_BLOONSTONES_QUANTITY,"basket_of_bloonstones");
               break;
            case Premium.BLOONSTONES1200.toString():
               this.depositBloonstones(Premium.BLOONSTONES1200,1,Premium.CHEST_OF_BLOONSTONES_QUANTITY,"chest_of_bloonstones");
               break;
            case Premium.BLOONSTONES3250.toString():
               this.depositBloonstones(Premium.BLOONSTONES3250,1,Premium.MOUNTAIN_OF_BLOONSTONES_QUANTITY,"mountain_of_bloonstones");
               break;
            case Premium.STARTER_PACK_ID.toString():
               this.addStarterPack();
         }
      }
      
      private function addStarterPack() : void
      {
         if(this.isStarterPackPurchased() == false)
         {
            StatsData.getInstance().hasPurchasedStarterPack.value = 1;
            StatsData.getInstance().save();
            ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney + 6000;
            ResourceStore.getInstance().bloonstones = ResourceStore.getInstance().bloonstones + 500;
            Premium.premiumItemPurchasedKongSignal.dispatch(Premium.STARTER_PACK_ID,1,"starter_pack");
         }
      }
   }
}

class SingletonBlocker#1000
{
    
   
   function SingletonBlocker#1000()
   {
      super();
   }
}
