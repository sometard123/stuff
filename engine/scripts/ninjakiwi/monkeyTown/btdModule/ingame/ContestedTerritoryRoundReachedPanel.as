package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.ContestedTerritoryRoundReachedPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class ContestedTerritoryRoundReachedPanel extends HideRevealViewSimple
   {
      
      public static const DESC_BEAT_MINE:int = 0;
      
      public static const DESC_BEAT_OTHERS:int = 1;
       
      
      private const _panelDescriptions:Array = [LocalisationConstants.CONTEST_BEAT_MINE,LocalisationConstants.CONTEST_BEAT_OTHERS];
      
      private var _clip:ContestedTerritoryRoundReachedPanelClip;
      
      private var _continueButton:ButtonControllerBase;
      
      public function ContestedTerritoryRoundReachedPanel(param1:DisplayObjectContainer)
      {
         this._clip = new ContestedTerritoryRoundReachedPanelClip();
         this._continueButton = new ButtonControllerBase(this._clip.continueButton);
         super(param1);
         addChild(this._clip);
         this._continueButton.setClickFunction(this.hide);
      }
      
      public function popUp(param1:int) : void
      {
         this._clip.controlText.text = this._panelDescriptions[param1];
         TowerPlace.blockTowerPlacing = true;
         this.reveal();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         TowerPlace.blockTowerPlacing = false;
      }
   }
}
