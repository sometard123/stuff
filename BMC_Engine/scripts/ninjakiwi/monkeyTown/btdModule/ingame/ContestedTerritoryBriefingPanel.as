package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.ContestedTerritoryBriefingPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class ContestedTerritoryBriefingPanel extends HideRevealViewSimple
   {
      
      public static const DESC_GAIN_CONTROL:int = 0;
      
      public static const DESC_EXTEND_LEAD:int = 1;
      
      public static const DESC_BEAT_NEW_SCORE:int = 2;
      
      private static const TEXT_ORIGIN:Number = 228;
       
      
      private const _panelDescriptions:Array = [LocalisationConstants.CONTEST_GAME_GAIN_CONTROL,LocalisationConstants.CONTEST_GAME_EXTEND_LEAD,LocalisationConstants.CONTEST_BEAT_NEW_SCORE];
      
      private var _clip:ContestedTerritoryBriefingPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _continueButton:ButtonControllerBase;
      
      public function ContestedTerritoryBriefingPanel(param1:DisplayObjectContainer)
      {
         this._clip = new ContestedTerritoryBriefingPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._continueButton = new ButtonControllerBase(this._clip.continueButton);
         super(param1);
         addChild(this._clip);
         this._okButton.setClickFunction(this.hide);
         this._continueButton.setClickFunction(this.hide);
         this._continueButton.fadeOut(0);
         this._continueButton.disableMouseInteraction();
      }
      
      public function popUp(param1:int, param2:int = -1, param3:String = "") : void
      {
         var _loc4_:String = this._panelDescriptions[param1];
         if(param1 == DESC_GAIN_CONTROL || param1 == DESC_EXTEND_LEAD || param1 == DESC_BEAT_NEW_SCORE)
         {
            _loc4_ = _loc4_.split("<round>").join(param2);
            this._continueButton.fadeOut(0);
            this._continueButton.disableMouseInteraction();
            this._okButton.fadeIn(0);
            this._okButton.enableMouseInteraction();
         }
         if(param1 == DESC_BEAT_NEW_SCORE)
         {
            _loc4_ = _loc4_.split("<name>").join(param3);
            this._continueButton.fadeIn(0);
            this._continueButton.enableMouseInteraction();
            this._okButton.fadeOut(0);
            this._okButton.disableMouseInteraction();
         }
         this._clip.roundField.text = _loc4_;
         this._clip.roundField.y = TEXT_ORIGIN + Math.round((this._clip.roundField.height - this._clip.roundField.textHeight) / 2);
         this.reveal();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         TowerPlace.blockTowerPlacing = true;
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         TowerPlace.blockTowerPlacing = false;
      }
   }
}
