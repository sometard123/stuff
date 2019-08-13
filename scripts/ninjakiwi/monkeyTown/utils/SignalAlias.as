package ninjakiwi.monkeyTown.utils
{
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class SignalAlias extends PrioritySignal
   {
       
      
      private var _target:Signal = null;
      
      public function SignalAlias(... rest)
      {
         super(rest);
      }
      
      public function setTargetSignal(param1:Signal) : void
      {
         this.clear();
         this._target = param1;
         this._valueClasses = this._target.valueClasses.slice(0);
         this._target.add(this.aliasDispatch);
      }
      
      public function clear() : void
      {
         if(this._target !== null)
         {
            this._target = null;
         }
      }
      
      private function aliasDispatch(... rest) : void
      {
         if(this._target !== null)
         {
            this.dispatch.apply(this,rest);
         }
      }
   }
}
