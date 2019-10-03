package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.interfaces.Resettable;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class HideRevealView extends MovieClip implements Resettable
   {
      
      protected static var _currentOpenViews:Dictionary = new Dictionary();
      
      protected static const _currentReveledPanel:Vector.<HideRevealView> = new Vector.<HideRevealView>();
      
      private static var _uiMutex:UIMutex = new UIMutex();
      
      public static const panelRevealBeginSignal:Signal = new Signal();
      
      public static const panelClosedSignal:Signal = new Signal(HideRevealView);
       
      
      protected const _system:MonkeySystem = MonkeySystem.getInstance();
      
      protected var _stage:Stage;
      
      protected var _container:DisplayObjectContainer;
      
      protected var _flashClip:DisplayObject;
      
      protected var _flashClipForcedDimensions:Rectangle = null;
      
      public var isModal:Boolean = false;
      
      public var modalBlocker:ModalBlocker;
      
      public var modalBlockerContainer:DisplayObjectContainer = null;
      
      public var isRevealed:Boolean = false;
      
      public var uiMutexGroup = null;
      
      public var autocloseMutexSiblings:Boolean = false;
      
      private var _defaultOnResizeEnabled:Boolean = false;
      
      private var _closeButton:ButtonControllerBase;
      
      protected var _hasBeenLazyInitialised:Boolean = false;
      
      protected var _autoPlayStopClips:Array = null;
      
      public const onRevealSignal:Signal = new Signal(HideRevealView);
      
      public const onHideSignal:Signal = new Signal(HideRevealView);
      
      public const revealStartSignal:Signal = new Signal(HideRevealView);
      
      public const hideStartSignal:Signal = new Signal(HideRevealView);
      
      public function HideRevealView(param1:DisplayObjectContainer, param2:* = null)
      {
         this.modalBlocker = ModalBlocker.getInstance();
         super();
         this._container = param1;
         this.uiMutexGroup = param2;
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this.alpha = 0;
         MonkeyCityMain.globalHideSignal.add(this.onGlobalHideSignal);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalResetSignal);
      }
      
      public function destroy() : void
      {
         this._container = null;
         this._flashClip = null;
         this.disableDefaultOnResize();
         this.modalBlocker = null;
         this.modalBlockerContainer = null;
         if(this._closeButton)
         {
            this._closeButton.destroy();
            this._closeButton = null;
         }
         this._autoPlayStopClips = null;
         this._autoPlayStopClips = null;
      }
      
      protected function lazyInitialise() : void
      {
         this._hasBeenLazyInitialised = true;
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
         this._stage.addEventListener(Event.RESIZE,this.resizeHandler);
         if(this._defaultOnResizeEnabled)
         {
            this._stage.addEventListener(Event.RESIZE,this.defaultResizeHandler);
         }
         this.resize();
      }
      
      private function resizeHandler(param1:Event) : void
      {
         this.resize();
      }
      
      public function resize() : void
      {
      }
      
      public function uiMutexIsAvailable() : Boolean
      {
         if(this.uiMutexGroup === null)
         {
            return true;
         }
         return !_uiMutex.isLocked(this.uiMutexGroup);
      }
      
      public function reveal(param1:Number = 0.2) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:* = undefined;
         if(!this._hasBeenLazyInitialised)
         {
            this.lazyInitialise();
         }
         if(this.isRevealed)
         {
            return;
         }
         if(this.uiMutexGroup !== null)
         {
            if(_currentOpenViews[this.uiMutexGroup] === this)
            {
               return;
            }
            _loc2_ = _uiMutex.getLock(this.uiMutexGroup);
            if(!_loc2_)
            {
               if(this.autocloseMutexSiblings)
               {
                  _loc3_ = _currentOpenViews[this.uiMutexGroup];
                  if(_loc3_ is HideRevealView)
                  {
                     _currentOpenViews[this.uiMutexGroup] = null;
                     HideRevealView(_loc3_).hide();
                  }
               }
               else
               {
                  return;
               }
            }
            _uiMutex.getLock(this.uiMutexGroup);
            _currentOpenViews[this.uiMutexGroup] = this;
         }
         if(this.isModal)
         {
            this.modalBlocker.reveal(this,this.modalBlockerContainer || this._container,param1);
         }
         if(this._defaultOnResizeEnabled)
         {
            this.centerOnStage();
         }
         this.visible = true;
         this.mouseEnabled = true;
         this.mouseChildren = true;
         if(this._autoPlayStopClips !== null)
         {
            this.playClips(this._autoPlayStopClips);
         }
         this.revealAnimation(param1,this.onRevealComplete);
         this._container.addChild(this);
         this.isRevealed = true;
         panelRevealBeginSignal.dispatch();
         this.revealStartSignal.dispatch(this);
      }
      
      protected function revealAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.killTweensOf(this,true);
         TweenLite.to(this,param1,{
            "alpha":1,
            "onComplete":param2
         });
      }
      
      protected function onRevealComplete() : void
      {
         this.onRevealSignal.dispatch(this);
      }
      
      public function hide(param1:Number = 0.2) : void
      {
         if(this.isModal)
         {
            this.modalBlocker.hide(this,param1);
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         if(this.uiMutexGroup !== null)
         {
            _uiMutex.unLock(this.uiMutexGroup);
            _currentOpenViews[this.uiMutexGroup] = null;
         }
         this.hideAnimation(param1,this.onHideComplete);
         this.hideStartSignal.dispatch(this);
         this._system.flashStage.focus = this._system.flashStage;
         TweenLite.to(this,param1 + 0.05,{"onComplete":this.dispatchOnHide});
      }
      
      protected function onGlobalResetSignal() : void
      {
         this.hide(0);
      }
      
      protected function onGlobalHideSignal() : void
      {
         this.hide(0);
      }
      
      protected function hideAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.killTweensOf(this,true);
         TweenLite.to(this,param1,{
            "alpha":0,
            "onComplete":param2
         });
      }
      
      protected function onHideComplete() : void
      {
         if(this._container !== null && this._container.contains(this))
         {
            this._container.removeChild(this);
         }
         if(this._autoPlayStopClips !== null)
         {
            this.haltClips(this._autoPlayStopClips);
         }
         this.isRevealed = false;
      }
      
      private function dispatchOnHide() : void
      {
         this.onHideSignal.dispatch(this);
      }
      
      public function set container(param1:DisplayObjectContainer) : void
      {
         this._container = param1;
      }
      
      public function centerOnStage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this._flashClip)
         {
            return;
         }
         if(this._flashClipForcedDimensions !== null)
         {
            _loc1_ = this._flashClipForcedDimensions.width * 0.5;
            _loc2_ = this._flashClipForcedDimensions.height * 0.5;
         }
         else
         {
            _loc1_ = this._flashClip.width * 0.5;
            _loc2_ = this._flashClip.height * 0.5;
         }
         x = int(this._system.flashStage.stageWidth * 0.5 - _loc1_);
         y = int(this._system.flashStage.stageHeight * 0.5 - _loc2_) - 10;
      }
      
      public function enableDefaultOnResize(param1:DisplayObject, param2:Rectangle = null) : void
      {
         this._flashClip = param1;
         this._flashClipForcedDimensions = param2;
         if(this._stage)
         {
            if(!this._stage.hasEventListener(Event.RESIZE))
            {
               this._stage.addEventListener(Event.RESIZE,this.defaultResizeHandler,false,0,true);
            }
         }
         this._defaultOnResizeEnabled = true;
         this.centerOnStage();
      }
      
      public function disableDefaultOnResize() : void
      {
         this._flashClip = null;
         if(this._stage)
         {
            this._stage.removeEventListener(Event.RESIZE,this.defaultResizeHandler);
         }
         this._defaultOnResizeEnabled = false;
      }
      
      public function enableCloseButton(param1:MovieClip) : void
      {
         this._closeButton = new ButtonControllerBase(param1);
         this._closeButton.setClickFunction(this.hide);
      }
      
      protected function defaultResizeHandler(param1:Event) : void
      {
         this.centerOnStage();
      }
      
      public function reset() : void
      {
      }
      
      public function setAutoPlayStopClipsArray(param1:Array, param2:Boolean = true) : void
      {
         this._autoPlayStopClips = param1;
         if(param2)
         {
            this.setPlayStateOfClips(param1,false);
         }
      }
      
      public function haltClips(param1:Array) : void
      {
         this.setPlayStateOfClips(param1,false);
      }
      
      public function playClips(param1:Array) : void
      {
         this.setPlayStateOfClips(param1,true);
      }
      
      public function setPlayStateOfClips(param1:Array, param2:Boolean) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc3_:LGDisplayListUtil = LGDisplayListUtil.getInstance();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            _loc3_.setPlayStateOfAllChildMovieClips(_loc4_,param2,true,true);
            _loc5_++;
         }
      }
   }
}
