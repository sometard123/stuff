package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.RankUpSpamClip;
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   
   public class RankUpSpam extends Sprite
   {
       
      
      private var _clip:RankUpSpamClip;
      
      private const ANIMATION_LENGTH:Number = this._clip.totalFrames;
      
      public function RankUpSpam()
      {
         this._clip = new RankUpSpamClip();
         super();
         this.addChild(this._clip);
      }
      
      public function go() : void
      {
         TweenLite.delayedCall(this.ANIMATION_LENGTH,this.release,null,true);
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
