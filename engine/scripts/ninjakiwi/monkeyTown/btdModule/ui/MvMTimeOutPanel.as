package ninjakiwi.monkeyTown.btdModule.ui
{
   import assets.btdmodule.PvPTimeOutPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.ingame.ModalBlocker;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class MvMTimeOutPanel extends HideRevealViewSimple
   {
       
      
      private const _clip:PvPTimeOutPanelClip = new PvPTimeOutPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public const okSignal:Signal = new Signal();
      
      public function MvMTimeOutPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this._okButton.setClickFunction(this.onOkay);
         this.addChild(this._clip);
      }
      
      private function onOkay() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      override public function resize() : void
      {
         super.resize();
         this._clip.x = Main.mapArea.width * 0.5;
         this._clip.y = Main.mapArea.height * 0.5;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().reveal("MvMTimeOut",_container);
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         ModalBlocker.getInstance().hide("MvMTimeOut");
      }
   }
}
