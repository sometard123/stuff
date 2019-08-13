package ninjakiwi.monkeyTown.saleEvents
{
   import com.ninjakiwi.gateway.login.LoginInfo;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeSecretCardAnimationController;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.DateTool;
   import org.osflash.signals.Signal;
   
   public class SaleEventData
   {
      
      private static var instance:SaleEventData;
       
      
      private var _eventData:Object = null;
      
      private var _saleItems:Vector.<SaleEventItem>;
      
      public const readySignal:Signal = new Signal();
      
      private var _isReady:Boolean = false;
      
      public const KNOWLEDGE_SALE_KEY:String = "knowledgePackSale";
      
      private const allSaleIDs:Array = [this.KNOWLEDGE_SALE_KEY];
      
      public function SaleEventData(param1:SingletonEnforcer#1537)
      {
         this._saleItems = new Vector.<SaleEventItem>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use SaleEventData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : SaleEventData
      {
         if(instance == null)
         {
            instance = new SaleEventData(new SingletonEnforcer#1537());
         }
         return instance;
      }
      
      private function init() : void
      {
         SkuSettingsLoader.getGameEvents(function(param1:Object):void
         {
            onSkuSettingsDataLoaded(param1);
         });
      }
      
      private function onSkuSettingsDataLoaded(param1:Object) : void
      {
         this._eventData = param1;
         this.processSKUData();
      }
      
      private function processSKUData() : void
      {
         var itemData:Object = null;
         var saleItem:SaleEventItem = null;
         if(false == MonkeySystem.getInstance().serverTimeHasBeenInitialised)
         {
            MonkeySystem.getInstance().serverTimeHasBeenInitialisedSignal.addOnce(function():void
            {
               processSKUData();
            });
            return;
         }
         for each(itemData in this._eventData)
         {
            if(this.allSaleIDs.indexOf(itemData.type) !== -1)
            {
               if(SaleEventItem.validateData(itemData))
               {
                  if(false !== itemData.active)
                  {
                     saleItem = new SaleEventItem(itemData);
                     this._saleItems.push(saleItem);
                  }
               }
            }
         }
         this._isReady = true;
         this.readySignal.dispatch();
      }
      
      public function getActiveSales() : Array
      {
         var _loc2_:SaleEventItem = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._saleItems)
         {
            if(DateTool.timeRangeIsCurrent(_loc2_.startTime,_loc2_.endTime) && _loc2_.active)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getActiveKnowledgeSales() : Array
      {
         var _loc3_:SaleEventItem = null;
         var _loc1_:Array = this.getActiveSales();
         var _loc2_:Array = [];
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.type == this.KNOWLEDGE_SALE_KEY)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
   }
}

class SingletonEnforcer#1537
{
    
   
   function SingletonEnforcer#1537()
   {
      super();
   }
}
