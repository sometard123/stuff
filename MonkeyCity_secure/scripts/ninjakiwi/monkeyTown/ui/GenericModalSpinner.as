package ninjakiwi.monkeyTown.ui
{
   import assets.ui.GenericSpinnerClip;
   import flash.display.DisplayObjectContainer;
   
   public class GenericModalSpinner extends HideRevealView
   {
       
      
      private const _clip:GenericSpinnerClip = new GenericSpinnerClip();
      
      public function GenericModalSpinner(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.cogs]);
         this._clip.stop();
      }
   }
}
