package ninjakiwi.monkeyTown.town.ui.newsPanelScroller
{
   import assets.ui.NewsPanelScrollerItemClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.DefaultEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.FriendCrateInfoBox;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class NewsPanelScrollerItem extends Sprite
   {
       
      
      private var _data:Object = null;
      
      private const _clip:NewsPanelScrollerItemClip = new NewsPanelScrollerItemClip();
      
      private var _countdownTimer:CountdownTimer;
      
      private var _buttonController:ButtonControllerBase;
      
      public const requestCloseSignal:Signal = new Signal();
      
      public function NewsPanelScrollerItem(param1:Object)
      {
         this._buttonController = new ButtonControllerBase(this._clip.hit);
         super();
         this._data = param1;
         this._clip.countdown.visible = false;
         addChild(this._clip);
         this.build();
      }
      
      private function build() : void
      {
         var _loc1_:Loader = new Loader();
         var _loc2_:URLRequest = new URLRequest(this._data.newsImage);
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         _loc1_.load(_loc2_,_loc3_);
         this._clip.container.addChild(_loc1_);
         this._clip.hit.alpha = 0;
         if(this._data.isNews)
         {
            if(this.hasValidOnClick(this._data))
            {
               this._buttonController.setClickFunction(this.onHit);
            }
            else
            {
               this._buttonController.disableMouseInteraction();
            }
         }
         else
         {
            this._buttonController.setClickFunction(this.onHit);
         }
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._clip.countdown.timerMessage.text = "";
         if(this._data.isEvent)
         {
            this._clip.countdown.visible = true;
            this._countdownTimer = new CountdownTimer(this._clip.countdown.timerField,this._data.gameplayEvent.endTime);
            this._clip.countdown.timerMessage.text = "Event ends in:";
         }
         else if(this._data.isSale)
         {
            this._clip.countdown.visible = true;
            this._countdownTimer = new CountdownTimer(this._clip.countdown.timerField,this._data.saleEvent.endTime);
            this._clip.countdown.timerMessage.text = "Sale ends in:";
         }
      }
      
      private function hasValidOnClick(param1:Object) : Boolean
      {
         if(false === param1.hasOwnProperty("onClick") || param1.onClick === null || EventsMenuData.getItemClass(param1.onClick) === DefaultEventMenuItem)
         {
            return false;
         }
         return true;
      }
      
      private function onHit() : void
      {
         var item:EventsMenuItem = null;
         var itemClass:Class = null;
         if(this._data.isEvent)
         {
            itemClass = EventsMenuData.getItemClass(this._data.gameplayEvent.type);
            try
            {
               item = new itemClass(this._data.gameplayEvent);
               item.onOpen();
               this.requestCloseSignal.dispatch();
            }
            catch(e:Error)
            {
            }
         }
         else if(this._data.isSale)
         {
            itemClass = EventsMenuData.getItemClass(this._data.saleEvent.type);
            try
            {
               item = new itemClass();
               item.onOpen();
               this.requestCloseSignal.dispatch();
            }
            catch(e:Error)
            {
            }
         }
         else if(this._data.isNews)
         {
            itemClass = EventsMenuData.getItemClass(this._data.onClick);
            try
            {
               item = new itemClass(this._data.gameplayEvent);
               item.onOpen();
               this.requestCloseSignal.dispatch();
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._clip.spinner,false,false,true);
         this._clip.removeChild(this._clip.spinner);
      }
      
      public function update() : void
      {
         if(this._countdownTimer !== null)
         {
            this._countdownTimer.update();
         }
      }
   }
}
