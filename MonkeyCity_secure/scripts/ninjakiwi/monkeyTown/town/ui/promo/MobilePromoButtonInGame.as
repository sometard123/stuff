package ninjakiwi.monkeyTown.town.ui.promo
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import ninjakiwi.monkeyTown.analytics.IdleTracker;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MobilePromoButtonInGame extends MobilePromoButton
   {
      
      public static const COOKIE_NAME:String = "mobile_promo_in_game_cookie";
       
      
      protected var _closeButton:ButtonControllerBase;
      
      private var _noInteraction:Boolean = true;
      
      private const AUTOHIDE_TIME:Number = 60;
      
      private const INITIAL_DELAY_SEC:Number = 300.0;
      
      private const RECHECK_DELAY_SEC:Number = 60;
      
      private const LONGTERM_RECHECK_DELAY_SEC:Number = 1800.0;
      
      private const DAY_MS:Number = 8.64E7;
      
      public function MobilePromoButtonInGame(param1:MovieClip)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         this._closeButton = new ButtonControllerBase(_clip.closeButton);
         this._closeButton.setClickFunction(this.hide);
         _clip.x = _clip.width;
         MonkeySystem.getInstance().resizeSignal.add(this.onResize);
         this.beginInitialTimer();
      }
      
      private function onResize(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = 66;
      }
      
      override protected function onClickApple() : void
      {
         super.onClickApple();
      }
      
      override protected function onClickAndroid() : void
      {
         super.onClickAndroid();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         var time:Number = param1;
         TweenLite.to(_clip,time,{
            "x":_clip.width,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         var time:Number = param1;
         _clip.visible = true;
         TweenLite.to(_clip,time,{
            "x":0,
            "onComplete":function():void
            {
            }
         });
      }
      
      private function beginInitialTimer() : void
      {
         TweenLite.delayedCall(this.INITIAL_DELAY_SEC,this.delayComplete);
      }
      
      private function delayComplete() : void
      {
         if(this.getTimeSinceLastReveal() < this.DAY_MS)
         {
            TweenLite.delayedCall(this.LONGTERM_RECHECK_DELAY_SEC,this.delayComplete);
            return;
         }
         if(!MonkeySystem.getInstance().map.worldIsReady || MonkeyCityMain.isInGame || IdleTracker.isIdle)
         {
            TweenLite.delayedCall(this.RECHECK_DELAY_SEC,this.delayComplete);
            return;
         }
         this.reveal();
         this.autoHide();
         this.updateCookieTimestamp();
      }
      
      private function autoHide() : void
      {
         var autoHideTween:TweenLite = TweenLite.delayedCall(this.AUTOHIDE_TIME,function onAutoHide():void
         {
            if(_noInteraction)
            {
               hide();
            }
         });
      }
      
      override protected function onMouseOver(param1:MouseEvent = null) : void
      {
         super.onMouseOver(param1);
         this._noInteraction = false;
      }
      
      protected function getTimeSinceLastReveal() : Number
      {
         return new Date().getTime() - this.getTimeOfLastReveal();
      }
      
      protected function getTimeOfLastReveal() : Number
      {
         var time:Number = 0;
         Kloud.loadCookie(COOKIE_NAME,function(param1:SharedObject):void
         {
            if(param1.data.hasOwnProperty("timeOfLastReveal"))
            {
               time = param1.data.timeOfLastReveal;
            }
         });
         return time;
      }
      
      protected function updateCookieTimestamp() : void
      {
         Kloud.loadCookie(COOKIE_NAME,function(param1:SharedObject):void
         {
            param1.data.timeOfLastReveal = new Date().getTime();
            param1.flush();
         });
      }
   }
}
