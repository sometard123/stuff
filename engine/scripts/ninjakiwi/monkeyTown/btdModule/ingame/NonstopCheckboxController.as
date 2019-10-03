package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.gui.NonstopCheckboxClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class NonstopCheckboxController extends EventDispatcher
   {
      
      public static const CONTINUOUS_ON:String = "FastForwardContinuousOn";
      
      public static const CONTINUOUS_OFF:String = "FastForwardContinuousOff";
       
      
      private var _clip:NonstopCheckboxClip;
      
      private var _checked:Boolean;
      
      private var _isMouseOver:Boolean;
      
      public function NonstopCheckboxController(param1:NonstopCheckboxClip)
      {
         super();
         this._clip = param1;
         this._clip.mouseChildren = false;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         param1.addEventListener(MouseEvent.CLICK,this.onClicked);
         this.reset();
      }
      
      public function reset() : void
      {
         this._isMouseOver = false;
         this.checked = false;
         this.lock(false);
      }
      
      public function lock(param1:Boolean) : void
      {
         if(param1)
         {
            this.checked = false;
            this._clip.mouseEnabled = false;
            this._clip.gotoAndStop("Locked");
         }
         else
         {
            this.checked = false;
            this._clip.mouseEnabled = true;
            this._clip.gotoAndStop("Out");
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         this._isMouseOver = true;
         if(this._checked)
         {
            this._clip.gotoAndStop("OverChecked");
         }
         else
         {
            this._clip.gotoAndStop("Over");
         }
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this._isMouseOver = false;
         if(this._checked)
         {
            this._clip.gotoAndStop("OutChecked");
         }
         else
         {
            this._clip.gotoAndStop("Out");
         }
      }
      
      private function onClicked(param1:Event) : void
      {
         this.checked = !!this.checked?false:true;
      }
      
      public function get checked() : Boolean
      {
         return this._checked;
      }
      
      public function set checked(param1:Boolean) : void
      {
         if(param1 == this._checked)
         {
            return;
         }
         this._checked = param1;
         if(this._checked)
         {
            if(this._isMouseOver)
            {
               this._clip.gotoAndStop("OverChecked");
            }
            else
            {
               this._clip.gotoAndStop("OutChecked");
            }
            this.dispatchEvent(new Event(CONTINUOUS_ON));
         }
         else
         {
            if(this._isMouseOver)
            {
               this._clip.gotoAndStop("Over");
            }
            else
            {
               this._clip.gotoAndStop("Out");
            }
            this.dispatchEvent(new Event(CONTINUOUS_OFF));
         }
      }
   }
}
