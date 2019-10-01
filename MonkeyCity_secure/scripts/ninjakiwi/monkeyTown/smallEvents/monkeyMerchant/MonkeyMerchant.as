package ninjakiwi.monkeyTown.smallEvents.monkeyMerchant
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeRewards;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.ui.NotEnoughBloonstonesPanel;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class MonkeyMerchant extends GameEventSubManager
   {
       
      
      private var _notEnoughBloonstonesPanel:NotEnoughBloonstonesPanel;
      
      private var _wares:Vector.<MonkeyMerchantWare>;
      
      public function MonkeyMerchant()
      {
         this._wares = new Vector.<MonkeyMerchantWare>();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "monkeyMerchant";
      }
      
      public function reset(... rest) : void
      {
         this._wares.length = 0;
         GameSignals.CITY_IS_FINALLY_READY.remove(this.updateOwnedItemStates);
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         this.reset();
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         SkuSettingsLoader.getGameEventDataByID("monkeyMerchant",_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         if(null == param1 || false == param1.hasOwnProperty("wares"))
         {
            this.reset();
            return;
         }
         GameSignals.CITY_IS_FINALLY_READY.remove(this.updateOwnedItemStates);
         GameSignals.CITY_IS_FINALLY_READY.add(this.updateOwnedItemStates);
         this.populateWares(param1);
         callWhenCurrentEventEnds(this.reset);
      }
      
      private function populateWares(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         var _loc4_:MonkeyMerchantWare = null;
         this._wares.length = 0;
         for(_loc2_ in param1.wares)
         {
            _loc3_ = param1.wares[_loc2_];
            if(!(false == _loc3_.hasOwnProperty("available") || false == _loc3_.hasOwnProperty("price") || false == _loc3_.available))
            {
               _loc4_ = new MonkeyMerchantWare().Price(_loc3_.price).SpecialItemID(_loc2_).HasItem(false);
               this._wares.push(_loc4_);
            }
         }
      }
      
      public function requestToBuyWareFromID(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._wares.length)
         {
            if(this._wares[_loc2_].specialItemID == param1)
            {
               return this.requestToBuyWare(this._wares[_loc2_]);
            }
            _loc2_++;
         }
         return false;
      }
      
      public function requestToBuyWare(param1:MonkeyMerchantWare) : Boolean
      {
         if(param1.hasItem || SpecialItemStore.getInstance().hasSpecialItem(param1.specialItemID))
         {
            return false;
         }
         var _loc2_:ResourceStore = ResourceStore.getInstance();
         if(_loc2_.bloonstones < param1.price)
         {
            return false;
         }
         this.onBuyWareSuccessful(param1);
         _loc2_.bloonstones = _loc2_.bloonstones - param1.price;
         return true;
      }
      
      private function onBuyWareSuccessful(param1:MonkeyMerchantWare) : void
      {
         SpecialItemStore.getInstance().acquiredSpecialItem(param1.specialItemID);
         param1.HasItem(true);
      }
      
      public function updateOwnedItemStates() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:int = 0;
         while(_loc1_ < this._wares.length)
         {
            _loc2_ = SpecialItemStore.getInstance().hasSpecialItem(this._wares[_loc1_].specialItemID);
            this._wares[_loc1_].HasItem(_loc2_);
            _loc1_++;
         }
      }
   }
}
