package ninjakiwi.monkeyTown.town.ui.terrain
{
   import assets.ui.CapturedTerrainInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class CapturedTerrainInfoPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:CapturedTerrainInfoPanelClip = new CapturedTerrainInfoPanelClip();
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _buildButton:ButtonControllerBase = new ButtonControllerBase(this._clip.buildButton);
      
      private var _inspectingTile:Tile = null;
      
      public const buildSignal:Signal = new Signal(Tile);
      
      public function CapturedTerrainInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._closeButton.setClickFunction(hide);
         this._buildButton.setClickFunction(this.buildButtonClicked);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
      }
      
      private function buildButtonClicked() : void
      {
         hide();
         this.buildSignal.dispatch(this._inspectingTile);
      }
      
      public function syncTerrainInformation(param1:String, param2:Tile) : void
      {
         this._inspectingTile = param2;
      }
   }
}
