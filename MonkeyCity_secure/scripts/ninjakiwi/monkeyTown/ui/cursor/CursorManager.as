package ninjakiwi.monkeyTown.ui.cursor
{
   import flash.display.DisplayObjectContainer;
   import flash.ui.Mouse;
   
   public class CursorManager
   {
       
      
      public var _container:DisplayObjectContainer;
      
      private var _cursors:Array;
      
      private var _currentCursor:CustomCursor;
      
      public function CursorManager(param1:DisplayObjectContainer)
      {
         this._cursors = [];
         super();
         this._container = param1;
         this.initListeners();
      }
      
      private function initListeners() : void
      {
      }
      
      public function update() : void
      {
         if(this._currentCursor)
         {
            this._currentCursor.centerOnMouse();
         }
      }
      
      public function revealCursor(param1:String) : void
      {
         if(!this._cursors[param1])
         {
            return;
         }
         if(this._currentCursor != null)
         {
            this._currentCursor.hide();
         }
         this._currentCursor = this._cursors[param1];
         CustomCursor(this._cursors[param1]).reveal();
      }
      
      public function hideCurrentCursor() : void
      {
         if(this._currentCursor != null)
         {
            this._currentCursor.hide();
         }
         this._currentCursor = null;
         Mouse.show();
      }
      
      public function registerCursor(param1:CustomCursor, param2:String) : void
      {
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         if(this._cursors[param2] != null)
         {
         }
         this._cursors[param2] = param1;
      }
      
      public function makeAndRegisterCursor(param1:Class, param2:String) : CustomCursor
      {
         var _loc3_:CustomCursor = new CustomCursor(this._container);
         _loc3_.addGraphicByClassDefinition(param1);
         this.registerCursor(_loc3_,param2);
         return _loc3_;
      }
   }
}
