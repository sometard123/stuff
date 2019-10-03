package display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Frame
   {
      
      private static const testMargin:int = 20;
      
      public static var stage:Stage = null;
      
      private static var memoryUsed:Number = 0;
       
      
      public var handle:Point;
      
      public var data:BitmapData;
      
      public var rotations:Vector.<BitmapData>;
      
      public var rotatedHandles:Vector.<Point>;
      
      private var position:Point;
      
      public var label:String;
      
      private var sourceClass:Class = null;
      
      private var effectClass:Class = null;
      
      private var sourceIndex:int = 0;
      
      private var rotationCount:int = 0;
      
      private var cachedScale:Number = 1.0;
      
      public function Frame(param1:MovieClip, param2:Boolean, param3:int, param4:Object = null, param5:Number = 1.0)
      {
         var _loc8_:int = 0;
         this.handle = new Point();
         this.rotations = new Vector.<BitmapData>();
         this.rotatedHandles = new Vector.<Point>();
         this.position = new Point();
         super();
         var _loc6_:Class = null;
         var _loc7_:Boolean = false;
         this.cachedScale = param5;
         if(param4 is Class)
         {
            _loc6_ = Class(param4);
         }
         else if(param4 is Boolean)
         {
            _loc7_ = Boolean(param4);
         }
         this.rotationCount = param3;
         if(!param2)
         {
            this.label = param1.currentLabel;
            this.sourceClass = Class(getDefinitionByName(getQualifiedClassName(param1)));
            this.effectClass = null;
            this.sourceIndex = param1.currentFrame;
         }
         else
         {
            this.label = MovieClip(param1.getChildAt(0)).label;
            this.sourceClass = _loc6_;
            this.effectClass = Class(getDefinitionByName(getQualifiedClassName(param1)));
            this.sourceIndex = MovieClip(param1.getChildAt(0)).currentFrame;
         }
         this.data = this.copyToData(param1,this.handle,0,param5);
         this.rotations.push(this.data);
         this.rotatedHandles.push(this.handle);
         if(_loc7_)
         {
            _loc8_ = 0;
            while(_loc8_ < param3)
            {
               this.initialiseRotation(_loc8_,param1,param5);
               _loc8_++;
            }
         }
         else
         {
            while(this.rotations.length < param3)
            {
               this.rotations.push(null);
               this.rotatedHandles.push(null);
            }
         }
      }
      
      private function initialiseRotation(param1:int, param2:MovieClip = null, param3:Number = 1.0) : void
      {
         if(param2 == null)
         {
            if(this.effectClass)
            {
               param2 = new this.effectClass();
               param2.addChild(new this.sourceClass());
               MovieClip(param2.getChildAt(0)).gotoAndStop(this.sourceIndex);
            }
            else
            {
               param2 = new this.sourceClass();
               param2.gotoAndStop(this.sourceIndex);
            }
         }
         var _loc4_:Point = new Point();
         this.rotations[param1] = this.copyToData(param2,_loc4_,param1 / this.rotationCount * Math.PI * 2,param3);
         this.rotatedHandles[param1] = _loc4_;
         if(!this.effectClass)
         {
         }
      }
      
      private function copyToData(param1:MovieClip, param2:Point, param3:Number = 0, param4:Number = 1.0) : BitmapData
      {
         var _loc5_:String = null;
         if(stage !== null)
         {
            _loc5_ = stage.quality;
            stage.quality = StageQuality.BEST;
         }
         var _loc6_:MovieClip = new MovieClip();
         param1.scaleX = Main.instance.scale * param4;
         param1.scaleY = Main.instance.scale * param4;
         _loc6_.addChild(param1);
         param1.rotation = param3 * 180 / Math.PI;
         var _loc7_:Rectangle = _loc6_.getBounds(null);
         _loc7_.x = Math.floor(_loc7_.x);
         _loc7_.y = Math.floor(_loc7_.y);
         param2.x = -_loc7_.x;
         param2.y = -_loc7_.y;
         var _loc8_:Matrix = Pool.get(Matrix);
         _loc8_.identity();
         _loc8_.translate(Math.ceil(param2.x + testMargin),Math.ceil(param2.y + testMargin));
         var _loc9_:BitmapData = new BitmapData(_loc7_.width + testMargin * 2,_loc7_.height + testMargin * 2,true,0);
         _loc9_.draw(_loc6_,_loc8_,null,null,null,true);
         _loc7_ = _loc9_.getColorBoundsRect(4278190080,0,false);
         param2.x = param2.x + (testMargin - _loc7_.x);
         param2.y = param2.y + (testMargin - _loc7_.y);
         this.position.x = 0;
         this.position.y = 0;
         _loc7_.width = Math.max(_loc7_.width,1);
         _loc7_.height = Math.max(_loc7_.height,1);
         var _loc10_:BitmapData = new BitmapData(_loc7_.width,_loc7_.height,true,0);
         _loc10_.copyPixels(_loc9_,_loc7_,this.position);
         _loc9_.dispose();
         Pool.release(_loc8_);
         var _loc11_:Number = _loc10_.width * _loc10_.height * 4 * 4 / (1024 * 1024);
         memoryUsed = memoryUsed + _loc11_;
         if(stage !== null && stage.quality !== _loc5_)
         {
            stage.quality = _loc5_;
         }
         return _loc10_;
      }
      
      public function quickDraw(param1:BitmapData, param2:Number, param3:Number) : void
      {
         this.position.x = param2 * Main.instance.scale - this.handle.x;
         this.position.y = param3 * Main.instance.scale - this.handle.y;
         param1.copyPixels(this.data,this.data.rect,this.position,null,null,true);
      }
      
      public function drawRotated(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:ColorTransform = null) : void
      {
         var _loc6_:Matrix = null;
         var _loc7_:int = 0;
         var _loc8_:Point = null;
         var _loc9_:BitmapData = null;
         if(this.rotationCount > 0)
         {
            param4 = param4 + Math.PI / this.rotationCount;
            while(param4 < 0)
            {
               param4 = param4 + Math.PI * 2;
            }
            while(param4 >= Math.PI * 2)
            {
               param4 = param4 - Math.PI * 2;
            }
            _loc7_ = Math.floor(this.rotationCount * param4 / (Math.PI * 2));
            if(this.rotations[_loc7_] == null)
            {
               this.initialiseRotation(_loc7_,null,this.cachedScale);
            }
            _loc8_ = this.rotatedHandles[_loc7_];
            _loc9_ = this.rotations[_loc7_];
            this.position.x = param2 * Main.instance.scale - _loc8_.x;
            this.position.y = param3 * Main.instance.scale - _loc8_.y;
            if(param5 === null)
            {
               param1.copyPixels(_loc9_,_loc9_.rect,this.position,null,null,true);
            }
            else
            {
               _loc6_ = Pool.get(Matrix);
               _loc6_.identity();
               _loc6_.translate(-_loc8_.x,-_loc8_.y);
               _loc6_.translate(param2 * Main.instance.scale,param3 * Main.instance.scale);
               param1.draw(_loc9_,_loc6_,param5,null,null,true);
               Pool.release(_loc6_);
            }
            return;
         }
         _loc6_ = Pool.get(Matrix);
         _loc6_.identity();
         _loc6_.translate(-this.handle.x,-this.handle.y);
         _loc6_.rotate(param4);
         _loc6_.translate(param2 * Main.instance.scale,param3 * Main.instance.scale);
         param1.draw(this.data,_loc6_,param5,null,null,true);
         Pool.release(_loc6_);
      }
      
      public function drawScaled(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Matrix = Pool.get(Matrix);
         _loc6_.identity();
         _loc6_.translate(-this.handle.x,-this.handle.y);
         _loc6_.scale(param5,param5);
         _loc6_.rotate(param4);
         _loc6_.translate(param2 * Main.instance.scale,param3 * Main.instance.scale);
         param1.draw(this.data,_loc6_,null,null,null,true);
         Pool.release(_loc6_);
      }
      
      public function drawWithEffect(param1:BitmapData, param2:Number, param3:Number, param4:MovieClip, param5:Number, param6:Boolean = false) : void
      {
         var _loc9_:Number = NaN;
         if(this.rotationCount != 0)
         {
            _loc9_ = Math.PI * 2 / this.rotationCount;
            param5 = Math.round(param5 / _loc9_) * _loc9_;
         }
         var _loc7_:Matrix = Pool.get(Matrix);
         _loc7_.identity();
         _loc7_.translate(-this.handle.x,-this.handle.y);
         _loc7_.rotate(param5);
         _loc7_.translate(param2 * Main.instance.scale,param3 * Main.instance.scale);
         var _loc8_:Bitmap = new Bitmap(this.data);
         param4.inner.addChild(_loc8_);
         param1.draw(param4,_loc7_,null,null,null,true);
         if(!param6)
         {
            param1.draw(this.data,_loc7_,null,null,null,true);
         }
         param4.inner.removeChildAt(0);
         Pool.release(_loc7_);
      }
      
      public function drawWithBlendMode(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:String) : void
      {
         var _loc6_:Matrix = Pool.get(Matrix);
         _loc6_.identity();
         _loc6_.translate(-this.handle.x,-this.handle.y);
         _loc6_.rotate(param4);
         _loc6_.translate(param2 * Main.instance.scale,param3 * Main.instance.scale);
         param1.draw(this.data,_loc6_,null,param5,null,true);
         Pool.release(_loc6_);
      }
      
      public function getRotationCount() : int
      {
         return this.rotationCount;
      }
   }
}
