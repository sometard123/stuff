package ninjakiwi.sharedFrameAnalyser
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.display.gfx.bitClip.PositionedBMD;
   
   public class SharedFrameAnalyser
   {
       
      
      public function SharedFrameAnalyser()
      {
         super();
      }
      
      public function getSharedFramesFromDef(param1:*, param2:int = 1) : AnimationSharedFramesMap
      {
         var _loc3_:MovieClip = this.definitionToMovieClip(param1);
         var _loc4_:FrameCacher = new FrameCacher(_loc3_);
         var _loc5_:AnimationSharedFramesMap = this.getSharedFramesFromArray(_loc4_.frames);
         _loc4_.dispose();
         return _loc5_;
      }
      
      public function getSharedFramesFromArray(param1:Vector.<PositionedBMD>) : AnimationSharedFramesMap
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:Number = NaN;
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_[_loc2_] = -1;
            _loc5_[_loc2_] = new Point();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc5_[_loc2_] = param1[_loc2_].pos;
            if(_loc4_[_loc2_] === -1)
            {
               _loc4_[_loc2_] = _loc2_;
               _loc11_ = this.getMemoryUsedByBitmapData(param1[_loc2_].data);
               _loc8_ = _loc8_ + _loc11_;
               _loc3_ = _loc2_ + 1;
               while(_loc3_ < param1.length)
               {
                  if(this.bitmapsEqual(param1[_loc2_].data,param1[_loc3_].data))
                  {
                     _loc4_[_loc3_] = _loc2_;
                     _loc9_ = _loc9_ + _loc11_;
                     _loc7_++;
                  }
                  _loc3_++;
               }
            }
            _loc2_++;
         }
         var _loc10_:AnimationSharedFramesMap = new AnimationSharedFramesMap().Map(_loc4_).Offsets(_loc5_).TotalFrames(param1.length).DroppedFrames(_loc7_).MemoryUnoptimised(_loc8_).MemorySaved(_loc9_);
         return _loc10_;
      }
      
      public function getMemoryUsedByBitmapData(param1:BitmapData) : Number
      {
         var _loc2_:Number = (param1.width + 1) * (param1.height + 1) * 4;
         return _loc2_;
      }
      
      public function bitmapsEqual(param1:BitmapData, param2:BitmapData) : Boolean
      {
         if(param1.width != param2.width || param1.height != param2.height)
         {
            return false;
         }
         var _loc3_:Rectangle = new Rectangle(0,0,param1.width,param1.height);
         var _loc4_:Vector.<uint> = param1.getVector(_loc3_);
         var _loc5_:Vector.<uint> = param2.getVector(_loc3_);
         var _loc6_:int = _loc4_.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc4_[_loc7_] !== _loc5_[_loc7_])
            {
               return false;
            }
            _loc7_++;
         }
         return true;
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
   }
}
