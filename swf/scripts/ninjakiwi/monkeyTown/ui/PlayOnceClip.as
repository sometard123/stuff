package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   
   public class PlayOnceClip extends MovieClip
   {
       
      
      private var _clip:MovieClip = null;
      
      private var _totalFrames:int = 0;
      
      public function PlayOnceClip(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this._totalFrames = this._clip.totalFrames;
         param1.gotoAndPlay(1);
         this.addChild(param1);
         TweenLite.delayedCall(this._totalFrames,this.release,null,true);
      }
      
      private function release() : void
      {
         removeChild(this._clip);
         this._clip = null;
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
