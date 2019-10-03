package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.VictoryGenericPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class VictoryGenericPanel extends HideRevealViewSimple
   {
       
      
      protected var _clip:VictoryGenericPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public var okSignal:Signal;
      
      public function VictoryGenericPanel(param1:DisplayObjectContainer)
      {
         this._clip = new VictoryGenericPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this.okSignal = new Signal();
         super(param1);
         addChild(this._clip);
         this._okButton.setClickFunction(this.onOkButton);
      }
      
      private function onOkButton() : void
      {
         hide();
         this.okSignal.dispatch();
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         super.reveal(0.1);
         this._clip.gotoAndPlay(1);
      }
   }
}
