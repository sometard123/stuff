package ninjakiwi.monkeyTown.town.ui.salePanels
{
   import assets.ui.BuyMonkeyKnowledgePacksPanelClip;
   import assets.ui.Spam250Clip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.premiums.KongStoreAction;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.warning.MissingSomethingPanel;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.GenericConfirmPurchasePanel;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class MonkeyKnowledgePackSalePanel extends HideRevealView
   {
      
      private static const STACK_SPACING:int = 90;
      
      private static const PACK_IDS:Array = [672,673,674,710,711,712,713];
       
      
      private var _clip:BuyMonkeyKnowledgePacksPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _saleItemStack:SaleItemStack;
      
      private var _confirmPurchasePanel:GenericConfirmPurchasePanel;
      
      private var _contentContainer:Sprite;
      
      private var _countdownTimer:CountdownTimer = null;
      
      public function MonkeyKnowledgePackSalePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new BuyMonkeyKnowledgePacksPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._saleItemStack = new SaleItemStack();
         this._confirmPurchasePanel = TownUI.getInstance().genericConfirmPurchasePanel;
         this._contentContainer = new Sprite();
         super(param1);
         isModal = true;
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._contentContainer.x = this._clip.contentArea.x;
         this._contentContainer.y = this._clip.contentArea.y;
         this._clip.removeChild(this._clip.contentArea);
         this._clip.addChild(this._contentContainer);
         SaleEventData.getInstance().readySignal.add(this.build);
         this._closeButton.setClickFunction(this.hide);
         enableDefaultOnResize(this._clip);
      }
      
      public function setSaleState(param1:Boolean) : void
      {
         this._clip.timer.visible = param1;
         this._clip.backgroundSale.visible = param1;
         this._clip.backgroundSale.visible = param1;
         this._clip.backgroundStandard.visible = !param1;
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         super.reveal(param1);
         this.build();
         if(this._countdownTimer == null)
         {
            this._countdownTimer = new CountdownTimer(this._clip.timer.timerField,0);
         }
         this._countdownTimer.start();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         if(this._countdownTimer !== null)
         {
            this._countdownTimer.stop();
         }
      }
      
      private function build() : void
      {
         var sale:SaleEventItem = null;
         if(this._countdownTimer == null)
         {
            this._countdownTimer = new CountdownTimer(this._clip.timer.timerField,0);
         }
         sale = null;
         var dataID:String = "nonSaleItemsData";
         var activeSales:Array = SaleEventData.getInstance().getActiveKnowledgeSales();
         if(activeSales.length === 0)
         {
            this.setSaleState(false);
            dataID = "nonSaleItemsData";
         }
         else
         {
            this.setSaleState(true);
            sale = activeSales[0];
            dataID = sale.dataID;
         }
         this._contentContainer.removeChildren();
         SkuSettingsLoader.getGameEventDataByID("knowledgePackSale",dataID,function(param1:Object):void
         {
            buildWithData(param1,sale);
         });
      }
      
      private function buildWithData(param1:Object, param2:SaleEventItem = null) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:SaleItemInfoBox = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:* = param2 !== null;
         var _loc4_:Array = param1.saleItems;
         if(_loc3_)
         {
            this._clip.saleSash.visible = true;
         }
         else
         {
            this._clip.saleSash.visible = false;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_].toString();
            _loc7_ = SaleItemData.getItemData(_loc6_);
            _loc8_ = new SaleItemInfoBox(_loc7_);
            _loc8_.buySignal.add(this.buyItem);
            _loc8_.y = _loc5_ * STACK_SPACING;
            this._contentContainer.addChild(_loc8_);
            _loc5_++;
         }
         if(_loc3_)
         {
            this._countdownTimer.setEndTime(param2.endTime);
         }
      }
      
      private function buyItem(param1:Object) : void
      {
         var nkCoinBalance:int = 0;
         var data:Object = param1;
         if(!Kong.isOnKong())
         {
            nkCoinBalance = MonkeySystem.getInstance().nkGatewayUser.coins;
            if(nkCoinBalance < data.cost)
            {
               TownUI.getInstance().purchaseNKCoinsPanel.reveal();
               return;
            }
         }
         this._confirmPurchasePanel.configure(data.title,data.cost,function(param1:Boolean):void
         {
            if(param1)
            {
               if(Kong.isOnKong())
               {
                  buyKong(data);
               }
               else
               {
                  buyNK(data);
               }
            }
         });
         this._confirmPurchasePanel.reveal();
      }
      
      private function buyNK(param1:Object) : void
      {
         MonkeySystem.getInstance().nkGatewayUser.buyNKCoinsItem(param1.itemID,param1.itemID.toString()).then(this.onGotItemsNK,this.onFailNK);
      }
      
      private function onGotItemsNK(param1:Object) : void
      {
         var _loc2_:Object = SaleItemData.getItemData(param1.id);
         if(_loc2_ !== null)
         {
            if(_loc2_.hasOwnProperty("quantity") && _loc2_.hasOwnProperty("variableToIncrement"))
            {
               MonkeyKnowledge.getInstance()[_loc2_.variableToIncrement] = MonkeyKnowledge.getInstance()[_loc2_.variableToIncrement] + _loc2_.quantity;
            }
         }
      }
      
      private function onFailNK() : void
      {
      }
      
      private function buyKong(param1:Object) : void
      {
         ErrorReporter.externalLog("kong kallback pre call",param1.itemID.toString());
         var _loc2_:KongStoreAction = new KongStoreAction([param1.itemID.toString()],this.onKongStoreActionComplete);
      }
      
      private function onKongStoreActionComplete(param1:KongStoreAction) : void
      {
         ErrorReporter.externalLog("kong kallback");
         ErrorReporter.externalLog("kong kallback b - ",param1.items.length);
         ErrorReporter.deep(param1);
         this.checkForKnowledgeInventory();
      }
      
      private function checkForKnowledgeInventory() : void
      {
         ErrorReporter.externalLog("MonkeyKnowledgePackSalePanel::checkForKnowledgeInventory( )");
         Kong.getInventory(function onUserItems(param1:Object):void
         {
            var _loc2_:String = null;
            var _loc3_:int = 0;
            var _loc4_:Object = null;
            ErrorReporter.externalLog("MonkeyKnowledgePackSalePanel::checkForKnowledgeInventory( ) callback");
            ErrorReporter.deep(param1);
            if(param1.success)
            {
               ErrorReporter.externalLog(t.obj(param1));
               _loc3_ = 0;
               while(_loc3_ < param1.data.length)
               {
                  _loc4_ = param1.data[_loc3_];
                  if(isPack(_loc4_.identifier))
                  {
                     awardPackByID(_loc4_.id,_loc4_.identifier);
                  }
                  _loc3_++;
               }
            }
         });
      }
      
      private function isPack(param1:*) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < PACK_IDS.length)
         {
            if(PACK_IDS[_loc2_].toString() == param1.toString())
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function awardPackByID(param1:int, param2:String) : void
      {
         var instanceIdentifier:int = param1;
         var id:String = param2;
         Kong.useItem(instanceIdentifier,function(param1:Object):void
         {
            var _loc2_:Object = null;
            if(param1.success)
            {
               ErrorReporter.externalLog("use item callback SUCCESS",t.obj(param1));
               _loc2_ = SaleItemData.getItemData(id);
               if(_loc2_.hasOwnProperty("quantity") && _loc2_.hasOwnProperty("variableToIncrement"))
               {
                  ErrorReporter.externalLog(t.obj(_loc2_));
                  MonkeyKnowledge.getInstance()[_loc2_.variableToIncrement] = MonkeyKnowledge.getInstance()[_loc2_.variableToIncrement] + _loc2_.quantity;
               }
            }
         });
      }
   }
}
