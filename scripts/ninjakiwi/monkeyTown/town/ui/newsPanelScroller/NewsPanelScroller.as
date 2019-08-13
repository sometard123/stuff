package ninjakiwi.monkeyTown.town.ui.newsPanelScroller
{
   import assets.ui.NewsPanelScrollerClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.FirstTimeTriggerManager;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class NewsPanelScroller extends HideRevealView
   {
       
      
      private const _clip:NewsPanelScrollerClip = new NewsPanelScrollerClip();
      
      private var _data:Object = null;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _contentContainer:Sprite;
      
      private const _monitorEvents:Array = ["ctMilestones","ctOccupation"];
      
      private var _scrollBar:ScrollBar;
      
      private var _pendingCalls:Vector.<PendingCall>;
      
      private var _additionalEvents:Array;
      
      private var _updateTimer:Timer;
      
      private const BLEED_X:int = 30;
      
      private const STACK_ITEM_HEIGHT:int = 180;
      
      private const STACK_SPACING:int = 190.0;
      
      private const NEWS_REVEAL_RATE:Number = 8.64E7;
      
      private const HAS_SEEN_KEY:String = "hasSeenNewsPanelScroller";
      
      private const SHOW_EVERY_TIME:Boolean = false;
      
      private var _newsPanelItems:Vector.<NewsPanelScrollerItem>;
      
      public function NewsPanelScroller(param1:DisplayObjectContainer, param2:* = null)
      {
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._contentContainer = new Sprite();
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._contentContainer,this._clip.contentArea,true);
         this._pendingCalls = new Vector.<PendingCall>();
         this._additionalEvents = [];
         this._updateTimer = new Timer(1000);
         this._newsPanelItems = new Vector.<NewsPanelScrollerItem>();
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip,new Rectangle(0,0,800,600));
         this._clip.contentArea.visible = false;
         this._contentContainer.x = this._clip.contentArea.x;
         this._contentContainer.y = this._clip.contentArea.y;
         this._clip.addChild(this._contentContainer);
         this._contentContainer.mask = this._clip.masker;
         this._closeButton.setClickFunction(this.hide);
         this._clip.addChild(this._clip.scrollbar);
         GameEventManager.gameEventManagerReadySignal.addOnce(this.onGameEventManagerReady);
         GameSignals.CITY_IS_FINALLY_READY.addOnce(this.onCityLoaded);
         this._updateTimer.addEventListener(TimerEvent.TIMER,this.tick);
      }
      
      private function tick(param1:TimerEvent = null) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._newsPanelItems.length)
         {
            this._newsPanelItems[_loc2_].update();
            _loc2_++;
         }
      }
      
      private function onCityLoaded() : void
      {
         this.checkForReveal();
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.checkForReveal);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.checkForReveal);
      }
      
      private function checkForReveal(... rest) : void
      {
         var that:NewsPanelScroller = null;
         var arguments:Array = rest;
         if(FirstTimeTriggerManager.tutorialIsActive)
         {
            return;
         }
         that = this;
         KeyValueStore.getInstance().get(this.HAS_SEEN_KEY,function(param1:Object):void
         {
            var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
            if(param1 == null || _loc2_ - param1.timeLastSeen > NEWS_REVEAL_RATE || SHOW_EVERY_TIME)
            {
               callDelayedFunctions();
               if(_newsPanelItems.length > 0)
               {
                  PanelManager.getInstance().showPanel(that);
                  KeyValueStore.getInstance().set(HAS_SEEN_KEY,{"timeLastSeen":_loc2_});
               }
            }
         });
      }
      
      private function onGameEventManagerReady() : void
      {
         this.buildData();
         this.build();
         this.callDelayedFunctions();
      }
      
      private function buildData() : void
      {
         var _loc1_:Array = this.getActiveEventItems();
         var _loc2_:Array = this.getActiveSaleItems();
         var _loc3_:Array = this.getActiveNewsItems();
      }
      
      private function getImageForCurrentTier(param1:Object) : String
      {
         if(false === param1.hasOwnProperty("levels") || false === param1.hasOwnProperty("images"))
         {
            return null;
         }
         var _loc2_:int = GameEventManager.findLevelTierIndex(param1.levels);
         var _loc3_:Array = param1.images;
         if(_loc2_ >= _loc3_.length)
         {
            _loc2_ = _loc3_.length - 1;
         }
         var _loc4_:String = null;
         var _loc5_:int = 0;
         while(_loc5_ <= _loc2_)
         {
            if(_loc3_[_loc5_] !== null)
            {
               _loc4_ = _loc3_[_loc5_];
            }
            _loc5_++;
         }
         return SkuSettingsLoader.expandImageURL(_loc4_);
      }
      
      private function build() : void
      {
         var _loc8_:* = null;
         var _loc9_:GameplayEvent = null;
         var _loc10_:NewsPanelScrollerItem = null;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         if(!GameEventManager.isInitialised)
         {
            this.delayFunction(this.build);
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._newsPanelItems.length)
         {
            this._newsPanelItems[_loc1_].requestCloseSignal.removeAll();
            _loc1_++;
         }
         this._newsPanelItems.length = 0;
         this._contentContainer.removeChildren();
         var _loc2_:Array = this.getActiveEventItems();
         var _loc3_:Array = this.getActiveSaleItems();
         var _loc4_:Array = this.getActiveNewsItems();
         var _loc5_:Array = _loc4_.concat(_loc2_).concat(_loc3_);
         _loc5_.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc7_];
            _loc9_ = _loc5_[_loc7_].gameplayEvent;
            if(_loc9_ !== null)
            {
               _loc11_ = SkuSettingsLoader.findGameEventDataByID(_loc9_.type,_loc9_.dataID);
               if(_loc11_ !== null && _loc11_.hasOwnProperty("images"))
               {
                  _loc12_ = this.getImageForCurrentTier(_loc11_);
                  if(_loc12_ !== null)
                  {
                     _loc8_.newsImage = _loc12_;
                  }
               }
            }
            if(_loc8_.newsImage !== null)
            {
               _loc10_ = new NewsPanelScrollerItem(_loc8_);
               _loc10_.x = -this.BLEED_X;
               _loc10_.y = _loc6_ * this.STACK_SPACING;
               this._newsPanelItems.push(_loc10_);
               this._contentContainer.addChild(_loc10_);
               _loc10_.requestCloseSignal.add(this.hide);
               _loc6_++;
            }
            _loc7_++;
         }
         if(this._newsPanelItems.length < 3)
         {
            this._clip.scrollbar.visible = false;
         }
         else
         {
            this._clip.scrollbar.visible = true;
         }
      }
      
      private function getActiveNewsItems() : Array
      {
         var _loc4_:Object = null;
         var _loc1_:Array = SkuSettingsLoader.getNewsItems();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc4_.isNews = true;
            if(false === _loc4_.hasOwnProperty("active") || true === _loc4_.active)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getActiveEventItems() : Array
      {
         var _loc4_:GameplayEvent = null;
         var _loc5_:Object = null;
         var _loc1_:Array = GameEventManager.getInstance().getActiveEvents();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = SkuSettingsLoader.getMetaDataForEvent(_loc4_.type,_loc4_.dataID);
            _loc5_.gameplayEvent = _loc4_;
            _loc5_.isEvent = true;
            _loc2_.push(_loc5_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getActiveSaleItems() : Array
      {
         var _loc4_:SaleEventItem = null;
         var _loc5_:Object = null;
         var _loc1_:Array = SaleEventData.getInstance().getActiveSales();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = SkuSettingsLoader.getMetaDataForEvent(_loc4_.type,_loc4_.dataID);
            _loc5_.saleEvent = _loc4_;
            _loc5_.isSale = true;
            _loc2_.push(_loc5_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function delayFunction(param1:Function, param2:Array = null, param3:* = null) : void
      {
         this._pendingCalls.push(new PendingCall(param1,param2,param3));
      }
      
      private function callDelayedFunctions() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._pendingCalls.length)
         {
            this._pendingCalls[_loc1_].execute();
            _loc1_++;
         }
         this._pendingCalls.length = 0;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal();
         this.build();
         this._updateTimer.reset();
         this._updateTimer.start();
         this._scrollBar.setToTop();
         this.tick();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide();
         this._updateTimer.stop();
      }
   }
}

class PendingCall
{
    
   
   public var callFunction:Function;
   
   public var callArgs:Array;
   
   public var thisObj;
   
   function PendingCall(param1:Function, param2:Array = null, param3:* = null)
   {
      super();
      this.callFunction = param1;
      this.callArgs = param2;
      this.thisObj = param3;
   }
   
   public function execute() : void
   {
      if(this.callArgs !== null)
      {
         this.callFunction.apply(this.thisObj,this.callArgs);
      }
      else
      {
         this.callFunction.call(this.thisObj);
      }
   }
}
