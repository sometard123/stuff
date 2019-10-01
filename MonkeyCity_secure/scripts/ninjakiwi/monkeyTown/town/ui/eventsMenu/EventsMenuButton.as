package ninjakiwi.monkeyTown.town.ui.eventsMenu
{
   import assets.ui.EventsMenuButtonClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class EventsMenuButton extends MovieClip
   {
      
      private static const HOVER_SLIDE_AMOUNT:int = 28;
       
      
      private var _menuItem:EventsMenuItem;
      
      private const _clip:EventsMenuButtonClip = new EventsMenuButtonClip();
      
      private var _icon:DisplayObject = null;
      
      private var _buttonController:ButtonControllerBase;
      
      public const onMouseOverSignal:Signal = new Signal(EventsMenuButton);
      
      public const onMouseOutSignal:Signal = new Signal(EventsMenuButton);
      
      public function EventsMenuButton(param1:EventsMenuItem)
      {
         super();
         this._menuItem = param1;
         this.build();
      }
      
      private function build() : void
      {
         addChild(this._clip);
         this._icon = this._menuItem.getIcon();
         this._icon.x = this._clip.iconMarker.x;
         this._icon.y = this._clip.iconMarker.y;
         this._clip.removeChild(this._clip.iconMarker);
         this._clip.addChild(this._icon);
         this.initListeners();
      }
      
      private function initListeners() : void
      {
         this._buttonController = new ButtonControllerBase(this);
         this._buttonController.setOverFunction(this.onHover);
         this._buttonController.setOutFunction(this.onOut);
         this._buttonController.setClickFunction(this.onClick);
      }
      
      private function onClick() : void
      {
         if(this._menuItem.onOpen !== null)
         {
            this._menuItem.onOpen();
         }
      }
      
      private function onHover() : void
      {
         TweenLite.to(this._clip,0.3,{
            "x":-HOVER_SLIDE_AMOUNT,
            "ease":Cubic.easeOut
         });
         this.onMouseOverSignal.dispatch(this);
      }
      
      private function onOut() : void
      {
         TweenLite.to(this._clip,0.3,{
            "x":0,
            "ease":Cubic.easeOut
         });
         this.onMouseOutSignal.dispatch(this);
      }
      
      override public function get name() : String
      {
         return this._menuItem.name;
      }
   }
}
