package ninjakiwi.monkeyTown.town
{
   import assets.ui.NotEnoughCashPanelClip;
   import com.lgrey.signal.SignalHub;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class NotEnoughCashPanel extends HideRevealView
   {
       
      
      private var _clip:NotEnoughCashPanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _getCashButton:ButtonControllerBase;
      
      private const requestBloonstonesToCashExchangeSignal:Signal = SignalHub.getHub("ui").getSignal("requestBloonstonesToCashExchange");
      
      public function NotEnoughCashPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new NotEnoughCashPanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._getCashButton = new ButtonControllerBase(this._clip.buyCoinsButton);
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.messageField.text = param1;
      }
      
      private function init() : void
      {
         isModal = true;
         this._cancelButton.setClickFunction(hide);
         this._getCashButton.setClickFunction(this.getCash);
      }
      
      private function getCash() : void
      {
         this.requestBloonstonesToCashExchangeSignal.dispatch();
         hide();
      }
   }
}
