package ninjakiwi.mynk.net
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.utils.ByteArray;
   import ninjakiwi.dancingShadows.ShadowNum;
   import ninjakiwi.mynk.sharedDefinitions.Msg;
   import ninjakiwi.state.State;
   
   public class LoginSystem
   {
       
      
      protected var _state:LoginState;
      
      protected var _remoteAPI:RemoteAPI;
      
      protected var _displayObject:DisplayObjectContainer;
      
      public function LoginSystem(param1:RemoteAPIParams, param2:String = null)
      {
         super();
         this._displayObject = param1.container;
         this._remoteAPI = new RemoteAPI(param1);
         this._state = new LoginState(param2);
         this._state.enter();
         this._state.CONNECTING.addEventListener(State.ENTER,this.beginConnecting);
         this.addAPIListeners();
      }
      
      protected function addAPIListeners() : void
      {
         this._remoteAPI.addEventListener(IOErrorEvent.IO_ERROR,this.connectErrorMsgHandler);
      }
      
      public function load() : void
      {
         this._state.receive(Msg.CONNECT);
      }
      
      private function beginConnecting(param1:Event) : void
      {
         this._remoteAPI.load();
      }
      
      private function connectErrorMsgHandler(param1:Event) : void
      {
         this._state.receive(Msg.CONNECT_ERROR);
      }
      
      public function get remote() : RemoteAPI
      {
         return this._remoteAPI;
      }
      
      public function get state() : LoginState
      {
         return this._state;
      }
      
      public function get displayObject() : DisplayObjectContainer
      {
         return this._displayObject;
      }
      
      public function isConnected() : Boolean
      {
         return this._state.isCurrently(this._state.CONNECTED);
      }
   }
}
