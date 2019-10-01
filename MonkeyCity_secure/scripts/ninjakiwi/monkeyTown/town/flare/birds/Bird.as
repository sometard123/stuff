package ninjakiwi.monkeyTown.town.flare.birds
{
   import assets.ui.MonkeyKnowledgeInspector;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePathInfoBox;
   import org.osflash.signals.Signal;
   
   public class Bird
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var target:LGVector2D;
      
      public var velocity:LGVector2D;
      
      public var speed:Number = 1;
      
      public var steeringSpeed:Number = 0.1;
      
      private var _targetOffset:LGVector2D;
      
      private var _targetOffsetDistance:Number = 100;
      
      private var _offsetCounter:Number = 0;
      
      private var _offsetCounterSpeed:Number = 0.1;
      
      private var _offsetSpeedModifiers:LGVector2D;
      
      protected var _clip:BitClipCustom;
      
      protected var _numberOfAnimationAngles:uint = 16;
      
      protected var _animationClasses:Vector.<String>;
      
      protected var _anglePerAnimation:Number;
      
      protected var _angleRanges:Vector.<Range#1224>;
      
      protected var _currentAnimationIndex:int = 0;
      
      private var vectorToTarget:LGVector2D;
      
      public function Bird()
      {
         this.target = new LGVector2D();
         this.velocity = new LGVector2D();
         this._targetOffset = new LGVector2D();
         this._offsetSpeedModifiers = new LGVector2D();
         this._clip = new BitClipCustom();
         this._animationClasses = new Vector.<String>();
         this._angleRanges = new Vector.<Range#1224>();
         this.vectorToTarget = new LGVector2D();
         super();
         this._offsetCounter = Math.random() * 1000;
         this._offsetSpeedModifiers.set(1 + Math.random() * 0.2,1 + Math.random() * 0.2);
         this.initView();
      }
      
      public function update() : void
      {
         this._offsetCounter = this._offsetCounter + this._offsetCounterSpeed;
         this._targetOffset.set(Math.sin(this._offsetCounter * this._offsetSpeedModifiers.x) * this._targetOffsetDistance,Math.sin(this._offsetCounter * this._offsetSpeedModifiers.y) * this._targetOffsetDistance);
         this.vectorToTarget.set(this.target.x + this._targetOffset.x - this.x,this.target.y + this._targetOffset.y - this.y);
         this.velocity.rotateTowardVector(this.vectorToTarget,this.steeringSpeed);
         this.x = this.x + this.velocity.x;
         this.y = this.y + this.velocity.y;
         this.updateView();
      }
      
      protected function initView() : void
      {
         var _loc1_:Number = 1 / this._numberOfAnimationAngles;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._numberOfAnimationAngles)
         {
            this._angleRanges[_loc3_] = new Range#1224(_loc3_ * _loc1_,_loc3_ * _loc1_ + _loc1_);
            this._clip.addAnimation(this._animationClasses[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function findAnimationIndex() : int
      {
         var _loc1_:Number = this.velocity.getAngleDeg();
         var _loc2_:Number = _loc1_ / 360 + 0.5;
         var _loc3_:int = 0;
         while(_loc3_ < this._numberOfAnimationAngles)
         {
            if(this._angleRanges[_loc3_].valueIsInRange(_loc2_))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      protected function updateView() : void
      {
         var _loc1_:int = this.findAnimationIndex();
         if(_loc1_ !== this._currentAnimationIndex)
         {
            this._currentAnimationIndex = _loc1_;
            if(this._animationClasses.length > this._currentAnimationIndex)
            {
               this._clip.selectAnimation(this._animationClasses[this._currentAnimationIndex]);
            }
         }
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.update();
         this._clip.x = this.x;
         this._clip.y = this.y;
         this._clip.render(param1,param2);
      }
   }
}

class Range#1224
{
    
   
   public var low:Number;
   
   public var high:Number;
   
   function Range#1224(param1:Number = 0, param2:Number = 0)
   {
      super();
      this.low = param1;
      this.high = param2;
   }
   
   public function valueIsInRange(param1:Number) : Boolean
   {
      return param1 >= this.low && param1 <= this.high;
   }
}
