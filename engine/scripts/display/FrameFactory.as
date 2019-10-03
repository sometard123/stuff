package display
{
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class FrameFactory
   {
       
      
      private var frames:Dictionary;
      
      private var frameSetsBySourceClass:Dictionary;
      
      public function FrameFactory()
      {
         this.frames = new Dictionary();
         this.frameSetsBySourceClass = new Dictionary();
         super();
      }
      
      private function getScaleID(param1:Number) : String
      {
         if(Math.abs(param1 - Math.round(param1)) < 0.012)
         {
            param1 = Math.round(param1);
         }
         if(param1 == 1)
         {
            return "";
         }
         return "_scale" + (Math.floor(param1 * 100) / 100).toString();
      }
      
      public function getFrames(param1:Class, param2:int, param3:Boolean = false, param4:Number = 1.0) : Vector.<Frame>
      {
         var _loc10_:GlowFilter = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc5_:String = this.getScaleID(param4);
         var _loc6_:String = getQualifiedClassName(param1) + "_clip" + _loc5_;
         var _loc7_:Vector.<Frame> = this.frames[_loc6_];
         if(_loc7_ != null)
         {
            return _loc7_;
         }
         var _loc8_:MovieClip = new param1();
         _loc7_ = new Vector.<Frame>();
         if(param3)
         {
            _loc10_ = new GlowFilter();
            _loc10_.color = 0;
            _loc10_.strength = 1;
            _loc8_.filters = [_loc10_];
         }
         var _loc9_:int = 1;
         while(_loc9_ <= _loc8_.totalFrames)
         {
            _loc8_.gotoAndStop(_loc9_);
            _loc7_.push(new Frame(_loc8_,false,param2,null,param4));
            _loc9_++;
         }
         this.frames[_loc6_] = _loc7_;
         if(this.frameSetsBySourceClass[param1] == null)
         {
            this.frameSetsBySourceClass[param1] = new Vector.<FrameSetData>();
         }
         this.frameSetsBySourceClass[param1].push(new FrameSetData(_loc6_,_loc7_));
         return _loc7_;
      }
      
      public function getEffectFrames(param1:Class, param2:Class, param3:int, param4:Number = 1.0) : Vector.<Frame>
      {
         var _loc5_:String = this.getScaleID(param4);
         var _loc6_:String = getQualifiedClassName(param1) + "_" + getQualifiedClassName(param2) + "_clip" + _loc5_;
         var _loc7_:Vector.<Frame> = this.frames[_loc6_];
         if(_loc7_ != null)
         {
            return _loc7_;
         }
         var _loc8_:MovieClip = new param1();
         var _loc9_:MovieClip = new param2();
         _loc7_ = new Vector.<Frame>();
         _loc9_.inner.addChild(_loc8_);
         var _loc10_:int = 1;
         while(_loc10_ <= _loc8_.totalFrames)
         {
            _loc8_.gotoAndStop(_loc10_);
            _loc7_.push(new Frame(_loc9_,true,param3,param1,param4));
            _loc10_++;
         }
         this.frames[_loc6_] = _loc7_;
         if(this.frameSetsBySourceClass[param1] == null)
         {
            this.frameSetsBySourceClass[param1] = new Vector.<FrameSetData>();
         }
         this.frameSetsBySourceClass[param1].push(new FrameSetData(_loc6_,_loc7_));
         return _loc7_;
      }
      
      public function destroyFrames(param1:Class) : void
      {
         var _loc4_:FrameSetData = null;
         var _loc5_:Vector.<Frame> = null;
         var _loc6_:Frame = null;
         var _loc2_:Vector.<FrameSetData> = this.frameSetsBySourceClass[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.frameSet;
            for each(_loc6_ in _loc5_)
            {
               _loc6_.data.dispose();
            }
            delete this.frames[_loc4_.id];
            _loc3_++;
         }
         delete this.frameSetsBySourceClass[param1];
      }
   }
}
