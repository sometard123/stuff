package ninjakiwi.display.gfx
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class NinjaClip
   {
       
      
      public var renderBmd:BitmapData;
      
      public var renderViewport:Rectangle;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var angle:Number = 0;
      
      public var currentFrame:uint;
      
      public var deleteMe:Boolean = false;
      
      public function NinjaClip()
      {
         super();
      }
      
      public function setTarget(param1:BitmapData, param2:Rectangle) : void
      {
         this.renderBmd = param1;
         this.renderViewport = param2;
      }
      
      public function render(param1:BitmapData = null, param2:Rectangle = null, param3:Number = 0, param4:Number = 0, param5:Number = 0) : void
      {
      }
      
      public function play() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function gotoAndPlay(param1:*) : void
      {
      }
      
      public function gotoAndStop(param1:*) : void
      {
      }
   }
}
