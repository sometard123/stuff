package display
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class Clip
   {
       
      
      public var frameIndex:int = 0;
      
      public var subFrameIndex:Number = 0;
      
      public var frames:Vector.<Frame>;
      
      private var playing:Boolean = true;
      
      public var labelOver:Dictionary;
      
      public var sourceClass:Class = null;
      
      public var looping:Boolean = false;
      
      public var usePauseFrame:Boolean = false;
      
      public var pauseFrame:int = 1;
      
      public var pauseTimeMin:int = 0;
      
      public var pauseTimeMax:int = 10;
      
      private var delayCountdown:int = 0;
      
      public var isDelaying:Boolean = false;
      
      public var useFramerateModifier:Boolean = false;
      
      public var framerateModifier:Number = 1.0;
      
      public var markForRemoval:Boolean = false;
      
      public var loopCount:int = 0;
      
      public function Clip()
      {
         this.labelOver = new Dictionary();
         super();
      }
      
      public function initialise(param1:Class, param2:int, param3:Boolean = false, param4:Number = 1.0) : void
      {
         this.sourceClass = param1;
         this.frameIndex = 0;
         this.markForRemoval = false;
         this.subFrameIndex = this.frameIndex;
         this.loopCount = 0;
         this.frames = Main.instance.frameFactory.getFrames(param1,param2,param3,param4);
      }
      
      public function initialiseWithEffect(param1:Class, param2:Class, param3:int, param4:Number = 1.0) : void
      {
         this.frameIndex = 0;
         this.subFrameIndex = this.frameIndex;
         this.markForRemoval = false;
         this.loopCount = 0;
         this.frames = Main.instance.frameFactory.getEffectFrames(param1,param2,param3,param4);
      }
      
      public function process() : void
      {
         if(this.frames == null)
         {
            return;
         }
         if(this.frames[this.frameIndex].label && this.labelOver[this.frames[this.frameIndex].label] && (this.frameIndex + 1 >= this.frames.length || this.frames[this.frameIndex].label != this.frames[this.frameIndex + 1].label))
         {
            switch(this.labelOver[this.frames[this.frameIndex].label].command)
            {
               case LabelOverCommand.gotoAndPlay:
                  if(this.labelOver[this.frames[this.frameIndex].label].frameLabelTo)
                  {
                     this.gotoLabel(this.labelOver[this.frames[this.frameIndex].label].frameLabelTo);
                  }
                  else
                  {
                     this.frameIndex = this.labelOver[this.frames[this.frameIndex].label].frameNoTo;
                     this.subFrameIndex = this.frameIndex;
                  }
                  this.playing = true;
                  break;
               case LabelOverCommand.gotoAndStop:
                  if(this.labelOver[this.frames[this.frameIndex].label].frameLabelTo)
                  {
                     this.gotoLabel(this.labelOver[this.frames[this.frameIndex].label].frameLabelTo);
                  }
                  else
                  {
                     this.frameIndex = this.labelOver[this.frames[this.frameIndex].label].frameNoTo;
                     this.subFrameIndex = this.frameIndex;
                  }
                  this.playing = false;
            }
         }
         else if(this.playing)
         {
            if(this.usePauseFrame)
            {
               if(this.isDelaying)
               {
                  if(--this.delayCountdown <= 0)
                  {
                     this.endDelay();
                  }
                  else
                  {
                     return;
                  }
               }
               else if(this.frameIndex === this.pauseFrame - 1)
               {
                  this.beginDelay();
                  return;
               }
            }
            if(this.useFramerateModifier)
            {
               this.subFrameIndex = this.subFrameIndex + this.framerateModifier;
               this.subFrameIndex = this.subFrameIndex % this.frames.length;
               this.frameIndex = Math.floor(this.subFrameIndex);
            }
            else
            {
               this.frameIndex++;
            }
            if(this.frameIndex >= this.frames.length)
            {
               if(!this.looping)
               {
                  this.frameIndex--;
                  this.subFrameIndex = this.frameIndex;
                  this.playing = false;
               }
               else
               {
                  this.frameIndex = 0;
                  this.subFrameIndex = this.subFrameIndex - Math.floor(this.subFrameIndex);
                  this.loopCount++;
               }
            }
         }
      }
      
      private function beginDelay() : void
      {
         this.isDelaying = true;
         this.delayCountdown = Math.random() * (this.pauseTimeMax - this.pauseTimeMin) + this.pauseTimeMin;
      }
      
      private function endDelay() : void
      {
         this.isDelaying = false;
         this.delayCountdown = 0;
      }
      
      public function quickDraw(param1:BitmapData, param2:Number, param3:Number) : void
      {
         if(this.frames == null)
         {
            return;
         }
         this.frames[this.frameIndex].quickDraw(param1,param2,param3);
      }
      
      public function drawRotated(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:ColorTransform = null) : void
      {
         if(this.frames == null)
         {
            return;
         }
         this.frames[this.frameIndex].drawRotated(param1,param2,param3,param4,param5);
      }
      
      public function drawScaled(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         if(this.frames == null)
         {
            return;
         }
         this.frames[this.frameIndex].drawScaled(param1,param2,param3,param4,param5);
      }
      
      public function drawWithEffect(param1:BitmapData, param2:Number, param3:Number, param4:MovieClip, param5:Number = 0, param6:Boolean = false) : void
      {
         if(this.frames == null)
         {
            return;
         }
         this.frames[this.frameIndex].drawWithEffect(param1,param2,param3,param4,param5,param6);
      }
      
      public function drawWithBlendMode(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:String) : void
      {
         if(this.frames == null)
         {
            return;
         }
         this.frames[this.frameIndex].drawWithBlendMode(param1,param2,param3,param4,param5);
      }
      
      public function gotoAndStop(param1:int) : void
      {
         this.frameIndex = param1;
         this.subFrameIndex = param1;
         this.playing = false;
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         this.frameIndex = param1;
         this.subFrameIndex = param1;
         this.playing = true;
      }
      
      public function stop() : void
      {
         this.playing = false;
      }
      
      public function play() : void
      {
         this.playing = true;
      }
      
      public function get frameCount() : int
      {
         return this.frames.length;
      }
      
      public function get currentLabel() : String
      {
         if(this.frames == null)
         {
            return "";
         }
         return this.frames[this.frameIndex].label;
      }
      
      public function getLabelIndex(param1:String) : int
      {
         if(this.frames == null)
         {
            return -1;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.frames.length)
         {
            if(this.frames[_loc2_].label == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function gotoLabel(param1:String) : void
      {
         if(this.frames == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.frames.length)
         {
            if(this.frames[_loc2_].label == param1)
            {
               this.frameIndex = _loc2_;
               this.subFrameIndex = this.frameIndex;
               break;
            }
            _loc2_++;
         }
      }
      
      public function hasLabel(param1:String) : Boolean
      {
         var _loc2_:Frame = null;
         if(this.frames == null)
         {
            return false;
         }
         for each(_loc2_ in this.frames)
         {
            if(_loc2_.label == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isPlaying() : Boolean
      {
         return this.playing;
      }
   }
}
