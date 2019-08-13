package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assest.ui.AssaultRadioGroupClip;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class AssaultRadioGroup
   {
       
      
      private var _clip:AssaultRadioGroupClip;
      
      public var normalTickbox:TickBox;
      
      public var regenTickbox:TickBox;
      
      public var camoTickbox:TickBox;
      
      public const changedSignal:Signal = new Signal();
      
      public function AssaultRadioGroup(param1:AssaultRadioGroupClip)
      {
         super();
         this._clip = param1;
         this.normalTickbox = new TickBox(param1.tick1);
         this.regenTickbox = new TickBox(param1.tick2);
         this.camoTickbox = new TickBox(param1.tick3);
         this.normalTickbox.changedSignal.add(this.onNormalTickboxChanged);
         this.regenTickbox.changedSignal.add(this.onRegenTickboxChanged);
         this.camoTickbox.changedSignal.add(this.onCamoTickboxChanged);
         this.reset();
      }
      
      public function setIsAvailable(param1:Boolean) : void
      {
         this.normalTickbox.enabled = param1;
         this.regenTickbox.enabled = param1;
         this.camoTickbox.enabled = param1;
      }
      
      private function onNormalTickboxChanged(param1:Boolean) : void
      {
         if(param1)
         {
            this.regenTickbox.setTickedWithoutDispatching(false);
            this.camoTickbox.setTickedWithoutDispatching(false);
            this.changedSignal.dispatch();
         }
         else if(this.regenTickbox.ticked == false && this.camoTickbox.ticked == false)
         {
            this.normalTickbox.setTickedWithoutDispatching(true);
         }
      }
      
      private function onRegenTickboxChanged(param1:Boolean) : void
      {
         if(param1)
         {
            this.normalTickbox.setTickedWithoutDispatching(false);
         }
         else if(this.camoTickbox.ticked == false)
         {
            this.normalTickbox.setTickedWithoutDispatching(true);
         }
         this.changedSignal.dispatch();
      }
      
      private function onCamoTickboxChanged(param1:Boolean) : void
      {
         if(param1)
         {
            this.normalTickbox.setTickedWithoutDispatching(false);
         }
         else if(this.regenTickbox.ticked == false)
         {
            this.normalTickbox.setTickedWithoutDispatching(true);
         }
         this.changedSignal.dispatch();
      }
      
      public function reset() : void
      {
         this.normalTickbox.ticked = true;
         this.changedSignal.dispatch();
      }
   }
}
