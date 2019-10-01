package ninjakiwi.monkeyTown.town.ui.eventsMenu
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventMonitor;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.DefaultEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.KnowledgePackSaleEventMenuItem;
   
   public class EventsMenu extends Sprite
   {
       
      
      private var _stack:EventsMenuStack;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _container:DisplayObjectContainer;
      
      public function EventsMenu(param1:DisplayObjectContainer)
      {
         this._stack = new EventsMenuStack();
         super();
         this._container = param1;
         this._container.addChild(this);
         if(GameEventManager.isInitialised)
         {
            this.init();
         }
         else
         {
            GameEventManager.gameEventManagerReadySignal.add(this.init);
         }
      }
      
      private function init() : void
      {
         addChild(this._stack);
         MonkeyCityMain.globalHideSignal.add(this.onGlobalHideSignal);
         WorldViewSignals.buildWorldStartSignal.add(this.onBuildWorldStart);
         GameSignals.CITY_IS_FINALLY_READY.add(this.onCityLoaded);
         this._system.resizeSignal.add(this.resize);
         GameSignals.LOAD_CITY_BEGIN.add(this.onLoadCityBeginSignal);
         this.build();
         GameEventMonitor.gameEventEnded.add(this.build);
         GameEventMonitor.gameEventStarted.add(this.build);
      }
      
      private function onCityLevelChanged(... rest) : void
      {
         var _loc4_:SaleEventItem = null;
         if(false == MonkeySystem.getInstance().map.worldIsReady)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(ResourceStore.getInstance().townLevel == 2)
         {
            _loc2_ = true;
         }
         var _loc3_:Array = SaleEventData.getInstance().getActiveSales();
         for each(_loc4_ in _loc3_)
         {
            switch(_loc4_.type)
            {
               case "knowledgePackSale":
                  if(ResourceStore.getInstance().townLevel == MonkeyKnowledge.UNLOCK_AT_LEVEL)
                  {
                     _loc2_ = true;
                  }
                  continue;
               default:
                  continue;
            }
         }
         if(_loc2_)
         {
            this.build();
         }
      }
      
      private function onLoadCityBeginSignal() : void
      {
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onCityLevelChanged);
      }
      
      private function onBuildWorldStart() : void
      {
         this._stack.clear();
      }
      
      private function onGlobalHideSignal() : void
      {
         this._stack.clear();
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onCityLevelChanged);
      }
      
      public function onCityLoaded() : void
      {
         this.build();
      }
      
      public function build(... rest) : void
      {
         var _loc3_:GameplayEvent = null;
         var _loc4_:Array = null;
         var _loc5_:SaleEventItem = null;
         var _loc6_:Class = null;
         var _loc7_:EventsMenuItem = null;
         this._stack.clear();
         ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.onCityLevelChanged);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onCityLevelChanged);
         if(ResourceStore.getInstance().townLevel < 2)
         {
            return;
         }
         var _loc2_:Array = GameEventManager.getInstance().getActiveEvents();
         for each(_loc3_ in _loc2_)
         {
            _loc6_ = EventsMenuData.getItemClass(_loc3_.type);
            _loc7_ = new _loc6_(_loc3_);
            _loc7_.endTime = _loc3_.endTime;
            if(_loc7_ is DefaultEventMenuItem)
            {
               _loc7_.name = "Placeholder for " + _loc3_.type;
            }
            this._stack.addItem(_loc7_);
         }
         _loc4_ = SaleEventData.getInstance().getActiveSales();
         for each(_loc5_ in _loc4_)
         {
            switch(_loc5_.type)
            {
               case "knowledgePackSale":
                  if(ResourceStore.getInstance().townLevel >= MonkeyKnowledge.UNLOCK_AT_LEVEL)
                  {
                     this._stack.addItem(new KnowledgePackSaleEventMenuItem(_loc5_));
                  }
                  continue;
               default:
                  continue;
            }
         }
         this._stack.build();
         this._stack.preReveal();
         setTimeout(this._stack.slideInButtons,2000);
         this.resize();
      }
      
      private function resize(... rest) : void
      {
         this.x = this._system.flashStage.stageWidth;
         this.y = 160;
      }
   }
}
