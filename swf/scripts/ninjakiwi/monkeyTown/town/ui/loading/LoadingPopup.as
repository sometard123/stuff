package ninjakiwi.monkeyTown.town.ui.loading
{
   import assets.ui.LoadingClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class LoadingPopup extends HideRevealView
   {
       
      
      private const _clip:LoadingClip = new LoadingClip();
      
      public function LoadingPopup(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         this.addChild(this._clip);
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.cogs]);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(0);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(0);
      }
   }
}
