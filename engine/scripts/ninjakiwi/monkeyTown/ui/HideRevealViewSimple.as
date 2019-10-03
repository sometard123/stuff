package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class HideRevealViewSimple extends MovieClip
   {
       
      
      protected var _stage:Stage;
      
      protected var _container:DisplayObjectContainer;
      
      protected var _flashClip:DisplayObject;
      
      public var isRevealed:Boolean = false;
      
      private var _defaultOnResizeEnabled:Boolean = false;
      
      private var _closeButton:ButtonControllerBase;
      
      protected var _autoPlayStopClips:Array = null;
      
      public const revealCompleteSignal:Signal = new Signal();
      
      public const onHideSignal:Signal = new Signal();
      
      public function HideRevealViewSimple(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this.alpha = 0;
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
         this._stage.addEventListener(Event.RESIZE,this.resizeHandler);
         if(this._defaultOnResizeEnabled)
         {
            this.centerOnStage();
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
      
      public function reveal(param1:Number = 0.5) : void
      {
         Main.instance.tooltip.hide();
         if(this._defaultOnResizeEnabled)
         {
            if(stage)
            {
               this.centerOnStage();
            }
         }
         this.visible = true;
         this.mouseEnabled = true;
         this.mouseChildren = true;
         TweenLite.killTweensOf(this);
         TweenLite.to(this,param1,{
            "alpha":1,
            "onComplete":this.revealCompleteSignal.dispatch
         });
         this._container.addChild(this);
         this.isRevealed = true;
      }
      
      public function hide(param1:Number = 0.5) : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         TweenLite.to(this,param1,{
            "alpha":0,
            "onComplete":this.onHideComplete
         });
         this.isRevealed = false;
         this.onHideSignal.dispatch();
      }
      
      private function onHideComplete() : void
      {
         if(this._container.contains(this))
         {
            this._container.removeChild(this);
         }
      }
      
      public function set container(param1:DisplayObjectContainer) : void
      {
         this._container = param1;
      }
      
      public function centerOnStage() : void
      {
         if(!this._flashClip)
         {
            return;
         }
         var _loc1_:int = this._flashClip.width * 0.5;
         var _loc2_:int = this._flashClip.height * 0.5;
         x = int(this._stage.stageWidth * 0.5 - _loc1_);
         y = int(this._stage.stageHeight * 0.5 - _loc2_) - 20;
      }
      
      public function enableDefaultOnResize(param1:DisplayObject) : void
      {
         this._flashClip = param1;
         if(this._stage)
         {
            this.centerOnStage();
            this._stage.addEventListener(Event.RESIZE,this.defaultResizeHandler);
         }
         this._defaultOnResizeEnabled = true;
      }
      
      public function enableCloseButton(param1:MovieClip) : void
      {
         this._closeButton = new ButtonControllerBase(param1);
         this._closeButton.setClickFunction(this.hide);
      }
      
      private function defaultResizeHandler(param1:Event) : void
      {
         this.centerOnStage();
      }
      
      public function setAutoPlayStopClipsArray(param1:Array, param2:Boolean = true) : void
      {
         this._autoPlayStopClips = param1;
         if(param2)
         {
            this.setPlayStateOfClips(param1,false);
         }
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
