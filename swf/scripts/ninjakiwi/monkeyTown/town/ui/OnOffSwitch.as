package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.OnOffSwitchClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class OnOffSwitch extends ButtonControllerBase
   {
       
      
      private var _clip:OnOffSwitchClip;
      
      private var _selected:Boolean = false;
      
      private var _cost:int = 0;
      
      private var _enable:Boolean = true;
      
      public const changed:Signal = new Signal();
      
      public function OnOffSwitch(param1:OnOffSwitchClip, param2:int)
      {
         super(param1);
         this._clip = param1;
         this._cost = param2;
         this._lockedMouseOverFunction = this.selectedRollOver;
         this._lockedMouseOutFunction = this.selectedRollOut;
         this.setOverFunction(this.selectedRollOver);
         this.setOutFunction(this.selectedRollOut);
         _target.addEventListener(MouseEvent.MOUSE_DOWN,this.click,false,0,true);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(_target != null)
         {
            if(_target.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               _target.removeEventListener(MouseEvent.MOUSE_DOWN,this.click,false);
            }
         }
      }
      
      public function reset() : void
      {
         this.select(false);
         this.setEnable(true);
      }
      
      public function getCostCharged() : int
      {
         if(this._selected == false || this._enable == false)
         {
            return 0;
         }
         return this._cost;
      }
      
      public function get description() : int
      {
         if(this._selected)
         {
            return Constants.LOTS;
         }
         return Constants.NORMAL;
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(param1 == false)
         {
            this.lock(5);
         }
         else if(this._selected)
         {
            this.lock(3);
         }
         else
         {
            this.unlock(1);
         }
         this._enable = param1;
      }
      
      private function click(param1:MouseEvent = null) : void
      {
         if(!this._enable)
         {
            return;
         }
         this._selected = !this._selected;
         this.select(this._selected);
      }
      
      public function select(param1:Boolean) : void
      {
         this._selected = param1;
         if(param1 == true)
         {
            this.lock(3);
         }
         else
         {
            this.unlock(1);
         }
         this.changed.dispatch();
      }
      
      private function selectedRollOver(param1:MouseEvent = null) : void
      {
         if(!this._enable)
         {
            return;
         }
         if(this._selected)
         {
            this.lock(4);
         }
         else
         {
            this.lock(2);
         }
      }
      
      private function selectedRollOut(param1:MouseEvent = null) : void
      {
         if(!this._enable)
         {
            return;
         }
         if(this._selected)
         {
            this.lock(3);
         }
         else
         {
            this.unlock(1);
         }
      }
   }
}
