package ninjakiwi.mynk
{
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import ninjakiwi.mynk.net.LoginState;
   
   public interface IGateway extends IEventDispatcher
   {
       
      
      function activate() : void;
      
      function isConnected() : Boolean;
      
      function get displayObject() : DisplayObjectContainer;
      
      function get state() : LoginState;
      
      function get user() : IGatewayUser;
      
      function get store() : IStore;
      
      function get uiHelper() : IUIHelper;
      
      function callServer(param1:String, param2:Function, ... rest) : void;
      
      function getServerTime() : void;
      
      function getAPIVersion() : String;
   }
}
