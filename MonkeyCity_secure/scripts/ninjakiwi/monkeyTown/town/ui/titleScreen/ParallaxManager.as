package ninjakiwi.monkeyTown.town.ui.titleScreen
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   
   public class ParallaxManager
   {
       
      
      public var sensitivityX:Number = 0.04;
      
      public var sensitivityY:Number = 0.0;
      
      public var mouseOffsetLimitX:Number = 400;
      
      public var mouseOffsetLimitY:Number = 400;
      
      private var _layers:Array;
      
      private var _stage:Stage = null;
      
      public var tweenDuration:Number = 0.5;
      
      public function ParallaxManager(param1:Stage)
      {
         this._layers = [];
         super();
         this._stage = param1;
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         this.setOffset(this._stage.mouseX - this._stage.stageWidth * 0.5,this._stage.mouseY - this._stage.stageHeight * 0.5);
      }
      
      public function addLayer(param1:DisplayObject, param2:Number) : void
      {
         this._layers.push(new ParallaxLayer(param1,param2));
      }
      
      public function setOffset(param1:Number, param2:Number) : void
      {
         var _loc3_:ParallaxLayer = null;
         if(param1 < -this.mouseOffsetLimitX)
         {
            param1 = -this.mouseOffsetLimitX;
         }
         if(param1 > this.mouseOffsetLimitX)
         {
            param1 = this.mouseOffsetLimitX;
         }
         if(param2 < -this.mouseOffsetLimitY)
         {
            param2 = -this.mouseOffsetLimitY;
         }
         if(param2 > this.mouseOffsetLimitY)
         {
            param2 = this.mouseOffsetLimitY;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._layers.length)
         {
            _loc3_ = this._layers[_loc4_];
            TweenLite.to(_loc3_.target,this.tweenDuration,{
               "x":_loc3_.homePosition.x + param1 * _loc3_.depth * this.sensitivityX,
               "y":_loc3_.homePosition.y + param2 * _loc3_.depth * this.sensitivityY
            });
            _loc4_++;
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.geom.Point;

class ParallaxLayer
{
    
   
   public var target:DisplayObject;
   
   public var depth:Number;
   
   public var homePosition:Point;
   
   function ParallaxLayer(param1:DisplayObject, param2:Number)
   {
      this.homePosition = new Point();
      super();
      this.target = param1;
      this.depth = param2;
      this.homePosition.x = param1.x;
      this.homePosition.y = param1.y;
   }
}
