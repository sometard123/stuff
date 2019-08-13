package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import flash.display.MovieClip;
   import flash.net.SharedObject;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class CrateTickBox
   {
       
      
      private var _clip:MovieClip;
      
      private var _tick:MovieClip;
      
      private var _ticked:Boolean = false;
      
      private var _enabled:Boolean = true;
      
      public var index:int = 0;
      
      private var buttonController:ButtonControllerBase;
      
      public const stateChangedSignal:Signal = new Signal(Boolean,int);
      
      public function CrateTickBox(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this.init();
      }
      
      private function init() : void
      {
         this._clip.gotoAndStop(0);
         this._tick = this._clip.tick;
         this.buttonController = new ButtonControllerBase(this._clip);
         this.buttonController.setClickFunction(this.onClick);
         this.ticked = false;
      }
      
      private function onClick() : void
      {
         if(!this._enabled)
         {
            return;
         }
         this.toggleTicked();
         this.stateChangedSignal.dispatch(this._ticked,this.index);
      }
      
      private function toggleTicked() : void
      {
         this.ticked = !this.ticked;
      }
      
      public function setTickVisible(param1:Boolean) : void
      {
         this._tick.visible = param1;
      }
      
      public function setEnabled(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.buttonController.unlock(1);
         }
         else
         {
            this.buttonController.lock(3);
            this.ticked = false;
         }
      }
      
      private function syncTickBoxGraphic() : void
      {
         this.setTickVisible(this._ticked);
      }
      
      public function set ticked(param1:Boolean) : void
      {
         this._ticked = param1;
         this.syncTickBoxGraphic();
      }
      
      public function get ticked() : Boolean
      {
         return this._ticked;
      }
   }
}
