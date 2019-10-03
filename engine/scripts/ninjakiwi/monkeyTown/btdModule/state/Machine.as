package ninjakiwi.monkeyTown.btdModule.state
{
   public class Machine
   {
       
      
      public var currentState:State = null;
      
      public function Machine()
      {
         super();
      }
      
      public function message(param1:Message) : void
      {
         var _loc2_:State = null;
         if(this.currentState != null)
         {
            _loc2_ = this.currentState.message(param1);
            if(_loc2_ != null)
            {
               this.changeState(_loc2_,param1);
            }
         }
      }
      
      public function changeState(param1:State, param2:Message) : void
      {
         if(this.currentState != null)
         {
            this.currentState.exit();
         }
         this.currentState = param1;
         if(this.currentState != null)
         {
            this.currentState.machine = this;
            this.currentState.enter(param2);
         }
      }
   }
}
