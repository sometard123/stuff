package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.vortex
{
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class VortexAnimation extends Entity
   {
      
      public static const CLOSED:int = 0;
      
      public static const OPENING:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const CLOSING:int = 3;
      
      public static const PORTAL_DURATION:int = 25;
       
      
      private var _syncFrame:int = 0;
      
      private var back:VortexAnimationBack;
      
      private var front:VortexAnimationFront;
      
      private var openingAnimation:VortexOpeningAnimation;
      
      private var _closeCheckTimer:Timer;
      
      private var _gameTimeOfPortalOpen:Number = 0;
      
      private var _state:int = 0;
      
      public function VortexAnimation()
      {
         this.back = new VortexAnimationBack();
         this.front = new VortexAnimationFront();
         this.openingAnimation = new VortexOpeningAnimation();
         this._closeCheckTimer = new Timer(100);
         super();
         this.init();
         Main.instance.game.addEntity(this);
         z = -9999999999;
      }
      
      public function init() : void
      {
         this.openingAnimation.x = this.back.x = this.front.x = Main.instance.game.level.bossEntryPointX;
         this.openingAnimation.y = this.back.y = this.front.y = Main.instance.game.level.bossEntryPointY;
         this.openingAnimation.pop.add(this.onPop);
         this.openingAnimation.complete.add(this.onOpenCloseComplete);
         this.openingAnimation.visible = false;
         this.back.visible = false;
         this.front.visible = false;
         this.openPortal();
      }
      
      private function onOpenCloseComplete() : void
      {
         this.openingAnimation.visible = false;
      }
      
      private function onPop() : void
      {
         switch(this._state)
         {
            case OPENING:
               this.back.visible = true;
               this.front.visible = true;
               this.startCloseCheck();
               break;
            case CLOSING:
               this.back.visible = false;
               this.front.visible = false;
         }
      }
      
      private function startCloseCheck() : void
      {
         this._gameTimeOfPortalOpen = Main.instance.game.getGameTime();
         this._closeCheckTimer.addEventListener(TimerEvent.TIMER,this.onTimerCloseCheck);
         this._closeCheckTimer.start();
      }
      
      private function onTimerCloseCheck(param1:TimerEvent) : void
      {
         var _loc2_:Number = Main.instance.game.getGameTime();
         if(_loc2_ - this._gameTimeOfPortalOpen > PORTAL_DURATION)
         {
            this._closeCheckTimer.removeEventListener(TimerEvent.TIMER,this.onTimerCloseCheck);
            this._closeCheckTimer.reset();
            this.closePortal();
         }
      }
      
      private function openPortal() : void
      {
         this.openingAnimation.visible = true;
         this.openingAnimation.playForward();
         this.back.visible = false;
         this.front.visible = false;
         this._state = OPENING;
      }
      
      private function closePortal() : void
      {
         this.openingAnimation.visible = true;
         this.openingAnimation.playBackward();
         this._state = CLOSING;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this._syncFrame++;
         if(this._syncFrame >= this.back.clip.frameCount - 1)
         {
            this._syncFrame = 0;
         }
         this.back.clip.gotoAndStop(this._syncFrame);
         this.front.clip.gotoAndStop(this._syncFrame);
      }
      
      override public function process(param1:Number) : void
      {
      }
   }
}
