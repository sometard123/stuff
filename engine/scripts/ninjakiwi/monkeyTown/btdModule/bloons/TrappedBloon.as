package ninjakiwi.monkeyTown.btdModule.bloons
{
   import fl.motion.BezierSegment;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class TrappedBloon
   {
       
      
      public var bloon:Bloon = null;
      
      public var chipTime:Number = 0;
      
      public var immunity:int = 0;
      
      public var pathTime:Number = 0;
      
      public var originX:Number = 0;
      
      public var originY:Number = 0;
      
      public var toX:Number = 0;
      
      public var toY:Number = 0;
      
      public var fromX:Number = 0;
      
      public var fromY:Number = 0;
      
      public var ejectTime:Number = 0;
      
      public var ejectPath:BezierSegment = null;
      
      public var popCount:int = 1;
      
      public var damage:int = 1;
      
      public var chipEvery:Number = 1;
      
      public var dir:Vector2;
      
      public function TrappedBloon()
      {
         this.dir = new Vector2();
         super();
      }
   }
}
