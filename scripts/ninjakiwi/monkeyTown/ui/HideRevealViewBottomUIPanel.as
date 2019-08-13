package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class HideRevealViewBottomUIPanel extends HideRevealViewVerticalSlide
   {
      
      private static const REVEAL_TIME:Number = 0.5;
      
      private static const HIDE_TIME:Number = 0.3;
      
      private static const SWITCH_TIME:Number = 0;
       
      
      private var _isSwitchingReveal:Boolean = false;
      
      private var _isSwitchingHide:Boolean = false;
      
      private var _inY:Number;
      
      private var _outY:Number;
      
      public const closedSignal:Signal = new Signal();
      
      public const openedSignal:Signal = new Signal();
      
      public function HideRevealViewBottomUIPanel(param1:DisplayObjectContainer, param2:* = null, param3:Number = -600, param4:Number = 0)
      {
         super(param1,param3,param4,param2);
         this._inY = param3;
         this._outY = param4;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         var _loc2_:TownUI = TownUI.getInstance();
         this.resize();
         if(_currentOpenViews[uiMutexGroup] != null)
         {
            this._isSwitchingReveal = true;
            super.reveal(SWITCH_TIME);
            _loc2_.bottomUI.moveLeftCogs(REVEAL_TIME);
            _loc2_.bottomUI.moveRightCogs(REVEAL_TIME);
         }
         else
         {
            this._isSwitchingReveal = false;
            super.reveal(REVEAL_TIME);
            _loc2_.bottomUI.moveLeftCogs(REVEAL_TIME * 3);
            _loc2_.bottomUI.moveRightCogs(REVEAL_TIME * 3);
         }
         isRevealed = true;
      }
      
      override protected function revealAnimation(param1:Number, param2:Function) : void
      {
         if(this._isSwitchingReveal)
         {
            this.alpha = 0;
            this.y = this._inY;
            TweenLite.killTweensOf(this);
            TweenLite.to(this,param1,{"alpha":1});
            TweenLite.delayedCall(param1,param2);
         }
         else
         {
            this.alpha = 1;
            super.revealAnimation(param1,param2);
         }
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TownUI = TownUI.getInstance();
         if(_currentOpenViews[uiMutexGroup] !== this)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            this._isSwitchingHide = true;
            super.hide(SWITCH_TIME);
         }
         else
         {
            this._isSwitchingHide = false;
            super.hide(HIDE_TIME);
            _loc3_.bottomUI.moveLeftCogs(HIDE_TIME * 3);
            _loc3_.bottomUI.moveRightCogs(HIDE_TIME * 3);
         }
         isRevealed = false;
      }
      
      override protected function hideAnimation(param1:Number, param2:Function) : void
      {
         if(this._isSwitchingHide)
         {
            this.alpha = 1;
            TweenLite.to(this,param1,{"alpha":0});
            TweenLite.delayedCall(param1,param2);
         }
         else
         {
            super.hideAnimation(param1,param2);
         }
      }
      
      override public function centerOnStage() : void
      {
      }
      
      override public function enableDefaultOnResize(param1:DisplayObject, param2:Rectangle = null) : void
      {
         super.enableDefaultOnResize(param1);
      }
      
      override public function resize() : void
      {
         super.resize();
         this._inY = -MonkeySystem.getInstance().flashStage.stageHeight * 0.5 - 290;
         updateInY(this._inY);
         if(isRevealed)
         {
            this.y = this._inY;
         }
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.closedSignal.dispatch();
      }
      
      override protected function onRevealComplete() : void
      {
         super.onRevealComplete();
         this.openedSignal.dispatch();
      }
   }
}
