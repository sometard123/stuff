package ninjakiwi.tool
{
   import flash.display.MovieClip;
   
   public class LevelAnimation extends MovieClip
   {
       
      
      public var startOnRandomFrame:Boolean = true;
      
      public var usePauseFrame:Boolean = false;
      
      public var pauseFrame:int = 1;
      
      public var pauseTimeMin:int = 0;
      
      public var pauseTimeMax:int = 10;
      
      public var useFramerateModifier:Boolean = false;
      
      public var framerateModifierMin:Number = 1.0;
      
      public var framerateModifierMax:Number = 1.0;
      
      public function LevelAnimation()
      {
         super();
      }
   }
}
