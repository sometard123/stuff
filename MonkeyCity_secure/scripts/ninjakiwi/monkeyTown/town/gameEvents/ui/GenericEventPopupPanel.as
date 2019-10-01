package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.GenericEventPopupPanelClip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.DateTool;
   
   public class GenericEventPopupPanel extends HideRevealView
   {
       
      
      protected const _clip:GenericEventPopupPanelClip = new GenericEventPopupPanelClip();
      
      protected const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      protected const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      protected var _timerBox:MovieClip;
      
      protected var _timerField:TextField;
      
      protected var _eventEndTime:Number = 0;
      
      protected var _customButtons:MovieClip = null;
      
      protected var _timer:Timer;
      
      public function GenericEventPopupPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._timerBox = this._clip.timer;
         this._timerField = this._clip.timer.timerField;
         this._timer = new Timer(1000,0);
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(this.hide);
         this._closeButton.setClickFunction(this.hide);
         this._timer.addEventListener(TimerEvent.TIMER,this.tick);
      }
      
      public function setUp(param1:String, param2:String, param3:Class, param4:Number, param5:Boolean = true, param6:MovieClip = null) : void
      {
         this._timerBox.visible = param5;
         this._clip.titleField.htmlText = param1;
         this._clip.infoField.htmlText = param2;
         this._eventEndTime = param4;
         this._okButton.target.visible = true;
         if(param6 !== null)
         {
            this._customButtons = param6;
            this._customButtons.x = this._okButton.target.x;
            this._customButtons.y = this._okButton.target.y;
            this._okButton.target.visible = false;
            addChild(this._customButtons);
         }
         var _loc7_:DisplayObject = new param3();
         if(_loc7_)
         {
            this._clip.iconPlaceholder.removeChildren();
            this._clip.iconPlaceholder.addChild(_loc7_);
         }
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this._okButton.target.visible = true;
         if(this._customButtons !== null && this._customButtons.parent && this._customButtons.parent.contains(this._customButtons))
         {
            this._customButtons.parent.removeChild(this._customButtons);
            this._customButtons = null;
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this.syncTime();
         this._timer.reset();
         this._timer.start();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this._timer.stop();
      }
      
      public function tick(param1:TimerEvent) : void
      {
         this.syncTime();
      }
      
      private function syncTime() : void
      {
         this._timerField.text = DateTool.getTimeStringFromUnixTime(this._eventEndTime - MonkeySystem.getInstance().getSecureTime()).toString();
      }
   }
}
