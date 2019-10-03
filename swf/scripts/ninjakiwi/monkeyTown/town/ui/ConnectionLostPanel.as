package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.ConnectionLostPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ConnectionLostPanel extends HideRevealView
   {
       
      
      private const _clip:ConnectionLostPanelClip = new ConnectionLostPanelClip();
      
      private const _reconnectButton:ButtonControllerBase = new ButtonControllerBase(this._clip.reconnectButton);
      
      public const tryReconnectSignal:Signal = new Signal();
      
      public function ConnectionLostPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._clip.messageField.y = 20;
         isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._reconnectButton.setClickFunction(this.onReconnectButtonClick);
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this.setMessage("There is a problem with your connection to the server. Please check your connection and try again...");
         this._reconnectButton.unlock();
         this._reconnectButton.target.alpha = 1;
         super.reveal(param1);
      }
      
      private function onReconnectButtonClick() : void
      {
         this._reconnectButton.lock();
         this._reconnectButton.target.alpha = 0.5;
         this.setMessage("Attempting to reconnect...");
         this.tryReconnectSignal.dispatch();
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.messageField.text = param1;
         this._clip.messageField.height = this._clip.messageField.textHeight + 20;
         this._clip.background.height = this._clip.messageField.y + this._clip.messageField.height + 35;
         this._clip.reconnectButton.y = this._clip.messageField.y + this._clip.messageField.height + 5;
      }
   }
}
