package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.GameOverContestedTerritoryPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ContestOutOfLivesPanel extends HideRevealViewSimple
   {
       
      
      private const _clip:GameOverContestedTerritoryPanelClip = new GameOverContestedTerritoryPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public const okSignal:Signal = new Signal();
      
      public function ContestOutOfLivesPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this.addChild(this._clip);
         this._okButton.setClickFunction(this.onClickOk);
      }
      
      override public function resize() : void
      {
         super.resize();
         this._clip.x = Main.mapArea.width * 0.5;
         this._clip.y = Main.mapArea.height * 0.5;
      }
      
      private function onClickOk() : void
      {
         this.okSignal.dispatch();
         this.hide();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         if(isRevealed)
         {
            return;
         }
         ModalBlocker.getInstance().reveal("Retry",_container);
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         ModalBlocker.getInstance().hide("Retry");
      }
   }
}
