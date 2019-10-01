package ninjakiwi.monkeyTown.saleEvents.ui
{
   import assets.ui.MonkeyKnowledgeSaleIntroPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.achievements.AchievementDefinition;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.pvp.InviteUser;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.DustBurst;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class KnowledgePackSaleIntroPanel extends HideRevealView
   {
       
      
      private var _clip:MonkeyKnowledgeSaleIntroPanelClip;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private const FLAG_KEY:String = "KnowledgePackSaleIntroPanelData";
      
      private const SHOW_EVERY_SESSION:Boolean = true;
      
      private var _seenThisSession:Boolean = false;
      
      public var DisplayUtil:LGDisplayListUtil;
      
      public function KnowledgePackSaleIntroPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeSaleIntroPanelClip();
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this.DisplayUtil = LGDisplayListUtil.getInstance();
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         GameSignals.CITY_IS_FINALLY_READY.addOnce(this.onCityReady);
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._buyButton.setClickFunction(this.onBuyButtonClick);
         this._closeButton.setClickFunction(hide);
      }
      
      private function onBuyButtonClick() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().knowledgePackSalePanel);
         hide();
      }
      
      private function onCityReady(... rest) : void
      {
         var arguments:Array = rest;
         var resourceStore:ResourceStore = ResourceStore.getInstance();
         if(resourceStore.townLevel < MonkeyKnowledge.UNLOCK_AT_LEVEL)
         {
            resourceStore.townLevelChangedDiffSignal.remove(this.onCityReady);
            resourceStore.townLevelChangedDiffSignal.add(this.onCityReady);
            return;
         }
         var that:KnowledgePackSaleIntroPanel = this;
         KeyValueStore.getInstance().get(this.FLAG_KEY,function(param1:Object):void
         {
            if(SHOW_EVERY_SESSION && false === _seenThisSession || (param1 == null || false == param1.hasSeen))
            {
               if(SaleEventData.getInstance().isReady)
               {
                  revealCheck();
               }
               else
               {
                  SaleEventData.getInstance().readySignal.add(revealCheck);
               }
            }
         });
      }
      
      private function revealCheck() : void
      {
         var _loc1_:Array = SaleEventData.getInstance().getActiveKnowledgeSales();
         if(_loc1_.length > 0)
         {
            PanelManager.getInstance().showPanel(this);
            this.syncToSale(_loc1_[0]);
         }
      }
      
      private function syncToSale(param1:SaleEventItem = null) : void
      {
         var _loc3_:Array = null;
         if(param1 == null)
         {
            _loc3_ = SaleEventData.getInstance().getActiveKnowledgeSales();
            if(_loc3_.length > 0)
            {
               param1 = _loc3_[0];
            }
            else
            {
               return;
            }
         }
         var _loc2_:String = param1.dataID;
         if(this.DisplayUtil.hasLabel(this._clip,_loc2_))
         {
            this._clip.gotoAndStop(_loc2_);
         }
         else
         {
            this._clip.gotoAndStop(1);
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this.syncToSale();
         this._seenThisSession = true;
         KeyValueStore.getInstance().set(this.FLAG_KEY,{"hasSeen":true});
      }
   }
}
