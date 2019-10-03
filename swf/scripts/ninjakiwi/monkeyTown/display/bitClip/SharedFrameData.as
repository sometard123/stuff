package ninjakiwi.monkeyTown.display.bitClip
{
   import ninjakiwi.monkeyTown.utils.ObjectHelper2;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class SharedFrameData
   {
      
      public static const instance:SharedFrameData = new SharedFrameData();
       
      
      private const serialisedData:Class = SharedFrameData_serialisedData;
      
      private const frameMappings:Object = ObjectHelper2.deserialize(new this.serialisedData());
      
      public function SharedFrameData()
      {
         super();
      }
      
      public function getMapping(param1:String) : AnimationSharedFramesMap
      {
         var _loc2_:AnimationSharedFramesMap = this.frameMappings[param1];
         return _loc2_;
      }
   }
}
