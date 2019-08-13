package ninjakiwi.monkeyTown.transition
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.interfaces.View;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class Transition extends Sprite
   {
      
      private static var _instance:Transition;
       
      
      private var _startBitmap:Bitmap;
      
      private var _startBitmapData:BitmapData;
      
      private var _destinationBitmap:Bitmap;
      
      private var _destinationBitmapData:BitmapData;
      
      private var _currentView:View = null;
      
      private var _previousView:View = null;
      
      private var _container:Sprite;
      
      private var _views:Dictionary;
      
      private var _stage:Stage;
      
      public const system:MonkeySystem = MonkeySystem.getInstance();
      
      public function Transition(param1:SingletonBlocker#1573)
      {
         this._views = new Dictionary();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use CharacterFactory.getInstance() instead of new.");
         }
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      public static function getInstance() : Transition
      {
         if(_instance == null)
         {
            _instance = new Transition(new SingletonBlocker#1573());
         }
         return _instance;
      }
      
      public function init() : void
      {
         this._startBitmapData = new BitmapData(this.system.RENDER_SURFACE_WIDTH,this.system.RENDER_SURFACE_HEIGHT,false,0);
         this._destinationBitmapData = new BitmapData(this.system.RENDER_SURFACE_WIDTH,this.system.RENDER_SURFACE_HEIGHT,false,0);
         this._startBitmap = new Bitmap(this._startBitmapData);
         this._destinationBitmap = new Bitmap(this._destinationBitmapData);
         this._startBitmap.visible = false;
         this._destinationBitmap.visible = false;
         this._container = new Sprite();
         addChild(this._container);
         this.system.CENTRAL_DISPATCHER.addEventListener("TransitionBack",function(param1:Event):void
         {
            back();
         });
      }
      
      public function transition(param1:Transitionable, param2:View) : void
      {
         var _loc3_:MovieClip = MovieClip(param1);
         var _loc4_:MovieClip = MovieClip(param2);
         param2.prepareToReveal();
         param1.prepareToExit();
         _loc3_.visible = true;
         _loc4_.visible = true;
         this._startBitmapData.draw(_loc3_);
         this._destinationBitmapData.draw(_loc4_);
         this._previousView = this._currentView;
         this._currentView = param2;
         this.startTransition();
      }
      
      public function back() : void
      {
         this.transition(this._currentView,this._previousView);
      }
      
      private function startTransition() : void
      {
         addChild(this._container);
         this.hideAllViews();
         this.transitionAnimationCompleteHandler();
      }
      
      private function transitionAnimationCompleteHandler() : void
      {
         this._currentView.prepareToReveal();
         var _loc1_:DisplayObject = DisplayObject(this._currentView);
         _loc1_.alpha = 1;
         _loc1_.visible = true;
         this.addChild(_loc1_);
         this._currentView.arriveAfterTransition();
         this._startBitmapData.fillRect(this._startBitmapData.rect,65280);
         this._destinationBitmapData.fillRect(this._destinationBitmapData.rect,65535);
      }
      
      public function transitionTo(param1:View) : void
      {
         if(this._currentView == null)
         {
         }
         this.transition(this._currentView,param1);
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
         this.init();
      }
      
      public function makeOneViewVisible(param1:View) : void
      {
         this.hideAllViews();
         this._currentView = param1;
         this.transitionAnimationCompleteHandler();
      }
      
      public function hideAllViews() : void
      {
         var _loc1_:* = null;
         var _loc2_:DisplayObject = null;
         for(_loc1_ in this._views)
         {
            _loc2_ = DisplayObject(_loc1_);
            _loc2_.visible = false;
            if(this.contains(_loc2_))
            {
               this.removeChild(_loc2_);
            }
         }
      }
      
      public function registerView(param1:MovieClip) : void
      {
         this._views[param1] = param1;
      }
      
      public function set currentView(param1:View) : void
      {
         this._currentView = param1;
      }
      
      public function get currentView() : View
      {
         return this._currentView;
      }
      
      public function isCurrentView(param1:Transitionable) : Boolean
      {
         return param1 == this._currentView;
      }
      
      public function processCurrentView(param1:Number) : void
      {
         if(this._currentView !== null)
         {
            this._currentView.process(param1);
         }
      }
   }
}

class SingletonBlocker#1573
{
    
   
   function SingletonBlocker#1573()
   {
      super();
   }
}
