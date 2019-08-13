package ninjakiwi.monkeyTown.display.bitClip
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ninjakiwi.display.gfx.NinjaClip;
   import ninjakiwi.display.gfx.bitClip.PositionedBMD;
   
   public class BitClipCustom extends NinjaClip
   {
      
      static var _animations:Dictionary = new Dictionary();
      
      public static var globalPlaying:Boolean = true;
       
      
      public var playing:Boolean = true;
      
      public var owner;
      
      protected var _animation:AnimationCustom;
      
      protected var _def;
      
      protected var _rotationStepsNum:uint;
      
      protected var _frameAction:Function;
      
      protected var _didAction:Boolean = false;
      
      protected var _renderedFrame:uint;
      
      protected var _renderDest:Point;
      
      public var timeScale:Number = 1;
      
      public var currentSubFrame:Number = 1;
      
      public var onLoopFunction:Function = null;
      
      public var animationDelayMin:Number = 0;
      
      public var animationDelayMax:Number = -1;
      
      public var animationDelayTimeoutID:uint;
      
      public var graphicsClassName:String;
      
      public var children:Vector.<BitClipCustom>;
      
      public var childNames:Array;
      
      public var visible:Boolean = true;
      
      private var _matrix:Matrix = null;
      
      private var _colorTransform:ColorTransform = null;
      
      private var _filters:Array;
      
      private var _useDrawWithTransforms:Boolean = false;
      
      private var _renderBitmap:Bitmap;
      
      private var _renderBitmapContainer:Sprite;
      
      public function BitClipCustom(param1:* = null, param2:uint = 1, param3:Boolean = false, param4:Boolean = false)
      {
         this._renderDest = new Point();
         this.children = new Vector.<BitClipCustom>();
         this.childNames = [];
         this._filters = [];
         this._renderBitmap = new Bitmap();
         this._renderBitmapContainer = new Sprite();
         super();
         if(param1 !== null)
         {
            this.addAnimation(param1,param1,param2,param3,param4,true);
         }
      }
      
      public static function disposeAnimation(param1:String) : void
      {
         var _loc2_:AnimationCustom = _animations[param1];
         if(_loc2_ !== null)
         {
            _loc2_.dispose();
            delete BitClipCustom._animations[param1];
         }
      }
      
      public static function clearAnimations() : void
      {
         var _loc1_:AnimationCustom = null;
         for each(_loc1_ in _animations)
         {
            _loc1_.dispose();
         }
         _animations = new Dictionary();
      }
      
      public static function getUsageDescription() : String
      {
         var _loc5_:* = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:AnimationCustom = null;
         var _loc1_:int = 0;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         for(_loc5_ in _animations)
         {
            _loc8_ = _animations[_loc5_];
            _loc4_++;
            _loc3_.push({
               "id":_loc5_,
               "bytes":_loc8_.bytes
            });
         }
         _loc3_.sortOn("bytes",Array.NUMERIC);
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc7_];
            _loc2_ = _loc2_ + ("id: " + _loc6_.id + " bytes: " + _loc6_.bytes + " ( " + Number(Number(_loc6_.bytes) / 1048576).toFixed(4) + "MB )\n");
            _loc1_ = _loc1_ + _loc6_.bytes;
            _loc7_++;
         }
         _loc2_ = _loc2_ + ("\nTotal Bytes: " + _loc1_ + " ( " + Number(Number(_loc1_) / 1048576).toFixed(4) + "MB )\n");
         _loc2_ = _loc2_ + ("Total Animations: " + _loc4_ + "\n");
         return _loc2_;
      }
      
      public function addAnimation(param1:* = null, param2:* = null, param3:uint = 1, param4:Boolean = false, param5:Boolean = false, param6:Boolean = true, param7:ColorTransform = null, param8:Array = null) : BitClipCustom
      {
         var _loc9_:AnimationCustom = null;
         var _loc10_:AnimationCustom = null;
         if(param1)
         {
         }
         this._renderBitmapContainer.addChild(this._renderBitmap);
         if(param1 is String)
         {
            this.graphicsClassName = param1;
         }
         if(param1 != null)
         {
            if(param1 is MovieClip || param1 is String || param1 is Class)
            {
            }
            this._def = param1;
         }
         if(param2 == null)
         {
            param2 = this._def;
         }
         if(param3 != 0)
         {
            this._rotationStepsNum = param3;
         }
         if(this._def != null)
         {
            _loc10_ = _animations[param2] as AnimationCustom;
            if(_loc10_)
            {
               this._animation = _loc10_;
            }
            else
            {
               _loc9_ = new AnimationCustom(this._def,this._rotationStepsNum,param4,param5,0,param7,null,param8);
               _animations[param2] = _loc9_;
            }
            if(param6)
            {
               currentFrame = 1;
               this._animation = _animations[param2];
            }
            if(this._animation == null)
            {
               this._animation = _animations[param2];
            }
         }
         if(this._def)
         {
         }
         if(this._animation === null)
         {
         }
         this.checkShouldDrawWithTransforms();
         return this;
      }
      
      public function removeAnimation(param1:*) : void
      {
         var _loc2_:AnimationCustom = _animations[param1];
         if(_loc2_)
         {
            delete _animations[param1];
            if(this._animation == _loc2_)
            {
               _loc2_ = null;
            }
         }
      }
      
      public function clearAllAnimations() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in _animations)
         {
            this.removeAnimation(_loc1_);
         }
      }
      
      public function hasAnimation(param1:*) : Boolean
      {
         return _animations[param1] != undefined;
      }
      
      public function selectAnimation(param1:*) : BitClipCustom
      {
         if(_animations[param1])
         {
            this._animation = _animations[param1];
         }
         return this;
      }
      
      public function totalFramesOfAnimation(param1:*) : int
      {
         if(!_animations[param1])
         {
            return 0;
         }
         return _animations[param1].totalFrames;
      }
      
      override public function render(param1:BitmapData = null, param2:Rectangle = null, param3:Number = 0, param4:Number = 0, param5:Number = 0) : void
      {
         var _loc6_:BitmapData = null;
         var _loc7_:Rectangle = null;
         if(false === this.visible || this._animation == null)
         {
            return;
         }
         if(param1 != null)
         {
            _loc6_ = param1;
         }
         else
         {
            _loc6_ = renderBmd;
         }
         if(param2 != null)
         {
            _loc7_ = param2;
         }
         else
         {
            _loc7_ = renderViewport;
         }
         var _loc8_:PositionedBMD = this._animation.getBMD(currentFrame,angle + param5);
         if(_loc8_ != null && _loc8_.data != null)
         {
            this._renderDest.x = int(_loc8_.pos.x - _loc7_.x + this.x + param3);
            this._renderDest.y = int(_loc8_.pos.y - _loc7_.y + this.y + param4);
            if(this._useDrawWithTransforms)
            {
               this.drawWithTransforms(_loc6_,_loc8_,this._renderDest);
            }
            else
            {
               _loc6_.copyPixels(_loc8_.data,_loc8_.rect,this._renderDest,null,null,true);
            }
         }
         this._renderedFrame = currentFrame;
         if(!this._didAction)
         {
            if(this._animation.actions != null)
            {
               if(this._animation.actions[currentFrame])
               {
                  this._frameAction = this._animation.actions[currentFrame];
                  this._frameAction(this);
                  this._frameAction = null;
                  this._didAction = true;
               }
            }
         }
         if(this.playing && globalPlaying)
         {
            this._didAction = false;
            if(currentFrame == this._renderedFrame)
            {
               this.currentSubFrame = this.currentSubFrame + this.timeScale;
               if(this.currentSubFrame > this._animation.totalFrames)
               {
                  this.currentSubFrame = this.currentSubFrame - this._animation.totalFrames;
                  if(this.currentSubFrame < 1)
                  {
                     this.currentSubFrame = this.currentSubFrame + 1;
                  }
                  if(this.animationDelayMax > 0)
                  {
                     this.startAnimationDelayBehaviour();
                  }
                  if(this.onLoopFunction != null)
                  {
                     this.onLoopFunction();
                  }
               }
               currentFrame = int(this.currentSubFrame);
            }
         }
      }
      
      public function startAnimationDelayBehaviour() : void
      {
         this.gotoAndStop(1);
         this.animationDelayTimeoutID = setTimeout(this.play,(Math.random() * (this.animationDelayMax - this.animationDelayMin) + this.animationDelayMax) * 1000);
      }
      
      private function drawWithTransforms(param1:BitmapData, param2:PositionedBMD, param3:Point) : void
      {
         var _loc4_:Matrix = null;
         if(this._matrix !== null)
         {
            _loc4_ = this._matrix;
         }
         else
         {
            _loc4_ = new Matrix();
            _loc4_.translate(param3.x,param3.y);
         }
         if(this._filters !== null && this._filters.length > 0)
         {
            this._renderBitmap.bitmapData = param2.data;
            param1.draw(this._renderBitmapContainer,_loc4_,this._colorTransform,null,null,false);
         }
         else
         {
            param1.draw(param2.data,_loc4_,this._colorTransform,null,null,false);
         }
      }
      
      public function cancelAnimationDelayTimeout() : void
      {
         clearTimeout(this.animationDelayTimeoutID);
         this.animationDelayTimeoutID = 0;
      }
      
      override public function stop() : void
      {
         this.cancelAnimationDelayTimeout();
         this.playing = false;
      }
      
      override public function play() : void
      {
         this.cancelAnimationDelayTimeout();
         this.playing = true;
      }
      
      override public function gotoAndPlay(param1:*) : void
      {
         this.cancelAnimationDelayTimeout();
         this.goto(param1);
         this.playing = true;
      }
      
      override public function gotoAndStop(param1:*) : void
      {
         this.cancelAnimationDelayTimeout();
         this.goto(param1);
         this.playing = false;
      }
      
      protected function goto(param1:*) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         this.cancelAnimationDelayTimeout();
         var _loc2_:uint = currentFrame;
         if(param1 is String)
         {
            _loc3_ = String(param1);
            if(this._animation.labels != null)
            {
               _loc4_ = this._animation.labels[_loc3_];
               if(_loc4_ != 0)
               {
                  _loc2_ = this._animation.labels[_loc3_];
               }
            }
         }
         else
         {
            _loc5_ = uint(param1);
            if(_loc5_ > 0 && _loc5_ <= this.totalFrames)
            {
               _loc2_ = _loc5_;
            }
         }
         if(currentFrame != _loc2_)
         {
            currentFrame = _loc2_;
            this._didAction = false;
         }
         this.currentSubFrame = currentFrame;
      }
      
      public function get totalFrames() : uint
      {
         if(this._animation)
         {
            return this._animation.totalFrames;
         }
         return 0;
      }
      
      public function get bmd() : PositionedBMD
      {
         var _loc1_:PositionedBMD = this._animation.getBMD(currentFrame,angle);
         var _loc2_:PositionedBMD = new PositionedBMD();
         if(_loc1_ != null && _loc1_.data != null)
         {
            _loc2_.data = _loc1_.data;
            _loc2_.pos = _loc1_.pos.clone();
            _loc2_.pos.x = _loc2_.pos.x + this.x;
            _loc2_.pos.y = _loc2_.pos.y + this.y;
         }
         return _loc2_;
      }
      
      public function delayBeforePlay(param1:Number) : void
      {
         this.stop();
         this.animationDelayTimeoutID = setTimeout(this.play,param1 * 1000);
      }
      
      public function set frameSharingEnabled(param1:Boolean) : void
      {
         AnimationCustom.ENABLE_RUNTIME_FRAME_SHARING_CALCULATION = param1;
      }
      
      private function checkShouldDrawWithTransforms() : void
      {
         this._useDrawWithTransforms = this._colorTransform !== null || this._filters && this._filters.length > 0 || this._matrix !== null;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return this._colorTransform;
      }
      
      public function set colorTransform(param1:ColorTransform) : void
      {
         this._colorTransform = param1;
         this.checkShouldDrawWithTransforms();
      }
      
      public function get filters() : Array
      {
         return this._filters;
      }
      
      public function set filters(param1:Array) : void
      {
         this._filters = param1;
         this._renderBitmapContainer.filters = this._filters;
         this.checkShouldDrawWithTransforms();
      }
      
      public function get matrix() : Matrix
      {
         return this._matrix;
      }
      
      public function set matrix(param1:Matrix) : void
      {
         this._matrix = param1;
      }
   }
}
