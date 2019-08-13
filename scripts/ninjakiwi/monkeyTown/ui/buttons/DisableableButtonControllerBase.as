package ninjakiwi.monkeyTown.ui.buttons
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public class DisableableButtonControllerBase extends ButtonControllerBase
   {
       
      
      private var _lockedColorTransform:ColorTransform;
      
      private const _unlockedColorTransform:ColorTransform = new ColorTransform();
      
      public function DisableableButtonControllerBase(param1:MovieClip)
      {
         this._lockedColorTransform = new ColorTransform(0.7,0.7,0.7);
         super(param1);
         setLockedOverFunction(this.onOver);
         setOutFunction(this.onOut);
         setLockedOutFunction(this.onOut);
      }
      
      private function onOut() : void
      {
      }
      
      private function onOver() : void
      {
      }
      
      override public function lock(param1:int = 1) : ButtonControllerBase
      {
         target.transform.colorTransform = this._lockedColorTransform;
         return super.lock(param1);
      }
      
      override public function unlock(param1:int = 0) : ButtonControllerBase
      {
         target.transform.colorTransform = this._unlockedColorTransform;
         target.alpha = 1;
         return super.unlock(param1);
      }
      
      public function changeLockedColorTransform(param1:ColorTransform) : void
      {
         this._lockedColorTransform = param1;
      }
   }
}
