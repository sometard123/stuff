package ninjakiwi.monkeyTown.town.flare.dustDevil
{
   import com.greensock.TweenLite;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.town.flare.FlareManager;
   
   public class DustDevil
   {
       
      
      private var _clip:BitClipCustom;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var age:int = 0;
      
      public var lifeSpan:int = 0;
      
      public var waitingTime:int = 0;
      
      public var timeToWait:int = 0;
      
      private var active:Boolean = false;
      
      private var _alpha:Number = 0;
      
      private var _offsetCounter:Number = 0;
      
      private var _offsetDistance:Number = 60;
      
      private var _offsetCounterSpeed:Number = 0.01;
      
      private var _offset:LGVector2D;
      
      private var _offsetSpeedModifiers:LGVector2D;
      
      private var FADE_TIME:Number = 2.0;
      
      public function DustDevil()
      {
         this._clip = new BitClipCustom();
         this._offset = new LGVector2D();
         this._offsetSpeedModifiers = new LGVector2D();
         super();
         this._clip.addAnimation("assets.flare.DustDevilAnimationClip");
         this.respawn();
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         if(!this.active)
         {
            this.waitingTime++;
            if(this.waitingTime == this.timeToWait)
            {
               this.respawn();
            }
            else
            {
               return;
            }
         }
         this._offsetCounter = this._offsetCounter + this._offsetCounterSpeed;
         this._offset.set(Math.sin(this._offsetCounter * this._offsetSpeedModifiers.x) * this._offsetDistance,Math.sin(this._offsetCounter * this._offsetSpeedModifiers.y) * this._offsetDistance);
         this.age++;
         if(this.age === this.lifeSpan)
         {
            this.fadeOut();
         }
         this._clip.x = this.x + this._offset.x;
         this._clip.y = this.y + this._offset.y;
         this._clip.render(param1,param2);
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         this._clip.colorTransform = new ColorTransform(1,1,1,this._alpha);
      }
      
      private function respawn() : void
      {
         this.age = 0;
         this.lifeSpan = 300 + Math.random() * 300;
         this._offsetSpeedModifiers.set(1 + Math.random() * 0.2,1 + Math.random() * 0.2);
         this.x = FlareManager.mousePositionInWorld.x + 200 * ((Math.random() - 0.5) * 2);
         this.y = FlareManager.mousePositionInWorld.y + 200 * ((Math.random() - 0.5) * 2);
         TweenLite.to(this,this.FADE_TIME,{"alpha":1});
         this.active = true;
      }
      
      private function fadeOut() : void
      {
         TweenLite.to(this,this.FADE_TIME,{
            "alpha":0,
            "onComplete":function():void
            {
               active = false;
               waitingTime = 0;
               timeToWait = lifeSpan = 300 + Math.random() * 1000;
            }
         });
      }
   }
}
