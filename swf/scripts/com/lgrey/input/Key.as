package com.lgrey.input
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class Key
   {
      
      private static var initialized:Boolean = false;
      
      private static var keysDown:Object = new Object();
       
      
      public function Key()
      {
         super();
      }
      
      public static function initialize(param1:Stage) : void
      {
         if(!initialized)
         {
            param1.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
            param1.addEventListener(KeyboardEvent.KEY_UP,keyReleased);
            param1.addEventListener(Event.DEACTIVATE,clearKeys);
            initialized = true;
         }
      }
      
      public static function isDown(param1:uint) : Boolean
      {
         if(!initialized)
         {
            throw new Error("Key class has yet been initialized.");
         }
         return Boolean(param1 in keysDown);
      }
      
      private static function keyPressed(param1:KeyboardEvent) : void
      {
         keysDown[param1.keyCode] = true;
      }
      
      private static function keyReleased(param1:KeyboardEvent) : void
      {
         if(param1.keyCode in keysDown)
         {
            delete keysDown[param1.keyCode];
         }
      }
      
      private static function clearKeys(param1:Event) : void
      {
         keysDown = new Object();
      }
   }
}
