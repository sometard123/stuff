package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.SpecialItemsPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class SpecialItemsPanel extends HideRevealViewBottomUIPanel
   {
       
      
      public var _initialSize:Rectangle;
      
      private var _clip:SpecialItemsPanelClip;
      
      private var _myMonkeysButton:ButtonControllerBase;
      
      private var _myTracksButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _scrollBar:ScrollBar;
      
      private var _contentArea:MovieClip;
      
      private var _contentContainer:Sprite;
      
      private var _viewIsActive:Boolean = false;
      
      private const _specialItemStore:SpecialItemStore = SpecialItemStore.getInstance();
      
      private const _specialItemData:SpecialItemData = SpecialItemData.getInstance();
      
      private const _items:Vector.<SpecialItemDefinition> = this._specialItemData.allDefinitions;
      
      private const _itemDescriptions:Vector.<SpecialItemDescription> = new Vector.<SpecialItemDescription>();
      
      public function SpecialItemsPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this.isModal = true;
         this.init();
      }
      
      private function init() : void
      {
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         SpecialItemStore.specialItemsStateChanged.add(this.onSpecialItemChanged);
         SpecialItemStore.specialItemsLoaded.add(this.onSpecialItemChanged);
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new SpecialItemsPanelClip();
         addChild(this._clip);
         this._initialSize = new Rectangle(0,0,this._clip.background.width,this._clip.background.height);
         this._contentArea = this._clip.contentArea;
         this._myMonkeysButton = new ButtonControllerBase(this._clip.myMonkeyButton);
         this._myMonkeysButton.setClickFunction(this.myMonkeyClicked);
         this._myTracksButton = new ButtonControllerBase(this._clip.myTrackButton);
         this._myTracksButton.setClickFunction(this.myTrackClicked);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(this.closeButtonClicked);
         this._contentContainer = new Sprite();
         this.addChild(this._contentContainer);
         this._contentContainer.x = this._contentArea.x;
         this._contentContainer.y = this._contentArea.y;
         this._contentContainer.mask = this._contentArea;
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._contentContainer,this._contentArea,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         this._scrollBar.fitView = this._clip.background;
         this._scrollBar.extraHeight = -40;
         enableDefaultOnResize(this._clip);
         this.buildView();
         this.refreshView();
      }
      
      private function destroyView() : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         this._initialSize = null;
         this._itemDescriptions.length = 0;
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         LGDisplayListUtil.getInstance().removeAllChildren(this._contentContainer);
         this._contentArea = null;
         this._contentContainer.mask = null;
         this._contentContainer = null;
         this._closeButton.destroy();
         this._closeButton = null;
         this._scrollBar.destroy();
         this._scrollBar = null;
         this._clip = null;
         disableDefaultOnResize();
      }
      
      private function onReset() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._itemDescriptions.length)
         {
            this._itemDescriptions[_loc1_].syncWithItem(null);
            _loc1_++;
         }
      }
      
      private function onSpecialItemChanged() : void
      {
         this.refreshView();
      }
      
      private function myMonkeyClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().myTowersPanel);
      }
      
      private function myTrackClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().myTracksPanel);
      }
      
      private function closeButtonClicked() : void
      {
         hide();
      }
      
      private function refreshView() : void
      {
         var _loc3_:SpecialItemDescription = null;
         if(!this._viewIsActive)
         {
            return;
         }
         var _loc1_:Vector.<SpecialItem> = this._specialItemStore.specialItemsInInventory;
         this.includeConsumables(_loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = this.findItemDescription(_loc1_[_loc2_].definition.id);
            _loc3_.syncWithItem(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      private function includeConsumables(param1:Vector.<SpecialItem>) : void
      {
         var _loc2_:Class = SpecialItemData.getInstance().RED_HOT_SPIKES.logic;
         var _loc3_:Class = SpecialItemData.getInstance().MONKEY_BOOSTS.logic;
         var _loc4_:Class = SpecialItemData.getInstance().BOSS_CHILL.logic;
         var _loc5_:Class = SpecialItemData.getInstance().BOSS_BANE.logic;
         var _loc6_:Class = SpecialItemData.getInstance().BOSS_BLAST.logic;
         var _loc7_:Class = SpecialItemData.getInstance().BOSS_WEAKEN.logic;
         var _loc8_:SpecialItem = new _loc2_(SpecialItemData.getInstance().RED_HOT_SPIKES,0);
         var _loc9_:SpecialItem = new _loc3_(SpecialItemData.getInstance().MONKEY_BOOSTS,0);
         var _loc10_:SpecialItem = new _loc4_(SpecialItemData.getInstance().BOSS_CHILL,0);
         var _loc11_:SpecialItem = new _loc5_(SpecialItemData.getInstance().BOSS_BANE,0);
         var _loc12_:SpecialItem = new _loc4_(SpecialItemData.getInstance().BOSS_BLAST,0);
         var _loc13_:SpecialItem = new _loc5_(SpecialItemData.getInstance().BOSS_WEAKEN,0);
         param1.push(_loc8_);
         param1.push(_loc9_);
         if(Constants.ENABLE_ANTI_BOSS_ABILITIES)
         {
            param1.push(_loc10_);
            param1.push(_loc11_);
            param1.push(_loc12_);
            param1.push(_loc13_);
         }
      }
      
      private function buildView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SpecialItemDefinition = null;
         var _loc5_:SpecialItemDescription = null;
         var _loc6_:int = 0;
         if(this._items != null)
         {
            _loc1_ = 25;
            _loc2_ = 20;
            _loc3_ = 100;
            _loc6_ = 0;
            while(_loc6_ < this._items.length)
            {
               _loc4_ = this._items[_loc6_];
               if(_loc4_.id != SpecialItemData.getInstance().CITY_CASH.id)
               {
                  _loc5_ = new SpecialItemDescription(_loc4_);
                  _loc5_.x = _loc1_;
                  _loc5_.y = _loc2_;
                  this._contentContainer.addChild(_loc5_);
                  _loc2_ = _loc2_ + _loc3_;
                  this._itemDescriptions.push(_loc5_);
               }
               _loc6_++;
            }
            this._contentContainer.height = this._contentContainer.height - 20;
            this._scrollBar.fit();
         }
      }
      
      private function findItemDescription(param1:String) : SpecialItemDescription
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._itemDescriptions.length)
         {
            if(param1 == this._itemDescriptions[_loc2_].specialItemID)
            {
               return this._itemDescriptions[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         this.initView();
         this.sort();
         super.reveal(param1);
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
      
      private function sort() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:SpecialItemDescription = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._itemDescriptions.length)
         {
            if(this._itemDescriptions[_loc1_].isItemSet == true)
            {
               _loc2_ = this.findNextEmptyDescriptionIndex();
               if(_loc2_ < _loc1_)
               {
                  _loc3_ = this._itemDescriptions[_loc1_].x;
                  _loc4_ = this._itemDescriptions[_loc1_].y;
                  _loc5_ = this._itemDescriptions[_loc1_];
                  this._itemDescriptions[_loc1_].x = this._itemDescriptions[_loc2_].x;
                  this._itemDescriptions[_loc1_].y = this._itemDescriptions[_loc2_].y;
                  this._itemDescriptions[_loc1_] = this._itemDescriptions[_loc2_];
                  this._itemDescriptions[_loc2_].x = _loc3_;
                  this._itemDescriptions[_loc2_].y = _loc4_;
                  this._itemDescriptions[_loc2_] = _loc5_;
               }
            }
            _loc1_++;
         }
      }
      
      private function findNextEmptyDescriptionIndex() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._itemDescriptions.length)
         {
            if(this._itemDescriptions[_loc1_].isItemSet == false)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
   }
}
