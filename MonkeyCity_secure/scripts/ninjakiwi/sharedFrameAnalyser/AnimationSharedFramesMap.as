package ninjakiwi.sharedFrameAnalyser
{
   public class AnimationSharedFramesMap
   {
       
      
      public var map:Array;
      
      public var offsets:Array;
      
      public var totalFrames:int;
      
      public var droppedFrames:int;
      
      public var memoryUnoptimised:Number = 0;
      
      public var memorySaved:Number = 0;
      
      public function AnimationSharedFramesMap()
      {
         this.map = [];
         this.offsets = [];
         super();
      }
      
      public function Map(param1:Array) : AnimationSharedFramesMap
      {
         this.map = param1;
         return this;
      }
      
      public function Offsets(param1:Array) : AnimationSharedFramesMap
      {
         this.offsets = param1;
         return this;
      }
      
      public function TotalFrames(param1:int) : AnimationSharedFramesMap
      {
         this.totalFrames = param1;
         return this;
      }
      
      public function DroppedFrames(param1:int) : AnimationSharedFramesMap
      {
         this.droppedFrames = param1;
         return this;
      }
      
      public function MemoryUnoptimised(param1:Number) : AnimationSharedFramesMap
      {
         this.memoryUnoptimised = param1;
         return this;
      }
      
      public function MemorySaved(param1:Number) : AnimationSharedFramesMap
      {
         this.memorySaved = param1;
         return this;
      }
   }
}
