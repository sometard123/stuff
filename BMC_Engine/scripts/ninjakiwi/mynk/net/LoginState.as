package ninjakiwi.mynk.net
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import ninjakiwi.mynk.sharedDefinitions.Msg;
   import ninjakiwi.state.State;
   import ninjakiwi.state.TimerState;
   
   public class LoginState extends State
   {
       
      
      public const NOT_CONNECTED:State = new State("not connected");
      
      public const CONNECTED:State = new State("connected");
      
      public const IDLE:State = new State("idle");
      
      public const CONNECTING:State = new TimerState("connecting",40);
      
      public const FAILED:State = new State("failed");
      
      public const LIMBO:State = new State("limbo");
      
      public const LOGGED_IN:State = new State("logged in");
      
      public const LOGGED_OUT:State = new State("logged out");
      
      public function LoginState(param1:String = null)
      {
         super(param1);
         this.build();
         this.setBaseStates();
         this.setTransitions();
         this.setTimeouts();
      }
      
      private function setBaseStates() : void
      {
         setBaseState(this);
         setBaseState(this.NOT_CONNECTED);
         setBaseState(this.CONNECTED);
         setBaseState(this.IDLE);
         setBaseState(this.CONNECTING);
         setBaseState(this.FAILED);
         setBaseState(this.LIMBO);
         setBaseState(this.LOGGED_IN);
         setBaseState(this.LOGGED_OUT);
      }
      
      private function build() : void
      {
         this.setup(this.NOT_CONNECTED,[this.NOT_CONNECTED,this.CONNECTED]);
         this.NOT_CONNECTED.setup(this.IDLE,[this.IDLE,this.CONNECTING,this.FAILED]);
         this.CONNECTED.setup(this.LIMBO,[this.LIMBO,this.LOGGED_IN,this.LOGGED_OUT]);
      }
      
      private function setTransitions() : void
      {
         this.NOT_CONNECTED.setTransition(Msg.CONNECTED,this.CONNECTED);
         this.IDLE.setTransition(Msg.CONNECT,this.CONNECTING);
         this.FAILED.setTransition(Msg.CONNECT,this.CONNECTING);
         this.CONNECTING.setTransition(Msg.CONNECT_ERROR,this.FAILED);
         this.CONNECTING.setTransition(Msg.TIME_UP,this.FAILED);
         this.CONNECTED.setTransition(Msg.LOGGED_IN,this.LOGGED_IN);
         this.CONNECTED.setTransition(Msg.LOGGED_OUT,this.LOGGED_OUT);
      }
      
      private function setTimeouts() : void
      {
         this.CONNECTING.addEventListener(TimerEvent.TIMER_COMPLETE,this.timeUp);
      }
      
      private function timeUp(param1:Event) : void
      {
         receive(Msg.TIME_UP);
      }
   }
}
