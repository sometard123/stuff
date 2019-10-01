package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class HideRevealViewPopup extends HideRevealViewCancelable
   {
       
      
      protected const _containerWrapper:Sprite = new Sprite();
      
      private var _originalContainer:DisplayObjectContainer;
      
      public function HideRevealViewPopup(param1:DisplayObjectContainer, param2:* = null)
      {
         super(this._containerWrapper,param2);
         this._originalContainer = param1;
         this.alpha = 1;
         enableDefaultOnResize(this._containerWrapper);
         modalBlockerContainer = this._originalContainer;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(0.2);
         if(this._originalContainer != null && !this._originalContainer.contains(this._containerWrapper))
         {
            this._originalContainer.addChild(this._containerWrapper);
         }
         this.x = this.width * -0.5;
         this.y = this.height * -0.5;
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(0.1);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         if(this._originalContainer != null && this._originalContainer.contains(this._containerWrapper))
         {
            this._originalContainer.removeChild(this._containerWrapper);
         }
      }
      
      override protected function revealAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.killTweensOf(this._containerWrapper);
         this._containerWrapper.scaleX = 0.8;
         this._containerWrapper.scaleY = 0.8;
         TweenLite.to(this._containerWrapper,param1 * 0.5,{
            "scaleX":1.1,
            "scaleY":1.1,
            "ease":Quad.easeIn
         });
         TweenLite.to(this._containerWrapper,param1 * 0.5,{
            "delay":param1 * 0.5,
            "scaleX":1,
            "scaleY":1,
            "onComplete":param2
         });
      }
      
      override protected function hideAnimation(param1:Number, param2:Function) : void
      {
         TweenLite.to(this._containerWrapper,param1,{
            "scaleX":0.6,
            "scaleY":0.6,
            "ease":Quad.easeIn,
            "onComplete":param2
         });
      }
      
      override public function centerOnStage() : void
      {
         this._containerWrapper.x = _system.flashStage.stageWidth * 0.5;
         this._containerWrapper.y = _system.flashStage.stageHeight * 0.5;
      }
   }
}
