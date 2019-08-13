package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.Spam250Clip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.Sprite;
   
   public class Spam250 extends Sprite
   {
       
      
      private var _clip:Spam250Clip;
      
      private const TWEEN_FRAMES:Number = 30;
      
      private const LOFT:Number = 70;
      
      private const FADE_FRAMES:Number = 10;
      
      public function Spam250()
      {
         this._clip = new Spam250Clip();
         super();
         this.addChild(this._clip);
         this.rotation = this.rotation + (Math.random() - 0.5) * 50;
      }
      
      public function go() : void
      {
         this._clip.alpha = 0;
         this._clip.rotation = this._clip.rotation + (Math.random() - 0.5) * 60;
         TweenLite.to(this._clip,this.FADE_FRAMES,{
            "alpha":1,
            "ease":Cubic.easeOut,
            "useFrames":true
         });
         TweenLite.to(this._clip,this.FADE_FRAMES,{
            "alpha":0,
            "delay":this.TWEEN_FRAMES - this.FADE_FRAMES,
            "ease":Cubic.easeIn,
            "useFrames":true
         });
         var _loc1_:Number = 1 + Math.random() * 0.4;
         this._clip.scaleX = this._clip.scaleY = 0.8 - Math.random() * 0.2;
         TweenLite.to(this._clip,this.TWEEN_FRAMES,{
            "y":-this.LOFT,
            "scaleX":_loc1_,
            "scaleY":_loc1_,
            "rotation":(Math.random() - 0.5) * 10,
            "ease":Cubic.easeOut,
            "onComplete":this.release,
            "useFrames":true
         });
      }
      
      private function release() : void
      {
         if(this.parent !== null && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
         this.removeChild(this._clip);
         this._clip = null;
      }
   }
}
