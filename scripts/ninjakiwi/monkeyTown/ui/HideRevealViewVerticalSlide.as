package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Circ;
   import com.greensock.easing.Quad;
   import flash.display.DisplayObjectContainer;
   
   public class HideRevealViewVerticalSlide extends HideRevealViewCancelable
   {
       
      
      private var _inStep1Y:int;
      
      private var _inStep2Y:int;
      
      private var _inStep3Y:int;
      
      private var _outY:int;
      
      public function HideRevealViewVerticalSlide(param1:DisplayObjectContainer, param2:int, param3:int, param4:* = null)
      {
         super(param1,param4);
         this._outY = param3;
         this.updateInY(param2);
         this.alpha = 1;
      }
      
      protected function updateInY(param1:int) : void
      {
         this._inStep3Y = param1;
         if(this._inStep3Y < this._outY)
         {
            this._inStep1Y = this._inStep3Y - (this._outY - this._inStep3Y) * 0.02;
            this._inStep2Y = this._inStep3Y + (this._inStep3Y - this._inStep1Y) * 0.7;
         }
         else
         {
            this._inStep1Y = this._inStep3Y + (this._inStep3Y - this._outY) * 0.02;
            this._inStep2Y = this._inStep3Y - (this._inStep1Y - this._inStep3Y) * 0.7;
         }
      }
      
      override protected function revealAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.killTweensOf(this);
         this.y = this._outY;
         TweenLite.to(this,param1,{
            "y":this._inStep3Y,
            "ease":Circ.easeOut
         });
         TweenLite.delayedCall(param1,param2);
      }
      
      private function revealAnimationStep2(param1:Number) : void
      {
         TweenLite.to(this,param1,{
            "y":this._inStep2Y,
            "ease":Quad.easeInOut
         });
      }
      
      private function revealAnimationStep3(param1:Number) : void
      {
         TweenLite.to(this,param1,{
            "y":this._inStep3Y,
            "ease":Quad.easeOut
         });
      }
      
      override protected function hideAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.to(this,param1,{
            "y":this._outY,
            "ease":Circ.easeIn
         });
         TweenLite.delayedCall(param1,param2);
      }
   }
}
