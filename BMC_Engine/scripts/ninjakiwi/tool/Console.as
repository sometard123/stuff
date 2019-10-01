package ninjakiwi.tool
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class Console extends Sprite
   {
       
      
      private var _consoleField:TextField;
      
      public function Console()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.size = 15;
         _loc1_.align = TextFormatAlign.LEFT;
         _loc1_.font = "Verdana";
         this._consoleField = new TextField();
         this._consoleField.autoSize = TextFieldAutoSize.LEFT;
         this._consoleField.multiline = true;
         this._consoleField.width = 800;
         this._consoleField.height = 400;
         this._consoleField.defaultTextFormat = _loc1_;
         addChild(this._consoleField);
      }
      
      public function log(param1:String) : void
      {
         this._consoleField.htmlText = this._consoleField.htmlText + (param1 + "\n");
      }
      
      public function clear() : void
      {
         this._consoleField.htmlText = "";
      }
   }
}
