package ninjakiwi.monkeyTown.premiums
{
   import assets.ui.CTRewardsPanelClip;
   import com.codecatalyst.promise.Promise;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MKPTester;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeTutorialPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class PremiumsManagerNK implements IPremiumsManager
   {
      
      private static var _instance:PremiumsManagerNK;
       
      
      private var _user:NKGatewayUser = null;
      
      private var _starterPackPurchased:Boolean = false;
      
      public function PremiumsManagerNK(param1:SingletonBlocker#985)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use PremiumsManager.getInstance() instead of new.");
         }
         Constants.OPEN_STORE_SIGNAL.add(this.onShowStoreSignal);
      }
      
      public static function getInstance() : PremiumsManagerNK
      {
         if(_instance == null)
         {
            _instance = new PremiumsManagerNK(new SingletonBlocker#985());
         }
         return _instance;
      }
      
      public function initForUser(param1:NKGatewayUser) : void
      {
         this.reset();
         this._user = param1;
         this._user.gotItemsSignal.add(this.onGotItems);
      }
      
      public function reset() : void
      {
         if(this._user !== null)
         {
            this._user.gotItemsSignal.remove(this.onGotItems);
            this._user = null;
         }
      }
      
      public function depositBloonstones(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:ResourceStore = ResourceStore.getInstance();
         var _loc6_:Number = GameMods.getModifier(GameModConstants.BLOONSTONES_EARN_MOD);
         _loc5_.bloonstonesDirect = _loc5_.bloonstonesDirect + param3 * _loc6_;
         Premium.premiumItemPurchasedSignal.dispatch(param1,param2,param4);
      }
      
      public function isStarterPackPurchased() : Boolean
      {
         return this._starterPackPurchased;
      }
      
      public function showStore(param1:Array) : void
      {
         t.obj(param1);
         MonkeySystem.getInstance().nkGatewayUser.showItemsToBuy(param1);
         Premium.openedStoreSignal.dispatch();
      }
      
      public function showStoreForBloonstones(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = [{
            "id":Premium.PILE_OF_BLOONSTONES_ID,
            "quantity":_loc3_
         },{
            "id":Premium.BASKET_OF_BLOONSTONES_ID,
            "quantity":_loc4_
         },{
            "id":Premium.CHEST_OF_BLOONSTONES_ID,
            "quantity":_loc5_
         },{
            "id":Premium.MOUNTAIN_OF_BLOONSTONES_ID,
            "quantity":_loc6_
         }];
         if(_loc3_ > 0 || _loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
         {
            _loc7_.sortOn("quantity",Array.DESCENDING);
         }
         _loc7_.unshift({
            "id":Premium.STARTER_PACK_ID,
            "quantity":0
         });
         this.showStore(_loc7_);
      }
      
      public function showStoreForItem(param1:Vector.<int> = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         if(param1 != null)
         {
            for each(_loc3_ in param1)
            {
               _loc2_.push({
                  "id":_loc3_,
                  "quantity":0
               });
            }
         }
         this.showStore(_loc2_);
      }
      
      public function processInventory(param1:NKGatewayUser) : void
      {
         var itemArray:Array = null;
         var item:Object = null;
         var consumeNextItem:Function = null;
         var coinsItems:Object = null;
         var permanentItem:Object = null;
         var nkGatewayUser:NKGatewayUser = param1;
         consumeNextItem = function(param1:Object = null):void
         {
            var result:Object = param1;
            if(itemArray.length == 0)
            {
               return;
            }
            var item:Object = itemArray.pop();
            nkGatewayUser.consumeIgcItem(item.uuid).then(consumeNextItem,function fail(param1:Object):void
            {
               t.obj(param1);
            });
         };
         var igcItems:Object = nkGatewayUser.inventory.igcItems;
         itemArray = [];
         for each(item in igcItems)
         {
            itemArray.push(item);
         }
         consumeNextItem();
         coinsItems = nkGatewayUser.inventory.coinsItems;
         for each(permanentItem in coinsItems)
         {
            if(permanentItem.id == Premium.STARTER_PACK_ID)
            {
               this._starterPackPurchased = true;
               break;
            }
         }
      }
      
      private function onShowStoreSignal() : void
      {
         this.showStoreForBloonstones();
      }
      
      private function onGotItems(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         if(param1.success)
         {
            _loc2_ = param1.items;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               switch(_loc4_.id)
               {
                  case Premium.BLOONSTONES250:
                     this.depositBloonstones(Premium.BLOONSTONES250,1,Premium.PILE_OF_BLOONSTONES_QUANTITY,_loc4_.name);
                     break;
                  case Premium.BLOONSTONES550:
                     this.depositBloonstones(Premium.BLOONSTONES550,1,Premium.BASKET_OF_BLOONSTONES_QUANTITY,_loc4_.name);
                     break;
                  case Premium.BLOONSTONES1200:
                     this.depositBloonstones(Premium.BLOONSTONES1200,1,Premium.CHEST_OF_BLOONSTONES_QUANTITY,_loc4_.name);
                     break;
                  case Premium.BLOONSTONES3250:
                     this.depositBloonstones(Premium.BLOONSTONES3250,1,Premium.MOUNTAIN_OF_BLOONSTONES_QUANTITY,_loc4_.name);
                     break;
                  case Premium.STARTER_PACK_ID:
                     this.addStarterPack(_loc4_.name);
               }
               _loc3_++;
            }
         }
      }
      
      private function addStarterPack(param1:String) : void
      {
         if(this._starterPackPurchased == false)
         {
            this._starterPackPurchased = true;
            ResourceStore.getInstance().addMoneyWithoutSaving(6000);
            ResourceStore.getInstance().bloonstonesDirect = ResourceStore.getInstance().bloonstonesDirect + 500;
            Premium.premiumItemPurchasedSignal.dispatch(Premium.STARTER_PACK_ID,1,param1);
         }
      }
   }
}

class SingletonBlocker#985
{
    
   
   function SingletonBlocker#985()
   {
      super();
   }
}
