package display
{
   public class LabelOverCommand
   {
      
      public static var gotoAndStop:int = 1;
      
      public static var gotoAndPlay:int = 2;
      
      public static var stop:int = 3;
      
      public static var play:int = 4;
       
      
      public var command:int = 0;
      
      public var frameNoTo:int = -1;
      
      public var frameLabelTo:String = null;
      
      public function LabelOverCommand()
      {
         super();
      }
   }
}
