package ninjakiwi.monkeyTown.ui
{
   import assets.ui.NotificationClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class Notification extends HideRevealViewCancelable
   {
      
      private static var _clip:MovieClip = new NotificationClip();
      
      private static var _instance:Notification;
      
      private static var _revealTimeout:uint = 0;
      
      private static var _isOpen:Boolean = false;
      
      public static var notificationDuration:int = 5000;
       
      
      public var padding:int = 5;
      
      public function Notification(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         _instance = this;
         TextField(_clip.noteField).autoSize = TextFieldAutoSize.LEFT;
         this.addChild(_clip);
      }
      
      public static function showNotification(param1:String) : void
      {
         if(_isOpen)
         {
            clearTimeout(_revealTimeout);
         }
         _clip.noteField.htmlText = param1;
         _clip.background.height = _clip.noteField.textHeight + _clip.noteField.y * 2;
         _revealTimeout = setTimeout(_instance.hide,notificationDuration);
         PanelManager.getInstance().showPanelOverlay(_instance);
      }
      
      override public function resize() : void
      {
         this.positionAtTopRight();
      }
      
      private function positionAtTopRight() : void
      {
         x = _system.flashStage.stageWidth - _clip.width - this.padding;
         y = 70;
      }
   }
}
