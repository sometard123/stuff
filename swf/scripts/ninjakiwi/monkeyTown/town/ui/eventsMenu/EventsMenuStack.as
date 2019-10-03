package ninjakiwi.monkeyTown.town.ui.eventsMenu
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import flash.display.Sprite;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   
   public class EventsMenuStack extends Sprite
   {
       
      
      private var _items:Array;
      
      private var _buttons:Vector.<EventsMenuButton>;
      
      private var _buttonContainer:Sprite;
      
      private var _toolTip:ToolTip;
      
      private const STACK_SPACING:int = 52;
      
      private const VISIBLE_AREA_WIDTH:int = 60;
      
      private const BUTTON_SLIDEIN_DELAY:Number = 0.1;
      
      public function EventsMenuStack()
      {
         this._items = [];
         this._buttons = new Vector.<EventsMenuButton>();
         this._buttonContainer = new Sprite();
         this._toolTip = new ToolTip();
         super();
         this.init();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         MonkeySystem.getInstance().flashStage.addChild(this._toolTip);
         this._toolTip.setStage(MonkeySystem.getInstance().flashStage);
         this._toolTip.width = 250;
         this._toolTip.scaleWidthByTextWidth = true;
      }
      
      private function init() : void
      {
         addChild(this._buttonContainer);
      }
      
      public function addItem(param1:EventsMenuItem) : void
      {
         this._items.push(param1);
      }
      
      public function clear() : void
      {
         var _loc2_:EventsMenuButton = null;
         this._buttonContainer.removeChildren();
         this._items.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.length)
         {
            _loc2_ = this._buttons[_loc1_];
            _loc2_.onMouseOutSignal.removeAll();
            _loc2_.onMouseOverSignal.removeAll();
            _loc1_++;
         }
         this._buttons.length = 0;
      }
      
      public function build() : void
      {
         var _loc3_:EventsMenuItem = null;
         var _loc4_:EventsMenuButton = null;
         this._items.sortOn("displayPriority");
         this._buttonContainer.removeChildren();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._items.length)
         {
            _loc3_ = this._items[_loc2_];
            _loc4_ = new EventsMenuButton(_loc3_);
            _loc4_.onMouseOverSignal.add(this.onButtonRollover);
            _loc4_.onMouseOutSignal.add(this.onButtonRollout);
            _loc4_.y = _loc1_;
            this._buttonContainer.addChild(_loc4_);
            this._buttons.push(_loc4_);
            _loc1_ = _loc1_ + this.STACK_SPACING;
            _loc2_++;
         }
      }
      
      public function preReveal() : void
      {
         var _loc2_:EventsMenuButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.length)
         {
            _loc2_ = this._buttons[_loc1_];
            _loc2_.x = this.VISIBLE_AREA_WIDTH;
            _loc1_++;
         }
      }
      
      public function slideInButtons() : void
      {
         var _loc2_:EventsMenuButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.length)
         {
            _loc2_ = this._buttons[_loc1_];
            TweenLite.to(_loc2_,0.5,{
               "x":0,
               "delay":_loc1_ * this.BUTTON_SLIDEIN_DELAY,
               "ease":Back.easeOut
            });
            _loc1_++;
         }
      }
      
      private function onButtonRollover(param1:EventsMenuButton) : void
      {
         this._toolTip.message = param1.name;
         this._toolTip.reveal();
         this._toolTip.activateMouseFollow();
      }
      
      private function onButtonRollout(param1:EventsMenuButton) : void
      {
         this._toolTip.hide();
         this._toolTip.deactivateMouseFollow();
      }
   }
}
