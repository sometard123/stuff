package ninjakiwi.monkeyTown.ui.cursor
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.ui.Mouse;
   
   public class CustomCursor extends MovieClip
   {
       
      
      public var hideSystemCursor:Boolean = true;
      
      private var _clip:MovieClip;
      
      private var _container:DisplayObjectContainer;
      
      public function CustomCursor(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function addGraphicByClassDefinition(param1:Class) : void
      {
         var classDefinition:Class = param1;
         try
         {
            this._clip = new classDefinition();
         }
         catch(err:Error)
         {
            return;
         }
         this._clip.mouseEnabled = false;
         this._clip.mouseChildren = false;
         addChild(this._clip);
      }
      
      public function setHideSystemCursorOnReveal(param1:Boolean) : CustomCursor
      {
         this.hideSystemCursor = param1;
         return this;
      }
      
      public function reveal() : void
      {
         if(this.hideSystemCursor)
         {
            Mouse.hide();
         }
         this.centerOnMouse();
         this._container.addChild(this);
      }
      
      public function centerOnMouse() : void
      {
         x = int(this._container.mouseX);
         y = int(this._container.mouseY);
      }
      
      public function hide() : void
      {
         if(this.hideSystemCursor)
         {
            Mouse.show();
         }
         this._container.removeChild(this);
      }
   }
}
