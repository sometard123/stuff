package ninjakiwi.monkeyTown.btdModule.tutorial
{
   import assets.btdmodule.MonkeyBoostHotSpikesPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.ingame.ModalBlocker;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class AllTacticsTutorial extends HideRevealViewSimple
   {
       
      
      private const _panel:MonkeyBoostHotSpikesPanelClip = new MonkeyBoostHotSpikesPanelClip();
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._panel.okButton);
      
      public function AllTacticsTutorial(param1:DisplayObjectContainer)
      {
         super(param1);
         this.addChild(this._panel);
         this._ok.setClickFunction(this.hide);
      }
      
      override public function reveal(param1:Number = 1.5) : void
      {
         ModalBlocker.getInstance().reveal("AllTacticsTutorial",_container);
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().hide("AllTacticsTutorial");
         super.hide(param1);
      }
   }
}
