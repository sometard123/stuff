package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.GenericInfoPanelClip;
   import com.lgrey.signal.SignalHub;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class GenericInfoPanel extends HideRevealView
   {
       
      
      protected var _clip:GenericInfoPanelClip;
      
      protected var _closeButton:ButtonControllerBase;
      
      private var _hubUI:SignalHub;
      
      private var _alertSignal:Signal;
      
      public function GenericInfoPanel(param1:DisplayObjectContainer)
      {
         this._clip = new GenericInfoPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._hubUI = SignalHub.getHub("ui");
         this._alertSignal = this._hubUI.defineSignal("alert",String);
         super(param1);
         isModal = true;
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._closeButton.setClickFunction(hide);
         enableDefaultOnResize(this._clip);
         this._alertSignal.add(this.onAlert);
      }
      
      private function onAlert(param1:String) : void
      {
         this.setMessage(param1);
         reveal();
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.informationField.htmlText = param1;
         this._clip.informationField.height = this._clip.informationField.textHeight + 50;
         this._clip.background.height = this._clip.informationField.textHeight + this._clip.informationField.y * 2;
         centerOnStage();
      }
   }
}
