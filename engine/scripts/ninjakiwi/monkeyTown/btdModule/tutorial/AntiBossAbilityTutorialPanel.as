package ninjakiwi.monkeyTown.btdModule.tutorial
{
   import assets.ui.AntiBossAbilityTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class AntiBossAbilityTutorialPanel extends HideRevealViewSimple
   {
       
      
      private var _clip:AntiBossAbilityTutorialPanelClip;
      
      private var _tutorialSave:Object = null;
      
      private var _okButton:ButtonControllerBase;
      
      public function AntiBossAbilityTutorialPanel(param1:DisplayObjectContainer, param2:Object)
      {
         this._clip = new AntiBossAbilityTutorialPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1);
         addChild(this._clip);
         this._tutorialSave = param2;
         if(false === this._tutorialSave.hasOwnProperty("seenAntiBossAbilityTutorial") || false == this._tutorialSave.seenAntiBossAbilityTutorial)
         {
            SpecialTrackBoss.onBossSpawnedSignal.addOnce(this.onBossSpawned);
         }
         this.init();
      }
      
      public function setTutorialSave(param1:Object) : void
      {
         this._tutorialSave = param1;
      }
      
      private function init() : void
      {
         this._okButton.setClickFunction(this.onOkClicked);
      }
      
      private function onOkClicked() : void
      {
         this.hide();
         Main.instance.unPauseGame();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         this._tutorialSave.seenAntiBossAbilityTutorial = true;
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
         Main.instance.game.inGameMenu.antiBossAbilityPane.setLocked(false);
         SpecialTrackBoss.onBossSpawnedSignal.remove(this.onBossSpawned);
      }
      
      private function onBossSpawned(... rest) : void
      {
         var arguments:Array = rest;
         SpecialTrackBoss.onBossSpawnedSignal.remove(this.onBossSpawned);
         setTimeout(function():void
         {
            reveal();
            Main.instance.pauseGame();
            Main.instance.game.inGameMenu.antiBossAbilityPane.setLocked(true);
            Main.instance.game.inGameMenu.antiBossAbilityPane.slideOut();
            Main.instance.game.inGameMenu.antiBossAbilityPane.setChillArrowVisible(true);
         },2000);
      }
   }
}
