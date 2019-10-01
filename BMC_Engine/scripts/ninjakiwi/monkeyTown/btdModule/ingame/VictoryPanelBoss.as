package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.sounds.CompletedStamp;
   import assets.ui.BlastapopoulosDefeatTitleAnimation;
   import assets.ui.BloonariusDefeatTitleAnimation;
   import assets.ui.DreadbloonDefeatTitleAnimation;
   import assets.ui.VictoryPanelBossClip;
   import assets.ui.VortexDefeatTitleAnimation;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class VictoryPanelBoss extends HideRevealViewSimple
   {
       
      
      protected var _clip:VictoryPanelBossClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _levelField:TextField;
      
      public var okSignal:Signal;
      
      public function VictoryPanelBoss(param1:DisplayObjectContainer)
      {
         this._clip = new VictoryPanelBossClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._levelField = this._clip.levelField.levelField;
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
      
      public function revealForBoss(param1:String, param2:String) : void
      {
         this._clip.bossDefeatedAnimationContainer.removeChildren();
         switch(param1)
         {
            default:
            case "bloonarius":
               this._clip.bossDefeatedAnimationContainer.addChild(new BloonariusDefeatTitleAnimation());
               break;
            case "vortex":
               this._clip.bossDefeatedAnimationContainer.addChild(new VortexDefeatTitleAnimation());
               break;
            case "blastapopoulos":
               this._clip.bossDefeatedAnimationContainer.addChild(new BlastapopoulosDefeatTitleAnimation());
               break;
            case "dreadbloon":
               this._clip.bossDefeatedAnimationContainer.addChild(new DreadbloonDefeatTitleAnimation());
         }
         this._clip.bossNameField.text = param2.toUpperCase();
         this.reveal();
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         revealCompleteSignal.removeAll();
         revealCompleteSignal.add(this.onReveal);
         this._clip.gotoAndStop(1);
         this._levelField.text = "Level " + (SpecialTrackManager.getInstance().specialTrack as SpecialTrackBoss).attackDef.bossLevel.toString();
         super.reveal(param1);
      }
      
      private function onReveal(... rest) : void
      {
         new MaxSound(CompletedStamp).play();
         this._clip.gotoAndPlay(1);
      }
   }
}
