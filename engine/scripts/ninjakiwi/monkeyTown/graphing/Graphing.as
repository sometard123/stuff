package ninjakiwi.monkeyTown.graphing
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class Graphing extends MovieClip
   {
       
      
      public var canvas:Sprite;
      
      private var _rangeX:Number = 1000;
      
      private var _rangeY:Number = 1000;
      
      private var _canvasWidth:Number = 800;
      
      private var _canvasHeight:Number = 600;
      
      private var xStep:Number = 10;
      
      private var yStep:Number = 10;
      
      private var rangeXTextField:TextField;
      
      private var rangeYTextField:TextField;
      
      private var valueTextField:TextField;
      
      private var _container:Sprite;
      
      private const PADDING:int = 0;
      
      private var currentRolledOverLine:MovieClip = null;
      
      private var glow:GlowFilter;
      
      public var lineWidth:Number = 1;
      
      public function Graphing()
      {
         this.canvas = new Sprite();
         this._container = new Sprite();
         this.glow = new GlowFilter(13421772,1,3,3,100,3);
         super();
         this.setup();
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      public static function getCol() : uint
      {
         return Math.random() * uint.MAX_VALUE;
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.sync();
      }
      
      public function clear(param1:Number = 1) : void
      {
         this.canvas.graphics.clear();
         this.canvas.removeChildren();
         this.canvas.graphics.beginFill(16777215,param1);
         this.canvas.graphics.drawRect(0,0,this._canvasWidth,-this._canvasHeight);
      }
      
      private function setup() : void
      {
         addChild(this._container);
         this._container.addChild(this.canvas);
         this._container.y = this._canvasHeight;
         this.canvas.graphics.lineStyle(this.lineWidth,255);
         this.valueTextField = this.createTextField();
         this.valueTextField.multiline = true;
         this.valueTextField.height = 100;
         this.valueTextField.x = this.PADDING;
         addChild(this.valueTextField);
         this.rangeXTextField = this.createTextField();
         this.rangeYTextField = this.createTextField();
         this._container.addChild(this.rangeXTextField);
         this._container.addChild(this.rangeYTextField);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.updateInfoReadout();
      }
      
      private function updateInfoReadout() : void
      {
         var _loc1_:Number = this.canvas.mouseX / this._canvasWidth * this._rangeX;
         var _loc2_:Number = -this.canvas.mouseY / this._canvasHeight * this._rangeY;
         this.valueTextField.text = "x: " + _loc1_ + "\ny: " + _loc2_ + "\n";
         if(this.currentRolledOverLine && this.currentRolledOverLine.rolloverName)
         {
            this.valueTextField.appendText(this.currentRolledOverLine.rolloverName);
         }
      }
      
      public function drawData(param1:Array, param2:uint = 255, param3:String = "") : void
      {
         var _loc4_:int = 0;
         var _loc5_:MovieClip = new MovieClip();
         this.canvas.addChild(_loc5_);
         _loc5_.rolloverName = param3;
         _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.onLineOver);
         _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.onLineOut);
         _loc5_.graphics.lineStyle(20,16776960,0);
         _loc4_ = 1;
         while(_loc4_ < param1.length)
         {
            this.drawLine(_loc5_,(_loc4_ - 1) * this.xStep,param1[_loc4_ - 1] * this.yStep,_loc4_ * this.xStep,param1[_loc4_] * this.yStep);
            _loc4_++;
         }
         _loc5_.graphics.lineStyle(this.lineWidth,param2);
         _loc4_ = 1;
         while(_loc4_ < param1.length)
         {
            this.drawLine(_loc5_,(_loc4_ - 1) * this.xStep,param1[_loc4_ - 1] * this.yStep,_loc4_ * this.xStep,param1[_loc4_] * this.yStep);
            _loc4_++;
         }
      }
      
      private function onLineOut(param1:MouseEvent) : void
      {
         param1.currentTarget.filters = [];
         this.currentRolledOverLine = null;
         this.updateInfoReadout();
      }
      
      private function onLineOver(param1:Event) : void
      {
         this.currentRolledOverLine = MovieClip(param1.currentTarget);
         this.currentRolledOverLine.filters = [this.glow];
         this.updateInfoReadout();
      }
      
      public function drawLine(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         param1.graphics.moveTo(param2,-param3);
         param1.graphics.lineTo(param4,-param5);
      }
      
      private function sync() : void
      {
         this.clear();
         this.xStep = this._canvasWidth / this.rangeX;
         this.yStep = this._canvasHeight / this.rangeY;
         this._container.x = this.PADDING;
         this._container.y = this._canvasHeight + this.PADDING;
         this.rangeXTextField.text = this.rangeX.toString();
         this.rangeXTextField.x = this._canvasWidth;
         this.rangeXTextField.y = 0;
         this.rangeYTextField.text = this.rangeY.toString();
         this.rangeYTextField.x = 0;
         this.rangeYTextField.y = -this._canvasHeight;
      }
      
      private function drawGrid() : void
      {
      }
      
      public function get rangeX() : Number
      {
         return this._rangeX;
      }
      
      public function set rangeX(param1:Number) : void
      {
         this._rangeX = param1;
         this.sync();
      }
      
      public function get rangeY() : Number
      {
         return this._rangeY;
      }
      
      public function set rangeY(param1:Number) : void
      {
         this._rangeY = param1;
         this.sync();
      }
      
      public function get canvasWidth() : Number
      {
         return this._canvasWidth;
      }
      
      public function set canvasWidth(param1:Number) : void
      {
         this._canvasWidth = param1;
         this.sync();
      }
      
      public function get canvasHeight() : Number
      {
         return this._canvasHeight;
      }
      
      public function set canvasHeight(param1:Number) : void
      {
         this._canvasHeight = param1;
         this.sync();
      }
      
      public function getRandomColor() : uint
      {
         return uint(Math.random() * uint.MAX_VALUE);
      }
      
      private function createTextField(param1:Number = 0, param2:Number = 0, param3:Number = 500, param4:Number = 30) : TextField
      {
         var _loc5_:TextField = new TextField();
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.width = param3;
         _loc5_.height = param4;
         return _loc5_;
      }
   }
}
