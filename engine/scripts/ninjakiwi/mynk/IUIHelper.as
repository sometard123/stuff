package ninjakiwi.mynk
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public interface IUIHelper extends IEventDispatcher
   {
       
      
      function get SHOW_MAIN_MENU() : String;
      
      function get SHOW_LOGIN_OPTIONS() : String;
      
      function waitForGame() : void;
      
      function gameIsReady() : void;
      
      function playAsGuest(param1:Event = null) : void;
      
      function openLoginPage(param1:Event = null) : void;
   }
}
