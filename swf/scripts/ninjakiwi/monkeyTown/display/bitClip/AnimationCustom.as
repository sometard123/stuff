package ninjakiwi.monkeyTown.display.bitClip
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.display.gfx.bitClip.PBMDParams;
   import ninjakiwi.display.gfx.bitClip.PositionedBMD;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   import ninjakiwi.sharedFrameAnalyser.SharedFrameAnalyser;
   
   public class AnimationCustom
   {
      
      protected static const ROTATION_STEPS_DEFAULT:uint = 1;
      
      protected static const TWOPI:Number = Math.PI * 2;
      
      protected static const ALPHA_BITS:uint = 4278190080;
      
      protected static const ALPHA_ZERO:uint = 0;
      
      protected static var _zeroDeg:Sprite = new Sprite();
      
      protected static var _zeroPoint:Point = new Point(0,0);
      
      protected static var _failed:Boolean = false;
      
      protected static var _onFailedFunction:Function;
      
      public static var stage:Stage;
      
      public static var totalNum:uint = 0;
      
      public static var ENABLE_RUNTIME_FRAME_SHARING_CALCULATION:Boolean = false;
      
      public static var ENABLE_PRECALCULATED_FRAME_SHARING:Boolean = true;
      
      public static var ONLY_USE_FIRST_FRAME:Boolean = false;
       
      
      public var totalFrames:uint;
      
      public var labels:Dictionary;
      
      public var actions:Array;
      
      public var name:String;
      
      protected var _rotationStepsNum:uint;
      
      protected var _rotationStepSize:Number;
      
      protected var _frames:Array;
      
      protected var _bytes:int;
      
      protected var _rotIndex:uint;
      
      private var _stage:Stage;
      
      private var _flipX:Boolean = false;
      
      private var _flipY:Boolean = false;
      
      private var _renderPadding:Number;
      
      private var _colorTransform:ColorTransform;
      
      private var _drawTransform:Matrix = null;
      
      private var _filters:Array = null;
      
      public var definitionClass:String;
      
      public function AnimationCustom(param1:*, param2:uint = 0, param3:Boolean = false, param4:Boolean = false, param5:Number = 0, param6:ColorTransform = null, param7:Matrix = null, param8:Array = null)
      {
         var _loc10_:String = null;
         var _loc11_:AnimationSharedFramesMap = null;
         super();
         if(stage !== null)
         {
            _loc10_ = stage.quality;
            stage.quality = StageQuality.BEST;
         }
         if(param1 is String)
         {
            this.definitionClass = param1;
         }
         else
         {
            this.definitionClass = getQualifiedClassName(param1);
         }
         this._flipX = param3;
         this._flipY = param4;
         this._renderPadding = param5;
         this._colorTransform = param6;
         this._filters = param8;
         this._drawTransform = param7;
         if(param2 == 0)
         {
            this._rotationStepsNum = ROTATION_STEPS_DEFAULT;
         }
         else
         {
            this._rotationStepsNum = param2;
         }
         this._rotationStepSize = TWOPI / this._rotationStepsNum;
         this.name = String(param1);
         this.labels = new Dictionary();
         var _loc9_:MovieClip = this.definitionToMovieClip(param1);
         if(ENABLE_PRECALCULATED_FRAME_SHARING)
         {
            _loc11_ = SharedFrameData.instance.getMapping(this.definitionClass);
            if(_loc11_ !== null)
            {
               this.renderFramesWithSharedFrames(_loc9_,_loc11_,this.definitionClass);
            }
            else
            {
               this.renderFrames(_loc9_);
            }
         }
         else
         {
            this.renderFrames(_loc9_);
         }
         if(stage !== null)
         {
            stage.quality = _loc10_;
         }
      }
      
      public function definitionToMovieClip(param1:*) : MovieClip
      {
         var clip:MovieClip = null;
         var defClass:Class = null;
         var def:* = param1;
         if(def is MovieClip)
         {
            clip = def;
         }
         else if(def is Class)
         {
            clip = this.clipFromClass(def);
         }
         else if(def is String)
         {
            try
            {
               defClass = getDefinitionByName(def) as Class;
               clip = new defClass();
            }
            catch(e:ReferenceError)
            {
               clip = new MovieClip();
               clip.graphics.beginFill(16737996);
               clip.graphics.drawRect(-10,-10,20,20);
               clip.graphics.endFill();
            }
         }
         return clip;
      }
      
      private function clipFromClass(param1:Class) : MovieClip
      {
         var clip:MovieClip = null;
         var clipClass:Class = param1;
         try
         {
            clip = new clipClass();
         }
         catch(e:ReferenceError)
         {
            clip = new MovieClip();
            clip.graphics.beginFill(65280);
            clip.graphics.drawRect(-25,-25,25,25);
            clip.graphics.endFill();
         }
         return clip;
      }
      
      protected function renderFramesWithSharedFrames(param1:MovieClip, param2:AnimationSharedFramesMap, param3:String) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:PositionedBMD = null;
         var _loc6_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:FrameLabel = null;
         var _loc10_:uint = 0;
         var _loc11_:PBMDParams = null;
         var _loc12_:int = 0;
         var _loc7_:Array = param2 !== null?param2.map:null;
         if(_loc7_ === null || _loc7_.length !== param1.totalFrames)
         {
            this.renderFrames(param1);
            return;
         }
         _zeroDeg.addChild(param1);
         this.totalFrames = param1.totalFrames;
         if(ONLY_USE_FIRST_FRAME)
         {
            this.totalFrames = 1;
         }
         this._frames = new Array(this.totalFrames);
         _loc8_ = 0;
         while(_loc8_ < this._frames.length)
         {
            _loc6_ = new Array(this._rotationStepsNum);
            this._frames[_loc8_] = _loc6_;
            param1.gotoAndStop(_loc8_ + 1);
            _loc10_ = 0;
            while(_loc10_ < this._rotationStepsNum)
            {
               _loc5_ = new PositionedBMD();
               _loc6_[_loc10_] = _loc5_;
               _loc4_ = _loc10_ * this._rotationStepSize;
               if(_loc8_ === _loc7_[_loc8_])
               {
                  _loc11_ = new PBMDParams(param1,_zeroDeg,_loc8_ + 1,_loc4_,_loc5_);
                  this.drawPBMD(_loc11_);
               }
               else
               {
                  _loc12_ = _loc7_[_loc8_];
                  _loc5_.data = this._frames[_loc12_][_loc10_].data;
                  _loc5_.rect = _loc5_.data.rect;
                  if(_loc10_ == 0)
                  {
                     _loc5_.pos = param2.offsets[_loc8_];
                  }
                  else
                  {
                     if(_loc6_[0].rect === null)
                     {
                     }
                     _loc5_.pos = this.getOffsetForRotation(_loc4_,param2.offsets[_loc8_],_loc6_[0].rect);
                  }
               }
               _loc10_++;
            }
            _loc8_++;
         }
         _zeroDeg.removeChild(param1);
         for each(_loc9_ in param1.currentLabels)
         {
            this.labels[_loc9_.name] = _loc9_.frame;
         }
      }
      
      private function getOffsetForRotation(param1:Number, param2:Point, param3:Rectangle) : Point
      {
         var _loc4_:int = 0;
         var _loc8_:LGVector2D = null;
         var _loc5_:Vector.<LGVector2D> = new Vector.<LGVector2D>(4);
         _loc5_[0] = new LGVector2D(param2.x,param2.y);
         _loc5_[1] = new LGVector2D(param2.x + param3.width,param2.y);
         _loc5_[2] = new LGVector2D(param2.x + param3.width,param2.y + param3.height);
         _loc5_[3] = new LGVector2D(param2.x,param2.y + param3.height);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc5_[_loc4_].rotateBy(param1);
            _loc4_++;
         }
         var _loc6_:LGVector2D = _loc5_[0];
         var _loc7_:LGVector2D = _loc5_[0];
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc4_];
            if(_loc8_.x < _loc7_.x)
            {
               _loc7_ = _loc8_;
            }
            if(_loc8_.y < _loc6_.y)
            {
               _loc6_ = _loc8_;
            }
            _loc4_++;
         }
         var _loc9_:Point = new Point(_loc7_.x,_loc6_.y);
         return _loc9_;
      }
      
      protected function renderFrames(param1:MovieClip) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:PositionedBMD = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:FrameLabel = null;
         var _loc7_:uint = 0;
         var _loc8_:PBMDParams = null;
         _zeroDeg.addChild(param1);
         this.totalFrames = param1.totalFrames;
         if(ONLY_USE_FIRST_FRAME)
         {
            this.totalFrames = 1;
         }
         this._frames = new Array(this.totalFrames);
         _loc5_ = 0;
         while(_loc5_ < this._frames.length)
         {
            _loc4_ = new Array(this._rotationStepsNum);
            this._frames[_loc5_] = _loc4_;
            param1.gotoAndStop(_loc5_ + 1);
            _loc7_ = 0;
            while(_loc7_ < this._rotationStepsNum)
            {
               _loc3_ = new PositionedBMD();
               _loc4_[_loc7_] = _loc3_;
               _loc2_ = _loc7_ * this._rotationStepSize;
               _loc8_ = new PBMDParams(param1,_zeroDeg,_loc5_ + 1,_loc2_,_loc3_);
               this.drawPBMD(_loc8_);
               _loc7_++;
            }
            _loc5_++;
         }
         _zeroDeg.removeChild(param1);
         for each(_loc6_ in param1.currentLabels)
         {
            this.labels[_loc6_.name] = _loc6_.frame;
         }
         if(ENABLE_RUNTIME_FRAME_SHARING_CALCULATION)
         {
            this.collapseSharedFrames();
         }
      }
      
      public function collapseSharedFrames() : void
      {
         var _loc1_:AnimationSharedFramesMap = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PositionedBMD = null;
         var _loc6_:int = 0;
         var _loc5_:Vector.<PositionedBMD> = new Vector.<PositionedBMD>(this.totalFrames);
         _loc3_ = 0;
         while(_loc3_ < this.totalFrames)
         {
            _loc5_[_loc3_] = this._frames[_loc3_][0];
            _loc3_++;
         }
         _loc1_ = new SharedFrameAnalyser().getSharedFramesFromArray(_loc5_);
         _loc3_ = 0;
         while(_loc3_ < this.totalFrames)
         {
            _loc2_ = _loc1_.map[_loc3_];
            _loc6_ = 0;
            while(_loc6_ < this._rotationStepsNum)
            {
               if(_loc2_ !== _loc3_)
               {
                  _loc4_ = this._frames[_loc3_][_loc6_];
                  _loc4_.data.dispose();
                  _loc4_.data = this._frames[_loc2_][_loc6_].data;
               }
               _loc6_++;
            }
            _loc3_++;
         }
      }
      
      protected function drawPBMD(param1:PBMDParams) : void
      {
         var tempBMD:BitmapData = null;
         var clipPixRect:Rectangle = null;
         var frameNum:int = 0;
         var params:PBMDParams = param1;
         var drawXform:Matrix = !!this._drawTransform?this._drawTransform:new Matrix();
         if(this._filters)
         {
            params.clip.filters = this._filters;
         }
         params.clip.gotoAndStop(params.frame);
         params.clip.rotation = params.angle * 360 / TWOPI;
         if(this._flipX)
         {
            drawXform.scale(-1,1);
            params.clip.scaleX = -1;
         }
         if(this._flipY)
         {
            drawXform.scale(1,-1);
            params.clip.scaleY = -1;
         }
         var clipRect:Rectangle = params.clip.getBounds(new MovieClip());
         clipRect.x = clipRect.x - this._renderPadding;
         clipRect.y = clipRect.y - this._renderPadding;
         clipRect.width = clipRect.width + this._renderPadding * 2;
         clipRect.height = clipRect.height + this._renderPadding * 2;
         clipRect.x = Math.floor(clipRect.x);
         clipRect.y = Math.floor(clipRect.y);
         clipRect.width = Math.ceil(clipRect.width);
         clipRect.height = Math.ceil(clipRect.height);
         var translateVector:Point = new Point(-clipRect.x,-clipRect.y);
         drawXform.rotate(params.angle);
         drawXform.translate(translateVector.x,translateVector.y);
         try
         {
            tempBMD = new BitmapData(clipRect.width + 1,clipRect.height + 1,true,0);
            tempBMD.draw(params.clip,drawXform,this._colorTransform);
            clipPixRect = tempBMD.getColorBoundsRect(ALPHA_BITS,ALPHA_ZERO,false);
            params.pbmd_out.data = new BitmapData(clipPixRect.width + 1,clipPixRect.height + 1,true,ALPHA_ZERO);
            params.pbmd_out.data.copyPixels(tempBMD,clipPixRect,_zeroPoint);
            params.pbmd_out.pos = clipRect.topLeft.add(clipPixRect.topLeft);
            params.pbmd_out.rect = params.pbmd_out.data.rect;
            tempBMD.fillRect(clipRect,0);
            tempBMD.dispose();
            this._bytes = this._bytes + (clipPixRect.width + 1) * (clipPixRect.height + 1) * 4;
            return;
         }
         catch(e:Error)
         {
            if(params.clip != null)
            {
               frameNum = params.clip.currentFrame;
            }
            t.obj(e);
            if(!_failed)
            {
               _failed = true;
               if(_onFailedFunction != null)
               {
                  _onFailedFunction();
               }
            }
            return;
         }
      }
      
      public function getBMD(param1:uint, param2:Number = 0) : PositionedBMD
      {
         var _loc3_:PositionedBMD = null;
         var _loc4_:Array = null;
         while(param2 < 0)
         {
            param2 = param2 + TWOPI;
         }
         while(param2 >= TWOPI)
         {
            param2 = param2 - TWOPI;
         }
         this._rotIndex = param2 / this._rotationStepSize + 0.5;
         if(this._rotIndex == this._rotationStepsNum)
         {
            this._rotIndex = 0;
         }
         if(this._frames[param1 - 1] != null)
         {
            _loc4_ = this._frames[param1 - 1];
            _loc3_ = _loc4_[this._rotIndex];
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         var _loc2_:PositionedBMD = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._frames.length)
         {
            _loc1_ = this._frames[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_];
               _loc2_.data.dispose();
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function get sizeKiB() : int
      {
         return Math.round(this._bytes / 1024);
      }
      
      public function get bytes() : int
      {
         return this._bytes;
      }
   }
}
