package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import flash.display.DisplayObjectContainer;
   
   public class HideRevealViewHorizontalSlide extends HideRevealViewCancelable
   {
       
      
      private var _inX:int;
      
      private var _outX:int;
      
      public function HideRevealViewHorizontalSlide(param1:DisplayObjectContainer, param2:int, param3:int, param4:* = null)
      {
         super(param1,param4);
         this._inX = param2;
         this._outX = param3;
         this.alpha = 1;
      }
      
      override protected function revealAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.killTweensOf(this);
         TweenLite.to(this,param1,{
            "x":this._inX,
            "ease":Quad.easeOut
         });
         TweenLite.delayedCall(param1,param2);
      }
      
      override protected function hideAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.to(this,param1,{
            "x":this._outX,
            "ease":Quad.easeIn
         });
         TweenLite.delayedCall(param1,param2);
      }
   }
}
